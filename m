From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 27 May 2019 16:19:31 +0800
Subject: [LTP] [PATCH v4] syscalls/prctl05.c: New test for prctl() with
	PR_{SET, GET}_NAME
In-Reply-To: <7113d89a-3eb8-5671-bb6a-26cc4cbb69bf@163.com>
References: <7113d89a-3eb8-5671-bb6a-26cc4cbb69bf@163.com>
Message-ID: <1558945171-2252-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/prctl.h                       |  5 ++
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/prctl/.gitignore |  1 +
 testcases/kernel/syscalls/prctl/prctl05.c  | 81 ++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/prctl/prctl05.c

diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index f42bd6459..ad0b12bce 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -9,6 +9,11 @@
 
 #include <sys/prctl.h>
 
+#ifndef PR_SET_NAME
+# define PR_SET_NAME 15
+# define PR_GET_NAME 16
+#endif
+
 #ifndef PR_SET_SECCOMP
 # define PR_GET_SECCOMP  21
 # define PR_SET_SECCOMP  22
diff --git a/runtest/syscalls b/runtest/syscalls
index 04558a580..d2dcd2152 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -862,6 +862,7 @@ prctl01 prctl01
 prctl02 prctl02
 prctl03 prctl03
 prctl04 prctl04
+prctl05 prctl05
 
 pread01 pread01
 pread01_64 pread01_64
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
index 1c3da3052..9ecaf9854 100644
--- a/testcases/kernel/syscalls/prctl/.gitignore
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -2,3 +2,4 @@
 /prctl02
 /prctl03
 /prctl04
+/prctl05
diff --git a/testcases/kernel/syscalls/prctl/prctl05.c b/testcases/kernel/syscalls/prctl/prctl05.c
new file mode 100644
index 000000000..bbd2a9c98
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/prctl05.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Test PR_GET_NAME and PR_SET_NAME of prctl(2).
+ * 1)Set the name of the calling thread, the name can be up to 16 bytes
+ *   long, including the terminating null byte. If exceeds 16 bytes, the
+ *   string is silently truncated.
+ * 2)Return the name of the calling thread, the buffer should allow space
+ *   for up to 16 bytes, the returned string will be null-terminated.
+ * 3)Check /proc/self/task/[tid]/comm and /proc/self/comm name whether
+ *   matches the thread name.
+ */
+
+#include <sys/prctl.h>
+#include <string.h>
+#include <stdio.h>
+#include "lapi/syscalls.h"
+#include "lapi/prctl.h"
+#include "tst_test.h"
+
+static struct tcase {
+	char setname[20];
+	char expname[20];
+} tcases[] = {
+	{"prctl05_test", "prctl05_test"},
+	{"prctl05_test_xxxxx", "prctl05_test_xx"}
+};
+
+static void check_proc_comm(char *path, char *name)
+{
+	char comm_buf[20];
+
+	SAFE_FILE_SCANF(path, "%s", comm_buf);
+	if (strcmp(name, comm_buf))
+		tst_res(TFAIL,
+			"%s has %s, expected %s", path, comm_buf, name);
+	else
+		tst_res(TPASS, "%s sets to %s", path, comm_buf);
+}
+
+static void verify_prctl(unsigned int n)
+{
+	char buf[20];
+	char comm_path[40];
+	pid_t tid;
+	struct tcase *tc = &tcases[n];
+
+	TEST(prctl(PR_SET_NAME, tc->setname));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_NAME) failed");
+		return;
+	}
+	tst_res(TPASS, "prctl(PR_SET_NAME, '%s') succeeded", tc->setname);
+
+	TEST(prctl(PR_GET_NAME, buf));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_NAME) failed");
+		return;
+	}
+
+	if (strcmp(tc->expname, buf)) {
+		tst_res(TFAIL,
+			"prctl(PR_GET_NAME) failed, expected %s, got %s", tc->expname, buf);
+		return;
+	}
+	tst_res(TPASS, "prctl(PR_GET_NAME) succeeded, thread name is %s", buf);
+
+	tid = tst_syscall(__NR_gettid);
+
+	sprintf(comm_path, "/proc/self/task/%d/comm", tid);
+	check_proc_comm(comm_path, tc->expname);
+
+	check_proc_comm("/proc/self/comm", tc->expname);
+}
+
+static struct tst_test test = {
+	.test = verify_prctl,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.18.1



