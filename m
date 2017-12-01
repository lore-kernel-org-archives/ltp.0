From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Dec 2017 16:46:39 +0100
Subject: [LTP] [RFC PATCH v2 3/5] travis: Add 32-bit cross-compile builds
In-Reply-To: <20171201154641.27407-1-pvorel@suse.cz>
References: <20171201154641.27407-1-pvorel@suse.cz>
Message-ID: <20171201154641.27407-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Choosen gcc 4.9 and 6 (to use old and some quite new version).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 8aea22d01..3ca37e47a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -3,6 +3,7 @@ language: c
 matrix:
     include:
         - os: linux
+          env: BUILD="native"
           compiler: gcc-4.9
           addons:
               apt:
@@ -10,6 +11,7 @@ matrix:
                   packages: ['gcc-4.9']
 
         - os: linux
+          env: BUILD="native"
           compiler: gcc-5
           addons:
               apt:
@@ -17,6 +19,7 @@ matrix:
                   packages: ['gcc-5']
 
         - os: linux
+          env: BUILD="native"
           compiler: gcc-6
           addons:
               apt:
@@ -24,6 +27,7 @@ matrix:
                   packages: ['gcc-6']
 
         - os: linux
+          env: BUILD="native"
           compiler: gcc-7
           addons:
               apt:
@@ -31,6 +35,7 @@ matrix:
                   packages: ['gcc-7']
 
         - os: linux
+          env: BUILD="native"
           compiler: clang-3.9
           addons:
               apt:
@@ -38,6 +43,7 @@ matrix:
                   packages: ['clang-3.9']
 
         - os: linux
+          env: BUILD="native"
           compiler: clang-4.0
           addons:
               apt:
@@ -45,14 +51,32 @@ matrix:
                   packages: ['clang-4.0']
 
         - os: linux
+          env: BUILD="native"
           compiler: clang-5.0
           addons:
               apt:
                   sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-5.0']
                   packages: ['clang-5.0']
 
+        - os: linux
+          env: BUILD="32"
+          compiler: gcc-4.9
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.9', 'gcc-4.9-multilib', 'linux-libc-dev:i386']
+
+        - os: linux
+          env: BUILD="32"
+          compiler: gcc-6
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-6', 'gcc-6-multilib', 'linux-libc-dev:i386']
+
 notifications:
     email:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
 
-script: ./build.sh
+before_install:
+script: ./build.sh $BUILD
-- 
2.15.0

