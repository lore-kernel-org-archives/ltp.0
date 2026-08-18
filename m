Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99BBC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:16:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 380893CD0B3
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:16:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE8883CCAFE
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F433600807
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 187BA3E03
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoMiCeuEl/MLK6pDKFAmpwAqI0j6zOCMUkxkk8gz0nM=;
 b=tsrGHJj9+RnflUCn38SyIpYeJ2EXofByaEO9p4bvvFv8yDnKb/h2cnzI6Jzf+k9NnQT3Lp
 /iz7QZ1lbw96pbxyafbMiEI5uM9hW1M5J4DtsY78cde4bg9Obi17cTETqQbTp8Fxj6PQff
 sAXMbqHW5eJI1oLXzzPHCuCr9NbZdhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoMiCeuEl/MLK6pDKFAmpwAqI0j6zOCMUkxkk8gz0nM=;
 b=HDwtHb1w5xQQjcZE1xdsxDl3Z/I/UGTNAchHOCiKnlTm4BltDLbriNRXfO9gsSXxvOp+Sm
 kWzyaPCfH1zeoDBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bWaRAOSY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lkYBkmnY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoMiCeuEl/MLK6pDKFAmpwAqI0j6zOCMUkxkk8gz0nM=;
 b=bWaRAOSYyjPXTpphmWbF7DsubthdlRBtvJeBZqV8aunX/OXVs8e2ormehKasas25cTuTSY
 98RHrHI+54GOWyUyzK68Uuxmdrnvf/XzT1Kc2eEC3phPpWTMcDD3zauf7ikiUI6rJqUzuv
 kJ6aEZmO2fY4VYLqDsJuwQ6WtTDp9iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoMiCeuEl/MLK6pDKFAmpwAqI0j6zOCMUkxkk8gz0nM=;
 b=lkYBkmnY8xY8pEwBg/iaFS4Ph6LhahkYimzja6NGr7KjMVX7D4dudV6rCHLgBRHzmboFXs
 IXVnpmCTFqKxqjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1948322BA
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lKpaBXxohGrdcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:12:50 +0200
Message-ID: <20260818141311.1265557-11-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 187BA3E03
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 10/31] testcases: sysfs: Add sys_cpu_cache01
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

A test for /sys/devices/system/cpu/cpu*/cache/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 .../sysfs/devices/system/cpu/.gitignore       |   1 +
 .../devices/system/cpu/sys_cpu_cache01.c      | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_cache01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 4cc2360c6..928b85928 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -6,3 +6,4 @@ sys_cpu_topology01 sys_cpu_topology01
 sys_cpu_topology02 sys_cpu_topology02
 sys_cpu_vulnerabilities01 sys_cpu_vulnerabilities01
 sys_cpu_smt01 sys_cpu_smt01
+sys_cpu_cache01 sys_cpu_cache01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/.gitignore b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
index d0f8a6dab..8da0a61c0 100644
--- a/testcases/kernel/sysfs/devices/system/cpu/.gitignore
+++ b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
@@ -2,3 +2,4 @@
 /sys_cpu_topology02
 /sys_cpu_vulnerabilities01
 /sys_cpu_smt01
+/sys_cpu_cache01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_cache01.c b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_cache01.c
new file mode 100644
index 000000000..16ccf0eba
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_cache01.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the CPU cache attributes exported under
+ * /sys/devices/system/cpu/cpuN/cache/indexM/.
+ *
+ * For every cache index of every online CPU the test verifies that:
+ *
+ * - level is greater than zero
+ * - type is one of Data, Instruction or Unified
+ * - coherency_line_size is a power of two
+ * - number_of_sets and ways_of_associativity are greater than zero
+ * - shared_cpu_list is a subset of the online CPUs
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include <limits.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define SYS_CPU "/sys/devices/system/cpu"
+
+static const char *const type_allowed[] = {
+	"Data", "Instruction", "Unified", NULL
+};
+
+static void check_index(int cpu, const char *index)
+{
+	char shared_cpu_list[PATH_MAX];
+
+	tst_res(TINFO, "Checking cpu%d %s", cpu, index);
+
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX,
+			       SYS_CPU "/cpu%d/cache/%s/level", cpu, index);
+
+	TST_SYSFS_ASSERT_ONEOF(type_allowed,
+			       SYS_CPU "/cpu%d/cache/%s/type", cpu, index);
+
+	TST_SYSFS_ASSERT_POW2(SYS_CPU "/cpu%d/cache/%s/coherency_line_size",
+			      cpu, index);
+
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX,
+			       SYS_CPU "/cpu%d/cache/%s/number_of_sets",
+			       cpu, index);
+
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX,
+			       SYS_CPU "/cpu%d/cache/%s/ways_of_associativity",
+			       cpu, index);
+
+	snprintf(shared_cpu_list, sizeof(shared_cpu_list),
+		 SYS_CPU "/cpu%d/cache/%s/shared_cpu_list", cpu, index);
+	TST_SYSFS_ASSERT_LIST_SUBSET(shared_cpu_list, SYS_CPU "/online");
+}
+
+static void check_cpu_caches(int cpu)
+{
+	char cache_dir[PATH_MAX];
+	DIR *d;
+	struct dirent *ent;
+
+	snprintf(cache_dir, sizeof(cache_dir), SYS_CPU "/cpu%d/cache", cpu);
+
+	if (access(cache_dir, F_OK))
+		return;
+
+	d = SAFE_OPENDIR(cache_dir);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "index", 5))
+			continue;
+
+		check_index(cpu, ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+}
+
+static void do_test(void)
+{
+	int count, max_id, cpu;
+
+	if (TST_SYSFS_ASSERT_PARSE_LIST(&count, &max_id, SYS_CPU "/online"))
+		return;
+
+	for (cpu = 0; cpu <= max_id; cpu++)
+		check_cpu_caches(cpu);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
