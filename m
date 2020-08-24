From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 24 Aug 2020 14:36:24 +0800
Subject: [LTP] [PATCH] travis: Add centos7 build
Message-ID: <1598250984-5141-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I have this idea when I meet ALG_SET_AEAD_ASSOCLEN undefined error on centos7.
Add centos7 travis target, it is more friendly for centos7 user and it is more
meaningful than centos6.

I have tested this patch on my ltp fork:
https://travis-ci.org/github/xuyang0410/ltp/jobs/720541105

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .travis.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index e8e3189af..281ec9e96 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -47,6 +47,10 @@ matrix:
           env: DISTRO=centos:6 TREE=out
           compiler: gcc
 
+        - os: linux
+          env: DISTRO=centos:7 TREE=out
+          compiler: gcc
+
         - os: linux
           env: DISTRO=debian:testing
           compiler: gcc
-- 
2.23.0



