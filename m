Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08079C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:19:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFFFD3CD694
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:19:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E61BE3CD737
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3FEFC1A008A4
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDB5E84C10
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylZY+P3Ryqu7Qb53WCqm1BbX6s9EMkzCmz6ME1+9oiQ=;
 b=j6BH180U8SUfVl09j3lcIfaMzxiv8h4Liubnr486z8uus6xZY6SZetLUtBEwgcT06usEJq
 GI8bjM4bM2DWVFCczA6GWDkwA+ai4UVqhOtYb6rd6peWt8DK01T3UGc0E88IR+xQNRC/bR
 g0V3UuEEYALfWEWXw7Hiq1Z4p9UwU3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylZY+P3Ryqu7Qb53WCqm1BbX6s9EMkzCmz6ME1+9oiQ=;
 b=xg/rAKLUDZnSFWcY8XJhA2EiOdWawRW58jcZBvhUyVZ3jimOnxQSWRSeU0eM0sGcxayK/P
 53Oilyk6Qp0q+iAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylZY+P3Ryqu7Qb53WCqm1BbX6s9EMkzCmz6ME1+9oiQ=;
 b=qo0EgZ6iJq9+MRnqbMc6IQHl2nOqF6/USCQ0tGSUvIkGiDYO2cXi6mhYufyBhsAr/gw78C
 VuRZHbckmZqd+NrlIS2UPkh0jkYUgZRGH+Yrqor07jQoWlIe5PEoFe9gyenkqV2G3ggJlp
 LSmlZl+GG/4yfR4t5SjDk7scPOrs5Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylZY+P3Ryqu7Qb53WCqm1BbX6s9EMkzCmz6ME1+9oiQ=;
 b=BQlAcWP0hlxGNkiAAA7tRPbmwRP+8l36jFrhYiK9VNVb6g2W/aESaeQW3Rbb2aF6k1P1Tn
 JZINa13nd7kD33BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB0C8367E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N8i/MOjWhWr2cgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:40 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:10 +0200
Message-ID: <20260819161634.1341577-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.953];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/31] testcases: sysfs: Add sys_cpu_topology02
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
 runtest/sysfs                                 |   1 +
 .../sysfs/devices/system/cpu/.gitignore       |   1 +
 .../devices/system/cpu/sys_cpu_topology02.c   | 112 ++++++++++++++++++
 3 files changed, 114 insertions(+)
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
index 000000000..536b23c3a
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
@@ -0,0 +1,112 @@
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
+ * - package_cpus_list is a subset of the present CPUs, not just the online
+ *   ones: the whole topology/ directory (package_cpus_list included) is
+ *   added/removed per-CPU on hotplug (drivers/base/topology.c registers it
+ *   against a cpuhp state), so it only ever lists CPUs that share the
+ *   package and are also online right now. Comparing against "present"
+ *   instead of "online" avoids relying on that always being reliably kept
+ *   in sync on every architecture, and avoids a spurious failure if a
+ *   sibling CPU is hot-unplugged concurrently with this test running.
+ * - the CPU itself is contained in its own thread_siblings_list
+ * - core_id is in [0, highest possible CPU id], since there can be at most
+ *   as many cores as possible CPUs (every core has at least one thread)
+ * - physical_package_id is in [-1, highest possible CPU id]. -1 is a
+ *   legitimate value here, not just a range extension for safety: per
+ *   include/linux/topology.h, -1 is the architecture-neutral default for
+ *   topology_physical_package_id() (and die_id/cluster_id/book_id/
+ *   drawer_id) on any architecture, or any CPU type within one, that does
+ *   not implement package detection. topology_core_id() does not have this
+ *   documented -1 fallback (its generic default is 0), so core_id is not
+ *   given the same allowance.
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
+	TST_SYSFS_ASSERT_RANGELL(-1, poss_max_id,
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
+	TST_SYSFS_ASSERT_LIST_SUBSET(sub, SYS_CPU "/present");
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
