From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 Jul 2019 09:39:41 +0200
Subject: [LTP] [PATCH v2] syscalls/ioprio: Add test cases for I/O priority
Message-ID: <20190718073941.13153-1-linus.walleij@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ioprio_get/ioprio_set syscalls are used primarily by the
userspace tool "ionice" to set priority of a process, user or
process group toward the I/O (block layer) scheduler.

This adds a simple iprio_get test and two more verbose tests
for ioprio_set.

Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use the new test fixture "tst_test.h"
- Fix up legalese in the Makefile to a simple SPDX tag.
- Test from v2.6.13 when the syscall was introduced
---
 testcases/kernel/syscalls/ioprio/.gitignore   |   3 +
 testcases/kernel/syscalls/ioprio/Makefile     |   6 +
 testcases/kernel/syscalls/ioprio/ioprio.h     |  44 ++++++
 .../kernel/syscalls/ioprio/ioprio_get01.c     |  48 ++++++
 .../kernel/syscalls/ioprio/ioprio_set01.c     |  98 ++++++++++++
 .../kernel/syscalls/ioprio/ioprio_set02.c     | 142 ++++++++++++++++++
 6 files changed, 341 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioprio/.gitignore
 create mode 100644 testcases/kernel/syscalls/ioprio/Makefile
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio.h
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_get01.c
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set01.c
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set02.c

