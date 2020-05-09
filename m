From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Sat, 9 May 2020 12:42:54 +0800
Subject: [LTP] [PATCH] travis: Enable fedora:lastest again
Message-ID: <1588999374-22808-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fedora:lastest docker image has been updated, it doesn't have file
conflicts problem with libtirpc rpm. So enable fedora:lastest again.

url:
https://travis-ci.org/github/xuyang0410/ltp/jobs/684940178

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index f918f6e40..9505ed9ba 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -45,7 +45,7 @@ matrix:
 
         # other builds
         - os: linux
-          env: DISTRO=fedora:rawhide MAKE_INSTALL=1
+          env: DISTRO=fedora:latest MAKE_INSTALL=1
           compiler: clang
 
         - os: linux
-- 
2.23.0



