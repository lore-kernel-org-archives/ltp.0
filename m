From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 14 Jun 2017 14:12:41 +0800
Subject: [LTP] [PATCH v4] controllers/memcg_test_3: Add new regression test
In-Reply-To: <5940D369.3040203@cn.fujitsu.com>
References: <5940D369.3040203@cn.fujitsu.com>
Message-ID: <1497420761-27575-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This kernel bug is about RHEL6 BZ1168185 and has been fixed in:

[PATCH RHEL6] [mm] memcg: fix crash in re-entrant cgroup_clear_css_refs()

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1168185
Patch: ftp://partners.redhat.com/1c5d859a/de6aafa8185ed8fd934f2debc72b79eb/kernel-individual-patch/rhel6/v2.6.32-to-kernel-2.6.32-536.el6.tar.bz2
       35944-mm-memcg-fix-crash-in-re-entrant-cgroup_clear_css_r.patch

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/controllers                                |   1 +
 testcases/kernel/controllers/memcg/.gitignore      |   1 +
 .../controllers/memcg/regression/memcg_test_3.c    | 114 +++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/regression/memcg_test_3.c

diff --git a/runtest/controllers b/runtest/controllers
index b904e05..2c43d0b 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -1,6 +1,7 @@
 #DESCRIPTION:Resource Management testing
 cgroup		cgroup_regression_test.sh
 memcg_regression	memcg_regression_test.sh
+memcg_test_3	memcg_test_3
 memcg_failcnt memcg_failcnt.sh
 memcg_force_empty memcg_force_empty.sh
 memcg_limit_in_bytes memcg_limit_in_bytes.sh
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
index 8730251..c0b6d07 100644
--- a/testcases/kernel/controllers/memcg/.gitignore
+++ b/testcases/kernel/controllers/memcg/.gitignore
@@ -2,5 +2,6 @@
 /functional/memcg_process
 /regression/memcg_test_1
 /regression/memcg_test_2
+/regression/memcg_test_3
 /regression/memcg_test_4
 /stress/memcg_process_stress
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
new file mode 100644
index 0000000..e9de903
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -0,0 +1,114 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ *  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
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
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * This is a regression test for a crash caused by memcg function
+ * reentrant on RHEL6.  When doing rmdir(), a pending signal can
+ * interrupt the execution and lead to cgroup_clear_css_refs()
+ * being entered repeatedly, this results in a BUG_ON().
+ *
+ * This bug was introduced by following RHEL6 patch on 2.6.32-488.el6:
+ *
+ *  [mm] memcg: fix race condition between memcg teardown and swapin
+ *  Link: https://bugzilla.redhat.com/show_bug.cgi?id=1001197
+ *  Patch: ftp://partners.redhat.com/1c5d859a/de6aafa8185ed8fd934f2debc72b79eb/kernel-individual-patch/rhel6/v2.6.32-to-kernel-2.6.32-488.el6.tar.bz2
+ *         31675-mm-memcg-fix-race-condition-between-memcg-teardown-.patch
+ *
+ * This test can crash the buggy kernel on RHEL6.6GA, and the bug
+ * was fixed by following patch on 2.6.32-536.el6:
+ *
+ *  [mm] memcg: fix crash in re-entrant cgroup_clear_css_refs()
+ *  Link: https://bugzilla.redhat.com/show_bug.cgi?id=1168185
+ *  Patch: ftp://partners.redhat.com/1c5d859a/de6aafa8185ed8fd934f2debc72b79eb/kernel-individual-patch/rhel6/v2.6.32-to-kernel-2.6.32-536.el6.tar.bz2
+ *         35944-mm-memcg-fix-crash-in-re-entrant-cgroup_clear_css_r.patch
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include "tst_test.h"
+
+#define MNTPOINT	"memcg"
+#define SUBDIR	"memcg/testdir"
+
+static int mount_flag;
+static volatile int sigcounter;
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	sigcounter++;
+}
+
+static void do_child(void)
+{
+	while (1)
+		SAFE_KILL(getppid(), SIGUSR1);
+
+	exit(0);
+}
+
+static void do_test(void)
+{
+	pid_t cpid = -1;
+
+	SAFE_SIGNAL(SIGUSR1, sighandler);
+
+	cpid = SAFE_FORK();
+	if (cpid == 0)
+		do_child();
+
+	while (sigcounter < 50000) {
+		if (access(SUBDIR, F_OK))
+			SAFE_MKDIR(SUBDIR, 0644);
+		rmdir(SUBDIR);
+	}
+
+	SAFE_KILL(cpid, SIGKILL);
+	SAFE_WAIT(NULL);
+
+	tst_res(TPASS, "Bug not reproduced");
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(MNTPOINT, 0644);
+
+	SAFE_MOUNT("memcg", MNTPOINT, "cgroup", 0, "memory");
+	mount_flag = 1;
+}
+
+static void cleanup(void)
+{
+	if (!access(SUBDIR, F_OK))
+		SAFE_RMDIR(SUBDIR);
+
+	if (mount_flag)
+		tst_umount(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.tid = "memcg_test_3",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.min_kver = "2.6.24",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_test,
+};
-- 
1.8.4.2



