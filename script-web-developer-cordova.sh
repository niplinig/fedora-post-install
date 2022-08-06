dnf install java-17-openjdk-devel zlib.i686 ncurses-libs.i686 bzip2-libs.i686 -y &&
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
 echo 'script finished the work'
