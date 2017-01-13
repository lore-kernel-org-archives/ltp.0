From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Jan 2017 10:07:05 +0100
Subject: [LTP] [PATCH v2 1/2] travis: use various gcc and clang versions +
	using containers
Message-ID: <20170113090706.29130-1-pvorel@suse.cz>
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
Used clang: 3.5, 3.8, 3.9

I simplified patch. This way we cannot install clang-3.3, but I suppose it's ok.
Which versions are you interested? We can have even more versions, but even this subset is IMHO quite a lot.

Whole check takes about 12 min, see https://travis-ci.org/pevik-travis/ltp/builds/191565390
---
 .travis.yml | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 16c0cd477..86b96d630 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,9 +1,75 @@
-sudo: required
-
 language: c
 
+matrix:
+    include:
+        - os: linux
+          compiler: gcc-4.6
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.6']
+
+        - os: linux
+          compiler: gcc-4.7
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.7']
+
+        - os: linux
+          compiler: gcc-4.8
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.8']
+
+        - os: linux
+          compiler: gcc-4.9
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-4.9']
+
+        - os: linux
+          compiler: gcc-5
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-5']
+
+        - os: linux
+          compiler: gcc-6
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test']
+                  packages: ['gcc-6']
+
+        - os: linux
+          compiler: clang-3.5
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise-3.5']
+                  packages: ['clang-3.5']
+
+        - os: linux
+          compiler: clang-3.8
+          addons:
+              apt:
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-precise-3.8']
+                  packages: ['clang-3.8']
+
+        - os: linux
+          compiler: clang-3.9
+          addons:
+              apt:
+                  sources:
+                      - sourceline: "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-3.9 main"
+                        key_url: "http://apt.llvm.org/llvm-snapshot.gpg.key"
+                      - 'ubuntu-toolchain-r-test'
+                  packages: ['clang-3.9']
+
 notifications:
     email:
         - ltp@lists.linux.it
 
-script: make autotools && ./configure --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
+script: make autotools && ./configure --prefix $HOME/ltp --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
-- 
2.11.0

