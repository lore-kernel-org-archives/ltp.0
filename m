From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 30 Jul 2019 13:45:31 +0800
Subject: [LTP] [PATCH v3 3/5] m4:remove useless ltp-fs_ioc_flags.m4
In-Reply-To: <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190729144227.GA8824@dell5510>
 <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1564465533-2475-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

FS_IOC_GETFLAGS and FS_IOC_SETFLAGS have been defined in lapi/fs.h.
setxattr03.c checked this ioctl return value, so removing it is safe.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac                                    |  1 -
 m4/ltp-fs_ioc_flags.m4                          | 11 -----------
 testcases/kernel/syscalls/setxattr/setxattr03.c |  9 ++++-----
 3 files changed, 4 insertions(+), 17 deletions(-)
 delete mode 100644 m4/ltp-fs_ioc_flags.m4

diff --git a/configure.ac b/configure.ac
index b0eddcbf8..70c6fef5b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -214,7 +214,6 @@ LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_CRYPTO
 LTP_CHECK_FIDEDUPE
 LTP_CHECK_FORTIFY_SOURCE
-LTP_CHECK_FS_IOC_FLAGS
 LTP_CHECK_FTS_H
 LTP_CHECK_IF_LINK
 LTP_CHECK_IOVEC
diff --git a/m4/ltp-fs_ioc_flags.m4 b/m4/ltp-fs_ioc_flags.m4
deleted file mode 100644
index 79fffd27b..000000000
--- a/m4/ltp-fs_ioc_flags.m4
+++ /dev/null
@@ -1,11 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) Linux Test Project, 2012
-dnl Author: Cyril Hrubis <chrubis@suse.cz>
-
-AC_DEFUN([LTP_CHECK_FS_IOC_FLAGS],[
-AH_TEMPLATE(HAVE_FS_IOC_FLAGS,
-[Define to 1 if you have FS_IOC_GETFLAGS and FS_IOC_SETFLAGS in <linux/fs.h>.])
-AC_MSG_CHECKING([for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS in <linux/fs.h>])
-AC_TRY_COMPILE([#include <linux/fs.h>], [int flags = FS_IOC_GETFLAGS;],
-               AC_DEFINE(HAVE_FS_IOC_FLAGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
-])
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index a2f6cbf36..4215a21f4 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -47,14 +47,14 @@
 #ifdef HAVE_SYS_XATTR_H
 # include <sys/xattr.h>
 #endif
-#include <linux/fs.h>
+#include "lapi/fs.h"
 
 #include "test.h"
 #include "safe_macros.h"
 
 char *TCID = "setxattr03";
 
-#if defined HAVE_SYS_XATTR_H && defined HAVE_FS_IOC_FLAGS
+#if defined HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE (sizeof(XATTR_TEST_VALUE) - 1)
@@ -206,7 +206,6 @@ static void cleanup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> not present or FS_IOC_FLAGS "
-		 "missing in <linux/fs.h>");
+	tst_brkm(TCONF, NULL, "<sys/xattr.h> not present");
 }
-#endif /* defined HAVE_SYS_XATTR_H && defined HAVE_FS_IOC_FLAGS */
+#endif /* defined HAVE_SYS_XATTR_H */
-- 
2.18.1



