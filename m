From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Dec 2018 15:14:15 +0100
Subject: [LTP] [PATCH 3/3] travis: Use docker based builds
In-Reply-To: <20181219141415.3495-1-pvorel@suse.cz>
References: <20181219141415.3495-1-pvorel@suse.cz>
Message-ID: <20181219141415.3495-3-pvorel@suse.cz>
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
---
Hi,

we can keep number of builds to 10 instead of current 15, but not sure
which jobs to remove.


Kind regards,
Petr
---
 .travis.packages_i386                         |   9 --
 .travis.packages_native                       |  18 ---
 .travis.yml                                   | 143 ++++++------------
 build.sh                                      |  12 +-
 travis/Dockerfile.centos.latest               |   5 +
 travis/Dockerfile.centos6                     |   5 +
 .../Dockerfile.debian.cross-compile.aarch64   |   1 +
 .../Dockerfile.debian.cross-compile.ppc64le   |   1 +
 travis/Dockerfile.debian.i386                 |   1 +
 travis/Dockerfile.debian.minimal              |   1 +
 travis/Dockerfile.debian.oldstable            |   5 +
 travis/Dockerfile.debian.ppc64le              |   5 +
 travis/Dockerfile.debian.stable               |   5 +
 travis/Dockerfile.debian.testing              |   5 +
 travis/Dockerfile.fedora.latest               |   5 +
 travis/Dockerfile.leap                        |   5 +
 travis/Dockerfile.tumbleweed                  |   5 +
 travis/Dockerfile.ubuntu.latest               |   5 +
 travis/Dockerfile.ubuntu.xenial               |   5 +
 travis/travis.centos.latest.sh                |   1 +
 travis/travis.centos6.sh                      |   1 +
 travis/travis.debian.cross-compile.aarch64.sh |   9 ++
 travis/travis.debian.cross-compile.ppc64le.sh |   9 ++
 travis/travis.debian.i386.sh                  |  19 +++
 travis/travis.debian.minimal.sh               |  21 +++
 travis/travis.debian.oldstable.sh             |   1 +
 travis/travis.debian.stable.sh                |  35 +++++
 travis/travis.debian.testing.sh               |   1 +
 travis/travis.fedora.latest.sh                |  12 ++
 travis/travis.leap.sh                         |   1 +
 travis/travis.sh                              |   6 +
 travis/travis.tumbleweed.sh                   |  21 +++
 travis/travis.ubuntu.latest.sh                |   1 +
 travis/travis.ubuntu.xenial.sh                |   1 +
 34 files changed, 254 insertions(+), 126 deletions(-)
 delete mode 100644 .travis.packages_i386
 delete mode 100644 .travis.packages_native
 create mode 100644 travis/Dockerfile.centos.latest
 create mode 100644 travis/Dockerfile.centos6
 create mode 120000 travis/Dockerfile.debian.cross-compile.aarch64
 create mode 120000 travis/Dockerfile.debian.cross-compile.ppc64le
 create mode 120000 travis/Dockerfile.debian.i386
 create mode 120000 travis/Dockerfile.debian.minimal
 create mode 100644 travis/Dockerfile.debian.oldstable
 create mode 100644 travis/Dockerfile.debian.ppc64le
 create mode 100644 travis/Dockerfile.debian.stable
 create mode 100644 travis/Dockerfile.debian.testing
 create mode 100644 travis/Dockerfile.fedora.latest
 create mode 100644 travis/Dockerfile.leap
 create mode 100644 travis/Dockerfile.tumbleweed
 create mode 100644 travis/Dockerfile.ubuntu.latest
 create mode 100644 travis/Dockerfile.ubuntu.xenial
 create mode 120000 travis/travis.centos.latest.sh
 create mode 120000 travis/travis.centos6.sh
 create mode 100755 travis/travis.debian.cross-compile.aarch64.sh
 create mode 100755 travis/travis.debian.cross-compile.ppc64le.sh
 create mode 100755 travis/travis.debian.i386.sh
 create mode 100755 travis/travis.debian.minimal.sh
 create mode 120000 travis/travis.debian.oldstable.sh
 create mode 100755 travis/travis.debian.stable.sh
 create mode 120000 travis/travis.debian.testing.sh
 create mode 100755 travis/travis.fedora.latest.sh
 create mode 120000 travis/travis.leap.sh
 create mode 100755 travis/travis.sh
 create mode 100755 travis/travis.tumbleweed.sh
 create mode 120000 travis/travis.ubuntu.latest.sh
 create mode 120000 travis/travis.ubuntu.xenial.sh

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
index 078028f9b..fe8e901fb 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,124 +1,73 @@
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
+          env: DISTRO=debian.i386 BUILD="32"
+          compiler: gcc
 
