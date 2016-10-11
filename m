From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 11 Oct 2016 09:52:09 +0800
Subject: [LTP] [PATCH] m4/ltp-xfs_quota.m4: fix xfs quota check
Message-ID: <1476150729-2128-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current check doesn't work since xfsprogs v4.5.0.
Undefined off64_t type leads to this issue, so we
need to define _GNU_SOURCE to make off64_t defined.

This has been broken by upstream xfsporgs-dev commmit

commit cb898f157f8410a03cf5f3400baa1df9e5eecd33
Author: Felix Janda <felix.janda@posteo.de>
Date: Fri Feb 5 08:34:06 2016 +1100

  linux.h: Use off64_t instead of loff_t

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 m4/ltp-xfs_quota.m4 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/m4/ltp-xfs_quota.m4 b/m4/ltp-xfs_quota.m4
index c9ee335..c23412a 100644
--- a/m4/ltp-xfs_quota.m4
+++ b/m4/ltp-xfs_quota.m4
@@ -24,6 +24,7 @@ dnl
 AC_DEFUN([LTP_CHECK_XFS_QUOTACTL],[dnl
 	AC_MSG_CHECKING([for XFS quota (xfs/xqm.h)])
 	AC_LINK_IFELSE([AC_LANG_SOURCE([
+#define _GNU_SOURCE
 #include <xfs/xqm.h>
 #include <sys/quota.h>
 int main(void) {
-- 
1.8.3.1



