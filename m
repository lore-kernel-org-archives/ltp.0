From: Michael Moese <mmoese@suse.de>
Date: Mon, 22 Jan 2018 14:12:18 +0100
Subject: [LTP] [RFC PATCH] Add library support for /proc/sys/kernel/tainted
Message-ID: <20180122131218.26407-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Someteimes, it is important to detect if the kernel has issued a
warning, or died. From 2.6.26 on, Linux has these inside
/proc/sys/kernel/tainted. The bitmask there can be analyzed to
detect the occurrance of these.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 include/tst_taint.h | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_taint.c     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 include/tst_taint.h
 create mode 100644 lib/tst_taint.c

diff --git a/include/tst_taint.h b/include/tst_taint.h
new file mode 100644
index 000000000..b01d07d60
--- /dev/null
+++ b/include/tst_taint.h
@@ -0,0 +1,67 @@
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
+#ifndef TST_TAINTED_H__
+#define TST_TAINTED_H__
+
+/*
+ * This are all flags that are supported by kernel 4.4.15
+ * see kernel/panic.c in kernel sources
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
+ * allow us to check if the kernel issued a warning or died
+ *
+ * returns 1 if supported, 0 otherwise
+ */
+int tst_taint_supported(void);
+
+/*
+ * read /proc/sys/kernel/tainted and return the value
+ * this function allows to be called even when the relevant flags are
+ * unsupported.
+ *
+ * returns bitmask of taint flag, or (unsigned int) -1 on read error.
+ */
+unsigned int tst_taint_read(void);
+
+/*
+ * a small helper function to check if flags specified by mask are set
+ *
+ * returns 1 if@least one of the flags is set, 0 otherwise
+ */
+int tst_taint_check_mask(unsigned int taint, unsigned int mask);
+
+#endif /* TST_TAINTED_H__ */
diff --git a/lib/tst_taint.c b/lib/tst_taint.c
new file mode 100644
index 000000000..38bf355ec
--- /dev/null
+++ b/lib/tst_taint.c
@@ -0,0 +1,69 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/utsname.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <linux/version.h>
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
+	struct utsname uname_data;
+	int maj, min, patch;
+
+	if (uname(&uname_data) == -1)
+		return -1;
+
+	if (sscanf(uname_data.release, "%d.%d.%d-", &maj, &min, &patch) != 3)
+		fprintf(stderr, "error parsing uname information\n");
+
+	if ((maj < 2) || ((maj == 2) && (min < 26))) {
+		fprintf(stderr, "Kernel version prior to 2.6.26 detected.\n");
+		fprintf(stderr, "please check kernel output manually\n");
+		taint_supported = 0;
+	} else
+		taint_supported = 1;
+
+
+	return taint_supported;
+}
+
+unsigned int tst_taint_read(void)
+{
+	int fd;
+	unsigned int val;
+	char buffer[11];
+
+	if (taint_supported == -1)
+		tst_taint_supported();
+
+	buffer[10] = 0;
+
+	fd = SAFE_OPEN(TAINT_FILE, O_RDONLY);
+
+	val = read(fd, buffer, 10);
+	SAFE_CLOSE(fd);
+	if (val == -1) {
+		fprintf(stderr, "unable to read %s\n", TAINT_FILE);
+		return (unsigned int) -1;
+	}
+	val = safe_atoi(buffer);
+
+	return val;
+}
+
+int tst_taint_check_mask(unsigned int taint, unsigned int mask)
+{
+	if ((taint & mask) != 0)
+		return 1;
+	return 0;
+}
-- 
2.13.6

