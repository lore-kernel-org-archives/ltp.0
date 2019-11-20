From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 20 Nov 2019 17:13:33 +0800
Subject: [LTP] [PATCH v4 2/5] syscalls/quotactl02: Add Q_XGETQSTATV test and
 group quota tests
In-Reply-To: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1574241216-15168-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Q_XGETQSTATV returns XFS filesystem-specific quota information in the fs_quota_statv
pointed to by addr. The qs_version field of the structure should be filled with the
version of the structure supported by the caller (for now, only FS_QSTAT_VERSION1
is supported).

Also, cover group quota like quotactl01.c.

Move common code to quota02.h, so we can use it for comming quotactl05.c to test project
quota on xfs filesystem.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/quotactl.h                       |  33 +++
 m4/ltp-quota.m4                               |   1 +
 .../kernel/syscalls/quotactl/quotactl02.c     | 222 ++++++++----------
 .../kernel/syscalls/quotactl/quotactl02.h     | 167 +++++++++++++
 4 files changed, 305 insertions(+), 118 deletions(-)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl02.h

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index 5c49cedce..808d044ff 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -30,6 +30,39 @@ struct if_nextdqblk {
 #endif
 #endif
 
+#ifndef HAVE_STRUCT_FS_QUOTA_STATV
+# ifdef HAVE_LINUX_TYPES_H
+# include <linux/types.h>
+struct fs_qfilestatv {
+	__u64           qfs_ino;
+	__u64           qfs_nblks;
+	__u32           qfs_nextents;
+	__u32           qfs_pad;
+};
+
+struct fs_quota_statv {
+	__s8                    qs_version;
+	__u8                    qs_pad1;
+	__u16                   qs_flags;
+	__u32                   qs_incoredqs;
+	struct fs_qfilestatv    qs_uquota;
+	struct fs_qfilestatv    qs_gquota;
+	struct fs_qfilestatv    qs_pquota;
+	__s32                   qs_btimelimit;
+	__s32                   qs_itimelimit;
+	__s32                   qs_rtbtimelimit;
+	__u16                   qs_bwarnlimit;
+	__u16                   qs_iwarnlimit;
+	__u64                   qs_pad2[8];
+};
+#define FS_QSTATV_VERSION1 1
+#endif
+#endif
+
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
index edba84391..9eae11f5e 100644
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
@@ -9,156 +10,141 @@
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
+	char *tname;
 } tcases[] = {
-	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflag, check_qoff, Q_XGETQSTAT,
-	"turn off xfs quota and get xfs quota off status"},
-	{QCMD(Q_XQUOTAON, USRQUOTA), &qflag, check_qon, Q_XGETQSTAT,
-	"turn on xfs quota and get xfs quota on status"},
-	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETQUOTA,
-	"Q_XGETQUOTA"},
-	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETNEXTQUOTA,
-	"Q_XGETNEXTQUOTA"},
+	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflagu, check_qoff,
+	QCMD(Q_XGETQSTAT, USRQUOTA), 1,
+	"turn off xfs quota and get xfs quota off status for user",
+	"QCMD(Q_XGETQSTAT, USRQUOTA) off"},
+
+	{QCMD(Q_XQUOTAON, USRQUOTA), &qflagu, check_qon,
+	QCMD(Q_XGETQSTAT, USRQUOTA), 1,
+	"turn on xfs quota and get xfs quota on status for user",
+	"QCMD(Q_XGETQSTAT, USRQUOTA) on"},
+
+	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETQUOTA, USRQUOTA), 0, "Q_XGETQUOTA for user",
+	"QCMD(Q_XGETQUOTA, USRQUOTA) qlim"},
+
+	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETNEXTQUOTA, USRQUOTA), 0, "Q_XGETNEXTQUOTA for user",
+	"QCMD(Q_XGETNEXTQUOTA, USRQUOTA)"},
+
+	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflagu, check_qoffv,
+	QCMD(Q_XGETQSTATV, USRQUOTA), 1,
+	"turn off xfs quota and get xfs quota off statv for user",
+	"QCMD(Q_XGETQSTATV, USRQUOTA) off"},
+
+	{QCMD(Q_XQUOTAON, USRQUOTA), &qflagu, check_qonv,
+	QCMD(Q_XGETQSTATV, USRQUOTA), 1,
+	"turn on xfs quota and get xfs quota on statv for user",
+	"QCMD(Q_XGETQSTATV, USRQUOTA) on"},
+
+	{QCMD(Q_XQUOTAOFF, GRPQUOTA), &qflagg, check_qoff,
+	QCMD(Q_XGETQSTAT, GRPQUOTA), 1,
+	"turn off xfs quota and get xfs quota off status for group",
+	"QCMD(Q_XGETQSTAT, GRPQUOTA) off"},
+
+	{QCMD(Q_XQUOTAON, GRPQUOTA), &qflagg, check_qon,
+	QCMD(Q_XGETQSTAT, GRPQUOTA), 1,
+	"turn on xfs quota and get xfs quota on status for group",
+	"QCMD(Q_XGETQSTAT, GRPQUOTA) on"},
+
+	{QCMD(Q_XSETQLIM, GRPQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETQUOTA, GRPQUOTA), 0, "Q_XGETQUOTA for group",
+	"QCMD(Q_XGETQUOTA, GRPQUOTA) qlim"},
+
+	{QCMD(Q_XSETQLIM, GRPQUOTA), &set_dquota, check_qlim,
+	QCMD(Q_XGETNEXTQUOTA, GRPQUOTA), 0, "Q_XGETNEXTQUOTA for group",
+	"QCMD(Q_XGETNEXTQUOTA, GRPQUOTA)"},
+
+	{QCMD(Q_XQUOTAOFF, GRPQUOTA), &qflagg, check_qoffv,
+	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
+	"turn off xfs quota and get xfs quota off statv for group",
+	"QCMD(Q_XGETQSTATV, GRPQUOTA) off"},
+
+	{QCMD(Q_XQUOTAON, GRPQUOTA), &qflagg, check_qonv,
+	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
+	"turn on xfs quota and get xfs quota on statv for group",
+	"QCMD(Q_XGETQSTATV, GRPQUOTA) on"},
 };
 
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
+static void setup(void)
 {
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
-
-	if (!(res_qstat.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
-		tst_res(TFAIL, "xfs quota enforcement was off unexpectedly");
-		return;
-	}
-
-	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+	test_id = geteuid();
+	check_support_cmd(USRQUOTA);
+	check_support_cmd(GRPQUOTA);
 }
 
-static void check_qlim(int subcmd, char *desp)
+static void verify_quota(unsigned int n)
 {
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
+	struct t_case *tc = &tcases[n];
 
-	if (res_dquota.d_id != test_id) {
-		tst_res(TFAIL, "quotactl() got unexpected user id %u, expected %u",
-				res_dquota.d_id, test_id);
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+	if ((tc->check_subcmd == QCMD(Q_XGETNEXTQUOTA, USRQUOTA)
+			|| tc->check_subcmd == QCMD(Q_XGETNEXTQUOTA, GRPQUOTA))
+			&& x_getnextquota_nsup) {
+		tst_res(TCONF, "current system doesn't support this cmd, skip it");
 		return;
 	}
-
-	if (res_dquota.d_rtb_hardlimit != set_dquota.d_rtb_hardlimit) {
-		tst_res(TFAIL, "quotactl() got unexpected rtb soft limit %llu, expected %llu",
-				res_dquota.d_rtb_hardlimit,
-			set_dquota.d_rtb_hardlimit);
+	if ((tc->check_subcmd == QCMD(Q_XGETQSTATV, USRQUOTA)
+			|| tc->check_subcmd == QCMD(Q_XGETQSTATV, GRPQUOTA))
+			&& x_getstatv_nsup) {
+		tst_res(TCONF, "current system doesn't support this cmd, skip it");
 		return;
 	}
 
-	tst_res(TPASS, "quoactl() succeeded to set and use %s to get xfs disk quota limits",
-			desp);
-}
-
-static void setup(void)
-{
-	test_id = geteuid();
-}
-
-static void verify_quota(unsigned int n)
-{
-	struct t_case *tc = &tcases[n];
-
 	TEST(quotactl(tc->cmd, tst_device->dev, test_id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl() failed to %s", tc->des);
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
@@ -168,7 +154,7 @@ static struct tst_test test = {
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
index 000000000..60237e16e
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -0,0 +1,167 @@
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
+static int x_getnextquota_nsup;
+static int x_getstatv_nsup;
+static const char mntpoint[] = "mnt_point";
+static const char *kconfigs[] = {
+	"CONFIG_XFS_QUOTA",
+	NULL
+};
+
+void check_support_cmd(int quotatype)
+{
+	struct fs_disk_quota resfs_dquota;
+	struct fs_quota_statv resfs_qstatv = {
+		.qs_version = FS_QSTATV_VERSION1
+	};
+
+	x_getnextquota_nsup = 0;
+	x_getstatv_nsup = 0;
+
+	TEST(quotactl(QCMD(Q_XGETNEXTQUOTA, quotatype), tst_device->dev, test_id, (void *) &resfs_dquota));
+	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
+		x_getnextquota_nsup = 1;
+
+	TEST(quotactl(QCMD(Q_XGETQSTATV, quotatype), tst_device->dev, test_id, (void *) &resfs_qstatv));
+	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
+		x_getstatv_nsup = 1;
+
+}
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
+	tst_res(TPASS, "quotactl() succeeded to %s", desp);
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
+	tst_res(TPASS, "quotactl() succeeded to %s", desp);
+}
+
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
+	tst_res(TPASS, "quotactl() succeeded to %s", desp);
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
+	tst_res(TPASS, "quotactl() succeeded to %s", desp);
+}
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
+		tst_res(TFAIL | TERRNO,
+			"quotactl() failed to get xfs disk quota limits");
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
+	tst_res(TPASS, "quotactl() succeeded to set and use %s to get xfs disk quota limits",
+			desp);
+}
+#endif//HAVE_XFS_XQM_H
+#endif
-- 
2.18.0



