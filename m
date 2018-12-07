From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Dec 2018 10:31:26 +0100
Subject: [LTP] [PATCH 1/1] travis: Use gcc 8 and clang 7
Message-ID: <20181207093126.12901-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replacing gcc 5 with gcc 8 and clang 4 with clang 7.
This gives us shiny new versions, older and very old ones, while
still keeping the same number of jobs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 078028f9b..f4e9bfe9d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,11 +11,11 @@ matrix:
         ### native builds ###
         - os: linux
           env: BUILD="native" INSTALL_PACKAGES="$BUILD"
-          compiler: gcc-5
+          compiler: gcc-8
           addons:
               apt:
                   sources: ['ubuntu-toolchain-r-test']
-                  packages: ['gcc-5']
+                  packages: ['gcc-8']
 
         - os: linux
           env: BUILD="native" TREE="out" INSTALL_PACKAGES="$BUILD"
@@ -27,11 +27,11 @@ matrix:
 
         - os: linux
           env: BUILD="native" TREE="out"
-          compiler: clang-4.0
+          compiler: clang-7
           addons:
               apt:
-                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-4.0']
-                  packages: ['clang-4.0']
+                  sources: ['ubuntu-toolchain-r-test', 'llvm-toolchain-trusty-7']
+                  packages: ['clang-7']
 
         - os: linux
           env: BUILD="native" INSTALL_PACKAGES="$BUILD"
-- 
2.19.2

