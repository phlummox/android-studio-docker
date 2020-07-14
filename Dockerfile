FROM gitpod/workspace-full-vnc@sha256:331a933c3bce7d7cb3e78f8cfac93ae706091575758adeba3a86072d585e52b0

ARG ANDROID_STUDIO_URL=https://dl.google.com/dl/android/studio/ide-zips/4.0.0.16/android-studio-ide-193.6514223-linux.tar.gz
ARG ANDROID_STUDIO_VERSION=4.0

USER root

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      coreutils            \
      curl                 \
      expect               \
      lib32gcc1            \
      lib32ncurses5-dev    \
      lib32stdc++6         \
      lib32z1              \
      libc6-i386           \
      pv                   \
      unzip                \
      wget

RUN \
  wget -O /opt/android-studio-ide.tar.gz $ANDROID_STUDIO_URL && \
  export sha="$(sha256sum /opt/android-studio-ide.tar.gz)" ; \
  if [ "$sha" != "70c04dc542281c015a700fad73d7d62ce9dace774bc12050cad9f1d6363112eb  /opt/android-studio-ide.tar.gz" ]; then \
      echo "SHA-256 Checksum mismatch, aborting installation"; \
      rm -f /opt/android-studio-ide.tar.gz; exit 1; \
    else \
      cd /opt && tar xf android-studio-ide.tar.gz && rm android-studio-ide.tar.gz; \
    fi

# fix display resolution
RUN \
  sed -i 's/1920x1080/1366x768/' /usr/bin/start-vnc-session.sh

USER gitpod

RUN \
  mkdir -p $HOME/.local/bin && \
  printf '\nPATH=$HOME/.local/bin:$PATH\n' | \
      tee -a /home/gitpod/.bashrc && \
  ln -s /opt/android-studio/bin/studio.sh \
    /home/gitpod/.local/bin/android_studio && \
  : "if running locally (vs using gitpod in cloud) need to create /workspace " && \
  sudo mkdir -p /workspace/.gradle && \
  sudo chown -R gitpod:gitpod /workspace

ARG ANDROID_INSTALLATION_URL=https://github.com/phlummox/android-studio-docker/releases/download/v0.1/android-studio-installation.tar.xz

RUN \
  cd $HOME && \
  wget -O - $ANDROID_INSTALLATION_URL | tar x --xz

#RUN \
#    apt-get update \
#    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
#        build-essential   \
#        curl              \
#        git               \
#        libz1             \
#        libbz2-1.0        \
#        libfreetype6      \
#        libglu1           \
#        libgtk-3-dev      \
#        libncurses5       \
#        libnotify4        \
#        libqt5widgets5    \
#        libstdc++6        \
#        libxft2           \
#        libxi6            \
#        libxrender1       \
#        libxtst6          \
#        sudo              \
#        unzip             \
#        wget              \
#    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* \
#    && rm -rf /var/tmp/*

## from 
## https://github.com/hpssjellis/my-gitpod-capacitor/blob/63bbb363a0e9c8cc0236fbdc033a7433f6b10e3c/Dockerfile
#RUN apt-get update  \
#    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
#             libdbus-1-dev  \
#             libnotify-dev libgconf2-dev       \
#             libcap-dev libcups2-dev libxtst-dev     \
#             libxss1 libnss3-dev gcc-multilib g++-multilib    \
#             gperf                        \
#    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*




### Download Android Studio from Google (needs wget)
### Compare SHA-256 Checksum (needs coreutils) 
#RUN \
#  mkdir --mode=755 -p /opt && \
#  wget -O /opt/android-studio-ide.tar.gz https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.0.0.16/android-studio-ide-193.6514223-linux.tar.gz && \
#  export sha="$(sha256sum /opt/android-studio-ide.tar.gz)" ; \
#  if [ "$sha" != "70c04dc542281c015a700fad73d7d62ce9dace774bc12050cad9f1d6363112eb  /opt/android-studio-ide.tar.gz" ]; then echo "SHA-256 Checksum mismatch, aborting installation"; rm -f /opt/android-studio-ide.tar.gz; exit 1; fi     
#
#RUN \
# cd /opt && tar xf android-studio-ide.tar.gz && rm android-studio-ide.tar.gz  
#
## sdk
##RUN set -x; cd /opt && wget --output-document=android-sdk.zip \
##    https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip 
##
##RUN \
## set -x; cd /opt && \
##    unzip android-sdk.zip -d /opt/android-sdk 
##&& rm -f android-sdk.zip





# SDK:
# https://ncona.com/2018/07/android-development-with-docker-2/

# Setup environment
#ENV ANDROID_HOME /opt/android-sdk
#ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

#RUN \
#  bash -c '. "$HOME/.sdkman/bin/sdkman-init.sh" ; sdk install java 10.0.2-open; sdk default java 10.0.2-open; which javac; which java; readlink -f  `which javac`; java -version;  echo $JAVA_HOME;'

#  sed -i '/^DEFAULT_JVM_OPTS=/ s/HOME"/& --add-modules java.xml.bind/' $ANDROID_HOME/tools/bin/sdkmanager

#RUN \
#  bash -c '. "$HOME/.sdkman/bin/sdkman-init.sh" ; sdkmanager  "platform-tools" "platforms;android-30"'

# Install SDK elements. This might change depending on what your app needs
# I'm installing the most basic ones. You should modify this to install the ones
# you need. You can get a list of available elements by getting a shell to the
# container and using `sdkmanager --list`
#RUN set -x echo yes | sudo --preserve-env=PATH,JAVA_HOME,ANDROID_HOME `which sdkmanager`  "platform-tools" "platforms;android-30"

#ARG ANDROID_STUDIO_URL=https://dl.google.com/dl/android/studio/ide-zips/3.5.3.0/android-studio-ide-191.6010548-linux.tar.gz
#ARG ANDROID_STUDIO_VERSION=3.5

#RUN \
#  sudo apt-get install x11-apps
#
#RUN \
#  sudo apt-get install screen gosu 
#
#USER gitpod
