Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79949C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:23:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C86363D236B
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:23:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E46033D527A
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE4261A008B9
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 293721F890
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO16dOY265qNErjszbnoOu3MPs9bKDCLV9PGsaTZX54=;
 b=Zqnus4UhNlI8ty3bbeNAi72gBd0YO8KhG+1lni0quJWJYe4ay+feCiPGndSXgQ1es9JtRI
 U0g3MqlRxenfMgvB+PEIRjkC0Oy7YkVPSvwRf9YxjUlASIP6+7pSjpPdxjPqDfufV+lDfG
 V14DTZ+WDLnEJoyjIXhzjCjHdmfC+5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO16dOY265qNErjszbnoOu3MPs9bKDCLV9PGsaTZX54=;
 b=km8g8xQ3szEKSl1GtwDwbpOid+eTT2DmgJJ/vsIeVMajm25pbqc2qG9pGrIHoIKqKV1jWL
 Q80Wbcff3hPlaeBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uLsr+CgO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3MImdTiE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO16dOY265qNErjszbnoOu3MPs9bKDCLV9PGsaTZX54=;
 b=uLsr+CgOe1aEgLlYJlH8vOsvuwu+Ca0KnTMGjzi1jgzVip8olnbbSkb893lMUSm036JHmo
 1Skg8CSWlHyHL+Wfc5F/z6xp/cd10/x/iRtjyoK8+yo1x9EA5N0Lc2VOlLPMxmScC+FR4S
 1xpLMumlIryOt4CmkqcZRFsyzcFr+ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO16dOY265qNErjszbnoOu3MPs9bKDCLV9PGsaTZX54=;
 b=3MImdTiEPvna9e0SZtd3xpM3CmvrGxfKIFTjTvR+NleFZxv2JdaFAVQVRN2R/7Ku+aZL+u
 +d4ambSLvRkbLNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 122F413685
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cyBnA9odkGpPawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:02 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:31 +0200
Message-ID: <20260827112157.1748734-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 293721F890
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 05/31] testcases: sysfs: Add sys_node01
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
 include/tst_path_defs.h                       |   1 +
 runtest/sysfs                                 |   1 +
 .../sysfs/devices/system/node/.gitignore      |   1 +
 .../kernel/sysfs/devices/system/node/Makefile |   7 +
 .../sysfs/devices/system/node/sys_node01.c    | 129 ++++++++++++++++++
 5 files changed, 139 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/node/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/node/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/node/sys_node01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 434e31af3..c96a1454c 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -94,6 +94,7 @@
 
 /* SYSFS DEVICES */
 #define PATH_SYS_CLOCKSOURCE			"/sys/devices/system/clocksource"
+#define PATH_SYS_NODE				"/sys/devices/system/node"
 
 /* SYSFS */
 #define PATH_SYS_KERNEL				"/sys/kernel"
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
index 000000000..dab4ff88f
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/node/sys_node01.c
@@ -0,0 +1,129 @@
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
+ *
+ * The last check is only enforced (TFAIL on mismatch) on physical hardware.
+ * /proc/meminfo's MemTotal (si_meminfo()'s totalram_pages()) and a node's
+ * MemTotal (si_meminfo_node()'s sum of that node's zones' managed pages) are
+ * two independently maintained counters, normally kept in lockstep by
+ * adjust_managed_page_count() updating both together, so their sums match
+ * exactly on real hardware. Under virtualization, memory hotplug/ballooning
+ * mechanisms (e.g. virtio-mem, virtio-balloon, Xen balloon) are a known
+ * source of drift between the two, since they can affect one counter without
+ * (yet) correspondingly attributing the change to a specific NUMA node's
+ * zones, so a mismatch there is only reported as TINFO.
+ */
+
+#include <stdio.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static long read_node_meminfo(int nid, const char *item)
+{
+	char path[PATH_MAX];
+	char fmt[128];
+	long val;
+
+	snprintf(path, sizeof(path), PATH_SYS_NODE "/node%d/meminfo", nid);
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
+		return;
+	}
+
+	if (tst_is_virt(VIRT_ANY)) {
+		tst_res(TINFO,
+			"Running in a VM, sum of node MemTotal (%ld kB) differs from /proc/meminfo MemTotal (%ld kB), likely memory hotplug/ballooning",
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
+	if (access(PATH_SYS_NODE "/online", F_OK)) {
+		tst_res(TCONF, PATH_SYS_NODE " is not available");
+		return;
+	}
+
+	TST_SYSFS_ASSERT_LIST_SUBSET(PATH_SYS_NODE "/online", PATH_SYS_NODE "/possible");
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, PATH_SYS_NODE "/online"))
+		return;
+
+	for (nid = 0; nid <= max_id; nid++) {
+		if (!tst_sysfs_exists(PATH_SYS_NODE "/node%d", nid))
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
