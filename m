From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  8 Jun 2017 12:57:31 +0300
Subject: [LTP] [PATCH v2 2/2] clone09: add a test for CLONE_NEWNET flag
In-Reply-To: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
References: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1496915851-5222-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that a new thread has new network namespace by
checking interface tag value parameter for lo interface
(/proc/sys/net/ipv4/conf/lo/tag). Change the value in
parent before clone() and then compare with the value saved
inside the thread.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: remove TCID field

 runtest/syscalls                          |    1 +
 testcases/kernel/syscalls/.gitignore      |    1 +
 testcases/kernel/syscalls/clone/clone09.c |   99 +++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/clone/clone09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fe52272..2189bec 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -84,6 +84,7 @@ clone05 clone05
 clone06 clone06
 clone07 clone07
 clone08 clone08
+clone09 clone09
 
 close01 close01
 close02 close02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index c14c4e6..ea168a7 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -62,6 +62,7 @@
 /clone/clone06
 /clone/clone07
 /clone/clone08
+/clone/clone09
 /close/close01
 /close/close02
 /close/close08
diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
new file mode 100644
index 0000000..193d32c
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "tst_test.h"
+#include "clone_platform.h"
+#include "linux_syscall_numbers.h"
+
+static void *child_stack;
+static int sysctl_net = -1;
+static int sysctl_net_new = -1;
+static const char sysctl_path[] = "/proc/sys/net/ipv4/conf/lo/tag";
+static const char sysctl_path_def[] = "/proc/sys/net/ipv4/conf/default/tag";
+static int flags = CLONE_NEWNET | CLONE_VM | SIGCHLD;
+
+static void setup(void)
+{
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+}
+
+static void cleanup(void)
+{
+	if (sysctl_net != -1)
+		SAFE_FILE_PRINTF(sysctl_path, "%d", sysctl_net);
+
+	free(child_stack);
+}
+
+static int newnet(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	SAFE_FILE_SCANF(sysctl_path, "%d", &sysctl_net_new);
+	tst_syscall(__NR_exit, 0);
+	return 0;
+}
+
+static long clone_child(void)
+{
+	TEST(ltp_clone(flags, newnet, NULL, CHILD_STACK_SIZE, child_stack));
+
+	if (TEST_RETURN == -1 && TTERRNO == EINVAL)
+		tst_brk(TCONF, "CLONE_NEWNET not supported, CONFIG_NET_NS?");
+
+	if (TEST_RETURN == -1)
+		tst_brk(TBROK | TTERRNO, "clone(CLONE_NEWNET) failed");
+
+	return TEST_RETURN;
+}
+
+static void do_test(void)
+{
+	int def_val;
+
+	tst_res(TINFO, "create clone in a new netns with 'CLONE_NEWNET' flag");
+
+	SAFE_FILE_SCANF(sysctl_path, "%d", &sysctl_net);
+	SAFE_FILE_PRINTF(sysctl_path, "%d", sysctl_net + 1);
+
+	clone_child();
+	tst_reap_children();
+
+	if (sysctl_net_new == (sysctl_net + 1)) {
+		tst_res(TFAIL, "sysctl params equal: %s=%d",
+			sysctl_path, sysctl_net_new);
+	}
+
+	SAFE_FILE_SCANF(sysctl_path_def, "%d", &def_val);
+
+	if (sysctl_net_new != def_val) {
+		tst_res(TFAIL, "netns param init to non-default value %d",
+			sysctl_net_new);
+	}
+
+	tst_res(TPASS, "sysctl params differ in new netns");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
-- 
1.7.1

