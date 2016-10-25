From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 25 Oct 2016 14:15:38 +0800
Subject: [LTP] [PATCH v2] syscalls/quotatcl01.c: Rewrite && Convert to new
	API
In-Reply-To: <20161024104928.GA19167@rei.lan>
References: <20161024104928.GA19167@rei.lan>
Message-ID: <1477376138-578-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
   for user.
3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
   for user.
4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
   flag for user.
5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
   flag for user.
6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
9) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
10) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
    for group.
11) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
    for group.
12) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
    flag for group.
13) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
    flag for group.
14) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
15) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
16) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl01.c | 412 +++++++++++-------------
 1 file changed, 181 insertions(+), 231 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index fcac469..9e1ff36 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -1,260 +1,210 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007				      */
-/*									      */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by	      */
-/* the Free Software Foundation; either version 2 of the License, or	      */
-/* (at your option) any later version.					      */
-/*									      */
-/* This program is distributed in the hope that it will be useful,	      */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	      */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      */
-/* the GNU General Public License for more details.			      */
-/*									      */
-/* You should have received a copy of the GNU General Public License	      */
-/* along with this program;  if not, write to the Free Software		      */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*									      */
-/******************************************************************************/
-/******************************************************************************/
-/*									      */
-/* File:		quotactl01.c					      */
-/*									      */
-/* Description: This tests the quotactl() syscall			      */
-/*									      */
-/* Usage:  <for command-line>						      */
-/* quotactl01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			      */
-/*	  where,  -c n : Run n copies concurrently.			      */
-/*			  -e   : Turn on errno logging.			      */
-/*			  -i n : Execute test n times.			      */
-/*			  -I x : Execute test for x seconds.		      */
-/*			  -P x : Pause for x seconds between iterations.      */
-/*			  -t   : Turn on syscall timing.		      */
-/*									      */
-/* Total Tests: 1							      */
-/*									      */
-/* Test Name:   quotactl01						      */
-/* History:	 Porting from Crackerjack to LTP is done by		      */
-/*			  Manas Kumar Nayak maknayak@in.ibm.com>	      */
-/******************************************************************************/
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <fcntl.h>
+/*
+* Copyright (c) Crackerjack Project., 2007
+* Copyright (c) 2016 Fujitsu Ltd.
+* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+*
+* This program is free software;  you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY;  without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+* the GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program.
+*
+* Test Name: quotactl01
+*
+* Description:
+* This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
+* 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
+* 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
+*    for user.
+* 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
+*    for user.
+* 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
+*    flag for user.
+* 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
+*    flag for user.
+* 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
+* 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
+* 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
+* 9) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
+* 10) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
+*     for group.
+* 11) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
+*     for group.
+* 12) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
+*     flag for group.
+* 13) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
+*     flag for group.
+* 14) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
+* 15) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
+* 16) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
+*
+*/
+
+#include <errno.h>
+#include <string.h>
 #include <unistd.h>
-#include <sys/syscall.h>
 #include <stdio.h>
-#include <errno.h>
-#include <linux/fs.h>
-#include <sys/types.h>
 #include "config.h"
