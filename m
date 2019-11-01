From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 1 Nov 2019 20:55:56 +0800
Subject: [LTP] [PATCH v3 2/5] syscalls/quotactl02.c: Add Q_XGETQSTATV test
In-Reply-To: <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1572612959-20577-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Q_XGETQSTATV returns XFS filesystem-specific quota information in the fs_quota_statv
pointed to by addr. The qs_version field of the structure should be filled with
the version of the structure supported by the caller (for now, only FS_QSTAT_VERSION1
is supported).

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/quotactl.h                       |   4 +
 m4/ltp-quota.m4                               |   1 +
 .../kernel/syscalls/quotactl/quotactl02.c     | 193 +++++++-----------
 .../kernel/syscalls/quotactl/quotactl02.h     | 152 ++++++++++++++
 4 files changed, 236 insertions(+), 114 deletions(-)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl02.h

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index afce865bc..787f4691e 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -13,6 +13,10 @@
 #endif
 #include <sys/quota.h>
 
+# ifndef Q_XGETQSTATV
+#  define Q_XGETQSTATV XQM_CMD(8)
+# endif
+
 # ifndef Q_XGETNEXTQUOTA
 #  define Q_XGETNEXTQUOTA XQM_CMD(9)
 # endif
diff --git a/m4/ltp-quota.m4 b/m4/ltp-quota.m4
index e8d08c6b7..bcdff7041 100644
--- a/m4/ltp-quota.m4
+++ b/m4/ltp-quota.m4
@@ -4,4 +4,5 @@ dnl Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
 
 AC_DEFUN([LTP_CHECK_SYSCALL_QUOTACTL],[
 AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
+AC_CHECK_TYPES([struct fs_quota_statv],,,[#include <xfs/xqm.h>])
 ])
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index edba84391..a3703d79b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2013 Fujitsu Ltd.
+ * Copyright (c) 2013-2019 FUJITSU LIMITED. All rights reserved
  * Author: DAN LI <li.dan@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
 
 /*
@@ -9,132 +10,98 @@
  *
  * Description:
  * This testcase checks basic flags of quotactl(2) for an XFS file system:
- * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status.
- * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status.
+ * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
+ *    for user.
+ * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
+ *    for usr.
  * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
- *    limits.
+ *    limits for user.
  * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
- *    quota limits.
+ *    quota limits greater than or equal to ID for user.
+ * 5) quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
+ *    for user.
+ * 6) quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
+ *    for user.
+ * 7) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
+ *    for group.
+ * 8) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
+ *    for group.
+ * 9) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
+ *    limits for group.
+ * 10)quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
+ *    quota limits for group.
+ * 11)quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
+ *    for group.
+ * 12)quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
+ *    for group.
  */
-#define _GNU_SOURCE
-#include "config.h"
-#include <errno.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <sys/quota.h>
 
-#include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl02.h"
 
 #ifdef HAVE_XFS_XQM_H
-# include <xfs/xqm.h>
-
-static void check_qoff(int, char *);
-static void check_qon(int, char *);
-static void check_qlim(int, char *);
-
-static uint32_t test_id;
-static struct fs_disk_quota set_dquota = {
-	.d_rtb_softlimit = 1000,
-	.d_fieldmask = FS_DQ_RTBSOFT
-};
-static uint32_t qflag = XFS_QUOTA_UDQ_ENFD;
-static const char mntpoint[] = "mnt_point";
+static uint32_t qflagu = XFS_QUOTA_UDQ_ENFD;
+static uint32_t qflagg = XFS_QUOTA_GDQ_ENFD;
 
 static struct t_case {
 	int cmd;
 	void *addr;
 	void (*func_check)();
 	int check_subcmd;
+	int flag;
 	char *des;
 } tcases[] = {
-	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflag, check_qoff, Q_XGETQSTAT,
-	"turn off xfs quota and get xfs quota off status"},
-	{QCMD(Q_XQUOTAON, USRQUOTA), &qflag, check_qon, Q_XGETQSTAT,
-	"turn on xfs quota and get xfs quota on status"},
-	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETQUOTA,
-	"Q_XGETQUOTA"},
-	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETNEXTQUOTA,
-	"Q_XGETNEXTQUOTA"},
-};
-
-static void check_qoff(int subcmd, char *desp)
-{
-	int res;
-	struct fs_quota_stat res_qstat;
-
-	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev, test_id,
-		       (void *) &res_qstat);
-	if (res == -1) {
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs quota off status");
-		return;
-	}
-
-	if (res_qstat.qs_flags & XFS_QUOTA_UDQ_ENFD) {
-		tst_res(TFAIL, "xfs quota enforcement was on unexpectedly");
-		return;
-	}
-
-	tst_res(TPASS, "quoactl() succeeded to %s", desp);
-}
-
-static void check_qon(int subcmd, char *desp)
-{
-	int res;
-	struct fs_quota_stat res_qstat;
-
-	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
-		       test_id, (void *) &res_qstat);
-	if (res == -1) {
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs quota on status");
-		return;
-	}
+	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflagu, check_qoff,
+	QCMD(Q_XGETQSTAT, USRQUOTA), 1,
+	"turn off xfs quota and get xfs quota off status for user"},
+
+	{QCMD(Q_XQUOTAON, USRQUOTA), &qflagu, check_qon,
+	QCMD(Q_XGETQSTAT, USRQUOTA), 1,
+	"turn on xfs quota and get xfs quota on status for user"},
+
+	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETQUOTA, USRQUOTA), 0,
+	"Q_XGETQUOTA for user"},
+
+	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETNEXTQUOTA, USRQUOTA), 0,
+	"Q_XGETNEXTQUOTA for user"},
+
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflagu, check_qoffv,
+	QCMD(Q_XGETQSTATV, USRQUOTA), 1,
+	"turn off xfs quota and get xfs quota off statv for user"},
+
+	{QCMD(Q_XQUOTAON, USRQUOTA), &qflagu, check_qonv,
+	QCMD(Q_XGETQSTATV, USRQUOTA), 1,
+	"turn on xfs quota and get xfs quota on statv for user"},
+#endif
 
