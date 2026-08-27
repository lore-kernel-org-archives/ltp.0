Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F086C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:29:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 017873D527A
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:29:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A8423D56E0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 632AC1A00708
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDF6F21957
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO2nUY3Z1pv11ijHOXUYItI8Z5Ouz89GsBkrmLTWmMk=;
 b=jF04uee0plLj36gNCTtR4K1gbaWulHgaMGADW6s4MZD7UyEKrV3BiW1FUre7VecUKg+wGw
 /17flbgcLlQQROt3q2I5OCNKy3v6BVC44vNCEr/bUnXp6KngXzYTvt9NU/dHnRH0KNoUvb
 lpLbco+mE+GHEfqTRKEPhh6Ll4PZwE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO2nUY3Z1pv11ijHOXUYItI8Z5Ouz89GsBkrmLTWmMk=;
 b=pnzO4wVNEl/OgFzRHr2Eh8HmCzA9DXXgdORz+t3952mx4L/xEyZm2Al60VETsXrowtM5F4
 f/Ch0s48lwt63EAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO2nUY3Z1pv11ijHOXUYItI8Z5Ouz89GsBkrmLTWmMk=;
 b=L2uxVM7L4Dmbg+d/3FaK3Q23KelbDr1kv9vxZWmLR27dvmfRdtNCFh8Wr4K18snd5NjM1m
 2G/aw1Px4Y51o4oQuHFEJ9t3EVsIru2kmBtZvYKpU0AFjcfMzvK6nXhqJHWgSfBGsuOFNI
 jVeUdfBWqABe8WBK/xDHIIVLYVq2KGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SO2nUY3Z1pv11ijHOXUYItI8Z5Ouz89GsBkrmLTWmMk=;
 b=czpNF0ic7p3vQAlIiHTlhhHH7/idv4kLK0y98s9WgzmjIxsnl/beZezlsI9kBzavs1fzuo
 ZLj/cPxyACjFWCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E8913688
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qLDSK/MdkGqhawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:51 +0200
Message-ID: <20260827112157.1748734-26-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 25/31] testcases: sysfs: Add sys_block_queue01
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
 include/tst_path_defs.h                       |   3 +
 runtest/sysfs                                 |   1 +
 testcases/kernel/sysfs/block/.gitignore       |   1 +
 .../kernel/sysfs/block/sys_block_queue01.c    | 105 ++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/sysfs/block/sys_block_queue01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 2c9cfcf85..94836eb42 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -92,6 +92,9 @@
 #define MEMINFO_HPAGE_SURP	"HugePages_Surp:"
 #define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
 
+/* SYS_BLOCK */
+#define PATH_SYS_BLOCK				"/sys/block"
+
 /* SYSFS CLASS */
 #define PATH_CLASS_ATA_DEVICE			"/sys/class/ata_device"
 #define PATH_CLASS_BDI				"/sys/class/bdi"
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
index 000000000..38564139a
--- /dev/null
+++ b/testcases/kernel/sysfs/block/sys_block_queue01.c
@@ -0,0 +1,105 @@
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
+#include "tst_path_defs.h"
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
+				   PATH_SYS_BLOCK "/%s/queue/", dev);
+
+	TST_SYSFS_ASSERT_EQ_SUFFIX("logical_block_size", "hw_sector_size",
+				   PATH_SYS_BLOCK "/%s/queue/", dev);
+
+	TST_SYSFS_ASSERT_LE_SUFFIX("max_sectors_kb", "max_hw_sectors_kb",
+				   PATH_SYS_BLOCK "/%s/queue/", dev);
+}
+
+static void check_device(const char *dev)
+{
+	char sched[64];
+
+	tst_res(TINFO, "Checking block device '%s'", dev);
+
+	TST_SYSFS_ASSERT_POW2(PATH_SYS_BLOCK "/%s/queue/logical_block_size", dev);
+	TST_SYSFS_ASSERT_POW2(PATH_SYS_BLOCK "/%s/queue/physical_block_size", dev);
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX,
+			       PATH_SYS_BLOCK "/%s/queue/read_ahead_kb", dev);
+	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX,
+			       PATH_SYS_BLOCK "/%s/queue/nr_requests", dev);
+	TST_SYSFS_ASSERT_RANGEUU(0, ULLONG_MAX,
+			       PATH_SYS_BLOCK "/%s/queue/discard_max_bytes", dev);
+
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/rotational", dev);
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/add_random", dev);
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/iostats", dev);
+
+	TST_SYSFS_ASSERT_CHOICE(sched_allowed, sched, sizeof(sched),
+				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);
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
+	dir = TST_SYSFS_TRY_OPENDIR(PATH_SYS_BLOCK);
+
+	while ((ent = SAFE_READDIR(dir))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		/* Only devices that export a request queue are of interest. */
+		if (!tst_sysfs_exists(PATH_SYS_BLOCK "/%s/queue", ent->d_name))
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
