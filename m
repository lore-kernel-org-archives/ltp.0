From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Jan 2017 12:06:32 +0100
Subject: [LTP] [PATCH 1/1] travis: use various gcc and clang versions +
	using containers
Message-ID: <20170112110632.11906-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using containers is declared to be faster, but does not allow us to use
sudo => install into $HOME.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Used gcc: 4.6, 4.7, 4.8. 4.9, 5, 6
Used clang: 3.3, 3.5, 3.8, 3.9
We can have quite a lot of versions, say what you prefer.

See result:
https://travis-ci.org/pevik-travis/ltp/builds/191263858
---
 .travis.yml | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 16c0cd477..b71b7c5d1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,9 +1,99 @@
-sudo: required
-
 language: c
 
+matrix:
+    include:
+        - os: linux
+          compiler: gcc
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.6']
+          env:
+              - COMPILER=gcc-4.6
+
+        - os: linux
+          compiler: gcc
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.7']
+          env:
+              - COMPILER=gcc-4.7
+
+        - os: linux
+          compiler: gcc
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.8']
+          env:
+              - COMPILER=gcc-4.8
+
+        - os: linux
+          compiler: gcc
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.9']
+          env:
+              - COMPILER=gcc-4.9
+
+        - os: linux
+          compiler: gcc
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-5']
+          env:
+              - COMPILER=gcc-5
+
+        - os: linux
+          compiler: gcc
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-6']
+          env:
+              - COMPILER=gcc-6
+
+        - os: linux
+          compiler: clang
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise-3.3']
+                  packages: ['clang-3.3']
+          env:
+              - COMPILER=clang-3.3
+
+        - os: linux
+          compiler: clang
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise-3.5']
+                  packages: ['clang-3.5']
+          env:
+              - COMPILER=clang-3.5
+
+        - os: linux
+          compiler: clang
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise-3.8']
+                  packages: ['clang-3.8']
+          env:
+              - COMPILER=clang-3.8
+
+        - os: linux
+          compiler: clang
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise']
+                  packages: ['clang-3.9']
+          env:
+              - COMPILER=clang-3.9
+
 notifications:
     email:
         - ltp@lists.linux.it
 
-script: make autotools && ./configure --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
+script: make autotools && ./configure --prefix $HOME/ltp --with-open-posix-testsuite --with-realtime-testsuite && make CXX=$COMPILER -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
-- 
2.11.0