-#if defined(HAVE_QUOTAV2) || defined(HAVE_QUOTAV1)
-#if defined(HAVE_QUOTAV2)
-#define _LINUX_QUOTA_VERSION 2
-#else /* HAVE_QUOTAV1 */
-#define _LINUX_QUOTA_VERSION 1
-#endif
-#include <sys/quota.h>
-#else /* ! (HAVE_QUOTAV2 || HAVE_QUOTAV1) */
-/* Not HAVE_QUOTAV2 */
-#define BROKEN_QUOTACTL 1
-#endif
-
-#include "test.h"
-#include "linux_syscall_numbers.h"
-
-char *TCID = "quotactl01";
-int testno;
-int TST_TOTAL = 1;
-
-#define QUOTACTL(cmd, addr) \
-	ltp_syscall(__NR_quotactl, QCMD(cmd, USRQUOTA), block_dev, id, \
-					(caddr_t) addr)
-#ifndef BROKEN_QUOTACTL
-
-#ifndef QUOTAFILE
-/* Default name of the quota file in Fedora 12. */
-#define QUOTAFILE "aquota.user"
-#endif
-
-char quota_started = 0;
-static char *block_dev, *mountpoint, *quota_file, *quota_loc = NULL;
-int id;
-struct dqblk dq;
-
-/* Extern Global Functions */
-/******************************************************************************/
-/*									      */
-/* Function:	cleanup							      */
-/*									      */
-/* Description: Performs all one time clean up for this test on successful    */
-/*		completion,  premature exit or  failure. Closes all temporary */
-/*		files, removes all temporary directories exits the test with  */
-/*		appropriate return code by calling tst_exit() function.	      */
-/*									      */
-/* Input:	None.							      */
-/*									      */
-/* Output:	None.							      */
-/*									      */
-/* Return:	On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*		On success - Exits calling tst_exit(). With '0' return code.  */
-/*									      */
-/******************************************************************************/
-void cleanup(void)
-{
 
-	tst_rmdir();
+#include "tst_test.h"
 
-	if (block_dev) {
-		if (quota_started == 1 && QUOTACTL(Q_QUOTAOFF, &dq)) {
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "failed to disable the quota on %s",
-				 block_dev);
-		}
-	}
-
-}
+#if defined(HAVE_QUOTAV2) || defined(HAVE_QUOTAV1)
+# include <sys/quota.h>
+
+# if defined(HAVE_QUOTAV2)
+#  define _LINUX_QUOTA_VERSION  2
+#  ifndef QFMT_VFS_V0
+#   define QFMT_VFS_V0     2
+#  endif
+#  define USRPATH MNTPOINT "/" "aquota.user"
+#  define GRPPATH MNTPOINT "/" "aquota.group"
+#  define FMTID	QFMT_VFS_V0
+# else
+#  define _LINUX_QUOTA_VERSION  1
+#  ifndef QFMT_VFS_OLD
+#   define QFMT_VFS_OLD    1
+#  endif
+#  define USRPATH MNTPOINT "/" "quota.user"
+#  define GRPPATH MNTPOINT "/" "quota.group"
+#  define FMTID	QFMT_VFS_OLD
+# endif
+
+# define MNTPOINT	"mntpoint"
+
+static int mount_flag;
+static unsigned long fmt_id = FMTID;
+static unsigned long test_id;
+static unsigned long data;
+static struct dqblk set_dq = {
+	.dqb_bsoftlimit = 100,
+	.dqb_valid = QIF_BLIMITS
+};
+static struct dqblk res_dq;
+# if defined(HAVE_QUOTAV2)
+static struct dqinfo set_qf = {
+	.dqi_bgrace = 80,
+	.dqi_valid = IIF_BGRACE
+};
+static struct dqinfo res_qf;
+static unsigned long fmt_buf[32];
+# endif
+
+static struct tcase {
+	int cmd;
+	unsigned long *id;
+	void *addr;
+	unsigned long *set_data;
+	unsigned long *res_data;
+	char *des;
+} tcases[] = {
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, USRPATH, &data, &data,
+	"turn on quota for user"},
+	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq, &data, &data,
+	"set disk quota limit for user"},
+	{QCMD(Q_GETQUOTA, USRQUOTA), &test_id, &res_dq, &set_dq.dqb_bsoftlimit,
+	&res_dq.dqb_bsoftlimit, "get disk quota limit for user"},
+# if defined(HAVE_QUOTAV2)
+	{QCMD(Q_SETINFO, USRQUOTA), &test_id, &set_qf, &data, &data,
+	"set information about quotafile for user"},
+	{QCMD(Q_GETINFO, USRQUOTA), &test_id, &res_qf, &set_qf.dqi_bgrace,
+	&res_qf.dqi_bgrace, "get information about quotafile for user"},
+	{QCMD(Q_GETFMT, USRQUOTA), &test_id, fmt_buf, &fmt_id, fmt_buf,
+	"get quota format for user"},
+# endif
+	{QCMD(Q_SYNC, USRQUOTA), &test_id, &res_dq, &data, &data,
+	"update quota usages for user"},
+	{QCMD(Q_QUOTAOFF, USRQUOTA), &test_id, USRPATH, &data, &data,
+	"turn off quota for user"},
+	{QCMD(Q_QUOTAON, GRPQUOTA), &fmt_id, GRPPATH, &data, &data,
+	"turn on quota for group"},
+	{QCMD(Q_SETQUOTA, GRPQUOTA), &test_id, &set_dq, &data, &data,
+	"set disk quota limit for group"},
+	{QCMD(Q_GETQUOTA, GRPQUOTA), &test_id, &res_dq, &set_dq.dqb_bsoftlimit,
+	&res_dq.dqb_bsoftlimit, "set disk quota limit for group"},
+# if defined(HAVE_QUOTAV2)
+	{QCMD(Q_SETINFO, GRPQUOTA), &test_id, &set_qf, &data, &data,
+	"set information about quotafile for group"},
+	{QCMD(Q_GETINFO, GRPQUOTA), &test_id, &res_qf, &set_qf.dqi_bgrace,
+	&res_qf.dqi_bgrace, "get information about quotafile for group"},
+	{QCMD(Q_GETFMT, GRPQUOTA), &test_id, fmt_buf, &fmt_id, fmt_buf,
+	"get quota format for group"},
+# endif
+	{QCMD(Q_SYNC, GRPQUOTA), &test_id, &res_dq, &data, &data,
+	"update quota usages for group"},
+	{QCMD(Q_QUOTAOFF, GRPQUOTA), &test_id, GRPPATH, &data, &data,
+	"turn off quota for group"}
+};
 
