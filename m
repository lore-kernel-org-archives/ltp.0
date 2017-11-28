From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 00:21:28 +0100
Subject: [LTP] [RFC PATCH 2/4] travis: Add 32 cross-compile build + use
	build.sh
In-Reply-To: <20171128232130.4843-1-pvorel@suse.cz>
References: <20171128232130.4843-1-pvorel@suse.cz>
Message-ID: <20171128232130.4843-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index f2d51f131..347cae5e8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -3,6 +3,7 @@ language: c
 matrix:
     include:
         - os: linux
+          env: BUILD="normal"
           compiler: gcc-4.6
           addons:
               apt:
@@ -10,6 +11,7 @@ matrix:
                   packages: ['gcc-4.6']
 
         - os: linux
+          env: BUILD="normal"
           compiler: gcc-4.7
           addons:
               apt:
@@ -17,6 +19,7 @@ matrix:
                   packages: ['gcc-4.7']
 
         - os: linux
+          env: BUILD="normal"
           compiler: gcc-4.8
           addons:
               apt:
@@ -24,6 +27,7 @@ matrix:
                   packages: ['gcc-4.8']
 
         - os: linux
+          env: BUILD="normal"
           compiler: gcc-4.9
           addons:
               apt:
@@ -31,6 +35,7 @@ matrix:
                   packages: ['gcc-4.9']
 
         - os: linux
+          env: BUILD="normal"
           compiler: gcc-5
           addons:
               apt:
@@ -38,6 +43,7 @@ matrix:
                   packages: ['gcc-5']
 
         - os: linux
+          env: BUILD="normal"
           compiler: gcc-6
           addons:
               apt:
@@ -45,6 +51,7 @@ matrix:
                   packages: ['gcc-6']
 
         - os: linux
+          env: BUILD="normal"
           compiler: clang-3.5
           addons:
               apt:
@@ -52,6 +59,7 @@ matrix:
                   packages: ['clang-3.5']
 
         - os: linux
+          env: BUILD="normal"
           compiler: clang-3.8
           addons:
               apt:
@@ -59,6 +67,7 @@ matrix:
                   packages: ['clang-3.8']
 
         - os: linux
+          env: BUILD="normal"
           compiler: clang-3.9
           addons:
               apt:
@@ -68,8 +77,17 @@ matrix:
                       - 'ubuntu-toolchain-r-test'
                   packages: ['clang-3.9']
 
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

