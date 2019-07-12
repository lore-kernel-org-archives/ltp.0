From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Jul 2019 12:24:09 +0200
Subject: [LTP] [PATCH] syscalls/ioprio: Add test cases for I/O priority
Message-ID: <20190712102409.12906-1-linus.walleij@linaro.org>
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I never did LTP work before. Reviews appreciated.
If this proves worthwhile I will add test cases for
real-time and other scheduling requireing root access
and possibly look into testing user or process group
scheduling as well.
---
 testcases/kernel/syscalls/ioprio/.gitignore   |   1 +
 testcases/kernel/syscalls/ioprio/Makefile     |  22 +++
 testcases/kernel/syscalls/ioprio/ioprio.h     |  44 +++++
 .../kernel/syscalls/ioprio/ioprio_get01.c     |  72 ++++++++
 .../kernel/syscalls/ioprio/ioprio_set01.c     | 123 +++++++++++++
 .../kernel/syscalls/ioprio/ioprio_set02.c     | 166 ++++++++++++++++++
 6 files changed, 428 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioprio/.gitignore
 create mode 100644 testcases/kernel/syscalls/ioprio/Makefile
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio.h
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_get01.c
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set01.c
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set02.c

diff --git a/testcases/kernel/syscalls/ioprio/.gitignore b/testcases/kernel/syscalls/ioprio/.gitignore
new file mode 100644
index 000000000000..fc1c236053a4
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/.gitignore
@@ -0,0 +1 @@
+/ioprio_get01.c
diff --git a/testcases/kernel/syscalls/ioprio/Makefile b/testcases/kernel/syscalls/ioprio/Makefile
new file mode 100644
index 000000000000..7a1a87a28ead
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
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
index 000000000000..62183ebcf856
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
@@ -0,0 +1,72 @@
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
+#include "test.h"
+#include "ioprio.h"
+
+static void setup(void);
+static void cleanup(void);
+
+TCID_DEFINE(ioprio_get01);
+int TST_TOTAL = 1;
+
+static int ioprio_get(int which, int who)
+{
+	return syscall(SYS_ioprio_get, which, who);
+}
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+		int prio, class;
+
+		/* Get the I/O priority for the current process */
+		TEST(ioprio_get(IOPRIO_WHO_PROCESS, 0));
+
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO, "ioprio_get failed");
+			continue;
+		}
+
+		class = IOPRIO_PRIO_CLASS(TEST_RETURN);
+		prio = IOPRIO_PRIO_LEVEL(TEST_RETURN);
+
+		if (!prio_in_range(prio)) {
+			tst_resm(TFAIL, "ioprio out of range (%d)", prio);
+			continue;
+		}
+
+		tst_resm(TPASS, "ioprio_get returned class %s prio %d",
+			 to_class_str[class], prio);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+}
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set01.c b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
new file mode 100644
index 000000000000..776c5392e8dc
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
@@ -0,0 +1,123 @@
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
+#include "test.h"
+#include "ioprio.h"
+
+static void setup(void);
+static void cleanup(void);
+
+TCID_DEFINE(ioprio_set01);
+int TST_TOTAL = 1;
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
+		tst_resm(TFAIL | TTERRNO,
+			 "reading back prio failed");
+		return;
+	}
+
+	newclass = IOPRIO_PRIO_CLASS(res);
+	newprio = IOPRIO_PRIO_LEVEL(res);
+	if (newclass != class)
+		tst_resm(TFAIL,
+			 "wrong class after setting, expected %s got %s",
+			 to_class_str[class],
+			 to_class_str[newclass]);
+	else if (newprio != prio)
+		tst_resm(TFAIL,
+			 "wrong prio after setting, expected %d got %d",
+			 prio, newprio);
+	else
+		tst_resm(TPASS, "ioprio_set new class %s, new prio %d",
+			 to_class_str[newclass],
+			 newprio);
+}
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+		int class, prio;
+
+		/* Get the I/O priority for the current process */
+		TEST(ioprio_get(IOPRIO_WHO_PROCESS, 0));
+
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO, "ioprio_get failed");
+			/* Try to continue anyway */
+			class = IOPRIO_CLASS_NONE;
+			prio = 4;
+		} else {
+			class = IOPRIO_PRIO_CLASS(TEST_RETURN);
+			prio = IOPRIO_PRIO_LEVEL(TEST_RETURN);
+			tst_resm(TPASS, "ioprio_get returned class %s prio %d",
+				 to_class_str[class], prio);
+		}
+
+		/* Bump prio to what it was + 1 */
+		class = IOPRIO_CLASS_BE;
+		prio++;
+
+		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+				IOPRIO_PRIO_VALUE(class, prio)));
+		if (TEST_RETURN == -1)
+			tst_resm(TFAIL | TTERRNO, "ioprio_set failed");
+		else
+			ioprio_check_setting(class, prio);
+
+		/* Bump prio down two notches */
+		prio -= 2;
+		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+				IOPRIO_PRIO_VALUE(class, prio)));
+		if (TEST_RETURN == -1)
+			tst_resm(TFAIL | TTERRNO, "ioprio_set failed");
+		else
+			ioprio_check_setting(class, prio);
+
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+}
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set02.c b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
new file mode 100644
index 000000000000..1ba515b37e90
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
@@ -0,0 +1,166 @@
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
+#include "test.h"
+#include "ioprio.h"
+
+static void setup(void);
+static void cleanup(void);
+
+TCID_DEFINE(ioprio_set02);
+int TST_TOTAL = 1;
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
+		tst_resm(TFAIL | TTERRNO,
+			 "reading back prio failed");
+		return;
+	}
+
+	newclass = IOPRIO_PRIO_CLASS(res);
+	newprio = IOPRIO_PRIO_LEVEL(res);
+	if (newclass != class)
+		tst_resm(TFAIL,
+			 "wrong class after setting, expected %s got %s",
+			 to_class_str[class],
+			 to_class_str[newclass]);
+	else if (newprio != prio)
+		tst_resm(TFAIL,
+			 "wrong prio after setting, expected %d got %d",
+			 prio, newprio);
+	else if (report)
+		tst_resm(TPASS, "ioprio_set new class %s, new prio %d",
+			 to_class_str[newclass],
+			 newprio);
+}
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		tst_count = 0;
+		int class, prio;
+		int fail_in_loop;
+
+		/* Get the I/O priority for the current process */
+		TEST(ioprio_get(IOPRIO_WHO_PROCESS, 0));
+
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO, "ioprio_get failed");
+			/* Try to continue anyway */
+			class = IOPRIO_CLASS_NONE;
+			prio = 4;
+		} else {
+			class = IOPRIO_PRIO_CLASS(TEST_RETURN);
+			prio = IOPRIO_PRIO_LEVEL(TEST_RETURN);
+			tst_resm(TPASS, "ioprio_get returned class %s prio %d",
+				 to_class_str[class], prio);
+		}
+
+		/* Bump to best effort scheduling, all 8 priorities */
+		class = IOPRIO_CLASS_BE;
+
+		fail_in_loop = 0;
+		for (prio = 0; prio < 8; prio++) {
+			TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+					IOPRIO_PRIO_VALUE(class, prio)));
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL | TTERRNO, "ioprio_set IOPRIO_CLASS_BE prio %d failed", prio);
+				fail_in_loop = 1;
+			}
+		}
+		if (!fail_in_loop)
+			tst_resm(TPASS, "tested all 8 prios in class %s",
+				 to_class_str[class]);
+
+		/* Test to fail with prio 8, first set prio 4 */
+		ioprio_set(IOPRIO_WHO_PROCESS, 0,
+			   IOPRIO_PRIO_VALUE(class, 4));
+		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+				IOPRIO_PRIO_VALUE(class, 8)));
+		if (TEST_RETURN == -1) {
+			ioprio_check_setting(class, 4, 1);
+			prio = 5;
+		}
+		else
+			tst_resm(TFAIL, "ioprio_set IOPRIO_CLASS_BE prio %d should not work", prio);
+
+		/* Bump down to idle scheduling */
+		class = IOPRIO_CLASS_IDLE;
+
+		fail_in_loop = 0;
+		for (prio = 0; prio < 8; prio++) {
+			TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+					IOPRIO_PRIO_VALUE(class, prio)));
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL | TTERRNO, "ioprio_set IOPRIO_CLASS_IDLE failed");
+				fail_in_loop = 1;
+			}
+		}
+		if (!fail_in_loop)
+			tst_resm(TPASS, "tested all 8 prios in class %s",
+				 to_class_str[class]);
+
+		/* Test NONE scheduling */
+		class = IOPRIO_CLASS_NONE;
+		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+				IOPRIO_PRIO_VALUE(class, 0)));
+		if (TEST_RETURN == -1)
+			tst_resm(TFAIL | TTERRNO, "ioprio_set IOPRIO_CLASS_NONE failed");
+		else
+			ioprio_check_setting(class, 0, 1);
+
+		/* Any other prio than 0 should not work with NONE */
+		class = IOPRIO_CLASS_NONE;
+		TEST(ioprio_set(IOPRIO_WHO_PROCESS, 0,
+				IOPRIO_PRIO_VALUE(class, 4)));
+		if (TEST_RETURN == -1)
+			tst_resm(TPASS, "tested illegal priority with class %s",
+				 to_class_str[class]);
+		else
+			tst_resm(TFAIL, "ioprio_set IOPRIO_CLASS_NONE should fail");
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+}
-- 
2.21.0

