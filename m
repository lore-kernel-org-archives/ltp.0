From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 21 Oct 2016 14:53:55 +0800
Subject: [LTP] [PATCH 2/2] syscalls/quotactl02.c: Reconstruct and Convert to
	new API
In-Reply-To: <1477032835-11570-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1477032835-11570-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1477032835-11570-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) take use of some SAFE Marcos
2) remove some unnecessary function
3) use quotactl instead of ltp_syscall

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl02.c | 257 +++++++++---------------
 1 file changed, 97 insertions(+), 160 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index 486ea93..2226edd 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -16,217 +16,154 @@
  */
 
 /*
+ * Test Name: quotactl02
+ *
  * Description:
- *	This tests basic flags of quotactl() syscall:
- *	1) Q_XQUOTAOFF - Turn off quotas for an XFS file system.
- *	2) Q_XQUOTAON - Turn on quotas for an XFS file system.
- *	3) Q_XGETQUOTA - Get disk quota limits and current usage for user id.
- *	4) Q_XSETQLIM - Set disk quota limits for user id.
- *	5) Q_XGETQSTAT - Get XFS file system specific quota information.
+ * This testcase checks basic flags of quotactl(2) for an XFS file system:
+ * 1) quotactl(2) succeeds to turn off quotas with Q_XQUOTAOFF for an XFS
+ *    file system.
+ * 2) quotactl(2) succeeds to turn on quotas with Q_XQUOTAON for an XFS file
+ *    system.
+ * 3) quotactl(2) succeeds to get quota on/off status with Q_XGETQSTAT for an
+ *    XFS file system.
+ * 4) quotactl(2) succeeds to set disk quota limits with Q_XSETQLIM for user
+ *    id.
+ * 5) quotactl(2) succeeds to get disk quota limits with Q_XGETQUOTA for user
+ *    id.
  */
-
 #define _GNU_SOURCE
-#include <fcntl.h>
+#include <errno.h>
 #include <unistd.h>
-#include <sys/syscall.h>
 #include <stdio.h>
-#include <errno.h>
-#include <sys/mount.h>
-#include <linux/fs.h>
-#include <sys/types.h>
-
+#include <sys/quota.h>
 #include "config.h"
+
+#if defined(HAVE_QUOTAV2) || defined(HAVE_QUOTAV1)
+#include <sys/quota.h>
+#endif
 #if defined(HAVE_XFS_QUOTA)
-# include <xfs/xqm.h>
+#include <xfs/xqm.h>
 #endif
-#include "test.h"
-#include "linux_syscall_numbers.h"
-#include "safe_macros.h"
 
-#define USRQCMD(cmd)	((cmd) << 8)
-#define RTBLIMIT	2000
+#include "tst_test.h"
 
-char *TCID = "quotactl02";
-int TST_TOTAL = 5;
+#if defined(HAVE_XFS_QUOTA) && (defined(HAVE_QUOTAV2) || defined(HAVE_QUOTAV1))
+static void check_qoff(char *);
+static void check_qon(char *);
+static void check_getqlim(char *);
 
-#if defined(HAVE_XFS_QUOTA)
-static void check_qoff(void);
-static void check_qon(void);
-static void check_getq(void);
-static void setup_setqlim(void), check_setqlim(void);
-static void check_getqstat(void);
-
-static void setup(void);
-static void cleanup(void);
-
-static int i;
-static int uid;
-static const char *block_dev;
+static int test_id;
 static int mount_flag;
-static struct fs_disk_quota dquota;
-static struct fs_quota_stat qstat;
-static unsigned int qflag = XFS_QUOTA_UDQ_ENFD;
+static struct fs_disk_quota set_dquota = {
+	.d_rtb_softlimit = 1000,
+	.d_fieldmask = FS_DQ_RTBSOFT
+};
+static struct fs_disk_quota res_dquota;
+static struct fs_quota_stat res_qstat;
+static unsigned short qflag = XFS_QUOTA_UDQ_ENFD;
 static const char mntpoint[] = "mnt_point";
 