+        # cross compilation builds
+        - os: linux
+          env: DISTRO=debian.cross-compile.ppc64le TREE="out" BUILD="cross"
+          compiler: powerpc64le-linux-gnu-gcc
         - os: linux
-          env: BUILD="native" TREE="out" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-7
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-7']
+          env: DISTRO=debian.cross-compile.aarch64 TREE="out" BUILD="cross"
+          compiler: aarch64-linux-gnu-gcc
 
+        # build with minimal dependencies
         - os: linux
-          env: BUILD="native" TREE="out"
-          compiler: clang-4.0
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-4.0']
-                  packages: ['clang-4.0']
+          env: DISTRO=debian.minimal TREE="out"
+          compiler: clang
 
         - os: linux
-          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
-          compiler: clang-5.0
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-5.0']
-                  packages: ['clang-5.0']
+          env: DISTRO=debian.testing
+          compiler: gcc
+        - os: linux
+          env: DISTRO=debian.testing
+          compiler: clang
 
         - os: linux
-          env: BUILD="native"
-          compiler: clang-3.9
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-3.9']
-                  packages: ['clang-3.9']
+          env: DISTRO=debian.oldstable
+          compiler: gcc
+        - os: linux
+          env: DISTRO=debian.oldstable
+          compiler: clang
 
-        ### 32-bit builds ###
         - os: linux
-          env: BUILD="32" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-4.9
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-4.9', 'gcc-4.9-multilib', 'linux-libc-dev:i386']
+          env: DISTRO=ubuntu.latest TREE="out"
+          compiler: gcc
 
         - os: linux
-          env: BUILD="32" TREE="out" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-6
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-6', 'gcc-6-multilib', 'linux-libc-dev:i386']
+          env: DISTRO=ubuntu.xenial
+          compiler: gcc
 
-        ### cross-compile builds ###
         - os: linux
-          env: BUILD="cross" INSTALL_PACKAGES="$BUILD"
-          compiler: arm-linux-gnueabihf-gcc
-          addons:
-              apt:
-                  packages: ['gcc-arm-linux-gnueabihf', 'libc6-dev-armhf-cross']
+          env: DISTRO=tumbleweed
+          compiler: gcc
 
         - os: linux
-          env: BUILD="cross" TREE="out" INSTALL_PACKAGES="$BUILD"
-          compiler: aarch64-linux-gnu-gcc
-          addons:
-              apt:
-                  packages: ['gcc-aarch64-linux-gnu', 'libc6-dev-arm64-cross']
+          env: DISTRO=leap
+          compiler: gcc
 
         - os: linux
-          env: BUILD="cross" TREE="out"
-          compiler: powerpc64le-linux-gnu-gcc
-          addons:
-              apt:
-                  packages: ['gcc-powerpc64le-linux-gnu', 'libc6-dev-ppc64el-cross']
+          env: DISTRO=fedora.latest
+          compiler: clang
 
-notifications:
-    email:
-        secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
+        - os: linux
+          env: DISTRO=centos.latest
+          compiler: gcc
+        - os: linux
+          env: DISTRO=centos6 TREE="out"
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
+    - docker build -f travis/Dockerfile.$DISTRO -t ltp .
 
