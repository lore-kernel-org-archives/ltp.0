Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B907FC61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:25:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36DD63D69E6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:25:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A113D77B7
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BD5920014E
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB44F1F892
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFVLZCFQM1OjWqkKnieFdOcWS0xVYH/72uL4e0Fi4Xg=;
 b=NR6sBfpkePsivCR3EH1AQUae9LUvtOymCNvWPxy9i84r+Clo9h6VZiPXmUDPxbbjHaOSN1
 VekJMxd7SboRSUCLxer6wMSfmIP26JFKgAB30VBM+jSjUVBgvweP58Oqpr6Y74aNhd4RKc
 83Hq7A5XfgB+Hf8GYfX4UQJ76Vo9cAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFVLZCFQM1OjWqkKnieFdOcWS0xVYH/72uL4e0Fi4Xg=;
 b=L6TE30MNmEEUgRFiW9FoXfX+B5nDFWhCoGtcUlgMpVTOlIjviGRdyaVI0xhprG8LzPmqKT
 9D4/e1vDhUM4c5CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFVLZCFQM1OjWqkKnieFdOcWS0xVYH/72uL4e0Fi4Xg=;
 b=OU5ODl0JH7DpQJgmThSbkeicQR3wafnJl5P5aytE4bmIhC+5h+KnbrSn/jBfeCpgSlP49f
 G1Vk9fARflGXnKeSVDLHWr0Fb+VlVfjm4BjHPe5DgRy95oZy2eq8OivhAvgOFGzOVhcMPV
 /e6pWS5hB03OpgzJfbsP8LAQNEBZybQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFVLZCFQM1OjWqkKnieFdOcWS0xVYH/72uL4e0Fi4Xg=;
 b=1Ildjg8QcoLb6A9tHi0qGzFaSWr6nDLQ+ARKTmyPhIaoxKlCMgfVRcaqfI6K2QScpsgYIl
 ZR+WsJtnYkPzs5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D05F813533
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mqLFMeAdkGpmawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:08 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:37 +0200
Message-ID: <20260827112157.1748734-12-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 11/31] testcases: sysfs: Add sys_clockevents01
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
 include/tst_path_defs.h                       |   1 +
 runtest/sysfs                                 |   1 +
 .../devices/system/clockevents/.gitignore     |   1 +
 .../sysfs/devices/system/clockevents/Makefile |   7 +
 .../system/clockevents/sys_clockevents01.c    | 138 ++++++++++++++++++
 5 files changed, 148 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/sys_clockevents01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 6bc0d65e1..4c25c796a 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -93,6 +93,7 @@
 #define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
 
 /* SYSFS DEVICES */
+#define PATH_SYS_CLOCKEVENTS			"/sys/devices/system/clockevents"
 #define PATH_SYS_CLOCKSOURCE			"/sys/devices/system/clocksource"
 #define PATH_SYS_CPU				"/sys/devices/system/cpu"
 #define PATH_SYS_CPU_SMT			"/sys/devices/system/cpu/smt"
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
index 000000000..661af03a7
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/clockevents/sys_clockevents01.c
@@ -0,0 +1,138 @@
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
+#include "tst_path_defs.h"
+
+static int cpu_is_online(int cpu_id)
+{
+	char online[8];
+
+	/* CPU not present at all, e.g. possible but never plugged in. */
+	if (!tst_sysfs_exists(PATH_SYS_CPU "/cpu%d", cpu_id))
+		return 0;
+
+	/*
+	 * Some CPUs, e.g. the boot CPU on some arches, cannot be offlined
+	 * and therefore have no "online" file. Such a CPU is always online.
+	 */
+	if (!TST_SYSFS_READ_STR(online, sizeof(online),
+				PATH_SYS_CPU "/cpu%d/online", cpu_id))
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
+			   PATH_SYS_CLOCKEVENTS "/%s/current_device", name);
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
+	d = TST_SYSFS_TRY_OPENDIR(PATH_SYS_CLOCKEVENTS);
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
+					PATH_SYS_CPU "/possible"))
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
