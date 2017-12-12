From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Dec 2017 18:45:44 +0100
Subject: [LTP] [RFC PATCH 2/2] travis: Add 2x cross-compile ARM build
In-Reply-To: <20171212174544.12310-1-pvorel@suse.cz>
References: <20171212174544.12310-1-pvorel@suse.cz>
Message-ID: <20171212174544.12310-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use arm-linux-gnueabihf-gcc and aarch64-linux-gnu-gcc compilers.

Cross-compile builds have just minimal dependencies (kernel and glibc
headers).

Builds replace native gcc-4.9 and gcc-6 builds to keep max 10 build
jobs in travis.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 2087e4174..74838be7c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -4,14 +4,6 @@ matrix:
     include:
 
         # normal native in-tree builds
-        - os: linux
-          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-4.9
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-4.9']
-
         - os: linux
           env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-5
@@ -20,14 +12,6 @@ matrix:
                   sources: ['ubuntu-toolchain-r-test']
                   packages: ['gcc-5']
 
-        - os: linux
-          env: BUILD="native" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-6
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-6']
-
         - os: linux
           env: BUILD="native" INSTALL_PACKAGES="$BUILD"
           compiler: gcc-7
@@ -87,6 +71,21 @@ matrix:
                   sources: ['ubuntu-toolchain-r-test']
                   packages: ['gcc-7']
 
+        # cross-compile ARM builds
+        - os: linux
+          env: BUILD="cross" INSTALL_PACKAGES="$BUILD"
+          compiler: arm-linux-gnueabihf-gcc
+          addons:
+              apt:
+                  packages: ['gcc-arm-linux-gnueabihf', 'libc6-dev-armhf-cross']
+
+        - os: linux
+          env: BUILD="cross" INSTALL_PACKAGES="$BUILD"
+          compiler: aarch64-linux-gnu-gcc
+          addons:
+              apt:
+                  packages: ['gcc-aarch64-linux-gnu', 'libc6-dev-arm64-cross']
+
 notifications:
     email:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
@@ -95,7 +94,7 @@ before_install:
     # installing / removing dependencies
     - if [ "$INSTALL_PACKAGES" = "" ]; then
           sudo apt remove $(cat .travis.packages_native | grep -v -e 'libc6' -e 'libc6-dev' -e 'linux-libc-dev' -e 'libacl1')
-      ; else
+      ; elif [ "$INSTALL_PACKAGES" != "cross" ]; then
           sudo apt install -qq $(cat .travis.packages_native)
       ; fi
 
-- 
2.15.0

