From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 14 Jul 2017 13:12:42 +0200
Subject: [LTP] [PATCH] syscalls/setrlimit: add setrlimit04
Message-ID: <efe5be914c757f391b9f0eba0630548dea309f1b.1500030543.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Early patches for stack guard gap caused that gap size was contributing
towards stack limit. This caused failures for new processes (E2BIG) when
ulimit was set to anything lower than size of gap.

  # ./setrlimit04
  tst_test.c:898: INFO: Timeout per run is 0h 05m 00s
  setrlimit04.c:53: BROK: execlp(/bin/true, /bin/true, ...) failed: E2BIG
  setrlimit04.c:61: FAIL: child process exited with 2

commit 1be7107fbe18 "mm: larger stack guard gap, between vmas" sets default
gap size to 1M (for systems with 4k pages), so let's set stack limit to 512kB
and confirm we can still run some trivial binary.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/.gitignore              |  1 +
 testcases/kernel/syscalls/setrlimit/setrlimit04.c | 67 +++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setrlimit/setrlimit04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 91aba8504ef3..dddc7b0bee94 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1132,6 +1132,7 @@ setreuid07_16 setreuid07_16
 setrlimit01 setrlimit01
 setrlimit02 setrlimit02
 setrlimit03 setrlimit03
+setrlimit04 setrlimit04
 
 set_robust_list01 set_robust_list01
 set_thread_area01 set_thread_area01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 3d9bb756c82b..1735cdab0860 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -922,6 +922,7 @@
 /setrlimit/setrlimit01
 /setrlimit/setrlimit02
 /setrlimit/setrlimit03
+/setrlimit/setrlimit04
 /setsid/setsid01
 /setsockopt/setsockopt01
 /settimeofday/settimeofday01
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit04.c b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
new file mode 100644
index 000000000000..13d1b9f98700
--- /dev/null
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
@@ -0,0 +1,67 @@
+/*
+ *   Copyright (C) 2017 Red Hat, Inc.  All rights reserved.
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   DESCRIPTION
+ *     Attempt to run a trivial binary with stack < 1MB.
+ *
+ *     Early patches for stack guard gap caused that gap size was
+ *     contributing towards stack limit. This caused failures
+ *     for new processes (E2BIG) when ulimit was set to anything
+ *     lower than size of gap. commit 1be7107fbe18 "mm: larger
+ *     stack guard gap, between vmas" sets default gap size to 1M
+ *     (for systems with 4k pages), so let's set stack limit to 512kB
+ *     and confirm we can still run some trivial binary.
+ */
+
+#define _GNU_SOURCE
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+
+#define STACK_LIMIT (512 * 1024)
+
+static void test_setrlimit(void)
+{
+	int status;
+	struct rlimit rlim;
+	pid_t child;
+
+	rlim.rlim_cur = STACK_LIMIT;
+	rlim.rlim_max = STACK_LIMIT;
+
+	SAFE_SETRLIMIT(RLIMIT_STACK, &rlim);
+
+	child = SAFE_FORK();
+	if (child == 0)
+		SAFE_EXECLP("/bin/true", "/bin/true", NULL);
+	SAFE_WAITPID(child, &status, 0);
+
+	if (WIFEXITED(status)) {
+		if ((WEXITSTATUS(status) == 0))
+			tst_res(TPASS, "child process completed OK");
+		else
+			tst_res(TFAIL, "child process exited with %d",
+				WEXITSTATUS(status));
+	} else if (WIFSIGNALED(status)) {
+		tst_res(TFAIL, "child exited with signal %s",
+			tst_strsig(WTERMSIG(status)));
+	}
+}
+
+static struct tst_test test = {
+	.test_all     = test_setrlimit,
+	.forks_child  = 1,
+	.needs_root = 1,
+};
-- 
1.8.3.1

