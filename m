From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jan 2019 14:26:07 +0100
Subject: [LTP] [PATCH v2 3/3] travis: Use docker based builds
In-Reply-To: <20190103132607.24930-1-pvorel@suse.cz>
References: <20190103132607.24930-1-pvorel@suse.cz>
Message-ID: <20190103132607.24930-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously we used 10 Trusty environment (VM) based travis jobs with
different gcc and clang versions installed via ubuntu-toolchain-r apt
repository.

We agreed that testing just different gcc/clang versions isn't enough,
it'd be good to test also different glibc and kernel headers, which are
on different distros. Therefore now we test 15 jobs based on various
distros (Debian, Ubuntu, Fedora, openSUSE, centOS).
We still test both gcc/clang, out-of-tree and cross-compilation builds.

Disadvantage of this approach is that it's not obvious compiler and libc
version. Travis C testing environment implementation prints compiler
version ($CC) before installing actually used compiler via docker.
Therefore run ver_linux printing version info and print $CC version in
build.sh.

Implements: #448

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 .travis.packages_i386                  |   9 --
 .travis.packages_native                |  18 ---
 .travis.yml                            | 149 +++++++++----------------
 build.sh                               |  12 +-
 travis/centos.sh                       |   1 +
 travis/debian.cross-compile.aarch64.sh |   7 ++
 travis/debian.cross-compile.ppc64le.sh |   7 ++
 travis/debian.i386.sh                  |  19 ++++
 travis/debian.minimal.sh               |  19 ++++
 travis/debian.sh                       |  35 ++++++
 travis/fedora.sh                       |  12 ++
 travis/opensuse.sh                     |   1 +
 travis/tumbleweed.sh                   |  21 ++++
 travis/ubuntu.sh                       |   1 +
 14 files changed, 184 insertions(+), 127 deletions(-)
 delete mode 100644 .travis.packages_i386
 delete mode 100644 .travis.packages_native
 create mode 120000 travis/centos.sh
 create mode 100755 travis/debian.cross-compile.aarch64.sh
 create mode 100755 travis/debian.cross-compile.ppc64le.sh
 create mode 100755 travis/debian.i386.sh
 create mode 100755 travis/debian.minimal.sh
 create mode 100755 travis/debian.sh
 create mode 100755 travis/fedora.sh
 create mode 120000 travis/opensuse.sh
 create mode 100755 travis/tumbleweed.sh
 create mode 120000 travis/ubuntu.sh

diff --git a/.travis.packages_i386 b/.travis.packages_i386
deleted file mode 100644
index 725329041..000000000
--- a/.travis.packages_i386
+++ /dev/null
@@ -1,9 +0,0 @@
-libacl1:i386
-libaio1:i386
-libcap2:i386
-libc6-dev-i386
-libc6:i386
-libkeyutils1:i386
-libnuma1:i386
-libssl-dev:i386
-libtirpc1:i386
diff --git a/.travis.packages_native b/.travis.packages_native
deleted file mode 100644
index d9e1a2acc..000000000
--- a/.travis.packages_native
+++ /dev/null
@@ -1,18 +0,0 @@
-libacl1
-libacl1-dev
-libaio-dev
-libaio1
-libcap-dev
-libcap2
-libc6
-libc6-dev
-libkeyutils-dev
-libkeyutils1
-libmm-dev
-libnuma-dev
-libnuma1
-libselinux1-dev
-libsepol1-dev
-libssl-dev
-libtirpc1
-linux-libc-dev
diff --git a/.travis.yml b/.travis.yml
index 078028f9b..24de925b0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,124 +1,77 @@
+sudo: required
 language: c
-
-# BUILD="native": native builds
-# BUILD="32": 32-bit builds
-# BUILD="cross": cross compile build
-# TREE="out": out-of-tree build
-# NO INSTALL_PACKAGES variable: build with minimal dependencies
+services:
+    - docker
 
 matrix:
     include:
-        ### native builds ###
+        # 32 bit build
         - os: linux
-          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-5
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-5']
+          env: DISTRO=debian:stable VARIANT=i386
+          compiler: gcc
 
+        # cross compilation builds
+        - os: linux
+          env: DISTRO=debian:stable VARIANT=cross-compile.ppc64le TREE="out"
+          compiler: powerpc64le-linux-gnu-gcc
         - os: linux
-          env: BUILD="native" TREE="out" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-7
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-7']
+          env: DISTRO=debian:stable VARIANT=cross-compile.aarch64 TREE="out"
+          compiler: aarch64-linux-gnu-gcc
 
+        # build with minimal dependencies
         - os: linux
-          env: BUILD="native" TREE="out"
-          compiler: clang-4.0
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-4.0']
-                  packages: ['clang-4.0']
+          env: DISTRO=debian:stable VARIANT=minimal TREE="out"
+          compiler: clang
 
         - os: linux
