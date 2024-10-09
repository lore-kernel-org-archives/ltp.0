Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668B3CED62A
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:32:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F09283C31F4
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:32:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32BB23C1CF0
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 571C51402E2A
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F107021E0B;
 Wed,  9 Oct 2024 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMAZa7WSz72avbtWk9diIDeT37kOoJ6PfkawKLH+zG0=;
 b=TJ6hkzxm5IgYajKGlfd4rSW/38W0kIVJ5SdYNOxDT3CRZfsku6cQc3WzlcXq1zTXh3m9ks
 mghLWradol50x2x0l1/lNN7VgOi6IrZfKBbOsAggeGGocLVn2me3XpkRXGXOcNjhngHBrN
 kPZNcrqE0smPw0XqRatyjeE3z1DNcuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMAZa7WSz72avbtWk9diIDeT37kOoJ6PfkawKLH+zG0=;
 b=6ik+XM4eFyUGr59kiW8olAJPgblgtCPKorMOAhEyBWzWyjQ9KPyxUEQRhjNetrVoBkjTdS
 HB09hWewVRolhnAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMAZa7WSz72avbtWk9diIDeT37kOoJ6PfkawKLH+zG0=;
 b=l1zAIiWlWqkR+1lJ61IsgRNuJUuLGhikouHtW3GKzB8sKobgVFUdOZmfv5m3jG/T3rQnyG
 /zNjidAxrsK1wNv3+vHOjN7DeMn/9MVQTDDx0vdgm+VKRt7rssTZxBR+Sblgqae4VQCWJz
 j41DEfRvtR9QYPxNYeIA/UsbP0owpZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMAZa7WSz72avbtWk9diIDeT37kOoJ6PfkawKLH+zG0=;
 b=cJ8OAPOXCXQqo/f/DmcG4sQd0/Otajrez+HAdgvNBa/En/AM+BE5vui/qRnYQHBtUy5D7j
 DntqEg1JLOfoT8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62F8613AAF;
 Wed,  9 Oct 2024 08:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iDQDCeI+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 08:29:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:13 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v7-11-d5ad31d47f68@suse.com>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
In-Reply-To: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=4389;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=CPkPJ0WE5jOB+Wkax0ZQfarFN7NE82D5uI2gU/4I2eI=;
 b=5Ii2ecKP2ZPauiVSenhX5vximi/y05IJai95pfIU+y9sYDiReEkSUoZ6a5GbCnQZdO3iFsPJ+
 wq9vCcQYTNKD1cLepicsQ/EsfN5ZivzMsvAxvQdv762CLMwsbhKT6V0
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 11/16] Add statmount05 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/statmount/.gitignore    |   1 +
 testcases/kernel/syscalls/statmount/statmount05.c | 123 ++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 452ac1ac9..97c7049a2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1578,6 +1578,7 @@ statmount01 statmount01
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
index 000000000..95e674c06
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount05.c
@@ -0,0 +1,123 @@
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
+	if (!TST_PASS)
+		return;
+
+	last_root = strrchr(mnt_root, '/');
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_ROOT);
+	TST_EXP_EQ_STR(st_mount->str + st_mount->mnt_root, last_root);
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
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_POINT);
+	TST_EXP_EQ_STR(st_mount->str + st_mount->mnt_point, mnt_point);
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
+	mnt_root = tst_tmpdir_genpath(DIRA);
+	mnt_point = tst_tmpdir_genpath(DIRB);
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
