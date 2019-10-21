From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 21 Oct 2019 19:37:02 +0800
Subject: [LTP] [PATCH 4/4] syscalls/quotactl02.c: Add Q_XGETQSTATV test
In-Reply-To: <1571657822-31421-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1571657822-31421-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1571657822-31421-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This cmd returns XFS filesystem-specific quota information in the fs_quota_statv
pointed to by addr. The qs_version field of the structure should be filled with
the version of the structure supported by the caller (for now, only FS_QSTAT_VERSION1
is supported).

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/quotactl.h                       |  4 ++
 m4/ltp-quota.m4                               |  2 +
 .../kernel/syscalls/quotactl/quotactl02.c     | 69 ++++++++++++++++++-
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index 99f4e5fc5..2a03c5b5a 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -10,6 +10,10 @@
 
 #include <linux/quota.h>
 
+# ifndef Q_XGETQSTATV
+#  define Q_XGETQSTATV XQM_CMD(8)
+# endif
+
 # ifndef Q_XGETNEXTQUOTA
 #  define Q_XGETNEXTQUOTA XQM_CMD(9)
 # endif
diff --git a/m4/ltp-quota.m4 b/m4/ltp-quota.m4
index 964c34925..688c7c5f7 100644
--- a/m4/ltp-quota.m4
+++ b/m4/ltp-quota.m4
@@ -4,4 +4,6 @@ dnl Copyright (c) 2019 Fujitsu Ltd.
 
 AC_DEFUN([LTP_CHECK_SYSCALL_QUOTACTL],[
 AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
+AC_CHECK_TYPES([struct fs_quota_statv],,,[#include <xfs/xqm.h>])
+
 ])
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 021833411..043ae0770 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2013 Fujitsu Ltd.
+ * Copyright (c) 2016-2019 FUJITSU LIMITED. All rights reserved
  * Author: DAN LI <li.dan@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
 
 /*
@@ -15,6 +16,8 @@
  *    limits.
  * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
  *    quota limits.
+ * 5) quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv.
+ * 6) quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv.
  */
 #define _GNU_SOURCE
 #include <errno.h>
@@ -29,6 +32,12 @@
 #include <xfs/xqm.h>
 static void check_qoff(int, char *);
 static void check_qon(int, char *);
+
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+static void check_qoffv(int, char *);
+static void check_qonv(int, char *);
+#endif
+
 static void check_qlim(int, char *);
 
 static uint32_t test_id;
@@ -54,6 +63,12 @@ static struct t_case {
 	"Q_XGETQUOTA"},
 	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETNEXTQUOTA,
 	"Q_XGETNEXTQUOTA"},
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflag, check_qoffv, Q_XGETQSTATV,
+	"turn off xfs quota and get xfs quota off statv"},
+	{QCMD(Q_XQUOTAON, USRQUOTA), &qflag, check_qonv, Q_XGETQSTATV,
+	"turn on xfs quota and get xfs quota on statv"},
+#endif
 };
 
 static void check_qoff(int subcmd, char *desp)
@@ -62,7 +77,7 @@ static void check_qoff(int subcmd, char *desp)
 	struct fs_quota_stat res_qstat;
 
 	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
-	               test_id, (void*) &res_qstat);
+			test_id, (void *) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs quota off status");
@@ -77,6 +92,31 @@ static void check_qoff(int subcmd, char *desp)
 	tst_res(TPASS, "quoactl() succeeded to %s", desp);
 }
 
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+static void check_qoffv(int subcmd, char *desp)
+{
+	int res;
+	struct fs_quota_statv res_qstatv = {
+		.qs_version = FS_QSTATV_VERSION1,
+	};
+
+	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
+			test_id, (void *) &res_qstatv);
+	if (res == -1) {
+		tst_res(TFAIL | TERRNO,
+			"quotactl() failed to get xfs quota off stav");
+		return;
+	}
+
+	if (res_qstatv.qs_flags & XFS_QUOTA_UDQ_ENFD) {
+		tst_res(TFAIL, "xfs quota enforcement was on unexpectedly");
+		return;
+	}
+
+	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+}
+#endif
+
 static void check_qon(int subcmd, char *desp)
 {
 	int res;
@@ -98,6 +138,31 @@ static void check_qon(int subcmd, char *desp)
 	tst_res(TPASS, "quoactl() succeeded to %s", desp);
 }
 
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+static void check_qonv(int subcmd, char *desp)
+{
+	int res;
+	struct fs_quota_statv res_qstatv = {
+		.qs_version = FS_QSTATV_VERSION1
+	};
+
+	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
+		test_id, (void *) &res_qstatv);
+	if (res == -1) {
+		tst_res(TFAIL | TERRNO,
+			"quotactl() failed to get xfs quota on statv");
+		return;
+	}
+
+	if (!(res_qstatv.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
+		tst_res(TFAIL, "xfs quota enforcement was off unexpectedly");
+		return;
+	}
+
+	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+}
+#endif
+
 static void check_qlim(int subcmd, char *desp)
 {
 	int res;
-- 
2.18.0



