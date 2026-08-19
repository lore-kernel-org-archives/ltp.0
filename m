Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA2FC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F0DE3CD674
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:19:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6A0B3CD69F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 735E71400994
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E13184C11
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IngQULVgdDkUq+M2MwWzG/bzioOHDnifGEx2pZXhWM=;
 b=YQU2oQsu7a8YRmbx2HUC0ql67SscQPHSOSF07ocNXhXTq4FzLUIN9p2fGzlCRysNec4uMM
 9VcjiS8ho/8sISaHzg6NEYkThQ2QchnS2mVpxFr8kOvKY0sZGT39Evh3FUOYAHKl7m2e/1
 6DHd3IwA0BzRWEYcixqXecgAGG2Ehm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IngQULVgdDkUq+M2MwWzG/bzioOHDnifGEx2pZXhWM=;
 b=QJT4h4Db1yP9jRAbGlmGY7RMYMFqbnRQuZdvoOBWX5qHDJl5jAb8ALaP4RzB6qcXXaj7ZQ
 YFuahN/Tlfm7BGDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IngQULVgdDkUq+M2MwWzG/bzioOHDnifGEx2pZXhWM=;
 b=F0naG6PKpl+bqArtqY58385f6rxcznV6xPqNTChinsFaR3GsqI58dFUmuGkVmzsTENQZzz
 he5IMqkYkM4qIUg9fptz7aPEn+TjJgn1Semi4qzn0Z1magvatah1Jp6brgoBL29cURifvd
 1hmPPv+2/Qyvc+mZdrtDq/p966dzmWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IngQULVgdDkUq+M2MwWzG/bzioOHDnifGEx2pZXhWM=;
 b=ZwZaAc81YB4XF80eUNopB+HwlqQEc/uhS4eiViN9mG2cucOIV9R5OlEoAd8MhFMbtSMMaX
 aRkX+6wL/IXYmKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DAF4362E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E3HXHfLWhWqHcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:50 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:14 +0200
Message-ID: <20260819161634.1341577-12-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 11/31] testcases: sysfs: Add sys_clockevents01
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

A test for /sys/devices/system/clockevents/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 .../devices/system/clockevents/.gitignore     |   1 +
 .../sysfs/devices/system/clockevents/Makefile |   7 +
 .../system/clockevents/sys_clockevents01.c    | 140 ++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/sys_clockevents01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 928b85928..3015c03f5 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -7,3 +7,4 @@ sys_cpu_topology02 sys_cpu_topology02
 sys_cpu_vulnerabilities01 sys_cpu_vulnerabilities01
 sys_cpu_smt01 sys_cpu_smt01
 sys_cpu_cache01 sys_cpu_cache01
+sys_clockevents01 sys_clockevents01
diff --git a/testcases/kernel/sysfs/devices/system/clockevents/.gitignore b/testcases/kernel/sysfs/devices/system/clockevents/.gitignore
new file mode 100644
index 000000000..9379d10dd
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clockevents/.gitignore
@@ -0,0 +1 @@
+/sys_clockevents01
diff --git a/testcases/kernel/sysfs/devices/system/clockevents/Makefile b/testcases/kernel/sysfs/devices/system/clockevents/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clockevents/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/devices/system/clockevents/sys_clockevents01.c b/testcases/kernel/sysfs/devices/system/clockevents/sys_clockevents01.c
new file mode 100644
index 000000000..c2cd432f5
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clockevents/sys_clockevents01.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the per-CPU clock event devices exported under
+ * /sys/devices/system/clockevents/clockeventN/.
+ *
+ * The kernel's tick_init_sysfs() creates one clockeventN directory for every
+ * *possible* CPU (for_each_possible_cpu()), not just the online ones, and N
+ * is the CPU id the directory belongs to (broadcast is a separate, extra
+ * entry used for CPUs whose local timer stops in idle). These directories
+ * are never removed on CPU hotplug, so a clockeventN directory exists
+ * regardless of whether cpuN is currently online.
+ *
+ * However current_device only names a device while the CPU is online:
+ * tick_shutdown(), called while taking a CPU offline, clears the per-CPU
+ * evtdev pointer, which makes current_device_show() emit an empty string.
+ * So current_device is expected to be non-empty only for online CPUs, it is
+ * legitimately empty for offline (or not-present) ones.
+ *
+ * On platforms without a per-CPU timer, secondary CPUs may instead rely
+ * entirely on a broadcast IPI from a single shared timer without ever
+ * getting their own clockeventN entry, so the number of clockeventN
+ * directories is only asserted not to exceed the number of possible CPUs
+ * rather than to match it exactly. The test verifies that:
+ *
+ * - there is at least one clockeventN directory
+ * - the number of clockeventN directories does not exceed the number of
+ *   possible CPUs
+ * - each clockeventN/current_device names a non-empty clock event device
+ *   while cpuN is online, and is not checked while cpuN is offline or not
+ *   present
+ *
+ * The test skips with TCONF when no clockevents directory is present.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <dirent.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define CLOCKEVENTS "/sys/devices/system/clockevents"
+#define SYS_CPU "/sys/devices/system/cpu"
+
+static int cpu_is_online(int cpu_id)
+{
+	char online[8];
+
+	/* CPU not present at all, e.g. possible but never plugged in. */
+	if (!tst_sysfs_exists(SYS_CPU "/cpu%d", cpu_id))
+		return 0;
+
+	/*
+	 * Some CPUs, e.g. the boot CPU on some arches, cannot be offlined
+	 * and therefore have no "online" file. Such a CPU is always online.
+	 */
+	if (!TST_SYSFS_READ_STR(online, sizeof(online),
+				SYS_CPU "/cpu%d/online", cpu_id))
+		return 1;
+
+	return atoi(online) == 1;
+}
+
+static void check_clockevent(const char *name)
+{
+	char device[64] = "";
+	int cpu_id, online;
+
+	if (sscanf(name, "clockevent%d", &cpu_id) != 1) {
+		tst_res(TWARN, "Cannot parse CPU id out of '%s'", name);
+		return;
+	}
+
+	online = cpu_is_online(cpu_id);
+
+	TST_SYSFS_READ_STR(device, sizeof(device),
+			   CLOCKEVENTS "/%s/current_device", name);
+
+	if (device[0] != '\0') {
+		tst_res(TPASS, "%s/current_device = '%s'", name, device);
+		return;
+	}
+
+	if (online) {
+		tst_res(TFAIL,
+			"%s/current_device is empty while cpu%d is online",
+			name, cpu_id);
+	} else {
+		tst_res(TPASS,
+			"%s/current_device is empty while cpu%d is offline",
+			name, cpu_id);
+	}
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int nclockevents = 0;
+	int possible_count, max_id;
+
+	d = SAFE_OPENDIR(CLOCKEVENTS);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "clockevent", 10))
+			continue;
+
+		nclockevents++;
+		check_clockevent(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!nclockevents) {
+		tst_res(TCONF, "No clockevent directory found");
+		return;
+	}
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&possible_count, &max_id,
+					SYS_CPU "/possible"))
+		return;
+
+	if (nclockevents <= possible_count) {
+		tst_res(TPASS,
+			"number of clockevent devices (%d) does not exceed possible CPUs (%d)",
+			nclockevents, possible_count);
+	} else {
+		tst_res(TFAIL,
+			"number of clockevent devices (%d) exceeds possible CPUs (%d)",
+			nclockevents, possible_count);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