-script: ./build.sh -o $TREE -t $BUILD -c $CC
+script:
+    - if [ ! "$TREE" ]; then TREE="in"; fi
+    - if [ ! "$BUILD" ]; then BUILD="native"; fi
+    - docker run -it ltp /bin/sh -c "cd travis && ./travis.$DISTRO.sh && ../build.sh -o $TREE -t $BUILD -c $CC"
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
diff --git a/travis/Dockerfile.centos.latest b/travis/Dockerfile.centos.latest
new file mode 100644
index 000000000..35741009a
--- /dev/null
+++ b/travis/Dockerfile.centos.latest
@@ -0,0 +1,5 @@
+FROM centos:latest
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.centos6 b/travis/Dockerfile.centos6
new file mode 100644
index 000000000..cbc7660ed
--- /dev/null
+++ b/travis/Dockerfile.centos6
@@ -0,0 +1,5 @@
+FROM centos:6
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.debian.cross-compile.aarch64 b/travis/Dockerfile.debian.cross-compile.aarch64
new file mode 120000
index 000000000..0695d8fef
--- /dev/null
+++ b/travis/Dockerfile.debian.cross-compile.aarch64
@@ -0,0 +1 @@
+Dockerfile.debian.stable
\ No newline at end of file
diff --git a/travis/Dockerfile.debian.cross-compile.ppc64le b/travis/Dockerfile.debian.cross-compile.ppc64le
new file mode 120000
index 000000000..0695d8fef
--- /dev/null
+++ b/travis/Dockerfile.debian.cross-compile.ppc64le
@@ -0,0 +1 @@
+Dockerfile.debian.stable
\ No newline at end of file
diff --git a/travis/Dockerfile.debian.i386 b/travis/Dockerfile.debian.i386
new file mode 120000
index 000000000..0695d8fef
--- /dev/null
+++ b/travis/Dockerfile.debian.i386
@@ -0,0 +1 @@
+Dockerfile.debian.stable
\ No newline at end of file
diff --git a/travis/Dockerfile.debian.minimal b/travis/Dockerfile.debian.minimal
new file mode 120000
index 000000000..0695d8fef
--- /dev/null
+++ b/travis/Dockerfile.debian.minimal
@@ -0,0 +1 @@
+Dockerfile.debian.stable
\ No newline at end of file
diff --git a/travis/Dockerfile.debian.oldstable b/travis/Dockerfile.debian.oldstable
new file mode 100644
index 000000000..9b50fe6b8
--- /dev/null
+++ b/travis/Dockerfile.debian.oldstable
@@ -0,0 +1,5 @@
+FROM debian:oldstable
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.debian.ppc64le b/travis/Dockerfile.debian.ppc64le
new file mode 100644
index 000000000..6eb2ec7aa
--- /dev/null
+++ b/travis/Dockerfile.debian.ppc64le
@@ -0,0 +1,5 @@
+FROM ppc64le/debian:stable
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.debian.stable b/travis/Dockerfile.debian.stable
new file mode 100644
index 000000000..0e496079a
--- /dev/null
+++ b/travis/Dockerfile.debian.stable
@@ -0,0 +1,5 @@
+FROM debian:stable
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.debian.testing b/travis/Dockerfile.debian.testing
new file mode 100644
index 000000000..ca086c9ac
--- /dev/null
+++ b/travis/Dockerfile.debian.testing
@@ -0,0 +1,5 @@
+FROM debian:testing
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.fedora.latest b/travis/Dockerfile.fedora.latest
new file mode 100644
index 000000000..4f0f8f86e
--- /dev/null
+++ b/travis/Dockerfile.fedora.latest
@@ -0,0 +1,5 @@
+FROM fedora:latest
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.leap b/travis/Dockerfile.leap
new file mode 100644
index 000000000..f40ba3d38
--- /dev/null
+++ b/travis/Dockerfile.leap
@@ -0,0 +1,5 @@
+FROM opensuse:leap
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.tumbleweed b/travis/Dockerfile.tumbleweed
new file mode 100644
index 000000000..493f6c4b0
--- /dev/null
+++ b/travis/Dockerfile.tumbleweed
@@ -0,0 +1,5 @@
+FROM opensuse:tumbleweed
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.ubuntu.latest b/travis/Dockerfile.ubuntu.latest
new file mode 100644
index 000000000..ce38a1f04
--- /dev/null
+++ b/travis/Dockerfile.ubuntu.latest
@@ -0,0 +1,5 @@
+FROM ubuntu:latest
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/Dockerfile.ubuntu.xenial b/travis/Dockerfile.ubuntu.xenial
new file mode 100644
index 000000000..2012aab96
--- /dev/null
+++ b/travis/Dockerfile.ubuntu.xenial
@@ -0,0 +1,5 @@
+FROM ubuntu:xenial
+
+RUN mkdir -p /usr/src/ltp
+WORKDIR /usr/src/ltp
+COPY . /usr/src/ltp
diff --git a/travis/travis.centos.latest.sh b/travis/travis.centos.latest.sh
new file mode 120000
index 000000000..5b53be398
--- /dev/null
+++ b/travis/travis.centos.latest.sh
@@ -0,0 +1 @@
+travis.fedora.latest.sh
\ No newline at end of file
diff --git a/travis/travis.centos6.sh b/travis/travis.centos6.sh
new file mode 120000
index 000000000..5b53be398
--- /dev/null
+++ b/travis/travis.centos6.sh
@@ -0,0 +1 @@
+travis.fedora.latest.sh
\ No newline at end of file
diff --git a/travis/travis.debian.cross-compile.aarch64.sh b/travis/travis.debian.cross-compile.aarch64.sh
new file mode 100755
index 000000000..e30f60d2e
--- /dev/null
+++ b/travis/travis.debian.cross-compile.aarch64.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+./travis.debian.stable.sh
+
+apt install -y --no-install-recommends \
+	gcc-aarch64-linux-gnu \
+	libc6-dev-arm64-cross
diff --git a/travis/travis.debian.cross-compile.ppc64le.sh b/travis/travis.debian.cross-compile.ppc64le.sh
new file mode 100755
index 000000000..c5169214c
--- /dev/null
+++ b/travis/travis.debian.cross-compile.ppc64le.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+./travis.debian.stable.sh
+
+apt install -y --no-install-recommends \
+	gcc-powerpc64le-linux-gnu \
+	libc6-dev-ppc64el-cross
diff --git a/travis/travis.debian.i386.sh b/travis/travis.debian.i386.sh
new file mode 100755
index 000000000..167953332
--- /dev/null
+++ b/travis/travis.debian.i386.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+dpkg --add-architecture i386
+./travis.debian.stable.sh
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
diff --git a/travis/travis.debian.minimal.sh b/travis/travis.debian.minimal.sh
new file mode 100755
index 000000000..36d185e3f
--- /dev/null
+++ b/travis/travis.debian.minimal.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+./travis.debian.stable.sh
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
diff --git a/travis/travis.debian.oldstable.sh b/travis/travis.debian.oldstable.sh
new file mode 120000
index 000000000..ffd9a3d86
--- /dev/null
+++ b/travis/travis.debian.oldstable.sh
@@ -0,0 +1 @@
+travis.debian.stable.sh
\ No newline at end of file
diff --git a/travis/travis.debian.stable.sh b/travis/travis.debian.stable.sh
new file mode 100755
index 000000000..3918a915f
--- /dev/null
+++ b/travis/travis.debian.stable.sh
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
diff --git a/travis/travis.debian.testing.sh b/travis/travis.debian.testing.sh
new file mode 120000
index 000000000..ffd9a3d86
--- /dev/null
+++ b/travis/travis.debian.testing.sh
@@ -0,0 +1 @@
+travis.debian.stable.sh
\ No newline at end of file
diff --git a/travis/travis.fedora.latest.sh b/travis/travis.fedora.latest.sh
new file mode 100755
index 000000000..a4633333e
--- /dev/null
+++ b/travis/travis.fedora.latest.sh
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
diff --git a/travis/travis.leap.sh b/travis/travis.leap.sh
new file mode 120000
index 000000000..c7ce18b7d
--- /dev/null
+++ b/travis/travis.leap.sh
@@ -0,0 +1 @@
+travis.tumbleweed.sh
\ No newline at end of file
diff --git a/travis/travis.sh b/travis/travis.sh
new file mode 100755
index 000000000..16d469cc4
--- /dev/null
+++ b/travis/travis.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+./travis.$DISTRO.sh
+../build.sh -o $TREE -t native -c $CC
diff --git a/travis/travis.tumbleweed.sh b/travis/travis.tumbleweed.sh
new file mode 100755
index 000000000..8bae69065
--- /dev/null
+++ b/travis/travis.tumbleweed.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+set -e
+
+zypper --non-interactive in --no-recommends \
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
diff --git a/travis/travis.ubuntu.latest.sh b/travis/travis.ubuntu.latest.sh
new file mode 120000
index 000000000..ffd9a3d86
--- /dev/null
+++ b/travis/travis.ubuntu.latest.sh
@@ -0,0 +1 @@
+travis.debian.stable.sh
\ No newline at end of file
diff --git a/travis/travis.ubuntu.xenial.sh b/travis/travis.ubuntu.xenial.sh
new file mode 120000
index 000000000..ffd9a3d86
--- /dev/null
+++ b/travis/travis.ubuntu.xenial.sh
@@ -0,0 +1 @@
+travis.debian.stable.sh
\ No newline at end of file
-- 
2.19.2

