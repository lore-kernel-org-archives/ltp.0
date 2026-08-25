Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5DEC61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 299E43C5A59
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:39:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A1423C5706
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FF35600A02
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2A0B1F7A8
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITRaoNpcZZkrs+DX25bZizNpsVZdFnGcwTyiReDWcJw=;
 b=tu+Vm3VCpk16iaRlSZVxeLMhOAF7YpyXLSG4Mvr1dJy2jaFcIwJEDxeLAoxdFPUd813YQz
 mcDsT/1yMKrDbDYf44Rq6QGMVKmjCiftxYXHx8f031JqfC3sbd1Ffsa3w+pOuzz2FTPeqy
 o9Adz7ZmT0+FUX6yb8lkuRORzj2ewbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITRaoNpcZZkrs+DX25bZizNpsVZdFnGcwTyiReDWcJw=;
 b=3fxxQkuB5mmjmJ7ebVo9Ilz+zOMnSqbJsG96nf1WaNyRgNlxKD7r4uxoKEFtLcEWin4ko1
 2KvGS2diM4HT1xBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TRgKVK8J;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KR12XrZi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITRaoNpcZZkrs+DX25bZizNpsVZdFnGcwTyiReDWcJw=;
 b=TRgKVK8JNMkQv8eAOj07UpLouOv6P17LNaH+8ekl6zCdSs4rwdjjcsxHkp7hq50UAnh7U3
 bGMSwnW0ZVtbyxMd6jk9KQhVpLe32DKBU0plavLYFjwidr1cWZ2g9Bkmz17eN6WUtvb9Ti
 uQtIwvQECfYtS+iP2ifySCxhPg+Cbcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITRaoNpcZZkrs+DX25bZizNpsVZdFnGcwTyiReDWcJw=;
 b=KR12XrZiwaPcXZJN4EP9gc9+yXK2NkVxRXkFhQmxX9KC7VYWdDNoh6au1VkIc3i58EVsUc
 hlIJ13vURTARwtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE02013418
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n6mmKTl+jWouSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:25 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:00 +0200
Message-ID: <20260825113625.1624134-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113625.1624134-1-chrubis@suse.cz>
References: <20260825113625.1624134-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: C2A0B1F7A8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 06/31] testcases: sysfs: Add sys_cpu_topology01
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

A test for /sys/devices/system/cpu/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 .../sysfs/devices/system/cpu/.gitignore       |   1 +
 .../kernel/sysfs/devices/system/cpu/Makefile  |   7 ++
 .../devices/system/cpu/sys_cpu_topology01.c   | 103 ++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 347bd78c1..4fc8f1eb2 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -2,3 +2,4 @@ sys_power01 sys_power01
 sys_kernel01 sys_kernel01
 sys_clocksource01 sys_clocksource01
 sys_node01 sys_node01
+sys_cpu_topology01 sys_cpu_topology01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/.gitignore b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
new file mode 100644
index 000000000..0615aff77
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
@@ -0,0 +1 @@
+/sys_cpu_topology01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/Makefile b/testcases/kernel/sysfs/devices/system/cpu/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology01.c b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology01.c
new file mode 100644
index 000000000..d2aefa85e
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology01.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the CPU topology attributes exported under
+ * /sys/devices/system/cpu/.
+ *
+ * The kernel exports several cpulist files describing the state of the CPUs:
+ *
+ * - possible - CPUs that could possibly be brought online during this boot
+ * - present  - CPUs that are populated (physically present)
+ * - online   - CPUs that are currently online and usable
+ * - offline  - CPUs that are known to the system but currently offline
+ *
+ * These sets are nested, so the test verifies that:
+ *
+ * - online is a subset of present
+ * - present is a subset of possible
+ * - offline is a subset of possible
+ * - kernel_max is greater than or equal to the highest possible CPU id
+ *
+ * The number of online CPUs is also cross-checked against /proc/stat, which
+ * contains one "cpuN" line for each online CPU.
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_sysfs_assert.h"
+
+#define SYS_CPU "/sys/devices/system/cpu"
+
+static int count_proc_stat_cpus(void)
+{
+	FILE *f;
+	char line[4096];
+	int cpus = 0;
+
+	f = SAFE_FOPEN("/proc/stat", "r");
+
+	while (fgets(line, sizeof(line), f)) {
+		if (!strncmp(line, "cpu", 3) && isdigit(line[3]))
+			cpus++;
+	}
+
+	SAFE_FCLOSE(f);
+
+	return cpus;
+}
+
+static void check_online_proc_stat(void)
+{
+	int count, max_id;
+	int stat_cpus;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, SYS_CPU "/online"))
+		return;
+
+	stat_cpus = count_proc_stat_cpus();
+
+	if (count == stat_cpus) {
+		tst_res(TPASS,
+			SYS_CPU "/online count (%d) == /proc/stat cpu lines (%d)",
+			count, stat_cpus);
+	} else {
+		tst_res(TFAIL,
+			SYS_CPU "/online count (%d) != /proc/stat cpu lines (%d)",
+			count, stat_cpus);
+	}
+}
+
+static void check_kernel_max(void)
+{
+	int count, max_id;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, SYS_CPU "/possible"))
+		return;
+
+	TST_SYSFS_ASSERT_RANGELL(max_id, LONG_MAX, SYS_CPU "/kernel_max");
+}
+
+static void run(void)
+{
+	TST_SYSFS_ASSERT_LIST_SUBSET(SYS_CPU "/online", SYS_CPU "/present");
+	TST_SYSFS_ASSERT_LIST_SUBSET(SYS_CPU "/present", SYS_CPU "/possible");
+	TST_SYSFS_ASSERT_LIST_SUBSET(SYS_CPU "/offline", SYS_CPU "/possible");
+
+	check_kernel_max();
+
+	check_online_proc_stat();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