diff --git a/testcases/kernel/syscalls/ioprio/.gitignore b/testcases/kernel/syscalls/ioprio/.gitignore
new file mode 100644
index 000000000000..890081d8c625
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/.gitignore
@@ -0,0 +1,3 @@
+ioprio_get01
+ioprio_set01
+ioprio_set02
diff --git a/testcases/kernel/syscalls/ioprio/Makefile b/testcases/kernel/syscalls/ioprio/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ioprio/ioprio.h b/testcases/kernel/syscalls/ioprio/ioprio.h
new file mode 100644
index 000000000000..3a0f068a053a
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio.h
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#ifndef LTP_IOPRIO_H
+#define LTP_IOPRIO_H
+
+enum {
+	IOPRIO_CLASS_NONE = 0,
+	IOPRIO_CLASS_RT,
+	IOPRIO_CLASS_BE,
+	IOPRIO_CLASS_IDLE,
+};
+
+enum {
+	IOPRIO_WHO_PROCESS = 1,
+	IOPRIO_WHO_PGRP,
+	IOPRIO_WHO_USER,
+};
+
+#define IOPRIO_CLASS_SHIFT	(13)
+#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
+
+#define IOPRIO_PRIO_CLASS(data)	((data) >> IOPRIO_CLASS_SHIFT)
+#define IOPRIO_PRIO_LEVEL(data)	((data) & IOPRIO_PRIO_MASK)
+#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
+
+static const char *to_class_str[] = {
+	[IOPRIO_CLASS_NONE] = "NONE",
+	[IOPRIO_CLASS_RT]   = "REALTIME",
+	[IOPRIO_CLASS_BE]   = "BEST-EFFORT",
+	[IOPRIO_CLASS_IDLE] = "IDLE"
+};
+
+/* Priority range from 0 (highest) to 7 (lowest) */
+static inline int prio_in_range(int prio)
+{
+	if ((prio < 0) || (prio > 7))
+		return 0;
+	return 1;
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_get01.c b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
new file mode 100644
index 000000000000..79807763a5f3
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited
+ */
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "ioprio.h"
+
+static int ioprio_get(int which, int who)
+{
+	return syscall(SYS_ioprio_get, which, who);
+}
+
+static void run(void)
+{
+	int prio, class;
+
+	/* Get the I/O priority for the current process */
+	TEST(ioprio_get(IOPRIO_WHO_PROCESS, 0));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "ioprio_get failed");
+		return;
+	}
+
+	class = IOPRIO_PRIO_CLASS(TST_RET);
+	prio = IOPRIO_PRIO_LEVEL(TST_RET);
+
+	if (!prio_in_range(prio)) {
+		tst_res(TFAIL, "ioprio out of range (%d)", prio);
+		return;
+	}
+
+	tst_res(TPASS, "ioprio_get returned class %s prio %d",
+		to_class_str[class], prio);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "2.6.13",
+};
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set01.c b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
new file mode 100644
index 000000000000..9f2c9f4b3d48
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ */
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "ioprio.h"
+
+static int ioprio_get(int which, int who)
+{
+	return syscall(SYS_ioprio_get, which, who);
+}
+
+static int ioprio_set(int which, int who, int ioprio)
+{
+	return syscall(SYS_ioprio_set, which, who, ioprio);
+}
+
+static void ioprio_check_setting(int class, int prio)
+{
+	int res;
+	int newclass, newprio;
+
+	res = ioprio_get(IOPRIO_WHO_PROCESS, 0);
+	if (res == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"reading back prio failed");
+		return;
+	}
+
+	newclass = IOPRIO_PRIO_CLASS(res);
+	newprio = IOPRIO_PRIO_LEVEL(res);
+	if (newclass != class)
+		tst_res(TFAIL,
+			"wrong class after setting, expected %s got %s",
+			to_class_str[class],
+			to_class_str[newclass]);
+	else if (newprio != prio)
+		tst_res(TFAIL,
+			"wrong prio after setting, expected %d got %d",
+			prio, newprio);
+	else
+		tst_res(TPASS, "ioprio_set new class %s, new prio %d",
+			to_class_str[newclass],
+			newprio);
+}
+
+static void run(void)
+{
+	int class, prio;
+
+	/* Get the I/O priority for the current process */
+	TEST(ioprio_get(IOPRIO_WHO_PROCESS, 0));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "ioprio_get failed");
+		/* Try to continue anyway */
+		class = IOPRIO_CLASS_NONE;
+		prio = 4;
+	} else {
+		class = IOPRIO_PRIO_CLASS(TST_RET);
+		prio = IOPRIO_PRIO_LEVEL(TST_RET);
+		tst_res(TPASS, "ioprio_get returned class %s prio %d",
+			 to_class_str[class], prio);
+	}
+
+	/* Bump prio to what it was + 1 */
+	class = IOPRIO_CLASS_BE;
+	prio++;
+
+	TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+			IOPRIO_PRIO_VALUE(class, prio)));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "ioprio_set failed");
+	else
+		ioprio_check_setting(class, prio);
+
+	/* Bump prio down two notches */
+	prio -= 2;
+	TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+			IOPRIO_PRIO_VALUE(class, prio)));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "ioprio_set failed");
+	else
+		ioprio_check_setting(class, prio);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "2.6.13",
+};
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set02.c b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
new file mode 100644
index 000000000000..7cec8538254d
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ */
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "ioprio.h"
+
+static int ioprio_get(int which, int who)
+{
+	return syscall(SYS_ioprio_get, which, who);
+}
+
+static int ioprio_set(int which, int who, int ioprio)
+{
+	return syscall(SYS_ioprio_set, which, who, ioprio);
+}
+
+static void ioprio_check_setting(int class, int prio, int report)
+{
+	int res;
+	int newclass, newprio;
+
+	res = ioprio_get(IOPRIO_WHO_PROCESS, 0);
+	if (res == -1) {
+		tst_res(TFAIL | TTERRNO,
+			 "reading back prio failed");
+		return;
+	}
+
+	newclass = IOPRIO_PRIO_CLASS(res);
+	newprio = IOPRIO_PRIO_LEVEL(res);
+	if (newclass != class)
+		tst_res(TFAIL,
+			"wrong class after setting, expected %s got %s",
+			to_class_str[class],
+			to_class_str[newclass]);
+	else if (newprio != prio)
+		tst_res(TFAIL,
+			"wrong prio after setting, expected %d got %d",
+			prio, newprio);
+	else if (report)
+		tst_res(TPASS, "ioprio_set new class %s, new prio %d",
+			to_class_str[newclass],
+			newprio);
+}
+
+static void run(void)
+{
+	int class, prio;
+	int fail_in_loop;
+
+	/* Get the I/O priority for the current process */
+	TEST(ioprio_get(IOPRIO_WHO_PROCESS, 0));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "ioprio_get failed");
+		/* Try to continue anyway */
+		class = IOPRIO_CLASS_NONE;
+		prio = 4;
+	} else {
+		class = IOPRIO_PRIO_CLASS(TST_RET);
+		prio = IOPRIO_PRIO_LEVEL(TST_RET);
+		tst_res(TPASS, "ioprio_get returned class %s prio %d",
+			 to_class_str[class], prio);
+	}
+
+	/* Bump to best effort scheduling, all 8 priorities */
+	class = IOPRIO_CLASS_BE;
+
+	fail_in_loop = 0;
+	for (prio = 0; prio < 8; prio++) {
+		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+				IOPRIO_PRIO_VALUE(class, prio)));
+		if (TST_RET == -1) {
+			tst_res(TFAIL | TTERRNO, "ioprio_set IOPRIO_CLASS_BE prio %d failed", prio);
+			fail_in_loop = 1;
+		}
+	}
+	if (!fail_in_loop)
+		tst_res(TPASS, "tested all 8 prios in class %s",
+			 to_class_str[class]);
+
+	/* Test to fail with prio 8, first set prio 4 */
+	ioprio_set(IOPRIO_WHO_PROCESS, 0,
+		   IOPRIO_PRIO_VALUE(class, 4));
+	TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+			IOPRIO_PRIO_VALUE(class, 8)));
+	if (TST_RET == -1) {
+		ioprio_check_setting(class, 4, 1);
+		prio = 5;
+	}
+	else
+		tst_res(TFAIL, "ioprio_set IOPRIO_CLASS_BE prio %d should not work", prio);
+
+	/* Bump down to idle scheduling */
+	class = IOPRIO_CLASS_IDLE;
+
+	fail_in_loop = 0;
+	for (prio = 0; prio < 8; prio++) {
+		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+				IOPRIO_PRIO_VALUE(class, prio)));
+		if (TST_RET == -1) {
+			tst_res(TFAIL | TTERRNO, "ioprio_set IOPRIO_CLASS_IDLE failed");
+			fail_in_loop = 1;
+		}
+	}
+	if (!fail_in_loop)
+		tst_res(TPASS, "tested all 8 prios in class %s",
+			 to_class_str[class]);
+
+	/* Test NONE scheduling */
+	class = IOPRIO_CLASS_NONE;
+	TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+			IOPRIO_PRIO_VALUE(class, 0)));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "ioprio_set IOPRIO_CLASS_NONE failed");
+	else
+		ioprio_check_setting(class, 0, 1);
+
+	/* Any other prio than 0 should not work with NONE */
+	class = IOPRIO_CLASS_NONE;
+	TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+			IOPRIO_PRIO_VALUE(class, 4)));
+	if (TST_RET == -1)
+		tst_res(TPASS, "tested illegal priority with class %s",
+			 to_class_str[class]);
+	else
+		tst_res(TFAIL, "ioprio_set IOPRIO_CLASS_NONE should fail");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "2.6.13",
+};
-- 
2.21.0