-/* Local  Functions */
-/******************************************************************************/
-/*									      */
-/* Function:	setup							      */
-/*									      */
-/* Description: Performs all one time setup for this test. This function is   */
-/*		typically used to capture signals, create temporary dirs      */
-/*		and temporary files that may be used in the course of this    */
-/*		test.							      */
-/*									      */
-/* Input:	None.							      */
-/*									      */
-/* Output:	None.							      */
-/*									      */
-/* Return:	On failure - Exits by calling cleanup().		      */
-/*		On success - returns 0.					      */
-/*									      */
-/******************************************************************************/
-void setup(void)
+static void setup(void)
 {
+	const char *const cmd[] = {"quotacheck", "-ug", MNTPOINT, NULL};
 
-	tst_require_root();
+	SAFE_MKDIR(MNTPOINT, 0755);
 
-	/* Capture signals if any */
-	/* Create temporary directories */
+	SAFE_MKFS(tst_device->dev, "ext4", NULL, NULL);
 
-	if ((quota_loc = malloc(FILENAME_MAX)) == NULL) {
-		tst_brkm(TCONF | TERRNO, NULL,
-			 "couldn't allocate memory for the quota loc buffer");
-	}
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, "ext4", 0, "usrquota,grpquota");
 
-	TEST_PAUSE;
-	tst_tmpdir();
+	tst_run_cmd(cmd, NULL, NULL, 0);
 
-	snprintf(quota_loc, FILENAME_MAX, "%s/%s", mountpoint, quota_file);
+	test_id = geteuid();
 
-	if (QUOTACTL(Q_QUOTAON, quota_loc) != 0) {
+	if (access(USRPATH, F_OK) == -1)
+		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
 
-		if (errno == ENOENT) {
-			tst_brkm(TCONF, cleanup,
-				 "quota file - %s - doesn't exist (is the name "
-				 "correct?)", quota_loc);
-		} else {
-			/* Provide a terse explanation for why the command
-			 * failed.. */
-			tst_brkm(TCONF | TERRNO, cleanup,
-				 "failed to enable quotas on block device: %s; "
-				 "1. Ensure that the device is mounted with the "
-				 "quota option. 2. Check the filesystem status "
-				 "with `quotacheck %s'", block_dev, block_dev);
-		}
-	} else {
-		quota_started = 1;
-	}
+	if (access(GRPPATH, F_OK) == -1)
+		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
 
+	mount_flag = 1;
 }
-#endif
 
-/*
-*  WARNING!! This test may cause the potential harm to the system, we DO NOT
-*  provide any warranty for the safety!!
-*/
-/*
-* To use this testcase, the quota function must be turned on and the user must
-* be the super user.
-*/
-
-#ifdef BROKEN_QUOTACTL
-int main(void)
+static void cleanup(void)
 {
-	tst_brkm(TBROK, NULL, "This system doesn't support quota v2");
+	if (mount_flag && tst_umount(MNTPOINT) < 0)
+		tst_res(TWARN | TERRNO, "umount(2) failed");
 }
-#else
-int cmd[] = {
-	Q_GETQUOTA,
-	Q_SETQUOTA,
-/* Only available in quota v2 */
-#if defined(HAVE_QUOTAV2)
-	Q_GETINFO,
-	Q_SETINFO,
-	Q_GETFMT,
-#endif
-	Q_SYNC
-};
 
-int main(int ac, char **av)
+static void verify_quota(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
 
-	static int block_dev_FLAG = 0, mountpoint_FLAG = 0, quota_file_FLAG = 0;
-	option_t opts[] = {
-		{.option = "b:",.flag = &block_dev_FLAG,.arg = &block_dev},
-		{.option = "m:",.flag = &mountpoint_FLAG,.arg = &mountpoint},
-		{.option = "q:",.flag = &quota_file_FLAG,.arg = &quota_file},
-		{.option = '\0'}
-	};
-
-	int newtid = -1;
-	int ret;
-	int i;
-	int lc;
-
-	tst_parse_opts(ac, av, (option_t *) opts, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+	res_dq.dqb_bsoftlimit = 0;
+	res_qf.dqi_igrace = 0;
+	memset(fmt_buf, 0, sizeof(fmt_buf));
 
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			for (i = 0; i <= sizeof(cmd) / sizeof(cmd[0]); i++) {
-
-				ret = QUOTACTL(cmd[i], &dq);
-				if (ret != 0) {
-					tst_resm(TFAIL | TERRNO,
-						 "cmd=0x%x failed", cmd[i]);
-				} else {
-					tst_resm(TPASS,
-						 "quotactl call succeeded");
-				}
-
-			}
-
-			TEST(ltp_syscall(__NR_set_tid_address, &newtid));
-
-			if (TEST_RETURN == getpid()) {
-				cleanup();
-			} else {
-				cleanup();
-				tst_exit();
-			}
-
-		}
+	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, (caddr_t) tc->addr));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TERRNO, "quotactl failed to %s", tc->des);
+		return;
+	}
 
+	if (*tc->set_data != *tc->res_data) {
+		tst_res(TFAIL | TERRNO, "quotactl got unexpected info %lu, "
+			"expected %lu", *tc->res_data, *tc->set_data);
+		return;
 	}
 
-	cleanup();
+	tst_res(TPASS, "quotactl secceeded to %s", tc->des);
+}
 
-	tst_exit();
+static struct tst_test test = {
+	.tid = "quotactl01",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_quota,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_device = 1,
+	.setup = setup,
+	.cleanup = cleanup
+};
 
-}
+#else
+	TST_TEST_TCONF("This system didn't support quota");
 #endif
-- 
1.8.3.1



