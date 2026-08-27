Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F1C61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:24:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 177553D75B9
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:24:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 216953D7EF9
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9624C1000799
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC2A521942
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uywMRo/g001ITWkFajqe/rKezFV38qNnT7x6h+Rg5bo=;
 b=vKEVP/Pfla49EmF7z89kFLhF7RLix9Z2fol47d9hFaboQqrYTmGaL+NHIcxu+bxT2rVkJr
 9lOh0ZB/vqfb37EweRXwSkS6SOcy+kTv9jastdK7sl1pQhs+mPB4zlMY2pxHDu2LUl0uro
 E+qei2O4sj9x1WU65HvwUIymIWq5Fqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uywMRo/g001ITWkFajqe/rKezFV38qNnT7x6h+Rg5bo=;
 b=AWfiXr/iOpkomxlZN+pPLY5EFFtqECxu28EkJzJ1NucT3IXOVTc++6xdN5+K2uVnyb6+dL
 vY34+e3f2SBuOGBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="D9mZV/S2";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g1HMvYpy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uywMRo/g001ITWkFajqe/rKezFV38qNnT7x6h+Rg5bo=;
 b=D9mZV/S2i20Q3pzmpgBZacRpXYwGMElKPozvKABIs5Yc3Q5AZX/W6E7lsBtLNxwi785tux
 cHPSDMl6kCXblRL0yG2gvs40nED279FY2sv4jGKhPqttdArVtHUxNyg1yw/LGKIfk1yMaw
 RN1+F2MxrfvgPWNNIlwG4jr5XOuhUBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uywMRo/g001ITWkFajqe/rKezFV38qNnT7x6h+Rg5bo=;
 b=g1HMvYpyBrdcP1lXjgkEsvzeE7F6RUoS/bRklg1V1zvXuNl7QNgFF/6RGFZsR58Vp4MhVf
 NYHzqeLPsVMKMmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB61F13687
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ecIqNNodkGpUawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:02 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:33 +0200
Message-ID: <20260827112157.1748734-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: EC2A521942
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 07/31] testcases: sysfs: Add sys_cpu_topology02
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
 .../devices/system/cpu/sys_cpu_topology02.c   | 132 ++++++++++++++++++
 3 files changed, 134 insertions(+)
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
index 000000000..7098da9f3
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
@@ -0,0 +1,132 @@
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
+ *   package and are also online right now. Comparing against ``present``
+ *   instead of ``online`` avoids relying on that always being reliably kept
+ *   in sync on every architecture, and avoids a spurious failure if a
+ *   sibling CPU is hot-unplugged concurrently with this test running.
+ * - the CPU itself is contained in its own thread_siblings_list
+ * - core_id is in [0, highest possible CPU id], since there can be at most
+ *   as many cores as possible CPUs (every core has at least one thread)
+ * - physical_package_id is in [-1, highest possible CPU id] on physical
+ *   hardware, or just at least -1 under virtualization (see below). -1 is a
+ *   legitimate value here, not just a range extension for safety: per
+ *   include/linux/topology.h, -1 is the architecture-neutral default for
+ *   topology_physical_package_id() (and die_id/cluster_id/book_id/
+ *   drawer_id) on any architecture, or any CPU type within one, that does
+ *   not implement package detection. topology_core_id() does not have this
+ *   documented -1 fallback (its generic default is 0), so core_id is not
+ *   given the same allowance.
+ *
+ *   The upper bound on physical_package_id is dropped under virtualization:
+ *   store_cpu_topology() in drivers/base/arch_topology.c falls back to
+ *   physical_package_id = cpu_to_node(cpu) whenever ACPI/DT topology
+ *   parsing did not already populate it (common on minimal/generic arm64 VM
+ *   firmware without full ACPI PPTT tables). On physical hardware this
+ *   fallback is still bounded by the number of possible CPUs, since NUMA
+ *   node ids are compacted/renumbered from the firmware's proximity domains
+ *   and there can never be more NUMA nodes than CPUs (each node needs at
+ *   least one). But a VM's NUMA node numbering is a hypervisor/firmware
+ *   policy choice entirely unrelated to its own CPU count, e.g. mirroring a
+ *   large host's own (possibly sparse) NUMA node ids under NUMA
+ *   passthrough/vNUMA configuration, so the bound would not be meaningful
+ *   there and is dropped to avoid a false failure.
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
+#include "tst_path_defs.h"
+
+static void check_self_in_threads(int cpu)
+{
+	TST_SYSFS_ASSERT_LIST_CONTAINS(cpu,
+		PATH_SYS_CPU "/cpu%d/topology/thread_siblings_list", cpu);
+}
+
+static void check_cpu_topology(int cpu, int poss_max_id, long pkg_max_id)
+{
+	char sub[PATH_MAX], super[PATH_MAX];
+
+	if (access(PATH_SYS_CPU, F_OK))
+		return;
+
+	if (!tst_sysfs_exists(PATH_SYS_CPU "/cpu%d/topology/core_id", cpu)) {
+		tst_res(TCONF, "cpu%d has no topology directory", cpu);
+		return;
+	}
+
+	tst_res(TINFO, "Checking cpu%d topology", cpu);
+
+	TST_SYSFS_ASSERT_RANGELL(0, poss_max_id,
+			       PATH_SYS_CPU "/cpu%d/topology/core_id", cpu);
+
+	TST_SYSFS_ASSERT_RANGELL(-1, pkg_max_id,
+			       PATH_SYS_CPU "/cpu%d/topology/physical_package_id",
+			       cpu);
+
+	snprintf(sub, sizeof(sub),
+		 PATH_SYS_CPU "/cpu%d/topology/thread_siblings_list", cpu);
+	snprintf(super, sizeof(super),
+		 PATH_SYS_CPU "/cpu%d/topology/core_cpus_list", cpu);
+	TST_SYSFS_ASSERT_LIST_SUBSET(sub, super);
+
+	snprintf(sub, sizeof(sub),
+		 PATH_SYS_CPU "/cpu%d/topology/core_cpus_list", cpu);
+	snprintf(super, sizeof(super),
+		 PATH_SYS_CPU "/cpu%d/topology/package_cpus_list", cpu);
+	TST_SYSFS_ASSERT_LIST_SUBSET(sub, super);
+
+	snprintf(sub, sizeof(sub),
+		 PATH_SYS_CPU "/cpu%d/topology/package_cpus_list", cpu);
+	TST_SYSFS_ASSERT_LIST_SUBSET(sub, PATH_SYS_CPU "/present");
+
+	check_self_in_threads(cpu);
+}
+
+static void do_test(void)
+{
+	int count, max_id, poss_count, poss_max_id, cpu;
+	long pkg_max_id;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, PATH_SYS_CPU "/online"))
+		return;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&poss_count, &poss_max_id,
+					PATH_SYS_CPU "/possible"))
+		return;
+
+	if (tst_is_virt(VIRT_ANY))
+		pkg_max_id = LONG_MAX;
+	else
+		pkg_max_id = poss_max_id;
+
+	for (cpu = 0; cpu <= max_id; cpu++)
+		check_cpu_topology(cpu, poss_max_id, pkg_max_id);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
