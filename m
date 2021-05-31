From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 May 2021 18:50:52 +0200
Subject: [LTP] [PATCH 3/3] CI: Move from Travis to GitHub Actions
In-Reply-To: <20210531165052.8731-1-pvorel@suse.cz>
References: <20210531165052.8731-1-pvorel@suse.cz>
Message-ID: <20210531165052.8731-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Travis is unreliable due "pull rate limit" issue.

Also using GitHub native CI allows more advanced features
(e.g. update wiki with doc/*.txt, nightly build docparser doc).

Nice bonus is that manual podman activation for distros using glibc >=
2.33 (e.g. openSUSE Tumbleweed, Fedora) it's not needed in GitHub.

Fixes: https://github.com/linux-test-project/ltp/issues/761

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested:

https://github.com/pevik/ltp/actions/runs/893331703

 .github/workflows/ci.yml | 154 +++++++++++++++++++++++++++++++++++++++
 .travis.yml              | 131 ---------------------------------
 build.sh                 |   7 --
 3 files changed, 154 insertions(+), 138 deletions(-)
 create mode 100644 .github/workflows/ci.yml
 delete mode 100644 .travis.yml

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
new file mode 100644
index 000000000..c74b4349a
--- /dev/null
+++ b/.github/workflows/ci.yml
@@ -0,0 +1,154 @@
+name: "CI: docker based builds"
+on: [push, pull_request]
+
+jobs:
+  job:
+    runs-on: ubuntu-latest
+
+    strategy:
+      fail-fast: false
+      matrix:
+        include:
+          # 32bit build
+          - container: "debian:stable"
+            env:
+              CC: gcc
+              VARIANT: i386
+
+          # cross compilation builds
+          - container: "debian:stable"
+            env:
+              ARCH: ppc64el
+              CC: powerpc64le-linux-gnu-gcc
+              MAKE_INSTALL: 1
+              TREE: out
+              VARIANT: cross-compile
+
+          - container: "debian:stable"
+            env:
+              ARCH: arm64
+              CC: aarch64-linux-gnu-gcc
+              MAKE_INSTALL: 1
+              TREE: out
+              VARIANT: cross-compile
+
+          - container: "debian:stable"
+            env:
+              ARCH: s390x
+              CC: s390x-linux-gnu-gcc
+              MAKE_INSTALL: 1
+              TREE: out
+              VARIANT: cross-compile
+
+          # musl (native)
+          - container: "alpine:latest"
+            env:
+              CC: gcc
+              METADATA: asciidoctor
+
+          # build with minimal dependencies
+          - container: "debian:stable"
+            env:
+              CC: clang
+              TREE: out
+              VARIANT: minimal
+
+          # other builds
+          - container: "fedora:latest"
+            env:
+              CC: clang
+              MAKE_INSTALL: 1
+              METADATA: asciidoctor-pdf
+
+          - container: "centos:7"
+            env:
+              CC: gcc
+              METADATA: asciidoc-pdf
+              TREE: out
+
+          - container: "debian:testing"
+            env:
+              CC: gcc
+              METADATA: asciidoctor-pdf
+
+          - container: "debian:oldstable"
+            env:
+              CC: clang
+              METADATA: asciidoc-pdf
+
+          - container: "opensuse/tumbleweed"
+            env:
+              CC: gcc
+              METADATA: asciidoctor
+
+          - container: "opensuse/leap"
+            env:
+              CC: gcc
+              METADATA: asciidoc-pdf
+
+          - container: "debian:oldstable"
+            env:
+              CC: gcc
+              METADATA: asciidoctor
+
+          - container: "debian:testing"
+            env:
+              CC: clang
+              METADATA: asciidoc-pdf
+
+          - container: "ubuntu:groovy"
+            env:
+              CC: gcc
+              METADATA: asciidoctor
+              TREE: out
+
+          - container: "ubuntu:xenial"
+            env:
+              CC: gcc
+              METADATA: asciidoc-pdf
+
+          - container: "centos:latest"
+            env:
+              CC: gcc
+              METADATA: asciidoctor
+
+    container:
+      image: ${{ matrix.container }}
+      env: ${{ matrix.env }}
+
+    steps:
+    - name: Show OS
+      run: cat /etc/os-release
+
+    - name: Git checkout
+      uses: actions/checkout@v1
+
+    - name: Install additional packages
+      run: |
+        INSTALL=${{ matrix.container }}
+        INSTALL="${INSTALL%%:*}"
+        INSTALL="${INSTALL%%/*}"
+        ./ci/$INSTALL.sh
+        if [ "$VARIANT" ]; then ./ci/$INSTALL.$VARIANT.sh; fi
+
+    - name: ver_linux
+      run: ./ver_linux
+
+    - name: Autotools
+      run: ./build.sh -r autotools
+
+    - name: Configure
+      run: |
+        if [ "$METADATA" = "asciidoc-pdf" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoc --enable-metadata-pdf"; fi
+        if [ "$METADATA" = "asciidoctor" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoctor"; fi
+        if [ "$METADATA" = "asciidoctor-pdf" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoctor --enable-metadata-pdf"; fi
+        case "$VARIANT" in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
+        CONFIGURE_OPT_EXTRA="$CONFIGURE_OPT_EXTRA" ./build.sh -r configure -o ${TREE:-in} -t $BUILD -c $CC
+
+    - name: Compile
+      run: ./build.sh -r build -o ${TREE:-in}
+
+    - name: Install
+      run: |
+        if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
+        ./build.sh -r install -o ${TREE:-in} $INSTALL_OPT
diff --git a/.travis.yml b/.travis.yml
deleted file mode 100644
index d0c88da45..000000000
--- a/.travis.yml
+++ /dev/null
@@ -1,131 +0,0 @@
-# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
-
-dist: bionic
-sudo: required
-language: c
-services:
-    - docker
-
-matrix:
-    include:
-        # 32 bit build
-        - os: linux
-          env: DISTRO=debian:stable VARIANT=i386
-          compiler: gcc
-
-        # cross compilation builds
-        - os: linux
-          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=ppc64el TREE=out MAKE_INSTALL=1
-          compiler: powerpc64le-linux-gnu-gcc
-
-        - os: linux
-          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=arm64 TREE=out
-          compiler: aarch64-linux-gnu-gcc
-
-        - os: linux
-          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=s390x TREE=out
-          compiler: s390x-linux-gnu-gcc
-
-        # musl (native)
-        - os: linux
-          # Message: WARNING: xsltproc: cannot process http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl
-          # doc/meson.build:70:1: ERROR: Problem encountered: Docs cannot be built: xsltproc does not work correctly
-          env: DISTRO=alpine:latest METADATA=asciidoctor
-          compiler: gcc
-
-        # build with minimal dependencies
-        - os: linux
-          env: DISTRO=debian:stable VARIANT=minimal TREE=out
-          compiler: clang
-
-        # other builds
-        - os: linux
-          env: DISTRO=fedora:latest MAKE_INSTALL=1 CONTAINER=podman METADATA=asciidoctor-pdf
-          compiler: clang
-
-        - os: linux
-          env: DISTRO=centos:7 TREE=out METADATA=asciidoc-pdf
-          compiler: gcc
-
-        - os: linux
-          env: DISTRO=debian:testing METADATA=asciidoctor-pdf
-          compiler: gcc
-
-        - os: linux
-          env: DISTRO=debian:oldstable METADATA=asciidoc-pdf
-          compiler: clang
-
-        - os: linux
-          env: DISTRO=opensuse/tumbleweed CONTAINER=podman METADATA=asciidoctor
-          compiler: gcc
-
-        - os: linux
-          env: DISTRO=opensuse/leap METADATA=asciidoc-pdf
-          compiler: gcc
-
-        - os: linux
-          env: DISTRO=debian:oldstable METADATA=asciidoctor
-          compiler: gcc
-
-        - os: linux
-          env: DISTRO=debian:testing METADATA=asciidoc-pdf
-          compiler: clang
-
-        - os: linux
-          env: DISTRO=ubuntu:groovy TREE=out METADATA=asciidoctor
-          compiler: gcc
-
-        - os: linux
-          env: DISTRO=ubuntu:xenial METADATA=asciidoc-pdf
-          compiler: gcc
-
-        - os: linux
-          env: DISTRO=centos:latest METADATA=asciidoctor
-          compiler: gcc
-
-before_install:
-    - CONTAINER="${CONTAINER:-docker}"
-    # distros with glibc >=2.33 require podman and newest runc due docker faccessat2 incompatibility
-    - >
-        if [ "$CONTAINER" = "podman" ]; then
-            # podman
-            CONTAINER_ARGS="--runtime=/usr/bin/runc"
-            . /etc/os-release
-            sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
-            wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
-            sudo apt update
-            sudo apt -y install podman slirp4netns
-
-            # runc
-            sudo curl -L https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64 -o /usr/bin/runc
-            sudo chmod +x /usr/bin/runc
-        fi
-
-    # Docker Hub pull rate limit workaround for docker
-    - >
-        if [ "$CONTAINER" = "docker" ]; then
-            conf="/etc/docker/daemon.json"
-            tmp=$(mktemp)
-            sudo jq '."registry-mirrors" += ["https://mirror.gcr.io"]' $conf > $tmp
-            sudo mv $tmp $conf
-            sudo systemctl daemon-reload
-            sudo systemctl restart docker
-        fi
-    - $CONTAINER info
-
-    # ltp
-    - DIR="/usr/src/ltp"
-    - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n" > Dockerfile
-    - cat Dockerfile
-    - $CONTAINER build $CONTAINER_ARGS -t ltp .
-
-script:
-    - INSTALL="${DISTRO%%:*}"
-    - INSTALL="${INSTALL%%/*}"
-    - if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
-    - if [ "$METADATA" = "asciidoc-pdf" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoc --enable-metadata-pdf"; fi
-    - if [ "$METADATA" = "asciidoctor" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoctor"; fi
-    - if [ "$METADATA" = "asciidoctor-pdf" ]; then CONFIGURE_OPT_EXTRA="--with-metadata-generator=asciidoctor --enable-metadata-pdf"; fi
-    - if [ ! "$TREE" ]; then TREE="in"; fi
-    - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
-    - $CONTAINER run $CONTAINER_ARGS -t ltp /bin/sh -c "cd ci && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && CONFIGURE_OPT_EXTRA=\"$CONFIGURE_OPT_EXTRA\" ../build.sh -o $TREE -t $BUILD -c $CC $INSTALL_OPT"
diff --git a/build.sh b/build.sh
index b3b1eb962..f58a6dae8 100755
--- a/build.sh
+++ b/build.sh
@@ -210,13 +210,6 @@ done
 
 cd $SRC_DIR
 
-echo "=== ver_linux ==="
-./ver_linux
-echo
-
-echo "=== compiler version ==="
-$CC --version
-
 if [ -z "$run" -o "$run" = "autotools" ]; then
 	make autotools
 fi
-- 
2.31.1

