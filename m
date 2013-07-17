Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UzK8S-0005xF-2X
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 05:18:44 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UzK8Q-0001Yt-Db
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 05:18:44 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r6H5ITcP021926
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Jul 2013 13:18:34 +0800
Message-ID: <51E628D6.4030002@cn.fujitsu.com>
Date: Wed, 17 Jul 2013 13:17:10 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51E6272B.3020509@cn.fujitsu.com>
In-Reply-To: <51E6272B.3020509@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] quotactl/quotactl02.c: create a case to test
 basic flags of quotactl(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>


Test basic xqm-related flags of quotactl() syscall.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/quotactl/quotactl02.c | 258 ++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0ce3679..bf5da76 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -769,6 +769,7 @@ pwrite03_64 pwrite03_64
 pwrite04_64 pwrite04_64

 quotactl01 quotactl01
+quotactl02 quotactl02 -D XFS_DEVICE

 read01 read01
 read02 read02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f7e4ce0..7bf341f 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -633,6 +633,7 @@
 /pwrite/pwrite04
 /pwrite/pwrite04_64
 /quotactl/quotactl01
+/quotactl/quotactl02
 /read/read01
 /read/read02
 /read/read03
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
new file mode 100644
index 0000000..bd21c37
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -0,0 +1,258 @@
+/*
+ * Copyright (c) 2013 Fujitsu Ltd.
+ * Author: DAN LI <li.dan@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * Description:
+ *	This tests basic flags of quotactl() syscall:
+ *	1) Q_XQUOTAOFF - Turn off quotas for an XFS file system.
+ *	2) Q_XQUOTAON - Turn on quotas for an XFS file system.
+ *	3) Q_XGETQUOTA - Get disk quota limits and current usage for user id.
+ *	4) Q_XSETQLIM - Set disk quota limits for user id.
+ *	5) Q_XGETQSTAT - Get XFS file system specific quota information.
+ */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include "config.h"
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/mount.h>
+#include <linux/fs.h>
+#include <sys/types.h>
+
+#if defined(HAVE_XFS_QUOTA)
+#include <xfs/xqm.h>
+#else
+#define BROKEN_XFS_QUOTA 1
+#endif
+
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+#include "safe_macros.h"
+
+#define USRQCMD(cmd)	((cmd) << 8)
+#define RTBLIMIT	2000
+
+char *TCID = "quotactl02";
+int TST_TOTAL = 5;
+
+#ifndef BROKEN_XFS_QUOTA
+static void func_test(int i);
+static void setup(void);
+static void cleanup(void);
+static void help(void);
+
+static int dflag;
+static int uid = -1;
+static char dev[PATH_MAX];
+static char *block_dev;
+static struct fs_disk_quota dquota;
+static struct fs_quota_stat qstat;
+static unsigned int qflag = XFS_QUOTA_UDQ_ENFD;
+static const char mntpoint[] = "mnt_point";
+
+static option_t options[] = {
+	{"D:", &dflag, &block_dev},
+	{NULL, NULL, NULL},
+};
+
+static struct test_case_t {
+	int cmd;
+	const char *dev;
+	int *id;
+	void *addr;
+} TC[] = {
+	{Q_XQUOTAOFF, dev, &uid, &qflag},
+	{Q_XQUOTAON, dev, &uid, &qflag},
+	{Q_XGETQUOTA, dev, &uid, &dquota},
+	{Q_XSETQLIM, dev, &uid, &dquota},
+	{Q_XGETQSTAT, dev, &uid, &qstat},
+};
+
+int main(int argc, char *argv[])
+{
+	int i;
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, &help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (!dflag)
+		tst_brkm(TBROK, NULL,
+			 "you must specify the device used for mounting with "
+			 "the -D option");
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+
+			TEST(ltp_syscall(__NR_quotactl,
+					 USRQCMD(TC[i].cmd), TC[i].dev,
+					 *TC[i].id, TC[i].addr));
+
+			if (TEST_RETURN != 0)
+				tst_resm(TFAIL | TERRNO,
+					 "cmd=0x%x failed", TC[i].cmd);
+
+			if (STD_FUNCTIONAL_TEST)
+				func_test(i);
+			else
+				tst_resm(TPASS,
+					 "quotactl call succeeded");
+
+		}
+	}
+
+	cleanup();
+
+	tst_exit();
+
+}
+
+void func_test(int i)
+{
+	int ret;
+
+	switch (i) {
+	case 0:
+		/* Validate Q_XQUOTAOFF flag of quotactl call */
+		ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
+				  TC[i].dev, *TC[i].id, &qstat);
+		if (ret != 0)
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fail to get quota stat");
+
+		if (qstat.qs_flags & XFS_QUOTA_UDQ_ENFD) {
+			tst_resm(TFAIL, "enforcement is not off");
+			return;
+		}
+
+		tst_resm(TPASS, "enforcement is off");
+		break;
+
+	case 1:
+		/* Validate Q_XQUOTAON flag of quotactl call */
+		ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQSTAT),
+				  TC[i].dev, *TC[i].id, &qstat);
+		if (ret != 0)
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "fail to get quota stat");
+
+		if (!(qstat.qs_flags & XFS_QUOTA_UDQ_ENFD)) {
+			tst_resm(TFAIL, "enforcement is off");
+			return;
+		}
+
+		tst_resm(TPASS, "enforcement is on");
+		break;
+
+	case 2:
+		/* Validate Q_XGETQUOTA flag of quotactl call */
+		if (!(dquota.d_flags & XFS_USER_QUOTA)) {
+			tst_resm(TFAIL, "get incorrect quota type");
+			return;
+		}
+
+		/* for case3 */
+		dquota.d_rtb_hardlimit = RTBLIMIT;
+		dquota.d_fieldmask = FS_DQ_LIMIT_MASK;
+
+		tst_resm(TPASS, "get the right quota type");
+		break;
+
+	case 3:
+		/* Validate Q_XSETQLIM flag of quotactl call */
+		ret = ltp_syscall(__NR_quotactl, USRQCMD(Q_XGETQUOTA),
+				  TC[i].dev, *TC[i].id, &dquota);
+		if (ret != 0)
+			tst_brkm(TFAIL | TERRNO, NULL,
+				 "fail to get quota information");
+
+		if (dquota.d_rtb_hardlimit != RTBLIMIT) {
+			tst_resm(TFAIL, "limit on RTB, except %lu get %lu",
+				 (uint64_t)RTBLIMIT,
+				 (uint64_t)dquota.d_rtb_hardlimit);
+			return;
+		}
+
+		tst_resm(TPASS, "quotactl works fine with Q_XSETQLIM");
+		break;
+
+	case 4:
+		/* Validate Q_XGETQSTAT flag of quotactl call */
+		if (qstat.qs_version != FS_QSTAT_VERSION) {
+			tst_resm(TFAIL, "get incorrect qstat version");
+			return;
+		}
+
+		tst_resm(TPASS, "get correct qstat version");
+		break;
+
+	default:
+		tst_brkm(TBROK, cleanup, "Got unexpected index");
+	}
+
+}
+
+void setup()
+{
+
+	tst_require_root(NULL);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, mntpoint, 0755);
+
+	uid = 0;
+	strncpy(dev, block_dev, PATH_MAX);
+
+	if (mount(dev, mntpoint, "xfs", 0, "uquota") < 0)
+		tst_brkm(TFAIL | TERRNO, NULL, "mount(2) fail");
+
+}
+
+void cleanup()
+{
+	if (umount(mntpoint) < 0)
+		tst_resm(TFAIL | TERRNO, "umount(2) fail");
+
+	TEST_CLEANUP;
+	tst_rmdir();
+}
+
+void help(void)
+{
+	printf("-D device : device used for mounting.\n");
+}
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "This system doesn't support xfs quota");
+}
+#endif
-- 
1.8.1

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
