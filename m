Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869AAC25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:29:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4F993CF9CD
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:29:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B86633CF95E
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:36 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B3A9200AD4
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 757E234925
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KD84L6CKqH9US6ZiwJGLI7FOK+OkRe/QvBOdn7fozlQ=;
 b=bM5q91WiWKZiK50Mkm9U+UEo0tlr3XQ9JDZ7bhEw6ZsbJHiYAzoPUYYSxPtjPUNs2m/PiI
 dWrnS5dDxPxqNkkFLpQhDwgOu9ZPbNyhzDYPEqX33QvjnCi9d0mx5aDlLDfCudX314Sqia
 XF/a88veU54sYD1hUZqa82wTCpP5X6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KD84L6CKqH9US6ZiwJGLI7FOK+OkRe/QvBOdn7fozlQ=;
 b=Yffb5iISBWaKmO9suRcvzRwg+K3qrSPQZ6dbNHO4InR72XS3fMOLxqdRJa9QbcOiWwbgQo
 +Asl9yqUZ5MdSCDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KD84L6CKqH9US6ZiwJGLI7FOK+OkRe/QvBOdn7fozlQ=;
 b=bM5q91WiWKZiK50Mkm9U+UEo0tlr3XQ9JDZ7bhEw6ZsbJHiYAzoPUYYSxPtjPUNs2m/PiI
 dWrnS5dDxPxqNkkFLpQhDwgOu9ZPbNyhzDYPEqX33QvjnCi9d0mx5aDlLDfCudX314Sqia
 XF/a88veU54sYD1hUZqa82wTCpP5X6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KD84L6CKqH9US6ZiwJGLI7FOK+OkRe/QvBOdn7fozlQ=;
 b=Yffb5iISBWaKmO9suRcvzRwg+K3qrSPQZ6dbNHO4InR72XS3fMOLxqdRJa9QbcOiWwbgQo
 +Asl9yqUZ5MdSCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 663FC137C3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KDfAFy/8RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:15 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-7-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3221;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=uBwCybHwKZr/Zok9JEnJzDiFKJeizgL+4I4h7HzZc4Q=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwuzpUwUeQlBHdNJZqAKspjHETWMN8g+OcoW
 NWdIW3WikyJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LgAKCRDLzBqyILPm
 RjO2C/wOnnS1wJzmEMGjhG22AoVRtLvfjngLxUX19XoT3esHFWmtyULlJxWwWHv7/3pDRVmzwIM
 5HccaqjK3Vgdr4fyvBs1jzyrJk7GwFWyPx8b6f4VwN525TbIDWqW9k6IPOmcbRQPVU5W/ZsGJ5+
 W90xOnAthgl5DUA9JyrROoEc2hta12Hb/mE629C/0EwOgPQmpqJA2386lGAYcOnNezy25IvAxSg
 ncVRtYD0KNWSjGpcyXJShcj1HLFEGkxhDm7LSG7eiUG7ZayvgrhMk5HaNleel6McglNQZNubUSX
 lc27mXRLyNkC8O8wEtmQPZTzQq6em93O+B6OdWKULAZ7AClHkU8YLQKZLSGBNDyyWYQHRMeNhGl
 lLsQnc4GDg1UuMxsykvErXEt7b/XjnWGcQGzKIAwAep1VHbkCWG3Fv37oHuWelUCYpnwgIZP2xP
 KcX0L5g/h8Ky2WpORx1SMjmZSS1AyWTnZmNKnvoG1nCRI1vYJfXKsIWnfHBtsGnCnkONQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/11] Add statmount02 test
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
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount02.c | 76 +++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d36aebfd5..ac6ebb51d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1539,6 +1539,7 @@ stat04 symlink01 -T stat04
 stat04_64 symlink01 -T stat04_64
 
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
index 000000000..77cd88469
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount02.c
@@ -0,0 +1,76 @@
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
+ * * create a mount point and read its mount info
+ * * run statmount() on the mount point using STATMOUNT_SB_BASIC
+ * * read results and check if mount info are correct
+ */
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+#include <linux/btrfs.h>
+
+#define MNTPOINT "mntpoint"
+
+static struct statmount *st_mount;
+static struct statx *sx_mount;
+static struct statfs *sf_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(
+		sx_mount->stx_mnt_id,
+		STATMOUNT_SB_BASIC,
+		st_mount,
+		sizeof(struct statmount),
+		0));
+
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_SB_BASIC);
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+	TST_EXP_EQ_LI(st_mount->sb_dev_major, sx_mount->stx_dev_major);
+	TST_EXP_EQ_LI(st_mount->sb_dev_minor, sx_mount->stx_dev_minor);
+	TST_EXP_EQ_LI(st_mount->sb_magic, sf_mount->f_type);
+}
+
+static void setup(void)
+{
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, sx_mount);
+	SAFE_STATFS(MNTPOINT, sf_mount);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		"btrfs",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{&sx_mount, .size = sizeof(struct statx)},
+		{&sf_mount, .size = sizeof(struct statfs)},
+		{}
+	}
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
