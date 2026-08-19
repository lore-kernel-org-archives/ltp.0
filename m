Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60870C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:23:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2ABE3CD737
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:23:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 545F03CD69F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD999100052C
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 246283ED5
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkyD3hYyTsCVwMEDwrua1O8y+ZShAu0EWXeAozGXlHs=;
 b=P0HtDCzdK3nuzrHV/2x0TSHTy/8InYhrbLgFr19SWIP7xEqVwpViFHqHQgxJp3mPte4Dza
 znDvnzy9z2aPViaO+Yap36uJlL95JNla3dzwfY3MaROm/In/1lh4Uft7+bP2eXTwHi6i5N
 rxXCBO2EPUALSAOZqFur8n/PgWJkBM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkyD3hYyTsCVwMEDwrua1O8y+ZShAu0EWXeAozGXlHs=;
 b=dWeHcVhe7DVezZ22hE7UmQKdjZCXk8O7C2op3tSr7WbYEoDVNEaIbsz7ZmpjrS7CHxEStd
 g87qlAdb0QtdCvCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dCTlXPE4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tFKxltjq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkyD3hYyTsCVwMEDwrua1O8y+ZShAu0EWXeAozGXlHs=;
 b=dCTlXPE4bpGFmY84SmIvoUBJsTtkrIoAijLw8lb1MRz/QxX3/ZqM8SwAHhGXsUKRFq7tBP
 5dkiEvbp+Qn33lxGcnaRJ50cRbn+a4nQKSDVUyhz+kLsmN4R5oqBVK0VMqcC7Aa3Eq86PS
 CD8piQoeOX7JvqjK3gI7y2yg99NOUrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkyD3hYyTsCVwMEDwrua1O8y+ZShAu0EWXeAozGXlHs=;
 b=tFKxltjqaCvMRG+bZ/B5dLo4ZDbKQ56swfP1rNcKYKXhx9gcJN/mUb/xU0zGee1gS30iYx
 askrZ14D3vNQpXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14A99364F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id txPFA/zWhWqzcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:17:00 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:28 +0200
Message-ID: <20260819161634.1341577-26-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 246283ED5
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 25/31] testcases: sysfs: Add sys_block_queue01
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
index 000000000..4f2bb732d
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
+	TST_SYSFS_ASSERT_RANGEUU(0, ULLONG_MAX,
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
