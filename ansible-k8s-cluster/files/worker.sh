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

echo "🔧 Applying sysctl parameters..."
sudo sysctl --system

echo "🔑 Adding Kubernetes repository..."
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "📦 Installing kubeadm, kubelet, kubectl, and containerd..."
sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl containerd
sudo apt-mark hold kubelet kubeadm kubectl

echo "🔧 Configuring containerd..."
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

echo "❌ Disabling swap..."
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "🔥 Flushing iptables rules..."
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -X

echo "🔗 Joining the Kubernetes cluster..."

# Read the join command from a file (pass this in your Ansible playbook)
if [ -f /tmp/kubeadm_join_cmd.sh ]; then
    JOIN_CMD=$(cat /tmp/kubeadm_join_cmd.sh)
    echo "➡️ Using join command: $JOIN_CMD"
    sudo $JOIN_CMD
else
    echo "❌ ERROR: Join command file /tmp/kubeadm_join_cmd.sh not found!"
    exit 1
fi

echo "✅ Worker node joined the cluster!"
