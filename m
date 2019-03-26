From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Mar 2019 13:52:03 +0100
Subject: [LTP] [PATCH 2/2] travis: Reorder builds to speedup testing
In-Reply-To: <20190326125203.21104-1-pvorel@suse.cz>
References: <20190326125203.21104-1-pvorel@suse.cz>
Message-ID: <20190326125203.21104-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fedora job is slow (12 min vs. ~8 min others), therefore it should be
started earlier (there are 5 jobs running at once, for Fedora we wait
about 3 mins).

Move Centos 6 job up as it's usually the one failing due missing
features (constants etc.) in kernel headers.

Move up openSUSE jobs up, as they're sometimes slow as well.

Reorder Debian oldstable and testing jobs (they were sorted by the OS
release, it's more likely to find a bug in different OS release than
different compiler).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8c3aa241d..a29551650 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -14,6 +14,7 @@ matrix:
         - os: linux
           env: DISTRO=debian:stable VARIANT=cross-compile.ppc64le TREE="out"
           compiler: powerpc64le-linux-gnu-gcc
+
         - os: linux
           env: DISTRO=debian:stable VARIANT=cross-compile.aarch64 TREE="out"
           compiler: aarch64-linux-gnu-gcc
@@ -23,27 +24,22 @@ matrix:
           env: DISTRO=debian:stable VARIANT=minimal TREE="out"
           compiler: clang
 
+        # other builds
         - os: linux
-          env: DISTRO=debian:testing
-          compiler: gcc
-        - os: linux
-          env: DISTRO=debian:testing
+          env: DISTRO=fedora:latest
           compiler: clang
 
         - os: linux
-          env: DISTRO=debian:oldstable
+          env: DISTRO=centos:6 TREE="out"
           compiler: gcc
-        - os: linux
-          env: DISTRO=debian:oldstable
-          compiler: clang
 
         - os: linux
-          env: DISTRO=ubuntu:latest TREE="out"
+          env: DISTRO=debian:testing
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:xenial
-          compiler: gcc
+          env: DISTRO=debian:oldstable
+          compiler: clang
 
         - os: linux
           env: DISTRO=opensuse/tumbleweed
@@ -54,14 +50,23 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=fedora:latest
+          env: DISTRO=debian:oldstable
+          compiler: gcc
+
+        - os: linux
+          env: DISTRO=debian:testing
           compiler: clang
 
         - os: linux
-          env: DISTRO=centos:latest
+          env: DISTRO=ubuntu:latest TREE="out"
           compiler: gcc
+
         - os: linux
-          env: DISTRO=centos:6 TREE="out"
+          env: DISTRO=ubuntu:xenial
+          compiler: gcc
+
+        - os: linux
+          env: DISTRO=centos:latest
           compiler: gcc
 
 before_install:
-- 
2.21.0

