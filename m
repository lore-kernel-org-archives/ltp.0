Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF91C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:54:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2724E3C210D
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:54:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FFBB3C210D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6AD4C10005B4
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EA3E1F853;
 Thu, 27 Aug 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5F9CQAGPH+8dHZzHicqJds6ulJGxRqTR5eUrt95SpI=;
 b=Dq5frEmfJNnGC8JgZMpn0CQveQXLmZY8QdfbhvNziiNe9799bO9k18HOsX4eXpjoXFSQtW
 2x8qQtrVO6e8PUeXv1nnNwyWAT0twCEgAsRwDtfeLUFgfaO/ml4JWQGEE577W0Ar64e8dr
 t0YeXkqedIoLuOMITxJ3CjHFjwsdbtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5F9CQAGPH+8dHZzHicqJds6ulJGxRqTR5eUrt95SpI=;
 b=ddKx5t5UQ/BECuFAvdUVz6apAMq7qYdLz4YZPRrCHj62Bput5Dd3UceVrTE91reoLHbYk2
 f6FzoAHeAa03AFAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tSauhHL3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z6nnY9mG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5F9CQAGPH+8dHZzHicqJds6ulJGxRqTR5eUrt95SpI=;
 b=tSauhHL3Z3VZ56uGy2uO5ANTd7ntXrQI7uU9EpmNHdHWxn6apKTQerOnVhh5UQATRLT4Ep
 rodVXLNEhkgvXfvtwjEg7PQuHLDHXOaijiobGUPxZiBJStymg46fSC0Czn14MdjnMXh1SM
 xw4LK9P2SSjwHzd+WhqtJnrWChmSwb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5F9CQAGPH+8dHZzHicqJds6ulJGxRqTR5eUrt95SpI=;
 b=z6nnY9mGee445VLwmP7zfNfOb9YOyNxfR5GgCdLeqWntRz1SLnvXq9/iINwqf13e6PeZX/
 wgtZAZePZ6nlfADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1111E1361C;
 Thu, 27 Aug 2026 11:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cA6xAmMlkGq6DAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 11:54:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 13:54:05 +0200
MIME-Version: 1.0
Message-Id: <20260827-swapon_discard_coverage-v1-2-633bcb11c181@suse.com>
References: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
In-Reply-To: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787831650; l=7365;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=UN0peTF62OU866FB47fNn8Kw5H/8OX+fq1q7/Es1HQ8=;
 b=fy+49MH+bwhkLyz+Exyq2VWULFDzryfw4JFRygPz8HRu8ajUIGyQt/BlWvnqhfcRteJbYJzUW
 npFxNgyCrgtBt+UQ6OhstMDUH8ce6ohscyyO2WIQKVWNmrf5geb8dh2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 2EA3E1F853
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify that swapon(2) discard flags (SWAP_FLAG_DISCARD,
SWAP_FLAG_DISCARD_ONCE, SWAP_FLAG_DISCARD_PAGES) correctly control
swapon-time area discard on block devices supporting discard operations.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/swapon/.gitignore |   1 +
 testcases/kernel/syscalls/swapon/swapon04.c | 197 ++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 737c63e31..ca190dd97 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1676,6 +1676,7 @@ swapoff02 swapoff02
 swapon01 swapon01
 swapon02 swapon02
 swapon03 swapon03
+swapon04 swapon04
 
 #Exclusive syscall() for POWER6 machines only
 switch01 endian_switch01
diff --git a/testcases/kernel/syscalls/swapon/.gitignore b/testcases/kernel/syscalls/swapon/.gitignore
index 729226b11..db03b81ea 100644
--- a/testcases/kernel/syscalls/swapon/.gitignore
+++ b/testcases/kernel/syscalls/swapon/.gitignore
@@ -1,3 +1,4 @@
 /swapon01
 /swapon02
 /swapon03
