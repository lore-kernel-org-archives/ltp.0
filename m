From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 27 Sep 2018 19:09:41 -0300
Subject: [LTP] [PATCH] syscalls/membarrier: Add membarrier() initial test
Message-ID: <20180927220941.19783-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #265

Initial test for membarrier() syscall. It tests all existing membarrier
"commands" (or features), including the need (or not) for previous
registration for the call to work.

Some features did not exist in older kernels and that is covered by
skipping some calls, flagging test as skipped & okay, and forcing
others, making sure that return codes and errno are set right in those
cases.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/membarrier/.gitignore     |   1 +
 testcases/kernel/syscalls/membarrier/Makefile |   8 +
 .../kernel/syscalls/membarrier/membarrier01.c | 337 ++++++++++++++++++
 4 files changed, 348 insertions(+)
 create mode 100644 testcases/kernel/syscalls/membarrier/.gitignore
 create mode 100644 testcases/kernel/syscalls/membarrier/Makefile
 create mode 100644 testcases/kernel/syscalls/membarrier/membarrier01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be7713..19be14098 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1504,3 +1504,5 @@ statx02 statx02
 statx03 statx03
 statx04 statx04
 statx05 statx05
+
+membarrier01 membarrier01
diff --git a/testcases/kernel/syscalls/membarrier/.gitignore b/testcases/kernel/syscalls/membarrier/.gitignore
new file mode 100644
index 000000000..eec8058b9
--- /dev/null
+++ b/testcases/kernel/syscalls/membarrier/.gitignore
@@ -0,0 +1 @@
+/membarrier01
diff --git a/testcases/kernel/syscalls/membarrier/Makefile b/testcases/kernel/syscalls/membarrier/Makefile
new file mode 100644
index 000000000..f71e4fc25
--- /dev/null
+++ b/testcases/kernel/syscalls/membarrier/Makefile
@@ -0,0 +1,8 @@
+# Copyright (c) 2018 - Linaro Limited. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/membarrier/membarrier01.c b/testcases/kernel/syscalls/membarrier/membarrier01.c
new file mode 100644
index 000000000..fdc6c4204
--- /dev/null
+++ b/testcases/kernel/syscalls/membarrier/membarrier01.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+
+/*
+ * Basic tests for membarrier(2) syscall. Tests bellow are responsible for
+ * testing the membarrier(2) interface only, without checking if the barrier was
+ * successful or not.
+ *
+ * There are 11 test cases:
+ *
+ * 00) invalid cmd:
+ *		- enabled by default
+ *		- should always fail with EINVAL
+ * 01) invalid flags:
+ *		- enabled by default
+ *		- should always fail with EINVAL
+ * ----
+ * 02) global barrier:
+ *		- ALWAYS enabled by CMD_QUERY
+ *		- should always succeed
+ * ----
+ * commit 22e4ebb975 (v4.14-rc1) added following feature:
+ *
+ * 03) private expedited barrier with no registrations:
+ *		- should fail with errno=EPERM due to no registrations
+ *		- or be skipped if unsupported by running kernel
+ * 04) register private expedited
+ *		- should succeed when supported by running kernel
+ *		- or fail with errno=EINVAL if unsupported and forced
+ * 05) private expedited barrier with registration
+ *		- should succeed due to existing registration (case 04)
+ *		- or fail with errno=EINVAL if unsupported and forced
+ *		- NOTE: if unsupported, and forced, on < 4.10, errno is EINVAL
+ * ----
+ * commit 70216e18e5 (v4.16-rc1) added following feature:
+ *
+ * 06) private expedited sync core barrier with no registrations
+ *		- should fail with errno=EPERM due to no registrations
+ *		- or be skipped if unsupported by running kernel
+ * 07) register private expedited sync core
+ *		- should succeed when supported by running kernel
+ *		- or fail with errno=EINVAL if unsupported and forced
+ * 08) private expedited sync core barrier with registration
+ *		- should succeed due to existing registration (case 07)
+ *		- or fail with errno=EINVAL if unsupported and forced
+ * ----
+ * commit c5f58bd58f4 (v4.16-rc1) added following feature:
+ *
+ * 09) global expedited barrier with no registrations
+ *		- should never fail due to no registrations
+ *		- or be skipped if unsupported by running kernel
+ * 10) register global expedited
+ *		- should succeed when supported by running kernel
+ *		- or fail with errno=EINVAL if unsupported and forced
+ * 11) global expedited barrier with registration
+ *		- should succeed due to existing registration (case 10) or not
+ *		- or fail with errno=EINVAL if unsupported and forced
+ * ----
+ * OBSERVATION:
+ *
+ * Linux kernel does not provide a way to unregister (mm->membarrier_state) the
+ * process intent of being affected by the membarrier(2) call.
+ */
+
+#include "config.h"
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "tst_test.h"
+
+#define passed_ok(_test)						       \
+	do {								       \
+		tst_res(TPASS, "membarrier(2): %s passed", _test.testname);    \
+		return;							       \
+	} while (0)
+
+#define passed_unexpectedly(_test)					       \
+	do {								       \
+		tst_res(TFAIL, "membarrier(2): %s passed unexpectedly. "       \
+			"ret = %ld with errno %d were expected. (force: %d)",  \
+			_test.testname, _test.exp_ret, _test.exp_errno,        \
+			_test.force);					       \
+		return;							       \
+	} while (0)
+
+#define failed_ok(_test)						       \
+	do {								       \
+		tst_res(TPASS, "membarrier(2): %s failed as expected",	       \
+			_test.testname);				       \
+		return;							       \
+	} while (0)
+
+#define failed_ok_unsupported(_test)					       \
+	do {								       \
+		tst_res(TPASS, "membarrier(2): %s failed as expected "	       \
+			"(unsupported)", _test.testname);		       \
+		return;							       \
+	} while (0)
+
+#define failed_not_ok(_test, _gotret, _goterr)				       \
+	do {								       \
+		tst_res(TFAIL, "membarrier(2): %s failed as expected. "	       \
+			"ret = %ld when expected was %ld. "		       \
+			"errno = %d when expected was %d. (force: %d)",        \
+			_test.testname, _gotret, _test.exp_ret, _goterr,       \
+			_test.exp_errno, _test.force);			       \
+		return;							       \
+	} while (0)
+
+#define failed_unexpectedly(_test, _gotret, _goterr)			       \
+	do {								       \
+		tst_res(TFAIL, "membarrier(2): %s failed unexpectedly. "       \
+			"Got ret = %ld with errno %d. (force: %d)",	       \
+			_test.testname, _gotret, _goterr, _test.force);	       \
+		return;							       \
+	} while (0)
+
+#define skipped(_test)							       \
+	do {								       \
+		tst_res(TPASS, "membarrier(2): %s skipped (unsupported)",      \
+			_test.testname);				       \
+		return;							       \
+	} while (0)
+
+#define skipped_fail(_test)						       \
+	do {								       \
+		tst_res(TFAIL, "membarrier(2): %s reported as not supported",  \
+			_test.testname);				       \
+		return;							       \
+	} while (0)
+
+static int sys_membarrier(int cmd, int flags)
+{
+	return syscall(__NR_membarrier, cmd, flags);
+}
+
+struct test_case {
+	char testname[80];
+	int command;		/* membarrier cmd                            */
+	int flags;		/* flags for given cmd                       */
+	long exp_ret;		/* expected return code for given cmd        */
+	int exp_errno;		/* expected errno for given cmd              */
+	int enabled;		/* enabled despite results from CMD_QUERY    */
+	int always;		/* CMD_QUERY should always enable this test  */
+	int force;		/* force if CMD_QUERY says is not enabled    */
+	int force_exp_errno;	/* expected errno after error for forced cmd */
+};
+
+struct test_case tc[] = {
+	{
+	 /* case 00 */
+	 .testname = "cmd_fail\0",
+	 .command = -1,
+	 .exp_ret = -1,
+	 .exp_errno = EINVAL,
+	 .enabled = 1,
+	 },
+	{
+	 /* case 01 */
+	 .testname = "cmd_flags_fail\0",
+	 .command = MEMBARRIER_CMD_QUERY,
+	 .flags = 1,
+	 .exp_ret = -1,
+	 .exp_errno = EINVAL,
+	 .enabled = 1,
+	 },
+	{
+	 /* case 02 */
+	 .testname = "cmd_global_success\0",
+	 .command = MEMBARRIER_CMD_GLOBAL,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .always = 1,
+	 },
+	{
+	 /* case 03 */
+	 .testname = "cmd_private_expedited_fail\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = -1,
+	 .exp_errno = EPERM,
+	 },
+	{
+	 /* case 04 */
+	 .testname = "cmd_private_expedited_register_success\0",
+	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+	{
+	 /* case 05 */
+	 .testname = "cmd_private_expedited_success\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+	{
+	 /* case 06 */
+	 .testname = "cmd_private_expedited_sync_core_fail\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
+	 .flags = 0,
+	 .exp_ret = -1,
+	 .exp_errno = EPERM,
+	 },
+	{
+	 /* case 07 */
+	 .testname = "cmd_private_expedited_sync_core_register_success\0",
+	 .command = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+	{
+	 /* case 08 */
+	 .testname = "cmd_private_expedited_sync_core_success\0",
+	 .command = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+	{
+	 /* case 09 */
+	 .testname = "cmd_global_expedited_success\0",
+	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 },
+	{
+	 /* case 10 */
+	 .testname = "cmd_global_expedited_register_success\0",
+	 .command = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+	{
+	 /* case 11 */
+	 .testname = "cmd_global_expedited_success\0",
+	 .command = MEMBARRIER_CMD_GLOBAL_EXPEDITED,
+	 .flags = 0,
+	 .exp_ret = 0,
+	 .force = 1,
+	 .force_exp_errno = EINVAL,
+	 },
+};
+
+static void verify_membarrier(unsigned int i)
+{
+	/* skips tests depending on supportability */
+
+	if (tc[i].enabled != 1 && tc[i].force != 1) {
+		if (tc[i].always == 0)
+			skipped(tc[i]);
+
+		skipped_fail(tc[i]);
+	}
+
+	TEST(sys_membarrier(tc[i].command, tc[i].flags));
+
+	/* cmd passes */
+
+	if (tc[i].exp_ret == TST_RET) {
+
+		if (TST_RET >= 0)
+			passed_ok(tc[i]);
+		else {
+			if (tc[i].enabled == 1 && tc[i].force != 1) {
+				if (tc[i].exp_errno != TST_ERR)
+					failed_not_ok(tc[i], TST_RET, TST_ERR);
+				else
+					failed_ok(tc[i]);
+			} else {
+				if (tc[i].force_exp_errno != TST_ERR)
+					failed_not_ok(tc[i], TST_RET, TST_ERR);
+				else
+					failed_ok_unsupported(tc[i]);
+			}
+		}
+
+	/* cmd fails */
+
+	} else {
+		if (tc[i].enabled == 1 && tc[i].force != 1) {
+			if (TST_RET >= 0)
+				passed_unexpectedly(tc[i]);
+			else
+				failed_unexpectedly(tc[i], TST_RET, TST_ERR);
+		} else {
+			if (tc[i].force_exp_errno == TST_ERR)
+				failed_ok_unsupported(tc[i]);
+			else
+				failed_not_ok(tc[i], TST_RET, TST_ERR);
+		}
+	}
+}
+
+static void setup(void)
+{
+	size_t i;
+	int ret;
+
+	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			tst_brk(TCONF, "sys_membarrier(2) not supported");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tc); i++) {
+		if ((tc[i].command > 0) && (ret & tc[i].command))
+			tc[i].enabled = 1;
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_membarrier,
+	.tcnt = ARRAY_SIZE(tc),
+};
-- 
2.19.0.rc2