-	if (!(res_qstat.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
-		tst_res(TFAIL, "xfs quota enforcement was off unexpectedly");
-		return;
-	}
+	{QCMD(Q_XQUOTAOFF, GRPQUOTA), &qflagg, check_qoff,
+	QCMD(Q_XGETQSTAT, GRPQUOTA), 1,
+	"turn off xfs quota and get xfs quota off status for group"},
 
-	tst_res(TPASS, "quoactl() succeeded to %s", desp);
-}
+	{QCMD(Q_XQUOTAON, GRPQUOTA), &qflagg, check_qon,
+	QCMD(Q_XGETQSTAT, GRPQUOTA), 1,
+	"turn on xfs quota and get xfs quota on status for group"},
 
-static void check_qlim(int subcmd, char *desp)
-{
-	int res;
-	static struct fs_disk_quota res_dquota;
-
-	res_dquota.d_rtb_softlimit = 0;
-
-	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
-		       test_id, (void *) &res_dquota);
-	if (res == -1) {
-		if (errno == EINVAL) {
-			tst_brk(TCONF | TERRNO,
-				"%s wasn't supported in quotactl()", desp);
-		}
-		tst_res(TFAIL | TERRNO,
-			"quotactl() failed to get xfs disk quota limits");
-		return;
-	}
+	{QCMD(Q_XSETQLIM, GRPQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETQUOTA, GRPQUOTA), 0,
+	"Q_XGETQUOTA for group"},
 
-	if (res_dquota.d_id != test_id) {
-		tst_res(TFAIL, "quotactl() got unexpected user id %u, expected %u",
-				res_dquota.d_id, test_id);
-		return;
-	}
+	{QCMD(Q_XSETQLIM, GRPQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETNEXTQUOTA, GRPQUOTA), 0,
+	"Q_XGETNEXTQUOTA for group"},
 
-	if (res_dquota.d_rtb_hardlimit != set_dquota.d_rtb_hardlimit) {
-		tst_res(TFAIL, "quotactl() got unexpected rtb soft limit %llu, expected %llu",
-				res_dquota.d_rtb_hardlimit,
-			set_dquota.d_rtb_hardlimit);
-		return;
-	}
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+	{QCMD(Q_XQUOTAOFF, GRPQUOTA), &qflagg, check_qoffv,
+	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
+	"turn off xfs quota and get xfs quota off statv for group"},
 
-	tst_res(TPASS, "quoactl() succeeded to set and use %s to get xfs disk quota limits",
-			desp);
-}
+	{QCMD(Q_XQUOTAON, GRPQUOTA), &qflagg, check_qonv,
+	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
+	"turn on xfs quota and get xfs quota on statv for group"},
+#endif
+};
 
 static void setup(void)
 {
@@ -151,14 +118,12 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	tc->func_check(tc->check_subcmd, tc->des);
+	if (tc->flag)
+		tc->func_check(tc->check_subcmd, tc->des, *(int *)(tc->addr));
+	else
+		tc->func_check(tc->check_subcmd, tc->des);
 }
 
