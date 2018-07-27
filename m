From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 27 Jul 2018 11:34:23 +0800
Subject: [LTP] [PATCH v2] syscalls/prctl03.c: New test for prctl() with
	PR_{SET, GET}_CHILD_SUBREAPER
In-Reply-To: <20180725125655.GA23890@rei>
References: <20180725125655.GA23890@rei>
Message-ID: <1532662463-9404-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/prctl.h                       |  17 ++++
 runtest/ltplite                            |   1 +
 runtest/stress.part3                       |   1 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/prctl/.gitignore |   1 +
 testcases/kernel/syscalls/prctl/prctl03.c  | 130 +++++++++++++++++++++++++++++
 6 files changed, 151 insertions(+)
 create mode 100644 include/lapi/prctl.h
 create mode 100644 testcases/kernel/syscalls/prctl/prctl03.c

diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
new file mode 100644
index 0000000..6db8a64
--- /dev/null
+++ b/include/lapi/prctl.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+#ifndef LAPI_PRCTL_H__
+# define LAPI_PRCTL_H__
+
+#include <sys/prctl.h>
+
+#ifndef PR_SET_CHILD_SUBREAPER
+# define PR_SET_CHILD_SUBREAPER	36
+# define PR_GET_CHILD_SUBREAPER	37
+#endif
+
+#endif /* LAPI_PRCTL_H__ */
diff --git a/runtest/ltplite b/runtest/ltplite
index 5a7819c..0840564 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -574,6 +574,7 @@ poll01 poll01
 
 prctl01 prctl01
 prctl02 prctl02
+prctl03 prctl03
 
 pread01 pread01
 pread02 pread02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 3121cd9..fea4ccb 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -483,6 +483,7 @@ poll01 poll01
 
 prctl01 prctl01
 prctl02 prctl02
+prctl03 prctl03
 
 pread01 pread01
 pread02 pread02
diff --git a/runtest/syscalls b/runtest/syscalls
index dc72484..420ff45 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -808,6 +808,7 @@ ppoll01 ppoll01
 
 prctl01 prctl01
 prctl02 prctl02
+prctl03 prctl03
 
 pread01 pread01
 pread01_64 pread01_64
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
index 6af5df6..2f46a9a 100644
--- a/testcases/kernel/syscalls/prctl/.gitignore
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -1,2 +1,3 @@
 /prctl01
 /prctl02
+/prctl03
diff --git a/testcases/kernel/syscalls/prctl/prctl03.c b/testcases/kernel/syscalls/prctl/prctl03.c
new file mode 100644
index 0000000..294f38d
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/prctl03.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * Test PR_SET_CHILD_SUBREAPER and PR_GET_CHILD_SUBREAPER of prctl(2).
+ * 1) If PR_SET_CHILD_SUBREAPER marks a process as a child subreaper, it
+ *    fulfills the role of init(1) for its descendant orphaned process.
+ *    The PPID of its orphaned process will be reparented to the subreaper
+ *    process, and the subreaper process can receive a SIGCHLD signal and
+ *    wait(2) on the orphaned process to discover corresponding termination
+ *    status.
+ * 2) The setting of PR_SET_CHILD_SUBREAPER is not inherited by children
+ *    created by fork(2).
+ * 3) PR_GET_CHILD_SUBREAPER can get the setting of PR_SET_CHILD_SUBREAPER.
+ *
+ * These flags was added by kenrel commit ebec18a6d3aa:
+ * "prctl: add PR_{SET,GET}_CHILD_SUBREAPER to allow simple process supervision"
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <sys/prctl.h>
+
+#include "tst_test.h"
+#include "lapi/prctl.h"
+
+static volatile int sigchild_recv;
+
+static void check_get_subreaper(int exp_val)
+{
+	int get_val;
+
+	TEST(prctl(PR_GET_CHILD_SUBREAPER, &get_val));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_CHILD_SUBREAPER) failed");
+		return;
+	}
+
+	if (get_val == exp_val) {
+		tst_res(TPASS, "prctl(PR_GET_CHILD_SUBREAPER) got expected %d",
+			get_val);
+	} else {
+		tst_res(TFAIL, "prctl(PR_GET_CHILD_SUBREAPER) got %d, expected %d",
+			get_val, exp_val);
+	}
+}
+
+static void verify_prctl(void)
+{
+	int status, ret;
+	pid_t pid;
+	pid_t ppid = getpid();
+
+	sigchild_recv = 0;
+
+	TEST(prctl(PR_SET_CHILD_SUBREAPER, 1));
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL) {
+			tst_res(TCONF,
+				"prctl() doesn't support PR_SET_CHILD_SUBREAPER");
+		} else {
+			tst_res(TFAIL | TTERRNO,
+				"prctl(PR_SET_CHILD_SUBREAPER) failed");
+		}
+		return;
+	}
+
+	tst_res(TPASS, "prctl(PR_SET_CHILD_SUBREAPER) succeeded");
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		pid_t cpid;
+
+		cpid = SAFE_FORK();
+		if (!cpid) {
+			TST_CHECKPOINT_WAIT(0);
+			if (getppid() != ppid) {
+				tst_res(TFAIL,
+					"PPID of orphaned process was not reparented");
+				exit(1);
+			}
+
+			tst_res(TPASS, "PPID of orphaned process was reparented");
+			exit(0);
+		}
+
+		check_get_subreaper(0);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+	TST_CHECKPOINT_WAKE(0);
+	ret = wait(&status);
+	if (ret > 0) {
+		tst_res(TPASS, "wait() got orphaned process, pid %d, status %d",
+			ret, status);
+	} else {
+		tst_res(TFAIL | TERRNO,
+			"wait() failed to get orphaned process");
+	}
+
+	if (sigchild_recv == 2)
+		tst_res(TPASS, "received SIGCHLD from orphaned process");
+	else
+		tst_res(TFAIL, "didn't receive SIGCHLD from orphaned process");
+
+	check_get_subreaper(1);
+}
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	sigchild_recv++;
+}
+
+static void setup(void)
+{
+	SAFE_SIGNAL(SIGCHLD, sighandler);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.test_all = verify_prctl,
+};
-- 
1.8.3.1



