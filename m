Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4707C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:19:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728E53CD735
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:19:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AA533C5868
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A98C36005C5
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 524E184C0A
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KabuQw9agkK8pV+lXhQz3Jz1aIkVDEqR7YW1tg8J6+Y=;
 b=HjoNdN5gDyH0LLGTOMfZWRQ0MNPMlX8Iq7TZbGatWqKL4oKapZ44n/obCl/iJ5cne4lzek
 FmZi6Lj2KntynfpuoGAb44kDjsaMchcxRf6KYSDvK4LzAYOMYaHueRukWUo9AhC18FT2Sv
 RD6lxpiC2tH3mAkG1cDs51bElbuMYbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KabuQw9agkK8pV+lXhQz3Jz1aIkVDEqR7YW1tg8J6+Y=;
 b=gAhciXaLespIUJT1ShN3aHktYOzW8QAigyYfYV565IQjI8KygMwTGyK98aRqI2mkDQUIMM
 /lqkm+ZGupG5nQAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KabuQw9agkK8pV+lXhQz3Jz1aIkVDEqR7YW1tg8J6+Y=;
 b=AHMMXRamM2ULDmG/TXBTKScHB6vbWzU0bvTeujolj282nHcIxDIX60eJNWFc7thbREZDEA
 +qjb1dsm1cVV453XjTUM3fHgk/Ix5yuhtI5tQueOQZ648MlGVoZs2n+/OVO0Abno/rpsKl
 4aao1XA2rQfUUksCSzlUE3HUSmeoeYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KabuQw9agkK8pV+lXhQz3Jz1aIkVDEqR7YW1tg8J6+Y=;
 b=zkRnevdt2LJBR5r4EegmtQDjNSUdX56NnzO4lZM4zsiGz6hiThcRbQ6yMB4u0DuwZ32cqC
 JbjJsaRH13/ZUnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7BC8367C
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XNfFN+fWhWrycgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:08 +0200
Message-ID: <20260819161634.1341577-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.952];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/31] testcases: sysfs: Add sys_node01
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A test for a /sys/devices/system/node/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 .../sysfs/devices/system/node/.gitignore      |   1 +
 .../kernel/sysfs/devices/system/node/Makefile |   7 ++
 .../sysfs/devices/system/node/sys_node01.c    | 112 ++++++++++++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/node/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/node/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/node/sys_node01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 7c014a57e..347bd78c1 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -1,3 +1,4 @@
 sys_power01 sys_power01
 sys_kernel01 sys_kernel01
 sys_clocksource01 sys_clocksource01
+sys_node01 sys_node01
diff --git a/testcases/kernel/sysfs/devices/system/node/.gitignore b/testcases/kernel/sysfs/devices/system/node/.gitignore
new file mode 100644
index 000000000..42a442639
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/node/.gitignore
@@ -0,0 +1 @@
+/sys_node01
diff --git a/testcases/kernel/sysfs/devices/system/node/Makefile b/testcases/kernel/sysfs/devices/system/node/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/node/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/devices/system/node/sys_node01.c b/testcases/kernel/sysfs/devices/system/node/sys_node01.c
new file mode 100644
index 000000000..2c2dca30b
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/node/sys_node01.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the NUMA node attributes exported under
+ * /sys/devices/system/node/.
+ *
+ * The kernel exports cpulist-style files describing the node state:
+ *
+ * - possible - node ids that could possibly be online
+ * - online   - node ids that are currently online
+ *
+ * as well as a per-node memory summary in nodeN/meminfo.
+ *
+ * The test verifies that:
+ *
+ * - online is a subset of possible
+ * - for each online node MemUsed == MemTotal - MemFree
+ * - the sum of all per-node MemTotal values matches MemTotal in /proc/meminfo
+ *
+ * All checks skip gracefully with TCONF on systems without NUMA sysfs.
+ */
+
+#include <stdio.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define SYS_NODE "/sys/devices/system/node"
+
+static long read_node_meminfo(int nid, const char *item)
+{
+	char path[PATH_MAX];
+	char fmt[128];
+	long val;
+
+	snprintf(path, sizeof(path), SYS_NODE "/node%d/meminfo", nid);
+	snprintf(fmt, sizeof(fmt), "Node %d %s: %%ld", nid, item);
+
+	SAFE_FILE_LINES_SCANF(path, fmt, &val);
+
+	return val;
+}
+
+static void check_node_mem(int nid, long *sum_total)
+{
+	long total, free, used;
+
+	total = read_node_meminfo(nid, "MemTotal");
+	free = read_node_meminfo(nid, "MemFree");
+	used = read_node_meminfo(nid, "MemUsed");
+
+	*sum_total += total;
+
+	if (used == total - free) {
+		tst_res(TPASS,
+			"node%d: MemUsed (%ld) == MemTotal (%ld) - MemFree (%ld)",
+			nid, used, total, free);
+	} else {
+		tst_res(TFAIL,
+			"node%d: MemUsed (%ld) != MemTotal (%ld) - MemFree (%ld)",
+			nid, used, total, free);
+	}
+}
+
+static void check_sum_memtotal(long sum_total)
+{
+	long global_total;
+
+	SAFE_FILE_LINES_SCANF("/proc/meminfo", "MemTotal: %ld", &global_total);
+
+	if (sum_total == global_total) {
+		tst_res(TPASS,
+			"sum of node MemTotal (%ld kB) matches /proc/meminfo MemTotal (%ld kB)",
+			sum_total, global_total);
+	} else {
+		tst_res(TFAIL,
+			"sum of node MemTotal (%ld kB) differs from /proc/meminfo MemTotal (%ld kB)",
+			sum_total, global_total);
+	}
+}
+
+static void run(void)
+{
+	int count, max_id, nid;
+	long sum_total = 0;
+
+	if (access(SYS_NODE "/online", F_OK)) {
+		tst_res(TCONF, SYS_NODE " is not available");
+		return;
+	}
+
+	TST_SYSFS_ASSERT_LIST_SUBSET(SYS_NODE "/online", SYS_NODE "/possible");
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, SYS_NODE "/online"))
+		return;
+
+	for (nid = 0; nid <= max_id; nid++) {
+		if (!tst_sysfs_exists(SYS_NODE "/node%d", nid))
+			continue;
+
+		check_node_mem(nid, &sum_total);
+	}
+
+	check_sum_memtotal(sum_total);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
