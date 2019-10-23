From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 23 Oct 2019 17:00:27 +0800
Subject: [LTP] =?utf-8?q?=5BPATCH_v2_2/6=5D_m4/ltp-xfs=5Fquota=2Em4=3A_Re?=
 =?utf-8?q?move_useless_ltp=E2=80=94xfs=5Fquota=2Em4?=
In-Reply-To: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1571821231-3846-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We can detect <xfs/xqm.h> in configure.ac instead of using
ltp-xfs_quota.m4. Also we should need to check CONFIG_XFS_QUOTA
whether enable in kernel config.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac                                  |  2 +-
 m4/ltp-xfs_quota.m4                           | 23 -------------------
 .../kernel/syscalls/quotactl/quotactl02.c     | 16 +++++++------
 .../kernel/syscalls/quotactl/quotactl03.c     | 17 +++++++-------
 4 files changed, 19 insertions(+), 39 deletions(-)
 delete mode 100644 m4/ltp-xfs_quota.m4

diff --git a/configure.ac b/configure.ac
index 3785dff63..5e741af08 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,7 @@ AC_CHECK_HEADERS([ \
     sys/ustat.h \
     sys/utsname.h \
     sys/xattr.h \
+    xfs/xqm.h \
 ])
 
 AC_CHECK_FUNCS([ \
@@ -257,7 +258,6 @@ LTP_CHECK_TIMERFD
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_CHECK_TPACKET_V3
 LTP_CHECK_UNAME_DOMAINNAME
-LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_X_TABLES
 LTP_DETECT_HOST_CPU
 
diff --git a/m4/ltp-xfs_quota.m4 b/m4/ltp-xfs_quota.m4
deleted file mode 100644
index 60a4b5633..000000000
--- a/m4/ltp-xfs_quota.m4
+++ /dev/null
@@ -1,23 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2013 Fujitsu Ltd.
-dnl Author: DAN LI <li.dan@cn.fujitsu.com>
-
-AC_DEFUN([LTP_CHECK_XFS_QUOTACTL],[
-	AC_MSG_CHECKING([for XFS quota (xfs/xqm.h)])
-	AC_LINK_IFELSE([AC_LANG_SOURCE([
-#define _GNU_SOURCE
-#include <xfs/xqm.h>
-#include <sys/quota.h>
-int main(void) {
-	struct fs_quota_stat qstat;
-	return quotactl(QCMD(Q_XGETQSTAT, USRQUOTA), "/dev/null", geteuid(),
-			(caddr_t) &qstat);
-}])],[has_xfs_quota="yes"])
-
-if test "x$has_xfs_quota" = xyes; then
-	AC_DEFINE(HAVE_XFS_QUOTA,1,[Define to 1 if you have xfs quota])
-	AC_MSG_RESULT(yes)
-else
-	AC_MSG_RESULT(no)
-fi
-])
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 0593b965f..021833411 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -22,15 +22,11 @@
 #include <stdio.h>
 #include <sys/quota.h>
 #include "config.h"
-
-#if defined(HAVE_XFS_QUOTA)
-# include <xfs/xqm.h>
-#endif
-
 #include "tst_test.h"
 #include "lapi/quotactl.h"
 
-#if defined(HAVE_XFS_QUOTA)
+#if defined(HAVE_XFS_XQM_H)
+#include <xfs/xqm.h>
 static void check_qoff(int, char *);
 static void check_qon(int, char *);
 static void check_qlim(int, char *);
@@ -156,9 +152,15 @@ static void verify_quota(unsigned int n)
 	tc->func_check(tc->check_subcmd, tc->des);
 }
 
+static const char *kconfigs[] = {
+	"CONFIG_XFS_QUOTA",
+	NULL
+};
+
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.needs_kconfigs = kconfigs,
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
@@ -168,5 +170,5 @@ static struct tst_test test = {
 	.setup = setup,
 };
 #else
-	TST_TEST_TCONF("This system didn't support xfs quota");
+	TST_TEST_TCONF("This system didn't have <xfs/xqm.h>");
 #endif
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index cf73231a9..434fefe2a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -30,16 +30,11 @@
 #include <sys/quota.h>
 #include "config.h"
 #include <sys/quota.h>
-
-#if defined(HAVE_XFS_QUOTA)
-# include <xfs/xqm.h>
-#endif
-
 #include "tst_test.h"
 #include "lapi/quotactl.h"
 
-#if defined(HAVE_XFS_QUOTA)
-
+#if defined(HAVE_XFS_XQM_H)
+#include <xfs/xqm.h>
 static const char mntpoint[] = "mnt_point";
 static uint32_t test_id = 0xfffffffc;
 
@@ -70,9 +65,15 @@ static void verify_quota(void)
 	}
 }
 
+static const char *kconfigs[] = {
+	"CONFIG_XFS_QUOTA",
+	NULL
+};
+
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.needs_kconfigs = kconfigs,
 	.test_all = verify_quota,
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
@@ -81,5 +82,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("This system didn't support xfs quota");
+	TST_TEST_TCONF("This system didn't have <xfs/xqm.h>");
 #endif
-- 
2.18.0



