From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  4 Dec 2017 13:25:53 +0100
Subject: [LTP] [RFC PATCH v3 5/5] travis: Install all dependencies + add
	build with minimal dependencies
In-Reply-To: <20171204122553.15338-1-pvorel@suse.cz>
References: <20171204122553.15338-1-pvorel@suse.cz>
Message-ID: <20171204122553.15338-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently travis has installed toolchain with libraries, glibc and
kernel headers so some of the packages listed are already installed.

Install all dependencies (headers and libraries).
The only exception is selinux support on 32bit build as as
libsepol1-dev:i386 conflict with libsepol1-dev for amd64, thus both
cannot be installed.

During reinstallation for build with minimal dependencies we need to
filter out some packages as toolchain package depends on it.

For minimal build chosen gcc 6 (relativelly recent gcc version, but not
too new).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.packages_i386   |  9 +++++++++
 .travis.packages_native | 18 ++++++++++++++++++
 .travis.yml             | 44 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 61 insertions(+), 10 deletions(-)
 create mode 100644 .travis.packages_i386
 create mode 100644 .travis.packages_native

diff --git a/.travis.packages_i386 b/.travis.packages_i386
new file mode 100644
index 000000000..725329041
--- /dev/null
+++ b/.travis.packages_i386
@@ -0,0 +1,9 @@
+libacl1:i386
+libaio1:i386
+libcap2:i386
+libc6-dev-i386
+libc6:i386
+libkeyutils1:i386
+libnuma1:i386
+libssl-dev:i386
+libtirpc1:i386
diff --git a/.travis.packages_native b/.travis.packages_native
new file mode 100644
index 000000000..d9e1a2acc
--- /dev/null
+++ b/.travis.packages_native
@@ -0,0 +1,18 @@
+libacl1
+libacl1-dev
+libaio-dev
+libaio1
+libcap-dev
+libcap2
+libc6
+libc6-dev
+libkeyutils-dev
+libkeyutils1
+libmm-dev
+libnuma-dev
+libnuma1
+libselinux1-dev
+libsepol1-dev
+libssl-dev
+libtirpc1
+linux-libc-dev
diff --git a/.travis.yml b/.travis.yml
index cc5627412..da79e1f9d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -2,8 +2,10 @@ language: c
 
 matrix:
     include:
+
+        # normal native in-tree builds
         - os: linux
-          env: BUILD="native"
+          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-4.9
           addons:
               apt:
@@ -11,7 +13,7 @@ matrix:
                   packages: ['gcc-4.9']
 
         - os: linux
-          env: BUILD="native"
+          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-5
           addons:
               apt:
@@ -19,7 +21,7 @@ matrix:
                   packages: ['gcc-5']
 
         - os: linux
-          env: BUILD="native"
+          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-6
           addons:
               apt:
@@ -27,7 +29,7 @@ matrix:
                   packages: ['gcc-6']
 
         - os: linux
-          env: BUILD="native"
+          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-7
           addons:
               apt:
@@ -35,7 +37,7 @@ matrix:
                   packages: ['gcc-7']
 
         - os: linux
-          env: BUILD="native"
+          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: clang-3.9
           addons:
               apt:
@@ -43,7 +45,7 @@ matrix:
                   packages: ['clang-3.9']
 
         - os: linux
-          env: BUILD="native"
+          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: clang-4.0
           addons:
               apt:
@@ -51,15 +53,25 @@ matrix:
                   packages: ['clang-4.0']
 
         - os: linux
-          env: BUILD="native"
+          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: clang-5.0
           addons:
               apt:
                   sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-5.0']
                   packages: ['clang-5.0']
 
+        # minimal build (some headers and libraries are missing)
+        - os: linux
+          env: BUILD="native"
+          compiler: gcc-6
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-6']
+
+        # 32-bit in-tree cross-compile builds
         - os: linux
-          env: BUILD="32"
+          env: BUILD="32" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-4.9
           addons:
               apt:
@@ -67,15 +79,16 @@ matrix:
                   packages: ['gcc-4.9', 'gcc-4.9-multilib', 'linux-libc-dev:i386']
 
         - os: linux
-          env: BUILD="32"
+          env: BUILD="32" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-6
           addons:
               apt:
                   sources: ['ubuntu-toolchain-r-test']
                   packages: ['gcc-6', 'gcc-6-multilib', 'linux-libc-dev:i386']
 
+        # out-of-tree build
         - os: linux
-          env: BUILD="out"
+          env: BUILD="out" INSTALL_PACKAGES="native"
           compiler: gcc-7
           addons:
               apt:
@@ -87,4 +100,15 @@ notifications:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
 
 before_install:
+    # installing / removing dependencies
+    - if [ "$INSTALL_PACKAGES" = "" ]; then
+          sudo apt remove $(cat .travis.packages_native | grep -v -e 'libc6' -e 'libc6-dev' -e 'linux-libc-dev' -e 'libacl1')
+      ; else
+          sudo apt install -qq $(cat .travis.packages_native)
+      ; fi
+
+    - if [ "$INSTALL_PACKAGES" = "32" ]; then
+          sudo apt install -qq $(cat .travis.packages_i386)
+      ; fi
+
 script: ./build.sh $BUILD
-- 
2.15.0