-static struct test_case_t {
+static struct t_case {
 	int cmd;
+	int *id;
 	void *addr;
-	void (*func_test) ();
-	void (*func_setup) ();
-} TC[] = {
-	{Q_XQUOTAOFF, &qflag, check_qoff, NULL},
-	{Q_XQUOTAON, &qflag, check_qon, NULL},
-	{Q_XGETQUOTA, &dquota, check_getq, NULL},
-	{Q_XSETQLIM, &dquota, check_setqlim, setup_setqlim},
-	{Q_XGETQSTAT, &qstat, check_getqstat, NULL},
+	void (*func_check)();
+	char *des;
+} tcases[] = {
+	{QCMD(Q_XQUOTAOFF, USRQUOTA), &test_id, &qflag, NULL,
+	"turn off xfs quota"},
+	{QCMD(Q_XGETQSTAT, USRQUOTA), &test_id, &res_qstat, check_qoff,
+	"get xfs quota off status"},
+	{QCMD(Q_XQUOTAON, USRQUOTA), &test_id, &qflag, NULL,
+	"turn on xfs quota"},
+	{QCMD(Q_XGETQSTAT, USRQUOTA), &test_id, &res_qstat, check_qon,
+	"get xfs quota on status"},
+	{QCMD(Q_XSETQLIM, USRQUOTA), &test_id, &set_dquota, NULL,
+	"set xfs disk quota limits"},
+	{QCMD(Q_XGETQUOTA, USRQUOTA), &test_id, &res_dquota, check_getqlim,
+	"get xfs disk quota limits"}
 };
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (TC[i].func_setup != NULL)
-				(*TC[i].func_setup) ();
-
-			TEST(ltp_syscall(__NR_quotactl,
-					 USRQCMD(TC[i].cmd), block_dev,
-					 uid, TC[i].addr));
-
-			if (TEST_RETURN != 0)
-				tst_resm(TFAIL | TERRNO,
-					 "cmd=0x%x failed", TC[i].cmd);
-
-			(*TC[i].func_test) ();
-		}
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void check_qoff(void)
-{
-	int ret;
-
-	ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
-			  block_dev, uid, &qstat);
-	if (ret != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fail to get quota stat");
-
-	if (qstat.qs_flags & XFS_QUOTA_UDQ_ENFD) {
-		tst_resm(TFAIL, "enforcement is not off");
-		return;
-	}
-
-	tst_resm(TPASS, "enforcement is off");
-}
-
-static void check_qon(void)
+static void check_qoff(char *desp)
 {
-	int ret;
-	ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
-			  block_dev, uid, &qstat);
-	if (ret != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fail to get quota stat");
-
-	if (!(qstat.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
-		tst_resm(TFAIL, "enforcement is off");
+	if (res_qstat.qs_flags & XFS_QUOTA_UDQ_ENFD) {
+		tst_res(TFAIL, "enforcement was on unexpectedly");
 		return;
 	}
 
-	tst_resm(TPASS, "enforcement is on");
-}
+	tst_res(TPASS, "quoactl succeeded to %s", desp);
 
-static void check_getq(void)
-{
-	if (!(dquota.d_flags & XFS_USER_QUOTA)) {
-		tst_resm(TFAIL, "get incorrect quota type");
-		return;
-	}
-
-	tst_resm(TPASS, "get the right quota type");
-}
-
-static void setup_setqlim(void)
-{
-	dquota.d_rtb_hardlimit = RTBLIMIT;
-	dquota.d_fieldmask = FS_DQ_LIMIT_MASK;
 }
 
-static void check_setqlim(void)
+static void check_qon(char *desp)
 {
-	int ret;
-	ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQUOTA),
-			  block_dev, uid, &dquota);
-	if (ret != 0)
-		tst_brkm(TFAIL | TERRNO, NULL,
-			 "fail to get quota information");
-
-	if (dquota.d_rtb_hardlimit != RTBLIMIT) {
-		tst_resm(TFAIL, "limit on RTB, except %lu get %lu",
-			 (uint64_t)RTBLIMIT,
-			 (uint64_t)dquota.d_rtb_hardlimit);
+	if (!(res_qstat.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
+		tst_res(TFAIL, "enforcement was off unexpectedly");
 		return;
 	}
 
-	tst_resm(TPASS, "quotactl works fine with Q_XSETQLIM");
+	tst_res(TPASS, "quoactl succeeded to %s", desp);
 }
 
-static void check_getqstat(void)
+static void check_getqlim(char *desp)
 {
-	if (qstat.qs_version != FS_QSTAT_VERSION) {
-		tst_resm(TFAIL, "get incorrect qstat version");
+	if (res_dquota.d_rtb_hardlimit != set_dquota.d_rtb_hardlimit) {
+		tst_res(TFAIL, "quotactl got unexpected rtb soft limit %llu,"
+			" expected %llu", res_dquota.d_rtb_hardlimit,
+			set_dquota.d_rtb_hardlimit);
 		return;
 	}
 
-	tst_resm(TPASS, "get correct qstat version");
+	tst_res(TPASS, "quoactl succeeded to %s", desp);
 }
 
 static void setup(void)
 {
+	SAFE_MKDIR(mntpoint, 0755);
 
-	tst_require_root();
-
-	TEST_PAUSE;
+	SAFE_MKFS(tst_device->dev, "xfs", NULL, NULL);
 
-	tst_tmpdir();
+	SAFE_MOUNT(tst_device->dev, mntpoint, "xfs", 0, "usrquota");
 
-	SAFE_MKDIR(cleanup, mntpoint, 0755);
+	test_id = geteuid();
 
-	block_dev = tst_acquire_device(cleanup);
-
-	if (!block_dev)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, block_dev, "xfs", NULL, NULL);
-
-	if (mount(block_dev, mntpoint, "xfs", 0, "uquota") < 0)
-		tst_brkm(TFAIL | TERRNO, NULL, "mount(2) fail");
 	mount_flag = 1;
 }
 
 static void cleanup(void)
 {
 	if (mount_flag && tst_umount(mntpoint) < 0)
-		tst_resm(TWARN | TERRNO, "umount(2) failed");
+		tst_res(TWARN | TERRNO, "umount(2) failed");
+}
 
-	if (block_dev)
-		tst_release_device(block_dev);
+static void verify_quota(unsigned int n)
+{
+	struct t_case *tc = &tcases[n];
+
+	res_dquota.d_rtb_softlimit = 0;
 
-	tst_rmdir();
+	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, (caddr_t) tc->addr));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TERRNO, "quotactl failed to %s", tc->des);
+		return;
+	}
+
+	if (tc->func_check != NULL)
+		tc->func_check(tc->des);
+	else
+		tst_res(TPASS, "quotactl succeeded to %s", tc->des);
 }
+
+static struct tst_test test = {
+	.tid = "quotactl02",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_quota,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_device = 1,
+	.setup = setup,
+	.cleanup = cleanup
+};
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "This system doesn't support xfs quota");
-}
+	TST_TEST_TCONF("This system didn't support quota or xfs quota");
 #endif
-- 
1.8.3.1



