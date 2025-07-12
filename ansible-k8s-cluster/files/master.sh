#!/bin/bash
set -e

echo "🚀 Updating system and installing dependencies..."
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl gpg net-tools bash-completion linux-modules-extra-$(uname -r)

echo "🔌 Loading kernel modules..."
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

echo "🔧 Applying sysctl params..."
sudo sysctl --system

echo "🔑 Adding Kubernetes repo..."
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "📦 Installing kubeadm, kubelet, kubectl, containerd..."
sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl containerd
sudo apt-mark hold kubelet kubeadm kubectl

echo "🔧 Configuring containerd..."
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

echo "❌ Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "🔥 Flushing iptables..."
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -X

echo "🎯 Initializing Kubernetes cluster..."
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=all

echo "🔐 Setting up kubeconfig..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "🌐 Applying Calico CNI..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml --validate=false

echo "⏳ Waiting for Kubernetes API server to become ready..."
until kubectl get nodes &>/dev/null; do
  echo "⌛ Waiting for kube-apiserver..."
  sleep 5
done

echo "🔑 Saving join command..."
kubeadm token create --print-join-command > /tmp/kubeadm_join_cmd.sh

echo "✅ Master node setup complete!"

