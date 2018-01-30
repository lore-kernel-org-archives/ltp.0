From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Jan 2018 08:43:50 +0100
Subject: [LTP] [RFC PATCH 2/2] travis: Update params for build.sh + change
	builds
In-Reply-To: <20180130074350.4032-1-pvorel@suse.cz>
References: <20180130074350.4032-1-pvorel@suse.cz>
Message-ID: <20180130074350.4032-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add powerpc64le cross-compile build.
Some builds set to be out-of-tree or minimal.

We now have 10 builds, some combination of:
5x native + 2x 32-bit + 3x cross-compile
5x in-tree + 5x out-of-tree
7x full dependencies + 3x minimal dependencies

Using compilers:
gcc 4.9, 5, 6, 7,
clang 3.9, 4, 5
gcc (cross-compile): 3x 4.8.4
cross-compile archs: arm, aarch64, powerpc64le

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d89c4353b..9658ffba9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,9 +1,15 @@
 language: c
 
+# BUILD="native": native builds
+# BUILD="32": 32-bit builds
+# BUILD="cross": cross compile build
+# TREE="out": out-of-tree build
+# NO INSTALL_PACKAGES variable: build with minimal dependencies
+
 matrix:
     include:
 
-        # normal native in-tree builds
+        ### native builds ###
         - os: linux
           env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-5
@@ -13,7 +19,7 @@ matrix:
                   packages: ['gcc-5']
 
         - os: linux
-          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
+          env: BUILD="native" TREE="out" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-7
           addons:
               apt:
@@ -21,7 +27,7 @@ matrix:
                   packages: ['gcc-7']
 
         - os: linux
-          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
+          env: BUILD="native" TREE="out"
           compiler: clang-4.0
           addons:
               apt:
@@ -36,7 +42,6 @@ matrix:
                   sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-5.0']
                   packages: ['clang-5.0']
 
-        # minimal build (some headers and libraries are missing)
         - os: linux
           env: BUILD="native"
           compiler: clang-3.9
@@ -45,7 +50,7 @@ matrix:
                   sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-3.9']
                   packages: ['clang-3.9']
 
-        # 32-bit in-tree cross-compile builds
+        ### 32-bit builds ###
         - os: linux
           env: BUILD="32" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-4.9
@@ -55,23 +60,14 @@ matrix:
                   packages: ['gcc-4.9', 'gcc-4.9-multilib', 'linux-libc-dev:i386']
 
         - os: linux
-          env: BUILD="32" INSTALL_PACKAGES="$BUILD"
+          env: BUILD="32" TREE="out" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-6
           addons:
               apt:
                   sources: ['ubuntu-toolchain-r-test']
                   packages: ['gcc-6', 'gcc-6-multilib', 'linux-libc-dev:i386']
 
-        # out-of-tree build
-        - os: linux
-          env: BUILD="out" INSTALL_PACKAGES="native"
-          compiler: gcc-7
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-7']
-
-        # cross-compile ARM builds
+        ### cross-compile builds ###
         - os: linux
           env: BUILD="cross" INSTALL_PACKAGES="$BUILD"
           compiler: arm-linux-gnueabihf-gcc
@@ -80,12 +76,19 @@ matrix:
                   packages: ['gcc-arm-linux-gnueabihf', 'libc6-dev-armhf-cross']
 
         - os: linux
-          env: BUILD="cross" INSTALL_PACKAGES="$BUILD"
+          env: BUILD="cross" TREE="out" INSTALL_PACKAGES="$BUILD"
           compiler: aarch64-linux-gnu-gcc
           addons:
               apt:
                   packages: ['gcc-aarch64-linux-gnu', 'libc6-dev-arm64-cross']
 
+        - os: linux
+          env: BUILD="cross" TREE="out"
+          compiler: powerpc64le-linux-gnu-gcc
+          addons:
+              apt:
+                  packages: ['gcc-powerpc64le-linux-gnu', 'libc6-dev-ppc64el-cross']
+
 notifications:
     email:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
@@ -101,5 +104,8 @@ before_install:
     - if [ "$INSTALL_PACKAGES" = "32" ]; then
           sudo apt install -qq $(cat .travis.packages_i386)
       ; fi
+    - if [ ! "$TREE" ]; then
+          TREE="in"
+      ; fi
 
-script: ./build.sh -t $BUILD -c $CC
+script: ./build.sh -o $TREE -t $BUILD -c $CC
-- 
2.16.0

