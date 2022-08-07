# fedora-post-install
Post install scripts for fedora

```
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
```
Cordova requirements

```
dnf install java-11-openjdk-devel zlib.i686 ncurses-libs.i686 bzip2-libs.i686 -y &&
cd ~ &&
wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip &&
unzip commandlinetools-linux-8512546_latest.zip &&
rm commandlinetools-linux-8512546_latest.zip &&
mkdir Android &&
mv cmdline-tools Android/latest &&
cd Android &&
mkdir cmdline-tools &&
mv latest cmdline-tools/latest &&
cd cmdline-tools/latest/bin &&
./sdkmanager --install "platform-tools" "platforms;android-30" "system-images;android-30;google_apis;x86_64" "build-tools;30.0.3" &&
cd /opt &&
mkdir gradle &&
cd gradle &&
wget https://downloads.gradle-dn.com/distributions/gradle-6.4-bin.zip &&
unzip gradle-6.4-bin.zip &&
rm gradle-6.4-bin.zip &&
cd gradle-6.4/bin &&
./gradle &&
echo -e 'export PATH=$PATH:/opt/gradle/gradle-7.5.1/bin\nexport JAVA_HOME=/usr/lib/jvm/java-17-openjdk-17.0.4.0.8-1.fc36.x86_64/\nexport ANDROID_HOME=~/Android/tools/bin/\nexport ANDROID_SDK_ROOT=~/Android/cmdline-tools/latest/'>> ~/.bashrc &&
source ~/.bashrc
```

```

git config --global user.email "niplinig@espol.edu.ec"
git config --global user.name "Nicolas Plaza"


```

export PATH=$PATH:/opt/gradle/gradle-7.5.1/bin/
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.16.0.8-1.fc36.x86_64
export ANDROID_SDK_ROOT=~/Android/Sdk/
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
```
