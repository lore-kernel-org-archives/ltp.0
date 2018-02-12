From: Michael Moese <mmoese@suse.de>
Date: Mon, 12 Feb 2018 11:03:39 +0100
Subject: [LTP] [PATCH v4 1/3] Add library support for
	/proc/sys/kernel/tainted
In-Reply-To: <20180212100341.23841-1-mmoese@suse.de>
References: <20180212100341.23841-1-mmoese@suse.de>
Message-ID: <20180212100341.23841-2-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometimes, it is important to detect if the kernel has issued a
warning, died, or is tainted in another way. Linux provides this
information in /proc/sys/kernel/tainted in the form of a bitfield.
This patch provides library functions for testcases to detect, if
it has tainted the kernel.

The following functions will be introduced:

- int tst_taint_init(unsigned int mask)
  check if the flags supplied as mask are supported by the running
  kernel, and if so, if they are not yet set.

- int tst_taint_check()
  check if one or more of the bits specified in the mask provided
  to tst_taint_init() before are set.
  Returns 0 if those flags are not set, or the bitmask of set flags

These can be used in the following way:

First, during testcase setup:

void setup(void)
{
	...
	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
}

Second, check if the test triggered a bug:

void run(void)
{
	...
	. test code here
	...
	if (tst_taint_check() != 0)
		tst_res(TFAIL, "kernel has issues");
	 else
		tst_res(TPASS, "kernel seems to be fine");
}

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 doc/test-writing-guidelines.txt |  42 ++++++++++++++++
 include/tst_taint.h             | 104 +++++++++++++++++++++++++++++++++++++++
 lib/tst_taint.c                 | 106 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 include/tst_taint.h
 create mode 100644 lib/tst_taint.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 739b295b8..f12386485 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1312,6 +1312,48 @@ common.h:9: FAIL: check failed
 test.c:8: INFO: do_action(arg) failed
 -------------------------------------------------------------------------------
 