+/swapon04
diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
new file mode 100644
index 000000000..cf527586b
--- /dev/null
+++ b/testcases/kernel/syscalls/swapon/swapon04.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2026
+ */
+
+/*\
+ * Check that :manpage:`swapon(2)` discard flags control swapon-time area discard:
+ *
+ * - With 0 (no flags), the swap area is not discarded at swapon.
+ * - With SWAP_FLAG_DISCARD, the swap area is discarded at swapon.
+ * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE, the swap area is discarded at swapon.
+ * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES, swapon-time area discard
+ *   is disabled (page-cluster discard only).
+ * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES,
+ *   SWAP_FLAG_DISCARD_ONCE takes precedence and discards the swap area at swapon.
+ * - With SWAP_FLAG_DISCARD_ONCE or SWAP_FLAG_DISCARD_PAGES alone (without the
+ *   SWAP_FLAG_DISCARD master enable bit), discard is not enabled.
+ *
+ * [Algorithm]
+ *
+ * - Create a backing file on the test filesystem and fill it completely.
+ * - Attach the backing file to a loop device supporting discard.
+ * - For each test case, populate the backing file and format it with mkswap.
+ * - Record the allocated block count before swapon().
+ * - Call swapon() with the test case flags.
+ * - Verify whether the allocated block count dropped (discarded) or remained.
+ * - Call swapoff() to reset the swap device state.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "tse_swap.h"
+#include "lapi/syscalls.h"
+#include "lapi/fallocate.h"
+
+#define MNTPOINT "mntpoint"
+#define BACKING_FILE MNTPOINT "/swap_backing_file"
+#define SWAP_SIZE_MB 16
+
+static char loop_dev[PATH_MAX];
+static int loop_dev_id = -1;
+static int loop_attached;
+static int swap_active;
+static size_t max_header_blocks;
+
+static struct tcase {
+	int flags;
+	int exp_discard;
+	const char *desc;
+} tcases[] = {
+	{
+		.desc = "0 (no flags)",
+	},
+	{
+		.flags = SWAP_FLAG_DISCARD,
+		.exp_discard = 1,
+		.desc = "SWAP_FLAG_DISCARD",
+	},
+	{
+		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE,
+		.exp_discard = 1,
+		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE",
+	},
+	{
+		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES,
+		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES",
+	},
+	{
+		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES,
+		.exp_discard = 1,
+		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES",
+	},
+	{
+		.flags = SWAP_FLAG_DISCARD_ONCE,
+		.desc = "SWAP_FLAG_DISCARD_ONCE (alone without master flag)",
+	},
+	{
+		.flags = SWAP_FLAG_DISCARD_PAGES,
+		.desc = "SWAP_FLAG_DISCARD_PAGES (alone without master flag)",
+	},
+};
+
+static void setup(void)
+{
+	char discard_path[PATH_MAX];
+	unsigned long discard_max_bytes = 0;
+	size_t page_size, blk_size, alloc_units;
+	struct stat st;
+	int fd;
+
+	if (access("/proc/swaps", F_OK))
+		tst_brk(TCONF, "swap is not supported by kernel");
+
+	fd = SAFE_OPEN(BACKING_FILE, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	TEST(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, 4096));
+
+	if (TST_RET != 0) {
+		SAFE_CLOSE(fd);
+
+		if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS) {
+			tst_brk(TCONF, "Filesystem %s does not support FALLOC_FL_PUNCH_HOLE",
+				tst_device->fs_type);
+		}
+
+		tst_brk(TBROK | TERRNO, "fallocate() error");
+	}
+
+	SAFE_FTRUNCATE(fd, SWAP_SIZE_MB * TST_MB);
+	SAFE_CLOSE(fd);
+
+	loop_dev_id = tst_find_free_loopdev(loop_dev, sizeof(loop_dev));
+	if (loop_dev_id < 0)
+		tst_brk(TBROK, "No free loop device found");
+
+	if (tst_attach_device(loop_dev, BACKING_FILE))
+		tst_brk(TBROK, "Failed to attach %s to %s", loop_dev, BACKING_FILE);
+	loop_attached = 1;
+
+	snprintf(discard_path, sizeof(discard_path),
+		 "/sys/block/loop%d/queue/discard_max_bytes", loop_dev_id);
+	if (FILE_SCANF(discard_path, "%lu", &discard_max_bytes) != 0 || discard_max_bytes == 0) {
+		tst_brk(TCONF, "Loop device %s does not support discard on %s",
+			loop_dev, tst_device->fs_type);
+	}
+
+	SAFE_STAT(BACKING_FILE, &st);
+
+	page_size = getpagesize();
+	blk_size = st.st_blksize;
+	alloc_units = page_size > blk_size ? page_size : blk_size;
+
+	/* Minimum 512-byte blocks for 1 page + small tolerance for filesystem metadata */
+	max_header_blocks = (alloc_units / 512) * 2;
+}
+
+static void verify_swapon(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct stat st;
+	blkcnt_t blocks_before, blocks_after;
+	const char *const mkswap_argv[] = {"mkswap", loop_dev, NULL};
+
+	tst_fill_file(BACKING_FILE, 'A', TST_MB, SWAP_SIZE_MB);
+
+	tst_cmd(mkswap_argv, "/dev/null", "/dev/null", TST_CMD_TCONF_ON_MISSING);
+
+	SAFE_STAT(BACKING_FILE, &st);
+	blocks_before = st.st_blocks;
+
+	if (!blocks_before)
+		tst_brk(TBROK, "Backing file has 0 allocated blocks");
+
+	TEST(tst_syscall(__NR_swapon, loop_dev, tc->flags));
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO, "swapon(%s, %s)", loop_dev, tc->desc);
+		return;
+	}
+	swap_active = 1;
+
+	SAFE_STAT(BACKING_FILE, &st);
+	blocks_after = st.st_blocks;
+
+	if (tc->exp_discard)
+		TST_EXP_LE_LU(blocks_after, max_header_blocks);
+	else
+		TST_EXP_EQ_LI(blocks_after, blocks_before);
+
+	if (tst_syscall(__NR_swapoff, loop_dev) != 0)
+		tst_brk(TBROK | TTERRNO, "swapoff(%s) failed", loop_dev);
+	swap_active = 0;
+}
+
+static void cleanup(void)
+{
+	if (swap_active && tst_syscall(__NR_swapoff, loop_dev) != 0)
+		tst_res(TWARN | TTERRNO, "swapoff(%s) failed", loop_dev);
+	swap_active = 0;
+
+	if (loop_attached)
+		tst_detach_device(loop_dev);
+	loop_attached = 0;
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_swapon,
+	.tcnt = ARRAY_SIZE(tcases),
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
