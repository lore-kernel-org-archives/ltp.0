Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FF1C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 12:33:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D612C60F38
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 12:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D612C60F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5EE23C897B
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 14:33:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E4FA3C8965
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 14:32:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 385281400525
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 14:32:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2E7AF222CF;
 Thu, 16 Sep 2021 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1631795574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2izC7El3ujd897PzHAfLS2fpP4OpH1GMHvQMjFeo7Y=;
 b=hf38yUn595NfNhI92+w8GJUyHBtE6j8UU/ucDZ41PBkz8prUY2Ai2TdVg7+8NxciUUDbRC
 LRtAPRpdtNHbrQDON9oWuJIOsUMiAWZauL5nkZtxVWsMDmJh0PqQs505ho20dCxnGHLyD6
 4Z72Ce/Dttbw02rKV57VMYICg+BAbN8=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id DC05AA3B84;
 Thu, 16 Sep 2021 12:32:53 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 13:32:48 +0100
Message-ID: <20210916123248.4974-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909140911.44EC9A4308@relay2.suse.de>
References: <20210909140911.44EC9A4308@relay2.suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] kernel/irq: Add irqbalance01
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210916123248.mM7gu5GeSxva5FGjl2l7Mq6hTO-3TiP_LfRXm6l016I@z>

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


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
