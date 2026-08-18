Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18161C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:20:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACE303CD679
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:20:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFDC63CD587
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0B1DC10006B7
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92323845C6
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IGQtIAJ1iN2sKcfaeC6Wgga9ciyixu292lertyr0u8=;
 b=TtiaeX3+lSFwRwdazB8ngpKzhCSk5N9tIV8DQ48gJC3/3X9fQ9vUZQCG2FJA4BYbdrQ2Gb
 zDAdW2OHyNicF5VatxzS88gd0ngHaMRVh89XCpax94cfrBQUzl1Xqx6yIDbv9s9Q1aniAV
 2Fj2HveVlpobxviy3L8kkXk1fhHzTqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IGQtIAJ1iN2sKcfaeC6Wgga9ciyixu292lertyr0u8=;
 b=cIy37xmlYpVMPEVbYJemjJNVMmxezAYR9HhRx2A4eCBP9YvuLAZKoJNEw4SMcSfurhUwfc
 m+KTYUqm1WIHdxBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IGQtIAJ1iN2sKcfaeC6Wgga9ciyixu292lertyr0u8=;
 b=O3NaZ1HHhiRw0xNow9mFB4jxeY+8xAMGd0G8qQXi8O4iyYbsWQlugFj2NhxxuRWrGKpINn
 0gzv3OEjQRhW4dcrPqjH6LZW12BV0HgPcHCX80NIOo4Rt3rTL+q/eiZrQWMB4m5LEhIvNT
 dK/wEO8OUbMmC2DT2GJy9Im3t2fDMIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IGQtIAJ1iN2sKcfaeC6Wgga9ciyixu292lertyr0u8=;
 b=RvfmVcCsBAMrniCu8PvrEigeR9pXdHGLafHjuRVTN9epO2S1s7f6xkhxyCK0jiHNP/T2/S
 pL/eagg7s/n7jBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79BBB367A
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QSDHGZ1ohGq9cQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:49 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:13:05 +0200
Message-ID: <20260818141311.1265557-26-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 25/31] testcases: sysfs: Add sys_block_queue01
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

A test for /sys/block/*/queue/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 testcases/kernel/sysfs/block/.gitignore       |   1 +
 .../kernel/sysfs/block/sys_block_queue01.c    | 106 ++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 testcases/kernel/sysfs/block/sys_block_queue01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 26a229f03..f7d35e0c2 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -20,3 +20,4 @@ sys_net02 sys_net02
 sys_net03 sys_net03
 sys_net04 sys_net04
 sys_block_loop01 sys_block_loop01
+sys_block_queue01 sys_block_queue01
diff --git a/testcases/kernel/sysfs/block/.gitignore b/testcases/kernel/sysfs/block/.gitignore
index c64e99087..c7011b79f 100644
--- a/testcases/kernel/sysfs/block/.gitignore
+++ b/testcases/kernel/sysfs/block/.gitignore
@@ -1 +1,2 @@
 /sys_block_loop01
+/sys_block_queue01
diff --git a/testcases/kernel/sysfs/block/sys_block_queue01.c b/testcases/kernel/sysfs/block/sys_block_queue01.c
new file mode 100644
index 000000000..af31f6f64
--- /dev/null
+++ b/testcases/kernel/sysfs/block/sys_block_queue01.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the per block device request queue attributes exported
+ * under /sys/block/<dev>/queue/.
+ *
+ * For every block device that exports a request queue the test verifies that:
+ *
+ * - logical_block_size and physical_block_size are powers of two
+ * - logical_block_size <= physical_block_size
+ * - hw_sector_size equals logical_block_size
+ * - max_sectors_kb <= max_hw_sectors_kb
+ * - read_ahead_kb, nr_requests and discard_max_bytes are non-negative
+ * - nr_requests is greater than zero
+ * - rotational, add_random, iostats are boolean (0 or 1)
+ * - scheduler is a valid bracketed-choice file with exactly one active scheduler
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present, since the set of exported queue attributes differs between kernel
+ * versions and device types.
+ */
+
+#include <string.h>
+#include <dirent.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define SYS_BLOCK "/sys/block"
+
+/* schedulers that have existed in mainline over time */
+static const char *const sched_allowed[] = {
+	"none", "noop", "deadline", "mq-deadline", "cfq",
+	"kyber", "bfq", "anticipatory", NULL
+};
+
+static void check_cross(const char *dev)
+{
+	TST_SYSFS_ASSERT_LE_SUFFIX("logical_block_size", "physical_block_size",
+				   SYS_BLOCK "/%s/queue/", dev);
+
+	TST_SYSFS_ASSERT_EQ_SUFFIX("logical_block_size", "hw_sector_size",
+				   SYS_BLOCK "/%s/queue/", dev);
+
+	TST_SYSFS_ASSERT_LE_SUFFIX("max_sectors_kb", "max_hw_sectors_kb",
+				   SYS_BLOCK "/%s/queue/", dev);
+}
+
+static void check_device(const char *dev)
+{
+	char sched[64];
+
+	tst_res(TINFO, "Checking block device '%s'", dev);
+
+	TST_SYSFS_ASSERT_POW2(SYS_BLOCK "/%s/queue/logical_block_size", dev);
+	TST_SYSFS_ASSERT_POW2(SYS_BLOCK "/%s/queue/physical_block_size", dev);
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX,
+			       SYS_BLOCK "/%s/queue/read_ahead_kb", dev);
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX,
+			       SYS_BLOCK "/%s/queue/nr_requests", dev);
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX,
+			       SYS_BLOCK "/%s/queue/discard_max_bytes", dev);
+
+	TST_SYSFS_ASSERT_BOOL(SYS_BLOCK "/%s/queue/rotational", dev);
+	TST_SYSFS_ASSERT_BOOL(SYS_BLOCK "/%s/queue/add_random", dev);
+	TST_SYSFS_ASSERT_BOOL(SYS_BLOCK "/%s/queue/iostats", dev);
+
+	TST_SYSFS_ASSERT_CHOICE(sched_allowed, sched, sizeof(sched),
+				SYS_BLOCK "/%s/queue/scheduler", dev);
+
+	check_cross(dev);
+}
+
+static void run(void)
+{
+	DIR *dir;
+	struct dirent *ent;
+	int found = 0;
+
+	dir = SAFE_OPENDIR(SYS_BLOCK);
+
+	while ((ent = SAFE_READDIR(dir))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		/* Only devices that export a request queue are of interest. */
+		if (!tst_sysfs_exists(SYS_BLOCK "/%s/queue", ent->d_name))
+			continue;
+
+		found = 1;
+		check_device(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(dir);
+
+	if (!found)
+		tst_res(TCONF, "No block device with a request queue found");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
