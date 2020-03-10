From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 10 Mar 2020 18:02:57 +0800
Subject: [LTP] [PATCH] travis: Temporarily disable fedora:lastest
Message-ID: <1583834577-21695-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Docker hub image for fedora:lastest has problem, so it will
install x86_64 and i686 rpm together. It will lead to file
conflict as below:
 file /etc/bindresvport.blacklist from install of libtirpc-1.2.5-1.rc2.fc31.i686
conflicts with file from package libtirpc-1.2.5-0.fc31.x86_64

I have created a github issue[1] for it on fedora-cloud.

[1]https://github.com/fedora-cloud/docker-brew-fedora/issues/73

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .travis.yml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index f7d73f051..68d98406d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -43,11 +43,6 @@ matrix:
           compiler: gcc
           env: DISTRO=debian:testing
 
-        # other builds
-        - os: linux
-          env: DISTRO=fedora:latest MAKE_INSTALL=1
-          compiler: clang
-
         - os: linux
           env: DISTRO=centos:6 TREE=out
           compiler: gcc
-- 
2.18.0