-static const char *kconfigs[] = {
-	"CONFIG_XFS_QUOTA",
-	NULL
-};
-
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
@@ -168,7 +133,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
 	.mntpoint = mntpoint,
-	.mnt_data = "usrquota",
+	.mnt_data = "usrquota,grpquota",
 	.setup = setup,
 };
 #else
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.h b/testcases/kernel/syscalls/quotactl/quotactl02.h
new file mode 100644
index 000000000..c96cdc3e4
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+#ifndef QUOTACTL02_H
+#define QUOTACTL02_H
+
+#define _GNU_SOURCE
+#include "config.h"
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/quotactl.h"
+
+#ifdef HAVE_XFS_XQM_H
+# include <xfs/xqm.h>
+
+static struct fs_disk_quota set_dquota = {
+	.d_rtb_softlimit = 1000,
+	.d_fieldmask = FS_DQ_RTBSOFT
+};
+static uint32_t test_id;
+static const char mntpoint[] = "mnt_point";
+static const char *kconfigs[] = {
+	"CONFIG_XFS_QUOTA",
+	NULL
+};
+void check_qoff(int subcmd, char *desp, int flag)
+{
+	int res;
+	struct fs_quota_stat res_qstat;
+
+	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	if (res == -1) {
+		tst_res(TFAIL | TERRNO,
+			"quotactl() failed to get xfs quota off status");
+		return;
+	}
+
+	if (res_qstat.qs_flags & flag) {
+		tst_res(TFAIL, "xfs quota enforcement was on unexpectedly");
+		return;
+	}
+
+	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+}
+
+void check_qon(int subcmd, char *desp, int flag)
+{
+	int res;
+	struct fs_quota_stat res_qstat;
+
+	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstat);
+	if (res == -1) {
+		tst_res(TFAIL | TERRNO,
+			"quotactl() failed to get xfs quota on status");
+		return;
+	}
+
+	if (!(res_qstat.qs_flags & flag)) {
+		tst_res(TFAIL, "xfs quota enforcement was off unexpectedly");
+		return;
+	}
+
+	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+}
+
+#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
+void check_qoffv(int subcmd, char *desp, int flag)
+{
+	int res;
+	struct fs_quota_statv res_qstatv = {
+		.qs_version = FS_QSTATV_VERSION1,
+	};
+
+	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	if (res == -1) {
+		tst_res(TFAIL | TERRNO,
+			"quotactl() failed to get xfs quota off stav");
+		return;
+	}
+
+	if (res_qstatv.qs_flags & flag) {
+		tst_res(TFAIL, "xfs quota enforcement was on unexpectedly");
+		return;
+	}
+
+	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+}
+
+void check_qonv(int subcmd, char *desp, int flag)
+{
+	int res;
+	struct fs_quota_statv res_qstatv = {
+		.qs_version = FS_QSTATV_VERSION1
+	};
+
+	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_qstatv);
+	if (res == -1) {
+		tst_res(TFAIL | TERRNO,
+			"quotactl() failed to get xfs quota on statv");
+		return;
+	}
+
+	if (!(res_qstatv.qs_flags & flag)) {
+		tst_res(TFAIL, "xfs quota enforcement was off unexpectedly");
+		return;
+	}
+
+	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+}
+#endif
+
+void check_qlim(int subcmd, char *desp)
+{
+	int res;
+	static struct fs_disk_quota res_dquota;
+
+	res_dquota.d_rtb_softlimit = 0;
+
+	res = quotactl(subcmd, tst_device->dev, test_id, (void *) &res_dquota);
+	if (res == -1) {
+		if (errno == EINVAL) {
+			tst_res(TCONF,
+				"%s wasn't supported in quotactl()", desp);
+		} else {
+			tst_res(TFAIL | TERRNO,
+				"quotactl() failed to get xfs disk quota limits");
+		}
+		return;
+	}
+
+	if (res_dquota.d_id != test_id) {
+		tst_res(TFAIL, "quotactl() got unexpected user id %u, expected %u",
+			res_dquota.d_id, test_id);
+		return;
+	}
+
+	if (res_dquota.d_rtb_hardlimit != set_dquota.d_rtb_hardlimit) {
+		tst_res(TFAIL, "quotactl() got unexpected rtb soft limit %llu, expected %llu",
+				res_dquota.d_rtb_hardlimit, set_dquota.d_rtb_hardlimit);
+		return;
+	}
+
+	tst_res(TPASS, "quoactl() succeeded to set and use %s to get xfs disk quota limits",
+			desp);
+}
+#endif//HAVE_XFS_XQM_H
+#endif
-- 
2.18.0



