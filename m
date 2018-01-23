From: Michael Moese <mmoese@suse.de>
Date: Tue, 23 Jan 2018 15:30:13 +0100
Subject: [LTP] [PATCH] Add library support for /proc/sys/kernel/tainted
Message-ID: <20180123143013.2879-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Someteimes, it is important to detect if the kernel has issued a
warning, or died, or is tainted in another way. Linux provides this
information in /proc/sys/kernel/tainted in the form of a bitfield.
From 2.6.26 on, Linux supports detection of kernel warnings or
even if the kernel had died.
This patch provides library functions for testcases to detect, if
it has triggered a bug in the kernel.

The following functions will be introduced:

- int tst_taint_supported(void)
  are TAINT_W and TAINT_D available on your kernel? Determined
  simply using the running kernel version

- int tst_taint_check_mask(unsigned int mask)
  check if one or more of the bits specified in mask are set
  in /sys/proc/kernel/tainted

- unsigned int tst_taint_read(void)
  unfiltered access to /sys/proc/kernel/tainted, for advanced use

These can be used in the following way:

First, check support state during setup():

void setup(void)
{
	...
	if (!tst_taint_supported())
		tst_brk(TCONF, "Kernel does not support tainted flags");
}

Second, check if the test triggered a bug:

void run(void)
{
	if (tst_taint_read() != 0)
		tst_res(TFAIL, "kernel is already tainted, stopping");

	...
	if(tst_taint_check(TST_TAINT_W | TST_TAINT_D))
		tst_res(TFAIL, "kernel has issues");
	 else
		tst_res(TPASS, "kernel seems to be fine");
}

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 include/tst_taint.h | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_taint.c     |  52 ++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 include/tst_taint.h
 create mode 100644 lib/tst_taint.c

diff --git a/include/tst_taint.h b/include/tst_taint.h
new file mode 100644
index 000000000..34e69c2f5
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
+ *	if (!tst_taint_supported())
+ *		tst_brk(TCONF, "Kernel does not support tainted flags");
+ * }
+ *
+ * void run(void)
+ * {
+ *	...
+ *	. test code here
+ *	...
+ *	if(tst_taint_check(TST_TAINT_W | TST_TAINT_D))
+ *		tst_res(TFAIL, "kernel has issues");
+ *	else
+ *		tst_res(TPASS, "kernel seems to be fine");
+ * }
+ *
+ *
+ *
+ * The above code checks, if the kernel issued a warning (TST_TAINT_W)
+ * or even died (TST_TAINT_D). If these are set durin execution of a
+ * test case, we most likely triggered a kernel bug.
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
+ * check if kernel is recent enough to support the tainted-flags that
+ * allow us to check if the kernel issued a warning or died.
+ * This _must_ be called before calling other functions!
+ *
+ * returns 1 if supported, 0 otherwise
+ */
+int tst_taint_supported(void);
+
+
+/*
+ * read /proc/sys/kernel/tainted and check if@least one of the
+ * bits specified in mask is set.
+ * mask is required to be > 0. Use tst_taint_read() in order to check
+ * for absence of any tainted flags.
+ *
+ * returns 1 if at least one bit of mask is set in
+ * /proc/sys/kernel/tainted, 0 otherwise.
+ * (unsigned int) -1 is returned if mask is zero or tst_taint_supported
+ * was not called before
+ */
+int tst_taint_check_mask(unsigned int mask);
+
+
+/*
+ * read /proc/sys/kernel/tainted and return the value
+ */
+unsigned int tst_taint_read(void);
+
+#endif /* TST_TAINTED_H__ */
diff --git a/lib/tst_taint.c b/lib/tst_taint.c
new file mode 100644
index 000000000..de9093976
--- /dev/null
+++ b/lib/tst_taint.c
@@ -0,0 +1,52 @@
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_safe_stdio.h"
+
+#define TAINT_FILE "/proc/sys/kernel/tainted"
+
+static int taint_supported = -1;
+
+int tst_taint_supported(void)
+{
+	if (tst_kvercmp(2, 6, 26) < 0) {
+		tst_res(TINFO, "Kernel version prior to 2.6.26 detected.\n");
+		tst_res(TINFO, "please check kernel output manually\n");
+		taint_supported = 0;
+	} else
+		taint_supported = 1;
+
+	return taint_supported;
+}
+
+unsigned int tst_taint_read(void)
+{
+	unsigned int val;
+
+	if (taint_supported == -1) {
+		tst_brk(TCONF, "call tst_taint_supported() before tst_taint_read()");
+		return (unsigned int) -1;
+	}
+	SAFE_FILE_SCANF(TAINT_FILE, "%u", &val);
+
+	return val;
+}
+
+int tst_taint_check_mask(unsigned int mask)
+{
+	unsigned int taint;
+
+	taint = tst_taint_read();
+	if (taint == (unsigned int) -1)
+		return -1;
+
+	if (mask == 0) {
+		tst_brk(TCONF, "mask is not allowed to be 0");
+		return  -1;
+	}
+	if ((taint & mask) != 0)
+		return 1;
+
+	return 0;
+}
-- 
2.13.6

