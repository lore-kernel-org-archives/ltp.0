From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 17 Dec 2020 12:57:52 +0530
Subject: [LTP] [PATCH V2 2/3] syscalls: init_module: Add tests
In-Reply-To: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
References: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
Message-ID: <50d28b5f804ee13cf4efca28cbd0b2d08929d46a.1608189944.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds success and failure tests for init_module() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Remove unwanted header
- Use TST_EXP_*() macros
- Always provide definition of init_module().
- Rename module.

 include/lapi/init_module.h                    | 19 ++++
 runtest/syscalls                              |  3 +
 .../kernel/syscalls/init_module/.gitignore    |  3 +
 .../kernel/syscalls/init_module/Makefile      | 21 ++++
 .../kernel/syscalls/init_module/init_module.c | 37 +++++++
 .../syscalls/init_module/init_module01.c      | 54 ++++++++++
 .../syscalls/init_module/init_module02.c      | 99 +++++++++++++++++++
 7 files changed, 236 insertions(+)
 create mode 100644 include/lapi/init_module.h
 create mode 100644 testcases/kernel/syscalls/init_module/.gitignore
 create mode 100644 testcases/kernel/syscalls/init_module/Makefile
 create mode 100644 testcases/kernel/syscalls/init_module/init_module.c
 create mode 100644 testcases/kernel/syscalls/init_module/init_module01.c
 create mode 100644 testcases/kernel/syscalls/init_module/init_module02.c

diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
new file mode 100644
index 000000000000..65ff70356c60
--- /dev/null
+++ b/include/lapi/init_module.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef INIT_MODULE_H__
+#define INIT_MODULE_H__
+
+#include "config.h"
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+
+static inline int init_module(void *module_image, unsigned long len,
+			      const char *param_values)
+{
+	return tst_syscall(__NR_init_module, module_image, len, param_values);
+}
+#endif /* INIT_MODULE_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index 9c328697b4a3..28174dddd716 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -517,6 +517,9 @@ getxattr03 getxattr03
 getxattr04 getxattr04
 getxattr05 getxattr05
 
+init_module01 init_module01
+init_module02 init_module02
+
 #Needs tty device.
 #ioctl01 ioctl01 -D /dev/tty0
 #ioctl02 ioctl02 -D /dev/tty0
diff --git a/testcases/kernel/syscalls/init_module/.gitignore b/testcases/kernel/syscalls/init_module/.gitignore
new file mode 100644
index 000000000000..b4d11e958544
--- /dev/null
+++ b/testcases/kernel/syscalls/init_module/.gitignore
@@ -0,0 +1,3 @@
+/init_module01
+/init_module02
+/*.ko
diff --git a/testcases/kernel/syscalls/init_module/Makefile b/testcases/kernel/syscalls/init_module/Makefile
new file mode 100644
index 000000000000..ebdca67d401d
--- /dev/null
+++ b/testcases/kernel/syscalls/init_module/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m := init_module.o
+
+else
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+REQ_VERSION_MAJOR	:= 2
+REQ_VERSION_PATCH	:= 6
+
+MAKE_TARGETS		:= init_module01 init_module02 init_module.ko
+
+include $(top_srcdir)/include/mk/module.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+endif
diff --git a/testcases/kernel/syscalls/init_module/init_module.c b/testcases/kernel/syscalls/init_module/init_module.c
new file mode 100644
index 000000000000..78d03b899a7e
--- /dev/null
+++ b/testcases/kernel/syscalls/init_module/init_module.c
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
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
new file mode 100644
index 000000000000..478ccf1c5fdf
--- /dev/null
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic init_module() tests.
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
+#define MODULE_NAME	"init_module.ko"
+
+static struct stat sb;
+static void *buf;
+
+static void setup(void)
+{
+	int fd;
+
+	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
+	SAFE_FSTAT(fd, &sb);
+	buf = SAFE_MMAP(0, sb.st_size, PROT_READ|PROT_EXEC, MAP_PRIVATE, fd, 0);
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	TST_EXP_PASS(init_module(buf, sb.st_size, "status=valid"));
+	if (!TST_PASS)
+		return;
+
+	tst_module_unload(MODULE_NAME);
+}
+
+static void cleanup(void)
+{
+	munmap(buf, sb.st_size);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
new file mode 100644
index 000000000000..102242dba98d
--- /dev/null
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * Basic init_module() failure tests.
+ *
+ * [ALGORITHM]
+ *
+ * Tests various failure scenarios for init_module().
+\*/
+
+#include <linux/capability.h>
+#include <errno.h>
+#include "lapi/init_module.h"
+#include "tst_module.h"
+#include "tst_capability.h"
+
+#define MODULE_NAME	"init_module.ko"
+
+static unsigned long size, zero_size;
+static void *buf, *faulty_buf, *null_buf;
+
+static struct tst_cap cap_req = TST_CAP(TST_CAP_REQ, CAP_SYS_MODULE);
+static struct tst_cap cap_drop = TST_CAP(TST_CAP_DROP, CAP_SYS_MODULE);
+
+static struct tcase {
+	const char *name;
+	void **buf;
+	unsigned long *size;
+	const char *param;
+	int cap;
+	int exp_errno;
+} tcases[] = {
+	{"NULL-buffer", &null_buf, &size, "", 0, EFAULT},
+	{"faulty-buffer", &faulty_buf, &size, "", 0, EFAULT},
+	{"null-param", &buf, &size, NULL, 0, EFAULT},
+	{"zero-size", &buf, &zero_size, "", 0, ENOEXEC},
+	{"invalid_param", &buf, &size, "status=invalid", 0, EINVAL},
+	{"no-perm", &buf, &size, "", 1, EPERM},
+	{"module-exists", &buf, &size, "", 0, EEXIST},
+};
+
+static void setup(void)
+{
+	struct stat sb;
+	int fd;
+
+	fd = SAFE_OPEN(MODULE_NAME, O_RDONLY|O_CLOEXEC);
+	SAFE_FSTAT(fd, &sb);
+	size = sb.st_size;
+	buf = SAFE_MMAP(0, size, PROT_READ|PROT_EXEC, MAP_PRIVATE, fd, 0);
+	SAFE_CLOSE(fd);
+
+	faulty_buf = tst_get_bad_addr(NULL);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (tc->cap)
+		tst_cap_action(&cap_drop);
+
+	/* Insert module twice */
+	if (tc->exp_errno == EEXIST) {
+		TST_EXP_PASS(init_module(*tc->buf, *tc->size, tc->param));
+		if (!TST_PASS)
+			goto out;
+
+		TST_EXP_FAIL(init_module(*tc->buf, *tc->size, tc->param), tc->exp_errno);
+		tst_module_unload(MODULE_NAME);
+	} else {
+		TST_EXP_FAIL(init_module(*tc->buf, *tc->size, tc->param), tc->exp_errno);
+	}
+
+	if (!TST_PASS && !TST_RET)
+		tst_module_unload(MODULE_NAME);
+
+out:
+	if (tc->cap)
+		tst_cap_action(&cap_req);
+}
+
+static void cleanup(void)
+{
+	munmap(buf, size);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