-          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
-          compiler: clang-5.0
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-5.0']
-                  packages: ['clang-5.0']
+          env: DISTRO=debian:testing
+          compiler: gcc
+        - os: linux
+          env: DISTRO=debian:testing
+          compiler: clang
 
         - os: linux
-          env: BUILD="native"
-          compiler: clang-3.9
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-3.9']
-                  packages: ['clang-3.9']
+          env: DISTRO=debian:oldstable
+          compiler: gcc
+        - os: linux
+          env: DISTRO=debian:oldstable
+          compiler: clang
 
-        ### 32-bit builds ###
         - os: linux
-          env: BUILD="32" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-4.9
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-4.9', 'gcc-4.9-multilib', 'linux-libc-dev:i386']
+          env: DISTRO=ubuntu:latest TREE="out"
+          compiler: gcc
 
         - os: linux
-          env: BUILD="32" TREE="out" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-6
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-6', 'gcc-6-multilib', 'linux-libc-dev:i386']
+          env: DISTRO=ubuntu:xenial
+          compiler: gcc
 
-        ### cross-compile builds ###
         - os: linux
-          env: BUILD="cross" INSTALL_PACKAGES="$BUILD"
-          compiler: arm-linux-gnueabihf-gcc
-          addons:
-              apt:
-                  packages: ['gcc-arm-linux-gnueabihf', 'libc6-dev-armhf-cross']
+          env: DISTRO=opensuse:tumbleweed
+          compiler: gcc
 
         - os: linux
-          env: BUILD="cross" TREE="out" INSTALL_PACKAGES="$BUILD"
-          compiler: aarch64-linux-gnu-gcc
-          addons:
-              apt:
-                  packages: ['gcc-aarch64-linux-gnu', 'libc6-dev-arm64-cross']
+          env: DISTRO=opensuse:leap
+          compiler: gcc
 
         - os: linux
-          env: BUILD="cross" TREE="out"
-          compiler: powerpc64le-linux-gnu-gcc
-          addons:
-              apt:
-                  packages: ['gcc-powerpc64le-linux-gnu', 'libc6-dev-ppc64el-cross']
+          env: DISTRO=fedora:latest
+          compiler: clang
 
-notifications:
-    email:
-        secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
+        - os: linux
+          env: DISTRO=centos:latest
+          compiler: gcc
+        - os: linux
+          env: DISTRO=centos:6 TREE="out"
+          compiler: gcc
 
 before_install:
