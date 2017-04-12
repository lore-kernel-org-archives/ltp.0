From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 12 Apr 2017 12:04:51 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/quotactl02.c: add Q_XGETNEXTQUOTA
	flag test
In-Reply-To: <20170411143050.GA3998@rei.lan>
References: <20170411143050.GA3998@rei.lan>
Message-ID: <1491969892-6918-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/quotactl.h                         | 26 +++++++++++++
 testcases/kernel/syscalls/quotactl/quotactl02.c | 52 +++++++++++++++++--------
 2 files changed, 61 insertions(+), 17 deletions(-)
 create mode 100644 include/lapi/quotactl.h

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
new file mode 100644
index 0000000..729472f
--- /dev/null
+++ b/include/lapi/quotactl.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef LAPI_QUOTACTL_H__
+# define LAPI_QUOTACTL_H__
+
+# ifndef Q_XGETNEXTQUOTA
+#  define Q_XGETNEXTQUOTA XQM_CMD(9)
+# endif
+
+#endif /* LAPI_QUOTACTL_H__ */
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index f7ae78b..ec5c7a0 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -22,7 +22,10 @@
  * This testcase checks basic flags of quotactl(2) for an XFS file system:
  * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status.
  * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status.
- * 3) quotactl(2) succeeds to set and get xfs disk quota limits.
+ * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
+ *    limits.
+ * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
+ *    quota limits.
  */
 #define _GNU_SOURCE
 #include <errno.h>
@@ -40,13 +43,14 @@
 #endif
 
 #include "tst_test.h"
+#include "lapi/quotactl.h"
 
 #if defined(HAVE_XFS_QUOTA) && (defined(HAVE_QUOTAV2) || defined(HAVE_QUOTAV1))
-static void check_qoff(char *);
-static void check_qon(char *);
-static void check_qlim(char *);
+static void check_qoff(int, char *);
+static void check_qon(int, char *);
+static void check_qlim(int, char *);
 
-static int test_id;
+static uint32_t test_id;
 static struct fs_disk_quota set_dquota = {
 	.d_rtb_softlimit = 1000,
 	.d_fieldmask = FS_DQ_RTBSOFT
@@ -58,22 +62,25 @@ static struct t_case {
 	int cmd;
 	void *addr;
 	void (*func_check)();
+	int check_subcmd;
 	char *des;
 } tcases[] = {
-	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflag, check_qoff,
+	{QCMD(Q_XQUOTAOFF, USRQUOTA), &qflag, check_qoff, Q_XGETQSTAT,
 	"turn off xfs quota and get xfs quota off status"},
-	{QCMD(Q_XQUOTAON, USRQUOTA), &qflag, check_qon,
+	{QCMD(Q_XQUOTAON, USRQUOTA), &qflag, check_qon, Q_XGETQSTAT,
 	"turn on xfs quota and get xfs quota on status"},
-	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim,
-	"set and get xfs disk quota limits"},
+	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETQUOTA,
+	"Q_XGETQUOTA"},
+	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETNEXTQUOTA,
+	"Q_XGETNEXTQUOTA"},
 };
 
-static void check_qoff(char *desp)
+static void check_qoff(int subcmd, char *desp)
 {
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(QCMD(Q_XGETQSTAT, USRQUOTA), tst_device->dev,
+	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
 	               test_id, (void*) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
@@ -89,12 +96,12 @@ static void check_qoff(char *desp)
 	tst_res(TPASS, "quoactl() succeeded to %s", desp);
 }
 
-static void check_qon(char *desp)
+static void check_qon(int subcmd, char *desp)
 {
 	int res;
 	struct fs_quota_stat res_qstat;
 
-	res = quotactl(QCMD(Q_XGETQSTAT, USRQUOTA), tst_device->dev,
+	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
 	               test_id, (void*) &res_qstat);
 	if (res == -1) {
 		tst_res(TFAIL | TERRNO,
@@ -110,21 +117,31 @@ static void check_qon(char *desp)
 	tst_res(TPASS, "quoactl() succeeded to %s", desp);
 }
 
-static void check_qlim(char *desp)
+static void check_qlim(int subcmd, char *desp)
 {
 	int res;
 	static struct fs_disk_quota res_dquota;
 
 	res_dquota.d_rtb_softlimit = 0;
 
-	res = quotactl(QCMD(Q_XGETQUOTA, USRQUOTA), tst_device->dev,
+	res = quotactl(QCMD(subcmd, USRQUOTA), tst_device->dev,
 	               test_id, (void*) &res_dquota);
 	if (res == -1) {
+		if (errno == EINVAL) {
+			tst_brk(TCONF | TERRNO,
+				"%s wasn't supported in quotactl()", desp);
+		}
 		tst_res(TFAIL | TERRNO,
 			"quotactl() failed to get xfs disk quota limits");
 		return;
 	}
 
+	if (res_dquota.d_id != test_id) {
+		tst_res(TFAIL, "quotactl() got unexpected user id %u,"
+			" expected %u", res_dquota.d_id, test_id);
+		return;
+	}
+
 	if (res_dquota.d_rtb_hardlimit != set_dquota.d_rtb_hardlimit) {
 		tst_res(TFAIL, "quotactl() got unexpected rtb soft limit %llu,"
 			" expected %llu", res_dquota.d_rtb_hardlimit,
@@ -132,7 +149,8 @@ static void check_qlim(char *desp)
 		return;
 	}
 
-	tst_res(TPASS, "quoactl() succeeded to %s", desp);
+	tst_res(TPASS, "quoactl() succeeded to set and use %s to get xfs disk "
+		"quota limits", desp);
 }
 
 static void setup(void)
@@ -150,7 +168,7 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	tc->func_check(tc->des);
+	tc->func_check(tc->check_subcmd, tc->des);
 }
 
 static struct tst_test test = {
-- 
1.8.3.1



