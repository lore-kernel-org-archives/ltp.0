Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3910FC5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:17:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B56A23CCDB8
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:17:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01B513CCB46
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0FC7E1A00A43
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D4C63E69
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHzHBzWAHZ2c9+QrYH0oRgQSzGDtA5TmmX4712wug+Q=;
 b=kOi483JTVXG3ueXEdIQYnvOeJNWEBxxj7FhFi7kEGRQaCHUpjABC2Gy7SKaRx9Iik21Bz6
 7P8Pl7L8bh1brBI2Ac4naZc0Q+LYnG3XwHVX18QF3BnjQPDRzRjdTSQS+nXY0GuLKOo1JZ
 kLXvQfIxu8S0zxZKLm3Gnb4bBkE5V34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHzHBzWAHZ2c9+QrYH0oRgQSzGDtA5TmmX4712wug+Q=;
 b=CozUfAL8GTP2QvJfhdIWM34jS2K+tfBxyI9U9LSt3So5CPI/KTraBppZVeVZldBocRqeHA
 A8eQyUytZxFOa5Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MLI59bGZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="GBV6u3/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHzHBzWAHZ2c9+QrYH0oRgQSzGDtA5TmmX4712wug+Q=;
 b=MLI59bGZkNLwf0yf7UPqAq/Xc8t/xylZv98T0qX1GgV9MofNMahI1V/h5wwrCYj8w6HIzI
 IKjc7aD6xdcvuiPBYCK/Dpj5jKcD2lqhwmBIDK+I9taQpCm/M0LzywbF71Jmjj9+Ma43n6
 QQ7e87V/S7bi2V1EeFfSf3b45CGnKVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHzHBzWAHZ2c9+QrYH0oRgQSzGDtA5TmmX4712wug+Q=;
 b=GBV6u3/Humo+dnkOgzWm63x7SzKuwGOw7Lfmecf6n9zxKo3YJfu699f2cw86tvS95ZGP6Z
 qIt7U9jdHRPlfwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C897C367D
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r3wzL3ZohGrVcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:10 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:12:47 +0200
Message-ID: <20260818141311.1265557-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7D4C63E69
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 07/31] testcases: sysfs: Add sys_cpu_topology02
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

A test for /sys/devices/system/cpu/cpu*/topology/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../sysfs/devices/system/cpu/.gitignore       |  1 +
 .../devices/system/cpu/sys_cpu_topology02.c   | 98 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 4fc8f1eb2..b1daab68f 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -3,3 +3,4 @@ sys_kernel01 sys_kernel01
 sys_clocksource01 sys_clocksource01
 sys_node01 sys_node01
 sys_cpu_topology01 sys_cpu_topology01
+sys_cpu_topology02 sys_cpu_topology02
diff --git a/testcases/kernel/sysfs/devices/system/cpu/.gitignore b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
index 0615aff77..a688a9b50 100644
--- a/testcases/kernel/sysfs/devices/system/cpu/.gitignore
+++ b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
@@ -1 +1,2 @@
 /sys_cpu_topology01
+/sys_cpu_topology02
diff --git a/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
new file mode 100644
index 000000000..00f7c6af9
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the per-CPU topology attributes exported under
+ * /sys/devices/system/cpu/cpuN/topology/.
+ *
+ * The topology masks describe how a CPU relates to the others. They are nested
+ * from the smallest (SMT threads) to the largest (package) group, so for every
+ * online CPU the test verifies that:
+ *
+ * - thread_siblings_list is a subset of core_cpus_list
+ * - core_cpus_list is a subset of package_cpus_list
+ * - package_cpus_list is a subset of the online CPUs
+ * - the CPU itself is contained in its own thread_siblings_list
+ * - core_id and physical_package_id are in [0, highest possible CPU id],
+ *   since there can be at most as many cores/packages as possible CPUs
+ *   (every core has at least one thread, every package at least one core)
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present, as the exact set of topology files differs between kernel versions
+ * and architectures.
+ */
+
+#include <stdio.h>
+#include <limits.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define SYS_CPU "/sys/devices/system/cpu"
+
+static void check_self_in_threads(int cpu)
+{
+	TST_SYSFS_ASSERT_LIST_CONTAINS(cpu,
+		SYS_CPU "/cpu%d/topology/thread_siblings_list", cpu);
+}
+
+static void check_cpu_topology(int cpu, int poss_max_id)
+{
+	char sub[PATH_MAX], super[PATH_MAX];
+
+	if (access(SYS_CPU, F_OK))
+		return;
+
+	if (!tst_sysfs_exists(SYS_CPU "/cpu%d/topology/core_id", cpu)) {
+		tst_res(TCONF, "cpu%d has no topology directory", cpu);
+		return;
+	}
+
+	tst_res(TINFO, "Checking cpu%d topology", cpu);
+
+	TST_SYSFS_ASSERT_RANGELL(0, poss_max_id,
+			       SYS_CPU "/cpu%d/topology/core_id", cpu);
+
+	TST_SYSFS_ASSERT_RANGELL(0, poss_max_id,
+			       SYS_CPU "/cpu%d/topology/physical_package_id",
+			       cpu);
+
+	snprintf(sub, sizeof(sub),
+		 SYS_CPU "/cpu%d/topology/thread_siblings_list", cpu);
+	snprintf(super, sizeof(super),
+		 SYS_CPU "/cpu%d/topology/core_cpus_list", cpu);
+	TST_SYSFS_ASSERT_LIST_SUBSET(sub, super);
+
+	snprintf(sub, sizeof(sub),
+		 SYS_CPU "/cpu%d/topology/core_cpus_list", cpu);
+	snprintf(super, sizeof(super),
+		 SYS_CPU "/cpu%d/topology/package_cpus_list", cpu);
+	TST_SYSFS_ASSERT_LIST_SUBSET(sub, super);
+
+	snprintf(sub, sizeof(sub),
+		 SYS_CPU "/cpu%d/topology/package_cpus_list", cpu);
+	TST_SYSFS_ASSERT_LIST_SUBSET(sub, SYS_CPU "/online");
+
+	check_self_in_threads(cpu);
+}
+
+static void do_test(void)
+{
+	int count, max_id, poss_count, poss_max_id, cpu;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, SYS_CPU "/online"))
+		return;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&poss_count, &poss_max_id,
+					SYS_CPU "/possible"))
+		return;
+
+	for (cpu = 0; cpu <= max_id; cpu++)
+		check_cpu_topology(cpu, poss_max_id);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
