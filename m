From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 16 Sep 2021 13:32:48 +0100
Subject: [LTP] [PATCH v2] kernel/irq: Add irqbalance01
In-Reply-To: <20210909140911.44EC9A4308@relay2.suse.de>
References: <20210909140911.44EC9A4308@relay2.suse.de>
Message-ID: <20210916123248.4974-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add first test specifically targeting interrupts and IRQ management.

This includes some comments inline because I think the parsing code is
unavoidably confusing.

Note on the CPU mask parsing; there is already some code for parsing
and manipulating bitmaps in the LTP. However it is absurdly
complicated and we don't need actual bitmaps. In fact an array of
bytes is more flexible.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

V2:
* Read proc files in at most 1-page blocks

  As Cyril suggested this looks like the best way. seq_file will only
  expand the internal buffer above a page if a record does not fit in
  one page. In this case a record is the per-cpus counts for an
  irq. However it won't expand the buffer for multiple records. It
  just returns whatver fits in the buffer.

* Read in CPU masks from the end of the buffer

  If nr_cpus is not a multiple of 4 then one of the hex digits has
  some padding. We either need to pad irq_affinity as well (which
  creates complication) or ignore the padding. It's easier to ignore
  it if we start at the end.

* Print headers and some minor format changes to printing
* Add a few more parsing checks
* Remove freeing of buffers

 runtest/irq                         |   1 +
 testcases/kernel/irq/.gitignore     |   1 +
 testcases/kernel/irq/Makefile       |   7 +
 testcases/kernel/irq/irqbalance01.c | 316 ++++++++++++++++++++++++++++
 4 files changed, 325 insertions(+)
 create mode 100644 runtest/irq
 create mode 100644 testcases/kernel/irq/.gitignore
 create mode 100644 testcases/kernel/irq/Makefile
 create mode 100644 testcases/kernel/irq/irqbalance01.c

