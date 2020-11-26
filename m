From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 26 Nov 2020 18:13:44 +0800
Subject: [LTP] [PATCH] travis: Remove obsolete CentOS 6
Message-ID: <20201126101344.550472-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We are planning to remove the support of old distros(e.g. CentOS 6).

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .travis.yml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 281ec9e96..3c5ff99b7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -43,10 +43,6 @@ matrix:
           env: DISTRO=fedora:latest MAKE_INSTALL=1
           compiler: clang
 
-        - os: linux
-          env: DISTRO=centos:6 TREE=out
-          compiler: gcc
-
         - os: linux
           env: DISTRO=centos:7 TREE=out
           compiler: gcc
-- 
2.25.1



