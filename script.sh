dnf clean all &&
free &&
echo -e '# Added for speed\nfastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf &&
sed -i '7 i GRUB_CMDLINE_LINUX="rhgb quiet mitigations=off"' /etc/default/grub &&
echo 'GRUB_CMDLINE_LINUX="zswap.enabled=1 rhgb quiet mitigations=off"' >> /etc/default/grub &&

dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm gnome-tweaks google-chrome-stable -y &&

dnf groupupdate core -y &&
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y &&
dnf groupupdate sound-and-video -y &&
dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted \*-firmware -y &&

dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel lame\* --exclude=lame-devel -y &&
dnf group upgrade --with-optional Multimedia -y &&

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &&
flatpak install flathub com.mattjakeman.ExtensionManager org.gnome.Epiphany io.gitlab.librewolf-community org.gustavoperedo.FontDownloader -y &&
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' &&
dnf check-update &&
dnf install code -y &&
dnf module install nodejs:16 -y &&
dnf update --refresh -y &&
dnf clean all &&
free &&
reboot
