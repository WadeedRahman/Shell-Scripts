# This is a shell Script Running Docker Desktop in Linux 24.04 Lts
# !/bin/bash
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
systemctl --user enable docker-desktop
systemctl --user restart docker-desktop
