sudo dnf install -y cloud-init bash-completion yum-utils epel-release
sudo dnf update -y 
sudo dnf install -y neofetch
sudo bash -c $'echo "neofetch" >> /etc/profile.d/mymotd.sh && chmod +x /etc/profile.d/mymotd.sh'
sudo cloud-init clean
sudo dnf clean all
