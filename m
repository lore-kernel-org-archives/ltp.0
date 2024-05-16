Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D809C25B77
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:32:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFA023CF9C5
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:32:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 321DD3CF982
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:38 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9E651600FB9
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2145C355
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyFJ5TEreUyXbp0M7V2Lh2GjCSo1bh6s2ozW1fxXFWg=;
 b=Dc6OYHDszI55XRFEIT5QL5gJTCoS8nB3hoUc4nQdRSeEvuLv6I5wCTy7wYkaRpsa5+Jvwi
 uykpYFAza0Qf7C17egbhi442vEqQQw/pa0rC8qftyzCv+1Tmvn07HQpvqsdokbt7uH2P5G
 ZVt+/NZUhg7WjSBij3YUo+Gh/PGTFPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyFJ5TEreUyXbp0M7V2Lh2GjCSo1bh6s2ozW1fxXFWg=;
 b=c/X3Fpvzse0WfoJTmxMhNTFXmd/eg26faVY7/0UxikwxIBHIaP3LSTz3sa1Q/+Hi4dgJt8
 nNa7CUfNvbyuBdAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dc6OYHDs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="c/X3Fpvz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyFJ5TEreUyXbp0M7V2Lh2GjCSo1bh6s2ozW1fxXFWg=;
 b=Dc6OYHDszI55XRFEIT5QL5gJTCoS8nB3hoUc4nQdRSeEvuLv6I5wCTy7wYkaRpsa5+Jvwi
 uykpYFAza0Qf7C17egbhi442vEqQQw/pa0rC8qftyzCv+1Tmvn07HQpvqsdokbt7uH2P5G
 ZVt+/NZUhg7WjSBij3YUo+Gh/PGTFPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyFJ5TEreUyXbp0M7V2Lh2GjCSo1bh6s2ozW1fxXFWg=;
 b=c/X3Fpvzse0WfoJTmxMhNTFXmd/eg26faVY7/0UxikwxIBHIaP3LSTz3sa1Q/+Hi4dgJt8
 nNa7CUfNvbyuBdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C0A213991
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OO4HHS/8RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:16 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-8-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=ZC4ICfJAoGrDs2CjPjQ+IKz+MGVUm3eH5X3BqdSqgyg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwu7yxraBk873+Z6fpts2PPfcBJ0d5ns5PdL
 8I8xg4OkDOJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LgAKCRDLzBqyILPm
 RuYXC/9xpWWDiC9vDe3+G+OlzpoORIAeDk/TSQIsB9r9lnTd+oHCw9L6SZyjDnXycYNH2+s/F5k
 onjCBsL2VwoztotDPUH7+kYwi9+NPEVOiHP8vzTB6vMGdbYNMnqRftwFOmvl6SyAKzCT+chXVVE
 vXPp/exDsjlJIqGTfY7EKb6WReGVdFmArXKgF/WHnSb0fLjKnwZpu7cLbX5Tz5nnzwdqWnpEVjo
 H6dIfUq7rTjDAGMOm+cgQ4GNwGPR0HGwBtRWhcjoU7v24m+Jv1G+ztJHus5veQUgFSdI1hEhlWz
 YggMx3aBxXXuyFIHgEqRqTrvZ8vB+DV3HuR/WhejXuKon5EmVpiI3GxkaJBacl0UjriJMXd2+YK
 gxmzxW2kKC/KVDR5XMnzQRrw77odG+malvnKIcqMhsHj/aXzBN4F6UMBas3AYd6PyR8BN9duM1M
 VfRFCDwcDNrFb4WULuQVjMbBOX7kQ8gUxEBrIEoJPYiB3iqg+17nWS4CRKtvP+7XEZ+2s=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8B2145C355
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 08/11] Add statmount03 test
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

This test verifies that statmount() is correctly reading mount
information (mount id, parent mount id, mount attributes etc.)
using STATMOUNT_MNT_BASIC.
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount03.c | 97 +++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ac6ebb51d..6eba317de 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1540,6 +1540,7 @@ stat04_64 symlink01 -T stat04_64
 
 statmount01 statmount01
 statmount02 statmount02
+statmount03 statmount03
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index a30b9565f..2a02bf721 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -1,2 +1,3 @@
 statmount01
 statmount02
+statmount03
diff --git a/testcases/kernel/syscalls/statmount/statmount03.c b/testcases/kernel/syscalls/statmount/statmount03.c
new file mode 100644
index 000000000..06b17bf16
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount03.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is correctly reading mount information
+ * (mount id, parent mount id, mount attributes etc.) using STATMOUNT_MNT_BASIC.
+ *
+ * [Algorithm]
+ *
+ * * create a mount point
+ * * create a new parent folder inside the mount point and obtain its mount info
+ * * create the new "/" mount folder and obtain its mount info
+ * * run statmount() on the mount point using STATMOUNT_MNT_BASIC
+ * * read results and check if mount info are correct
+ */
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define MYPARENT MNTPOINT "/myroot"
+
+static uint64_t root_id;
+static uint64_t root_id_old;
+static uint64_t parent_id;
+static uint64_t parent_id_old;
+static struct statmount *st_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(
+		root_id,
+		STATMOUNT_MNT_BASIC,
+		st_mount,
+		sizeof(struct statmount),
+		0));
+
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_BASIC);
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+	TST_EXP_EQ_LI(st_mount->mnt_id, root_id);
+	TST_EXP_EQ_LI(st_mount->mnt_id_old, root_id_old);
+	TST_EXP_EQ_LI(st_mount->mnt_parent_id, parent_id);
+	TST_EXP_EQ_LI(st_mount->mnt_parent_id_old, parent_id_old);
+	TST_EXP_EQ_LI(st_mount->mnt_propagation, MS_PRIVATE);
+}
+
+static void setup(void)
+{
+	struct statx sx;
+
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_MKDIR(MYPARENT, 0700);
+
+	SAFE_STATX(AT_FDCWD, MYPARENT, 0, STATX_MNT_ID_UNIQUE, &sx);
+	parent_id = sx.stx_mnt_id;
+
+	SAFE_STATX(AT_FDCWD, MYPARENT, 0, STATX_MNT_ID, &sx);
+	parent_id_old = sx.stx_mnt_id;
+
+	SAFE_MOUNT("", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+	SAFE_MOUNT(MYPARENT, MYPARENT, NULL, MS_BIND, NULL);
+	SAFE_CHROOT(MYPARENT);
+	SAFE_CHDIR("/");
+
+	SAFE_STATX(AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.stx_mnt_id;
+
+	SAFE_STATX(AT_FDCWD, "/", 0, STATX_MNT_ID, &sx);
+	root_id_old = sx.stx_mnt_id;
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
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
