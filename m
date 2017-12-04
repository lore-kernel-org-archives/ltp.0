From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  4 Dec 2017 13:25:50 +0100
Subject: [LTP] [RFC PATCH v3 2/5] travis: Drop old compilers, add new ones
In-Reply-To: <20171204122553.15338-1-pvorel@suse.cz>
References: <20171204122553.15338-1-pvorel@suse.cz>
Message-ID: <20171204122553.15338-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Dropped: gcc 4.6, 4.7, 4.8 and clang 3.5, 3.8
Added: gcc 6, 7 and clang 4.0, 5.0

+ simplify code for clang 3.9 as distro trusty is default in travis
since August 2017, see:
https://docs.travis-ci.com/user/reference/overview/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index f2d51f131..8aea22d01 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -2,27 +2,6 @@ language: c
 
 matrix:
     include:
-        - os: linux
-          compiler: gcc-4.6
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-4.6']
-
-        - os: linux
-          compiler: gcc-4.7
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-4.7']
-
-        - os: linux
-          compiler: gcc-4.8
-          addons:
-              apt:
-                  sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-4.8']
-
         - os: linux
           compiler: gcc-4.9
           addons:
@@ -45,28 +24,32 @@ matrix:
                   packages: ['gcc-6']
 
         - os: linux
-          compiler: clang-3.5
+          compiler: gcc-7
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-7']
+
+        - os: linux
+          compiler: clang-3.9
           addons:
               apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise-3.5']
-                  packages: ['clang-3.5']
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-3.9']
+                  packages: ['clang-3.9']
 
         - os: linux
-          compiler: clang-3.8
+          compiler: clang-4.0
           addons:
               apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise-3.8']
-                  packages: ['clang-3.8']
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-4.0']
+                  packages: ['clang-4.0']
 
         - os: linux
-          compiler: clang-3.9
+          compiler: clang-5.0
           addons:
               apt:
-                  sources:
-                      - sourceline: "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.9 main"
-                        key_url: "http://apt.llvm.org/llvm-snapshot.gpg.key"
-                      - 'ubuntu-toolchain-r-test'
-                  packages: ['clang-3.9']
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-5.0']
+                  packages: ['clang-5.0']
 
 notifications:
     email:
-- 
2.15.0