diff --git a/runtest/irq b/runtest/irq
new file mode 100644
index 000000000..56d0d23c8
--- /dev/null
+++ b/runtest/irq
@@ -0,0 +1 @@
+irqbalance01 irqbalance01
diff --git a/testcases/kernel/irq/.gitignore b/testcases/kernel/irq/.gitignore
new file mode 100644
index 000000000..8ed69a99c
--- /dev/null
+++ b/testcases/kernel/irq/.gitignore
@@ -0,0 +1 @@
+irqbalance01
diff --git a/testcases/kernel/irq/Makefile b/testcases/kernel/irq/Makefile
new file mode 100644
index 000000000..aa51da7cb
--- /dev/null
+++ b/testcases/kernel/irq/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
new file mode 100644
index 000000000..f32ab9495
--- /dev/null
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com> */
+/*\
+ * [Description]
+ *
+ * Check that something (e.g. irqbalance daemon) is performing IRQ
+ * load balancing.
+ *
+ * On many systems userland needs to set /proc/irq/$IRQ/smp_affinity
+ * to prevent many IRQs being delivered to the same CPU.
+ *
+ * Note some drivers and IRQ controllers will distribute IRQs
+ * evenly. Some systems will have housekeeping CPUs configured. Some
+ * IRQs can not be masked etc. So this test is not appropriate for all
+ * scenarios.
+ *
+ * Furthermore, exactly how IRQs should be distributed is a
+ * performance and/or security issue. This is only a generic smoke
+ * test. It will hopefully detect misconfigured systems and total
+ * balancing failures which are often silent errors.
+ *
+ * Heuristic: Evidence of Change
+ *
+ * 1. Find IRQs with a non-zero count
+ * 2. Check if they are now disallowed
+ *
+ * There are two sources of information we need to parse:
+ *
+ * 1. /proc/interrupts
+ * 2. /proc/irq/$IRQ/smp_affinity
+ *
+ * We get the active IRQs and CPUs from /proc/interrupts. It also
+ * contains the per-CPU IRQ counts and info we do not care about.
+ *
+ * We get the IRQ masks from each active IRQ's smp_affinity file. This
+ * is a bitmask written out in hexadecimal format. It shows which CPUs
+ * an IRQ may be received by.
+ */
+
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_file_at.h"
+
+enum affinity {
+	ALLOW = '+',
+	DENY = '-',
+};
+
+static unsigned int *irq_stats;
+static enum affinity *irq_affinity;
+
+static unsigned int nr_cpus;
+static unsigned int nr_irqs;
+static unsigned int *irq_ids;
+
+static char *read_proc_file(const char *const path)
+{
+	const size_t pg_len = SAFE_SYSCONF(_SC_PAGESIZE);
+	int fd = SAFE_OPEN(path, O_RDONLY);
+	size_t ret = 0, used_len = 0;
+	static size_t total_len;
+	static char *buf;
+
+	do {
+		if (used_len + 1 >= total_len) {
+			total_len += pg_len;
+			buf = SAFE_REALLOC(buf, total_len);
+		}
+
+		ret = SAFE_READ(0, fd,
+				buf + used_len,
+				total_len - used_len - 1);
+		used_len += ret;
+	} while (ret);
+
+	if (!used_len)
+		tst_brk(TBROK, "Empty %s?", path);
+
+	buf[used_len] = '\0';
+
+	SAFE_CLOSE(fd);
+
+	return buf;
+}
+
+static void collect_irq_info(void)
+{
+	char *buf, *c, *first_row;
+	char path[PATH_MAX];
+	size_t row, col;
+	long acc;
+	unsigned int cpu_total, bit;
+
+	nr_cpus = 0;
+	nr_irqs = 0;
+
+	buf = read_proc_file("/proc/interrupts");
+
+	/* Count CPUs, header columns are like /CPU[0-9]+/ */
+	for (c = buf; *c != '\0' && *c != '\n'; c++) {
+		if (!strncmp(c, "CPU", 3))
+			nr_cpus++;
+	}
+
+	c++;
+	first_row = c;
+	/* Count IRQs, real IRQs start with /[0-9]+:/ */
+	while (*c != '\0') {
+		switch (*c) {
+		case ' ':
+		case '\t':
+		case '\n':
+		case '0' ... '9':
+			c++;
+			break;
+		case ':':
+			nr_irqs++;
+			/* fall-through */
+		default:
+			while (*c != '\n' && *c != '\0')
+				c++;
+		}
+	}
+
+	tst_res(TINFO, "Found %u CPUS, %u IRQs", nr_cpus, nr_irqs);
+
+	irq_ids = SAFE_REALLOC(irq_ids, nr_irqs * sizeof(*irq_ids));
+	irq_stats = SAFE_REALLOC(irq_stats,
+				 nr_cpus * (nr_irqs + 1) * sizeof(*irq_stats));
+	irq_affinity = SAFE_REALLOC(irq_affinity,
+				    nr_cpus * nr_irqs * sizeof(*irq_affinity));
+
+	c = first_row;
+	acc = -1;
+	row = col = 0;
+	/* Parse columns containing IRQ counts and IRQ IDs into acc. Ignore
+	 * everything else.
+	 */
+	while (*c != '\0') {
+		switch (*c) {
+		case ' ':
+		case '\t':
+			if (acc >= 0) {
+				irq_stats[row * nr_cpus + col] = acc;
+				acc = -1;
+				col++;
+			}
+			break;
+		case '\n':
+			if (acc != -1)
+				tst_brk(TBROK, "Unexpected EOL");
+			col = 0;
+			row++;
+			break;
+		case '0' ... '9':
+			if (acc == -1)
+				acc = 0;
+
+			acc *= 10;
+			acc += *c - '0';
+			break;
+		case ':':
+			if (acc == -1 || col != 0)
+				tst_brk(TBROK, "Unexpected ':'");
+			irq_ids[row] = acc;
+			acc = -1;
+			break;
+		default:
+			acc = -1;
+			while (*c != '\n' && *c != '\0')
+				c++;
+			continue;
+		}
+
+		c++;
+	}
+
+	for (col = 0; col < nr_cpus; col++) {
+		cpu_total = 0;
+
+		for (row = 0; row < nr_irqs; row++)
+			cpu_total += irq_stats[row * nr_cpus + col];
+
+		irq_stats[row * nr_cpus + col] = cpu_total;
+	}
+
+	/* Read the CPU affinity masks for each IRQ. The first CPU is in the
+	 * right most (least significant) bit. See bitmap_string() in the kernel
+	 * (%*pb)
+	 */
+	for (row = 0; row < nr_irqs; row++) {
+		sprintf(path, "/proc/irq/%u/smp_affinity", irq_ids[row]);
+		buf = read_proc_file(path);
+		c = buf;
+		col = 0;
+
+		while (*c != '\0')
+			c++;
+
+		while (--c >= buf) {
+			if (col > nr_cpus) {
+				tst_res(TINFO, "%u/smp_affnity: %s",
+					irq_ids[row], buf);
+				tst_brk(TBROK, "More mask char bits than cpus");
+			}
+
+			switch (*c) {
+			case '\n':
+			case ' ':
+			case ',':
+				continue;
+			case '0' ... '9':
+				acc = *c - '0';
+				break;
+			case 'a' ... 'f':
+				acc = 10 + *c - 'a';
+				break;
+			default:
+				tst_res(TINFO, "%u/smp_affnity: %s",
+					irq_ids[row], buf);
+				tst_brk(TBROK, "Wasn't expecting 0x%02x", *c);
+			}
+
+			for (bit = 0; bit < 4 && col < nr_cpus; bit++) {
+				irq_affinity[row * nr_cpus + col++] =
+					(acc & (1 << bit)) ? ALLOW : DENY;
+			}
+		}
+
+		if (col < nr_cpus) {
+			tst_res(TINFO, "%u/smp_affnity: %s", irq_ids[row], buf);
+			tst_brk(TBROK, "Only found %zu cpus", col);
+		}
+	}
+}
+
+static void print_irq_info(void)
+{
+	size_t row, col;
+	unsigned int count;
+	enum affinity aff;
+
+	tst_printf("  IRQ       ");
+	for (col = 0; col < nr_cpus; col++)
+		tst_printf("CPU%-8zu", col);
+
+	tst_printf("\n");
+
+	for (row = 0; row < nr_irqs; row++) {
+		tst_printf("%5u:", irq_ids[row]);
+
+		for (col = 0; col < nr_cpus; col++) {
+			count = irq_stats[row * nr_cpus + col];
+			aff = irq_affinity[row * nr_cpus + col];
+
+			tst_printf("%10u%c", count, aff);
+		}
+
+		tst_printf("\n");
+	}
+
+	tst_printf("Total:");
+
+	for (col = 0; col < nr_cpus; col++)
+		tst_printf("%10u ", irq_stats[row * nr_cpus + col]);
+
+	tst_printf("\n");
+}
+
+static void evidence_of_change(void)
+{
+	size_t row, col, changed = 0;
+
+	for (row = 0; row < nr_irqs; row++) {
+		for (col = 0; col < nr_cpus; col++) {
+			if (!irq_stats[row * nr_cpus + col])
+				continue;
+
+			if (irq_affinity[row * nr_cpus + col] == ALLOW)
+				continue;
+
+			changed++;
+		}
+	}
+
+	tst_res(changed ? TPASS : TFAIL,
+		"Heuristic: Detected %zu irq-cpu pairs have been dissallowed",
+		changed);
+}
+
+static void setup(void)
+{
+	collect_irq_info();
+	print_irq_info();
+
+	if (nr_cpus < 1)
+		tst_brk(TBROK, "No CPUs found in /proc/interrupts?");
+
+	if (nr_irqs < 1)
+		tst_brk(TBROK, "No IRQs found in /proc/interrupts?");
+}
+
+static void run(void)
+{
+	collect_irq_info();
+
+	evidence_of_change();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_cpus = 2,
+};
-- 
2.31.1

