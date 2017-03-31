From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 31 Mar 2017 18:15:21 +0800
Subject: [LTP] [PATCH 1/2] syscalls/quotactl02.c: add Q_XGETNEXTQUOTA flag
	test
Message-ID: <1490955322-7483-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl02.c | 44 ++++++++++++++++---------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index f7ae78b..a601006 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -22,7 +22,8 @@
  * This testcase checks basic flags of quotactl(2) for an XFS file system:
  * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status.
  * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status.
- * 3) quotactl(2) succeeds to set and get xfs disk quota limits.
+ * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota limits.
+ * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk quota limits.
  */
 #define _GNU_SOURCE
 #include <errno.h>
@@ -42,11 +43,11 @@
 #include "tst_test.h"
 
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
@@ -58,22 +59,27 @@ static struct t_case {
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
+	"set and use Q_XGETQUOTA to get xfs disk quota limits"},
+# ifdef Q_XGETNEXTQUOTA
+	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETNEXTQUOTA,
+	"set and use Q_XGETNEXTQUOTA to get xfs disk quota limits"},
+# endif
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
@@ -89,12 +95,12 @@ static void check_qoff(char *desp)
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
@@ -110,14 +116,14 @@ static void check_qon(char *desp)
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
 		tst_res(TFAIL | TERRNO,
@@ -125,6 +131,12 @@ static void check_qlim(char *desp)
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
@@ -150,7 +162,7 @@ static void verify_quota(unsigned int n)
 		return;
 	}
 
-	tc->func_check(tc->des);
+	tc->func_check(tc->check_subcmd, tc->des);
 }
 
 static struct tst_test test = {
-- 
1.8.3.1



