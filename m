From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 00:21:29 +0100
Subject: [LTP] [RFC PATCH 3/4] travis: Add gcc-7, clang-4.0, clang-5.0,
	remove clang-3.9
In-Reply-To: <20171128232130.4843-1-pvorel@suse.cz>
References: <20171128232130.4843-1-pvorel@suse.cz>
Message-ID: <20171128232130.4843-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 347cae5e8..2c186b71c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -50,6 +50,14 @@ matrix:
                   sources: ['ubuntu-toolchain-r-test']
                   packages: ['gcc-6']
 
+        - os: linux
+          env: BUILD="normal"
+          compiler: gcc-7
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-7']
+
         - os: linux
           env: BUILD="normal"
           compiler: clang-3.5
@@ -68,14 +76,24 @@ matrix:
 
         - os: linux
           env: BUILD="normal"
-          compiler: clang-3.9
+          compiler: clang-4.0
           addons:
               apt:
                   sources:
-                      - sourceline: "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.9 main"
+                      - sourceline: "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-4.0 main"
                         key_url: "http://apt.llvm.org/llvm-snapshot.gpg.key"
                       - 'ubuntu-toolchain-r-test'
-                  packages: ['clang-3.9']
+                  packages: ['clang-4.0']
+
+        - os: linux
+          env: BUILD="normal"
+          compiler: clang-5.0
+          addons:
+              apt:
+                  sources:
+                      - sourceline: "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-5.0 main"
+                        key_url: "http://apt.llvm.org/llvm-snapshot.gpg.key"
+                  packages: ['clang-5.0']
 
         - os: linux
           env: BUILD="32"
-- 
2.15.0

