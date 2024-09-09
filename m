Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8584ECE57A
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDCF3C1892
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:04:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3650D3C14EE
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:39 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B5659600C6B
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 952C621BD9
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TA/0+WNH1MdIlomvWfL9ixq4LmXcJnA+UGtmXKTacwo=;
 b=PZ+F/6VWYIlzff2XpVLDwqBhjLU7bRBLaSg9fSQUxwDNKhvFKgsIn4YYHASLlElGeQJIxh
 I0tm51A/z/jKNzpzYAYA6oAo/liikS8N2NrMWoZtJLZwBxW9jKM3/BhxxL0j34ggL1Km6Y
 pi6pZOTd2CtXVTtezVqVlukkIVuJKPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TA/0+WNH1MdIlomvWfL9ixq4LmXcJnA+UGtmXKTacwo=;
 b=5koHDOFYv9B7fyLvEJWSlCYkoRbut2Heyel82KZTMf4f2Z4VjfOSx4iiQdjae/gRd7Ficg
 zpM06SsElx3s0lBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TA/0+WNH1MdIlomvWfL9ixq4LmXcJnA+UGtmXKTacwo=;
 b=PZ+F/6VWYIlzff2XpVLDwqBhjLU7bRBLaSg9fSQUxwDNKhvFKgsIn4YYHASLlElGeQJIxh
 I0tm51A/z/jKNzpzYAYA6oAo/liikS8N2NrMWoZtJLZwBxW9jKM3/BhxxL0j34ggL1Km6Y
 pi6pZOTd2CtXVTtezVqVlukkIVuJKPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TA/0+WNH1MdIlomvWfL9ixq4LmXcJnA+UGtmXKTacwo=;
 b=5koHDOFYv9B7fyLvEJWSlCYkoRbut2Heyel82KZTMf4f2Z4VjfOSx4iiQdjae/gRd7Ficg
 zpM06SsElx3s0lBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5175013312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aBqPDEPH3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 10:00:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:32 +0200
MIME-Version: 1.0
Message-Id: <20240909-listmount_statmount-v4-10-39558204ddf0@suse.com>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=4539;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IOlweJypu1tU+XTtyafjvmQbWT+C5jgQA/E1IzFBMhI=;
 b=AhWShxeUfizpCT0PAqnXWyxbgs0GCv5LscPMEj3Aja56eqO1qb1gjwEbn9tVy4Y27fos1B7uC
 QeTZK7zOCKhA6NRlzcgs55QnyzjNCQJuQ4AVHENf9D1BQewG5fu6XKb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 10/13] Add statmount05 test
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

This test verifies STATMOUNT_MNT_ROOT and STATMOUNT_MNT_POINT
functionalities of statmount().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/statmount/.gitignore    |   1 +
 testcases/kernel/syscalls/statmount/statmount05.c | 128 ++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index e43e53002..9f5a473f3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1572,6 +1572,7 @@ statmount01 statmount01
 statmount02 statmount02
 statmount03 statmount03
 statmount04 statmount04
+statmount05 statmount05
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index e720050b5..f64763242 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -2,3 +2,4 @@ statmount01
 statmount02
 statmount03
 statmount04
+statmount05
diff --git a/testcases/kernel/syscalls/statmount/statmount05.c b/testcases/kernel/syscalls/statmount/statmount05.c
new file mode 100644
index 000000000..dd4bb17f0
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount05.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies STATMOUNT_MNT_ROOT and STATMOUNT_MNT_POINT functionalities
+ * of statmount(). In particular, STATMOUNT_MNT_ROOT will give the mount root
+ * (i.e. mount --bind /mnt /bla -> /mnt) and STATMOUNT_MNT_POINT will
+ * give the mount point (i.e. mount --bind /mnt /bla -> /bla).
+ *
+ * [Algorithm]
+ *
+ * - create a mount point
+ * - mount a folder inside the mount point
+ * - run statmount() on the mounted folder using STATMOUNT_MNT_ROOT
+ * - read results and check if contain the mount root path
+ * - run statmount() on the mounted folder using STATMOUNT_MNT_POINT
+ * - read results and check if contain the mount point path
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+#include "tst_tmpdir.h"
+
+#define MNTPOINT "mntpoint"
+#define DIRA MNTPOINT "/LTP_DIR_A"
+#define DIRB MNTPOINT "/LTP_DIR_B"
+#define SM_SIZE (1 << 10)
+
+static uint64_t root_id;
+static struct statmount *st_mount;
+static char *mnt_root;
+static char *mnt_point;
+
+static void test_mount_root(void)
+{
+	tst_res(TINFO, "Testing STATMOUNT_MNT_ROOT");
+
+	char *last_root;
+
+	memset(st_mount, 0, SM_SIZE);
+
+	TST_EXP_PASS(statmount(root_id, STATMOUNT_MNT_ROOT, st_mount,
+		SM_SIZE, 0));
+
+	if (TST_RET == -1)
+		return;
+
+	last_root = strrchr(mnt_root, '/');
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_ROOT);
+	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->mnt_root, last_root) == 0,
+		"statmount() read '%s', expected '%s'",
+		st_mount->str + st_mount->mnt_root,
+		last_root);
+}
+
+static void test_mount_point(void)
+{
+	tst_res(TINFO, "Testing STATMOUNT_MNT_POINT");
+
+	memset(st_mount, 0, SM_SIZE);
+
+	TST_EXP_POSITIVE(statmount(root_id, STATMOUNT_MNT_POINT, st_mount,
+		SM_SIZE, 0));
+
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_POINT);
+	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->mnt_point, mnt_point) == 0,
+		"mount point is '%s'",
+		st_mount->str + st_mount->mnt_point);
+}
+
+static void run(void)
+{
+	test_mount_root();
+	test_mount_point();
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+
+	mnt_root = tst_tmpdir_mkpath(DIRA);
+	mnt_point = tst_tmpdir_mkpath(DIRB);
+
+	SAFE_MKDIR(mnt_root, 0700);
+	SAFE_MKDIR(mnt_point, 0700);
+	SAFE_MOUNT(mnt_root, mnt_point, "none", MS_BIND, NULL);
+
+	SAFE_STATX(AT_FDCWD, mnt_point, 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.data.stx_mnt_id;
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(DIRB))
+		SAFE_UMOUNT(DIRB);
+
+	if (tst_is_mounted(DIRA))
+		SAFE_UMOUNT(DIRA);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = SM_SIZE},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