-    # travis-ci/travis-ci#9112: remove all third party repositories except ubuntu-toolchain-r-test
-    - if [ -f /etc/apt/sources.list.d/ubuntu-toolchain-r-test*.list ]; then
-          cp -v /etc/apt/sources.list.d/ubuntu-toolchain-r-test*.list /tmp
-      ; fi
-    - sudo rm -fv /etc/apt/sources.list.d/*
-    - if [ -f /tmp/ubuntu-toolchain-r-test*.list ]; then
-          sudo cp -v /tmp/ubuntu-toolchain-r-test*.list /etc/apt/sources.list.d/
-      ; fi
-
-    # workaround apt related for error:
-    # Err:6 http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu trusty InRelease
-    # The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 1E9377A2BA9EF27F
-    - sudo apt update -o Acquire::Retries=100 -o Acquire::http::Timeout="60" -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true
-
-    # installing / removing dependencies
-    - if [ "$INSTALL_PACKAGES" = "" ]; then
-          sudo apt remove $(cat .travis.packages_native | grep -v -e 'libc6' -e 'libc6-dev' -e 'linux-libc-dev' -e 'libacl1')
-      ; else
-          sudo apt install -qq $(cat .travis.packages_native)
-      ; fi
-
-    - if [ "$INSTALL_PACKAGES" = "32" ]; then
-          sudo apt install -qq $(cat .travis.packages_i386)
-      ; fi
-    - if [ ! "$TREE" ]; then
-          TREE="in"
-      ; fi
-
-script: ./build.sh -o $TREE -t $BUILD -c $CC
+    - DIR="/usr/src/ltp"
+    - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n" > Dockerfile
+    - echo "cat Dockerfile"; cat Dockerfile; echo "=====" # FIXME: debug
+    - docker build -t ltp .
+
+script:
+    - INSTALL="${DISTRO%%:*}"
+    - if [ ! "$TREE" ]; then TREE="in"; fi
+    - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
+    - docker run -it ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
diff --git a/build.sh b/build.sh
index 4e8357982..ae3b86ff2 100755
--- a/build.sh
+++ b/build.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Script for travis builds.
 #
 # TODO: Implement comparison of installed files. List of installed files can
@@ -16,7 +16,7 @@ CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite"
 # TODO: open posix testsuite is currently broken in out-tree-build. Enable it once it's fixed.
 CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite"
 MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
-CC=
+CC=gcc
 
 build_32()
 {
@@ -152,4 +152,12 @@ while getopts "c:ho:p:t:" opt; do
 done
 
 cd `dirname $0`
+
+echo "=== ver_linux ==="
+./ver_linux
+echo
+
+echo "=== compiler version ==="
+$CC --version
+
 eval build_$build $tree
diff --git a/travis/centos.sh b/travis/centos.sh
new file mode 120000
index 000000000..1479a43e0
--- /dev/null
+++ b/travis/centos.sh
@@ -0,0 +1 @@
+fedora.sh
\ No newline at end of file
diff --git a/travis/debian.cross-compile.aarch64.sh b/travis/debian.cross-compile.aarch64.sh
new file mode 100755
index 000000000..4b07f186f
--- /dev/null
+++ b/travis/debian.cross-compile.aarch64.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+apt install -y --no-install-recommends \
+	gcc-aarch64-linux-gnu \
+	libc6-dev-arm64-cross
diff --git a/travis/debian.cross-compile.ppc64le.sh b/travis/debian.cross-compile.ppc64le.sh
new file mode 100755
index 000000000..d8431bd52
--- /dev/null
+++ b/travis/debian.cross-compile.ppc64le.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+apt install -y --no-install-recommends \
+	gcc-powerpc64le-linux-gnu \
+	libc6-dev-ppc64el-cross
diff --git a/travis/debian.i386.sh b/travis/debian.i386.sh
new file mode 100755
index 000000000..250d53b0d
--- /dev/null
+++ b/travis/debian.i386.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+dpkg --add-architecture i386
+apt update
+
+apt install -y --no-install-recommends \
+	linux-libc-dev:i386 \
+	gcc-multilib \
+	libacl1:i386 \
+	libaio1:i386 \
+	libcap2:i386 \
+	libc6-dev-i386 \
+	libc6:i386 \
+	libkeyutils1:i386 \
+	libnuma1:i386 \
+	libssl-dev:i386 \
+	libtirpc1:i386
diff --git a/travis/debian.minimal.sh b/travis/debian.minimal.sh
new file mode 100755
index 000000000..8e8bb6249
--- /dev/null
+++ b/travis/debian.minimal.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+apt remove -y \
+    libacl1-dev \
+    libaio-dev \
+    libaio1 \
+    libcap-dev \
+    libcap2 \
+    libkeyutils-dev \
+    libkeyutils1 \
+    libmm-dev \
+    libnuma-dev \
+    libnuma1 \
+    libselinux1-dev \
+    libsepol1-dev \
+    libssl-dev \
+    libtirpc1
diff --git a/travis/debian.sh b/travis/debian.sh
new file mode 100755
index 000000000..3918a915f
--- /dev/null
+++ b/travis/debian.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+apt update
+
+apt install -y --no-install-recommends \
+    acl-dev \
+    autoconf \
+    automake \
+    build-essential \
+    debhelper \
+    devscripts \
+    clang \
+    gcc \
+    libacl1 \
+    libacl1-dev \
+    libaio-dev \
+    libaio1 \
+    libcap-dev \
+    libcap2 \
+    libc6 \
+    libc6-dev \
+    libkeyutils-dev \
+    libkeyutils1 \
+    libmm-dev \
+    libnuma-dev \
+    libnuma1 \
+    libselinux1-dev \
+    libsepol1-dev \
+    libssl-dev \
+    linux-libc-dev \
+    lsb-release
+
+apt install libtirpc1 libtirpc3 || true
diff --git a/travis/fedora.sh b/travis/fedora.sh
new file mode 100755
index 000000000..a4633333e
--- /dev/null
+++ b/travis/fedora.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+yum -y install \
+	autoconf \
+	automake \
+	make \
+	clang \
+	gcc \
+	findutils \
+	redhat-lsb-core
diff --git a/travis/opensuse.sh b/travis/opensuse.sh
new file mode 120000
index 000000000..11c5f4b63
--- /dev/null
+++ b/travis/opensuse.sh
@@ -0,0 +1 @@
+tumbleweed.sh
\ No newline at end of file
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
new file mode 100755
index 000000000..7fe40d142
--- /dev/null
+++ b/travis/tumbleweed.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+zypper --non-interactive install --no-recommends \
+	autoconf \
+	automake \
+	clang \
+	gcc \
+	make \
+	kernel-default-devel \
+	keyutils-devel \
+	libacl-devel \
+	libaio-devel \
+	libcap-devel \
+	libnuma-devel \
+	libopenssl-devel \
+	libselinux-devel \
+	libtirpc-devel \
+	linux-glibc-devel \
+	lsb-release
diff --git a/travis/ubuntu.sh b/travis/ubuntu.sh
new file mode 120000
index 000000000..0edcb8b83
--- /dev/null
+++ b/travis/ubuntu.sh
@@ -0,0 +1 @@
+debian.sh
\ No newline at end of file
-- 
2.19.2

