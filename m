From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 11 Oct 2017 12:43:56 +0800
Subject: [LTP] [PATCH v3 1/2] syscalls/setrlimit05.c: Add a test for EFAULT
In-Reply-To: <20171010125459.GD4970@rei.lan>
References: <20171010125459.GD4970@rei.lan>
Message-ID: <1507697036-30535-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Usually, setrlimit() returns EFAULT when rlim points outside
   the accessible address space.
2) In some cases, setrlimit() could return SIGSEGV as expected
   when rlim points outside the accessible address space.
   Please see the following url for reasons:
    https://github.com/linux-test-project/ltp/issues/193

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/.gitignore              |  1 +
 testcases/kernel/syscalls/setrlimit/setrlimit05.c | 66 +++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setrlimit/setrlimit05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2362a23..dc1c452 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1142,6 +1142,7 @@ setrlimit01 setrlimit01
 setrlimit02 setrlimit02
 setrlimit03 setrlimit03
 setrlimit04 setrlimit04
+setrlimit05 setrlimit05
 
 set_robust_list01 set_robust_list01
 set_thread_area01 set_thread_area01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 930f3f9..e4a8df2 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -930,6 +930,7 @@
 /setrlimit/setrlimit02
 /setrlimit/setrlimit03
 /setrlimit/setrlimit04
+/setrlimit/setrlimit05
 /setsid/setsid01
 /setsockopt/setsockopt01
 /settimeofday/settimeofday01
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
new file mode 100644
index 0000000..3d708df
--- /dev/null
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ */
+
+/*
+ * Test for EFAULT when rlim points outside the accessible address space.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+static void verify_setrlimit(void)
+{
+	int status;
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
+		if (TEST_RETURN == -1 && TEST_ERRNO == EFAULT)
+			exit(0);
+
+		exit(1);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	/* Usually, setrlimit() should return EFAULT */
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		tst_res(TPASS, "setrlimit() returned EFAULT as expected");
+		return;
+	}
+
+	/* If glibc has to convert between 32bit and 64bit struct rlimit
+	 * in some cases, it is possible to get SegFault.
+	 */
+	if (!WIFEXITED(status) && WIFSIGNALED(status) == SIGSEGV) {
+		tst_res(TPASS, "setrlimit() returned SIGSEGV as expected");
+		return;
+	}
+
+	tst_res(TFAIL, "setrlimit() did not return EFAULT or SIGSEGV");
+}
+
+static struct tst_test test = {
+	.test_all = verify_setrlimit,
+	.forks_child = 1,
+	.needs_root = 1,
+};
-- 
1.8.3.1



