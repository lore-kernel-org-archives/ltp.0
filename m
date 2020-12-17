From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 17 Dec 2020 15:59:18 +0530
Subject: [LTP] [PATCH V3 3/3] syscalls: finit_module: Add tests
In-Reply-To: <0279beda4660ab1b401164e369c79475633bd067.1608189944.git.viresh.kumar@linaro.org>
References: <0279beda4660ab1b401164e369c79475633bd067.1608189944.git.viresh.kumar@linaro.org>
Message-ID: <d537c9be33a54d31f70bd25e3268dbebbb67ea8f.1608200941.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds success and failure tests for finit_module() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/init_module.h                    | 16 ++++
 runtest/syscalls                              |  3 +
 .../kernel/syscalls/finit_module/.gitignore   |  3 +
 .../kernel/syscalls/finit_module/Makefile     | 21 +++++
 .../syscalls/finit_module/finit_module.c      | 37 ++++++++
 .../syscalls/finit_module/finit_module01.c    | 49 ++++++++++
 .../syscalls/finit_module/finit_module02.c    | 89 +++++++++++++++++++
 7 files changed, 218 insertions(+)
 create mode 100644 testcases/kernel/syscalls/finit_module/.gitignore
 create mode 100644 testcases/kernel/syscalls/finit_module/Makefile
 create mode 100644 testcases/kernel/syscalls/finit_module/finit_module.c
 create mode 100644 testcases/kernel/syscalls/finit_module/finit_module01.c
 create mode 100644 testcases/kernel/syscalls/finit_module/finit_module02.c

diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
index 65ff70356c60..9e79e11b8557 100644
--- a/include/lapi/init_module.h
+++ b/include/lapi/init_module.h
@@ -16,4 +16,20 @@ static inline int init_module(void *module_image, unsigned long len,
 {
 	return tst_syscall(__NR_init_module, module_image, len, param_values);
 }
+
+static inline int finit_module(int fd, const char *param_values, int flags)
+{
+	return tst_syscall(__NR_finit_module, fd, param_values, flags);
+}
+
+void finit_module_supported_by_kernel(void)
+{
+       if ((tst_kvercmp(3, 8, 0)) < 0) {
+               /* Check if the syscall is backported on an older kernel */
+               TEST(syscall(__NR_finit_module, 0, "", 0));
+               if (TST_RET == -1 && TST_ERR == ENOSYS)
+                       tst_brk(TCONF, "Test not supported on kernel version < v3.8");
+       }
+}
+
 #endif /* INIT_MODULE_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index 28174dddd716..961545e73834 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -327,6 +327,9 @@ fgetxattr01 fgetxattr01
 fgetxattr02 fgetxattr02
 fgetxattr03 fgetxattr03
 
+finit_module01 finit_module01
+finit_module02 finit_module02
+
 flistxattr01 flistxattr01
 flistxattr02 flistxattr02
 flistxattr03 flistxattr03
diff --git a/testcases/kernel/syscalls/finit_module/.gitignore b/testcases/kernel/syscalls/finit_module/.gitignore
new file mode 100644
index 000000000000..5fcafdb3736d
--- /dev/null
+++ b/testcases/kernel/syscalls/finit_module/.gitignore
@@ -0,0 +1,3 @@
+/finit_module01
+/finit_module02
+/*.ko
diff --git a/testcases/kernel/syscalls/finit_module/Makefile b/testcases/kernel/syscalls/finit_module/Makefile
new file mode 100644
index 000000000000..a529695d23cc
--- /dev/null
+++ b/testcases/kernel/syscalls/finit_module/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m := finit_module.o
+
+else
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR	:= 3
+REQ_VERSION_PATCH	:= 8
+
+MAKE_TARGETS		:= finit_module01 finit_module02 finit_module.ko
+
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/syscalls/finit_module/finit_module.c b/testcases/kernel/syscalls/finit_module/finit_module.c
new file mode 100644
index 000000000000..78d03b899a7e
--- /dev/null
+++ b/testcases/kernel/syscalls/finit_module/finit_module.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Dummy test module.
+ *
+ * The module accepts a single argument named "status" and it fails
+ * initialization if the status is set to "invalid".
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/kernel.h>
+
+static char status[20];
+module_param_string(status, status, 20, 0444);
+
+static int dummy_init(void)
+{
+	struct proc_dir_entry *proc_dummy;
+
+	if (!strcmp(status, "invalid"))
+		return -EINVAL;
+
+	proc_dummy = proc_mkdir("dummy", 0);
+	return 0;
+}
+module_init(dummy_init);
+
+static void dummy_exit(void)
+{
+	remove_proc_entry("dummy", 0);
+}
+module_exit(dummy_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
new file mode 100644
index 000000000000..c31c0c2dce4c
--- /dev/null
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic finit_module() tests.
+ *
+ * [ALGORITHM]
+ *
+ * Inserts a simple module after opening and mmaping the module file.
+\*/
+
+#include <errno.h>
+#include "lapi/init_module.h"
+#include "tst_module.h"
+
+#define MODULE_NAME	"finit_module.ko"
+
+int fd;
+
+static void setup(void)
+{
+	finit_module_supported_by_kernel();
+	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
+}
+
+static void run(void)
+{
+	TST_EXP_PASS(finit_module(fd, "status=valid", 0));
+	if (!TST_PASS)
+		return;
+
+	tst_module_unload(MODULE_NAME);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
new file mode 100644
index 000000000000..088b15055221
--- /dev/null
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic finit_module() failure tests.
+ *
+ * [ALGORITHM]
+ *
+ * Tests various failure scenarios for finit_module().
+\*/
+
+#include <linux/capability.h>
+#include <errno.h>
+#include "lapi/init_module.h"
+#include "tst_module.h"
+#include "tst_capability.h"
+
+#define MODULE_NAME	"finit_module.ko"
+
+static int fd, fd_zero, fd_invalid = -1;
+
+static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
+static struct tst_cap cap_drop = TST_CAP(TST_CAP_DROP, CAP_SYS_MODULE);
+
+static struct tcase {
+	const char *name;
+	int *fd;
+	const char *param;
+	int open_flags;
+	int flags;
+	int cap;
+	int exp_errno;
+} tcases[] = {
+	{"invalid-fd", &fd_invalid, "", O_RDONLY | O_CLOEXEC, 0, 0, EBADF}, /* Keep this at index 0 */
+	{"zero-fd", &fd_zero, "", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL},
+	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT},
+	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL},
+	{"invalid-flags", &fd, "", O_RDONLY | O_CLOEXEC, -1, 0, EINVAL},
+	{"no-perm", &fd, "", O_RDONLY | O_CLOEXEC, 0, 1, EPERM},
+	{"module-exists", &fd, "", O_RDONLY | O_CLOEXEC, 0, 0, EEXIST},
+	{"file-not-readable", &fd, "", O_WRONLY | O_CLOEXEC, 0, 0, EBADF},
+};
+
+static void setup(void)
+{
+	finit_module_supported_by_kernel();
+
+	/* Kernel returned ENOEXEC for fd = -1 earlier */
+	if ((tst_kvercmp(4, 6, 0)) < 0)
+		tcases[0].exp_errno = ENOEXEC;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	fd = SAFE_OPEN(MODULE_NAME, tc->open_flags);
+
+	if (tc->cap)
+		tst_cap_action(&cap_drop);
+
+	/* Insert module twice */
+	if (tc->exp_errno == EEXIST)
+		tst_module_load(MODULE_NAME, NULL);
+
+	TST_EXP_FAIL(finit_module(*tc->fd, tc->param, tc->flags), tc->exp_errno);
+
+	if (tc->exp_errno == EEXIST)
+		tst_module_unload(MODULE_NAME);
+
+	if (!TST_PASS && !TST_RET)
+		tst_module_unload(MODULE_NAME);
+
+	if (tc->cap)
+		tst_cap_action(&cap_req);
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

