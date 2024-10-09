Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9B4CEDD88
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:07:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EB233C2ED6
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:07:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2861B3C2BD0
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:49 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2EC851402E2B
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E442421E8B;
 Wed,  9 Oct 2024 12:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLwf6HU6JD2oNxUsdGPxRBl4IC11+StyR1D4YmuSaR0=;
 b=Rz2pK4r4L0nKxqLxreBMseZYS/DvtNoXzNcvjjv2kmH52k8HsL69XDAR+L8g6IwIgJlLlM
 ajlEmmfPBy15RRbA+2x2LeWgfm8mqJumhD73EH8gbVe/IPrzVThcX3VWsltamabOL33rN8
 FRXiU9hThLrRh4X+eXEnvDCdcjotoLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLwf6HU6JD2oNxUsdGPxRBl4IC11+StyR1D4YmuSaR0=;
 b=ABMQwGgLRCXgLK4ICiXom9s6iC4kuyuuAtLQXbXEtu5sV0szr8eVzmAb4L80TZYQwoLEUb
 apbGkzPokd0S68Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLwf6HU6JD2oNxUsdGPxRBl4IC11+StyR1D4YmuSaR0=;
 b=Rz2pK4r4L0nKxqLxreBMseZYS/DvtNoXzNcvjjv2kmH52k8HsL69XDAR+L8g6IwIgJlLlM
 ajlEmmfPBy15RRbA+2x2LeWgfm8mqJumhD73EH8gbVe/IPrzVThcX3VWsltamabOL33rN8
 FRXiU9hThLrRh4X+eXEnvDCdcjotoLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLwf6HU6JD2oNxUsdGPxRBl4IC11+StyR1D4YmuSaR0=;
 b=ABMQwGgLRCXgLK4ICiXom9s6iC4kuyuuAtLQXbXEtu5sV0szr8eVzmAb4L80TZYQwoLEUb
 apbGkzPokd0S68Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9347213A58;
 Wed,  9 Oct 2024 12:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8E6qEV5xBmfLEwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 12:04:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 14:04:43 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v8-8-182cd6557223@suse.com>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
In-Reply-To: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728475481; l=3585;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=rUet5bE4PXtlXfmwgPHMKCcNQq6hg4sYow9a5cStz5s=;
 b=LtXhgXrFxss3/Y/jRYs0TYX6YyrmfvzQurVdNV/Q9VI+cScID7vqM/eomByStC8vstPikZG7O
 hLrGDkt8qv8B2/7LkVdVN9Ax/+CoEEH+V3ElJewD28ul+sfJWBR8Wjm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 08/16] Add statmount02 test
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

This test verifies that statmount() is correctly reading basic
filesystem info using STATMOUNT_SB_BASIC.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount02.c | 84 +++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 677d797f8..c6c31c546 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1575,6 +1575,7 @@ stat04 stat04
 stat04_64 stat04_64
 
 statmount01 statmount01
+statmount02 statmount02
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index f1529eb29..a30b9565f 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -1 +1,2 @@
 statmount01
+statmount02
diff --git a/testcases/kernel/syscalls/statmount/statmount02.c b/testcases/kernel/syscalls/statmount/statmount02.c
new file mode 100644
index 000000000..4e23c6979
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount02.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is correctly reading basic filesystem
+ * info using STATMOUNT_SB_BASIC.
+ * The btrfs validation is currently skipped due to the lack of support for VFS.
+ *
+ * [Algorithm]
+ *
+ * - create a mount point and read its mount info
+ * - run statmount() on the mount point using STATMOUNT_SB_BASIC
+ * - read results and check if mount info are correct
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+#include <linux/btrfs.h>
+
+#define MNTPOINT "mntpoint"
+
+static struct statmount *st_mount;
+static struct ltp_statx *sx_mount;
+static struct statfs *sf_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(sx_mount->data.stx_mnt_id, STATMOUNT_SB_BASIC,
+		st_mount, sizeof(struct statmount), 0));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_SB_BASIC);
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+	TST_EXP_EQ_LI(st_mount->sb_dev_major, sx_mount->data.stx_dev_major);
+	TST_EXP_EQ_LI(st_mount->sb_dev_minor, sx_mount->data.stx_dev_minor);
+	TST_EXP_EQ_LI(st_mount->sb_magic, sf_mount->f_type);
+	TST_EXP_EQ_LI(st_mount->sb_flags, MS_RDONLY);
+}
+
+static void setup(void)
+{
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_RDONLY, NULL);
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, sx_mount);
+	SAFE_STATFS(MNTPOINT, sf_mount);
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.8",
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		"btrfs",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{&sx_mount, .size = sizeof(struct ltp_statx)},
+		{&sf_mount, .size = sizeof(struct statfs)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
