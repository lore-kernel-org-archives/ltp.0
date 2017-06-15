From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 15 Jun 2017 17:57:35 +0800
Subject: [LTP] [PATCH 2/2] sched/autogroup01: Add new regression test
In-Reply-To: <1497520655-12426-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1497520655-12426-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1497520655-12426-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed by:
commit 18f649ef344127ef6de23a5a4272dbe2fdb73dde
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Mon Nov 14 19:46:09 2016 +0100

  sched/autogroup: Fix autogroup_move_group() to never skip sched_move_task()

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/sched                                  |  2 +
 testcases/kernel/sched/autogroup/.gitignore    |  1 +
 testcases/kernel/sched/autogroup/Makefile      | 23 +++++++
 testcases/kernel/sched/autogroup/autogroup01.c | 95 ++++++++++++++++++++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 testcases/kernel/sched/autogroup/.gitignore
 create mode 100644 testcases/kernel/sched/autogroup/Makefile
 create mode 100644 testcases/kernel/sched/autogroup/autogroup01.c

diff --git a/runtest/sched b/runtest/sched
index 89398df..774d11f 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -16,3 +16,5 @@ sched_getattr02 sched_getattr02
 sched_cli_serv run_sched_cliserv.sh
 # Run this stress test for 2 minutes
 sched_stress sched_stress.sh
+
+autogroup01 autogroup01
diff --git a/testcases/kernel/sched/autogroup/.gitignore b/testcases/kernel/sched/autogroup/.gitignore
new file mode 100644
index 0000000..bcc7453
--- /dev/null
+++ b/testcases/kernel/sched/autogroup/.gitignore
@@ -0,0 +1 @@
+/autogroup01
diff --git a/testcases/kernel/sched/autogroup/Makefile b/testcases/kernel/sched/autogroup/Makefile
new file mode 100644
index 0000000..6cc7782
--- /dev/null
+++ b/testcases/kernel/sched/autogroup/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2017 Fujitsu Ltd.
+#  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sched/autogroup/autogroup01.c b/testcases/kernel/sched/autogroup/autogroup01.c
new file mode 100644
index 0000000..3b08e42
--- /dev/null
+++ b/testcases/kernel/sched/autogroup/autogroup01.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ * Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * This is a regression test about the race in autogroup, this test
+ * can crash the buggy kernel, and the bug has been fixed in:
+ *
+ *   commit 18f649ef344127ef6de23a5a4272dbe2fdb73dde
+ *   Author: Oleg Nesterov <oleg@redhat.com>
+ *   Date:   Mon Nov 14 19:46:09 2016 +0100
+ *
+ *   sched/autogroup: Fix autogroup_move_group() to never skip sched_move_task()
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define LOOPS	1000
+#define PATH_AUTOGROUP	"/proc/sys/kernel/sched_autogroup_enabled"
+
+static int orig_autogroup = -1;
+
+static void do_test(void)
+{
+	int i;
+
+	if (!SAFE_FORK()) {
+		SAFE_FILE_PRINTF(PATH_AUTOGROUP, "%d", 1);
+		SAFE_SETSID();
+
+		if (SAFE_FORK()) {
+			pause();
+			exit(0);
+		}
+
+		SAFE_KILL(getppid(), SIGKILL);
+		usleep(1000);
+
+		SAFE_FILE_PRINTF(PATH_AUTOGROUP, "%d", 0);
+		SAFE_SETSID();
+
+		for (i = 0; i < LOOPS; i++)
+			usleep(10);
+
+		TST_CHECKPOINT_WAKE(0);
+
+		exit(0);
+	}
+
+	SAFE_WAIT(NULL);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	tst_res(TPASS, "Bug not reproduced");
+}
+
+static void setup(void)
+{
+	if (access(PATH_AUTOGROUP, F_OK))
+		tst_brk(TCONF, "autogroup not supported");
+
+	SAFE_FILE_SCANF(PATH_AUTOGROUP, "%d", &orig_autogroup);
+}
+
+static void cleanup(void)
+{
+	if (orig_autogroup != -1)
+		SAFE_FILE_PRINTF(PATH_AUTOGROUP, "%d", orig_autogroup);
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_test,
+};
-- 
1.8.4.2