+2.2.24 Tainted kernels
+^^^^^^^^^^^^^^^^^^^^^^
+
+If you need to detect, if a testcase triggers a kernel warning, bug or oops,
+the following can be used to detect TAINT_W or TAINT_D:
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+#include "tst_taint.h"
+
+void setup(void)
+{
+	...
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+	...
+}
+...
+void run(void)
+{
+	...
+	if (tst_taint_check() == 0)
+		tst_res(TPASS, "kernel is not tainted");
+	else
+		tst_res(TFAIL, "kernel is tainted");
+}
+-------------------------------------------------------------------------------
+
+You have to call tst_taint_init() with non-zero flags first, preferably during
+setup(). The function will generate a TCONF if the requested flags are not
+fully supported on the running kernel, and TBROK if either a zero mask was
+supplied or if the kernel is already tainted before executing the test.
+
+Then you can call tst_taint_check() during run(), which returns 0 or the 
+tainted flags set in /proc/sys/kernel/tainted as specified earlier.
+
+Depending on your kernel version, not all tainted-flags will be supported.
+
+For reference to tainted kernels, see kernel documentation:
+Documentation/admin-guide/tainted-kernels.rst or
+https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_taint.h b/include/tst_taint.h
new file mode 100644
index 000000000..1039e2ddc
--- /dev/null
+++ b/include/tst_taint.h
@@ -0,0 +1,104 @@
+/*
+ * Copyright (c) 2018 Michael Moese <mmoese@suse.de>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/* Usage example
+ *
+ * ...
+ * #include "tst_test.h"
+ * #include "tst_taint.h"
+ * ..
+ * void setup(void)
+ * {
+ *	...
+ *	tst_taint_init(TST_TAINT_W | TST_TAINT_D));
+ *	...
+ * }
+ *
+ * void run(void)
+ * {
+ *	...
+ *	. test code here
+ *	...
+ *	if (tst_taint_check() != 0)
+ *		tst_res(TFAIL, "kernel has issues");
+ *	else
+ *		tst_res(TPASS, "kernel seems to be fine");
+ * }
+ *
+ *
+ *
+ * The above code checks, if the kernel issued a warning (TST_TAINT_W)
+ * or even died (TST_TAINT_D) during test execution.
+ * If these are set after running a test case, we most likely
+ * triggered a kernel bug.
+ */
+
+#ifndef TST_TAINTED_H__
+#define TST_TAINTED_H__
+
+/*
+ * This are all 17 flags that are present in kernel 4.15
+ * see kernel/panic.c in kernel sources
+ *
+ * Not all of them are valid in all kernel versions.
+ */
+#define TST_TAINT_G     (1 <<  0) /* a module with non-GPL license loaded */
+#define TST_TAINT_F     (1 <<  1) /* a module was force-loaded */
+#define TST_TAINT_S     (1 <<  2) /* SMP with Non-SMP kernel */
+#define TST_TAINT_R     (1 <<  3) /* module force unloaded */
+#define TST_TAINT_M     (1 <<  4) /* machine check error occurred */
+#define TST_TAINT_B     (1 <<  5) /* page-release function found bad page */
+#define TST_TAINT_U     (1 <<  6) /* user requested taint flag */
+#define TST_TAINT_D     (1 <<  7) /* kernel died recently - OOPS or BUG */
+#define TST_TAINT_A     (1 <<  8) /* ACPI table has been overwritten */
+#define TST_TAINT_W     (1 <<  9) /* a warning has been issued by kernel */
+#define TST_TAINT_C     (1 << 10) /* driver from drivers/staging was loaded */
+#define TST_TAINT_I     (1 << 11) /* working around BIOS/Firmware bug */
+#define TST_TAINT_O     (1 << 12) /* out of tree module loaded */
+#define TST_TAINT_E     (1 << 13) /* unsigned module was loaded */
+#define TST_TAINT_L     (1 << 14) /* A soft lock-up has previously occurred */
+#define TST_TAINT_K     (1 << 15) /* kernel has been live-patched */
+#define TST_TAINT_X	(1 << 16) /* auxiliary taint, for distro's use */
+
+/*
+ * Initialize and prepare support for checking tainted kernel.
+ *
+ * supply the mask of TAINT-flags you want to check, for example
+ * (TST_TAINT_W | TST_TAINT_D) when you want to check if the kernel issued
+ * a warning or even reported it died.
+ *
+ * This function tests if the requested flags are supported on the
+ * locally running kernel. In case the tainted-flags are already set by
+ * the kernel, there is no reason to continue and TCONF is generated.
+ *
+ * The mask must not be zero.
+ */
+void tst_taint_init(unsigned int mask);
+
+
+/*
+ * check if the tainted flags handed to tst_taint_init() are still not set
+ * during or after running the test.
+ * Calling this function is only allowed after tst_taint_init() was called,
+ * otherwise TBROK will be generated.
+ *
+ * returns 0 or a bitmask of the flags that currently tainted the kernel.
+ */
+unsigned int tst_taint_check(void);
+
+
+#endif /* TST_TAINTED_H__ */
diff --git a/lib/tst_taint.c b/lib/tst_taint.c
new file mode 100644
index 000000000..8d7a37b47
--- /dev/null
+++ b/lib/tst_taint.c
@@ -0,0 +1,106 @@
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_safe_stdio.h"
+
+#define TAINT_FILE "/proc/sys/kernel/tainted"
+
+static unsigned int taint_mask = -1;
+
+static unsigned int tst_taint_read(void)
+{
+	unsigned int val;
+
+	if (taint_mask == (unsigned int) -1)
+		tst_brk(TBROK, "need to call tst_taint_init() first");
+
+	SAFE_FILE_SCANF(TAINT_FILE, "%u", &val);
+
+	return val;
+}
+
+static int tst_taint_check_kver(unsigned int mask)
+{
+	int r1;
+	int r2;
+	int r3 = 0;
+
+	if (mask & TST_TAINT_X) {
+		r1 = 4;
+		r2 = 15;
+	} else if (mask & TST_TAINT_K) {
+		r1 = 4;
+		r2 = 0;
+	} else if (mask & TST_TAINT_L) {
+		r1 = 3;
+		r2 = 17;
+	} else if (mask & TST_TAINT_E) {
+		r1 = 3;
+		r2 = 15;
+	} else if (mask & TST_TAINT_O) {
+		r1 = 3;
+		r2 = 2;
+	} else if (mask & TST_TAINT_I) {
+		r1 = 2;
+		r2 = 6;
+		r3 = 35;
+	} else if (mask & TST_TAINT_C) {
+		r1 = 2;
+		r2 = 6;
+		r3 = 28;
+	} else if (mask & TST_TAINT_W) {
+		r1 = 2;
+		r2 = 6;
+		r3 = 26;
+	} else if (mask & TST_TAINT_A) {
+		r1 = 2;
+		r2 = 6;
+		r3 = 25;
+	} else if (mask & TST_TAINT_D) {
+		r1 = 2;
+		r2 = 6;
+		r3 = 23;
+	} else if (mask & TST_TAINT_U) {
+		r1 = 2;
+		r2 = 6;
+		r3 = 21;
+	} else {
+		r1 = 2;
+		r2 = 6;
+		r3 = 16;
+	}
+
+	return tst_kvercmp(r1, r2, r3);
+}
+
+void tst_taint_init(unsigned int mask)
+{
+	unsigned int taint = -1;
+
+	if (mask == 0)
+		tst_brk(TBROK, "mask is not allowed to be 0");
+
+	if (tst_taint_check_kver(mask) < 0)
+		tst_res(TCONF, "Kernel is too old for requested mask");
+
+	taint_mask = mask;
+
+	taint = tst_taint_read();
+	if ((taint & mask) != 0)
+		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
+}
+
+
+unsigned int tst_taint_check(void)
+{
+	unsigned int taint = -1;
+
+	if (taint_mask == (unsigned int) -1)
+		tst_brk(TBROK, "need to call tst_taint_init() first");
+
+	taint = tst_taint_read();
+
+	return (taint & taint_mask);
+}
+
-- 
2.13.6

