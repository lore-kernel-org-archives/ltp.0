From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Jan 2020 11:34:12 +0100
Subject: [LTP] [PATCH 3/4] travis: Merge debian.cross-compile.*.sh
In-Reply-To: <20200108103413.29096-1-pvorel@suse.cz>
References: <20200108103413.29096-1-pvorel@suse.cz>
Message-ID: <20200108103413.29096-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml                            |  6 +++---
 travis/debian.cross-compile.aarch64.sh | 11 -----------
 travis/debian.cross-compile.ppc64le.sh | 11 -----------
 travis/debian.cross-compile.sh         | 16 ++++++++++++++++
 4 files changed, 19 insertions(+), 25 deletions(-)
 delete mode 100755 travis/debian.cross-compile.aarch64.sh
 delete mode 100755 travis/debian.cross-compile.ppc64le.sh
 create mode 100755 travis/debian.cross-compile.sh

diff --git a/.travis.yml b/.travis.yml
index 51efa22e3..d777a94c6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -12,11 +12,11 @@ matrix:
 
         # cross compilation builds
         - os: linux
-          env: DISTRO=debian:stable VARIANT=cross-compile.ppc64le TREE="out"
+          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=ppc64el TREE="out"
           compiler: powerpc64le-linux-gnu-gcc
 
         - os: linux
-          env: DISTRO=debian:stable VARIANT=cross-compile.aarch64 TREE="out"
+          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=arm64 TREE="out"
           compiler: aarch64-linux-gnu-gcc
 
         # musl (native)
@@ -98,4 +98,4 @@ script:
     - INSTALL="${INSTALL%%/*}"
     - if [ ! "$TREE" ]; then TREE="in"; fi
     - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
-    - docker run -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
+    - docker run -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
diff --git a/travis/debian.cross-compile.aarch64.sh b/travis/debian.cross-compile.aarch64.sh
deleted file mode 100755
index cc1eda5b5..000000000
--- a/travis/debian.cross-compile.aarch64.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
-set -e
-
-dpkg --add-architecture arm64
-apt update
-
-apt install -y --no-install-recommends \
-	gcc-aarch64-linux-gnu \
-	libc6-dev-arm64-cross \
-	libtirpc-dev:arm64
diff --git a/travis/debian.cross-compile.ppc64le.sh b/travis/debian.cross-compile.ppc64le.sh
deleted file mode 100755
index 671867d31..000000000
--- a/travis/debian.cross-compile.ppc64le.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
-set -e
-
-dpkg --add-architecture ppc64el
-apt update
-
-apt install -y --no-install-recommends \
-	gcc-powerpc64le-linux-gnu \
-	libc6-dev-ppc64el-cross \
-	libtirpc-dev:ppc64el
diff --git a/travis/debian.cross-compile.sh b/travis/debian.cross-compile.sh
new file mode 100755
index 000000000..2d2e609be
--- /dev/null
+++ b/travis/debian.cross-compile.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+set -e
+
+if [ -z "$ARCH" ];
+	echo "missing \$ARCH!"
+	exit 1
+fi
+
+dpkg --add-architecture $ARCH
+apt update
+
+apt install -y --no-install-recommends \
+	gcc-${ARCH}-linux-gnu \
+	libc6-dev-${ARCH}-cross \
+	libtirpc-dev:${ARCH}
-- 
2.24.1

