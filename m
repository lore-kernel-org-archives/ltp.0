Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D2CCAC599
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 14:26:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34473CDC65
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 16:26:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91C163CDC74
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:26:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC78E200111
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:26:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 217E120543;
 Wed, 17 Sep 2025 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758119150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4S95iov89IThSKRYWXp1HnW2xQgUiPXTESxguorALg=;
 b=gNGvYyt24x8IoOBwiepASeuv1bx1juzapKoutiotcjHIbPRvH2xtm3ndaBdWMWfYx1khFR
 hyqyf4fO5XEAb2Y1+AYRolkg6ORfWATRWgR455o2EKxMpmUgRyTj7ytqoZz3kbYDyAj4ej
 5/oInAiVuM1yf55idg2UjERVnyn2GxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758119150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4S95iov89IThSKRYWXp1HnW2xQgUiPXTESxguorALg=;
 b=jc3ID/Y5arqrP58KJG/EYuPz9aN+6ZpLYfcQMFJWssHwDrvAS/VqhtRFocJJK8DO01BqlH
 VMZ0Aas2F6fn9sCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758119150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4S95iov89IThSKRYWXp1HnW2xQgUiPXTESxguorALg=;
 b=gNGvYyt24x8IoOBwiepASeuv1bx1juzapKoutiotcjHIbPRvH2xtm3ndaBdWMWfYx1khFR
 hyqyf4fO5XEAb2Y1+AYRolkg6ORfWATRWgR455o2EKxMpmUgRyTj7ytqoZz3kbYDyAj4ej
 5/oInAiVuM1yf55idg2UjERVnyn2GxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758119150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4S95iov89IThSKRYWXp1HnW2xQgUiPXTESxguorALg=;
 b=jc3ID/Y5arqrP58KJG/EYuPz9aN+6ZpLYfcQMFJWssHwDrvAS/VqhtRFocJJK8DO01BqlH
 VMZ0Aas2F6fn9sCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03F5313A92;
 Wed, 17 Sep 2025 14:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uE71Ou3EymjLCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 17 Sep 2025 14:25:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 17 Sep 2025 16:25:46 +0200
MIME-Version: 1.0
Message-Id: <20250917-open_tree_attr-v3-2-d78d4150b662@suse.com>
References: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
In-Reply-To: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758119149; l=4985;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Q6SWQqnAfXH/taFbVF1G9lTkCVmo3KzHThd7uvfI1n0=;
 b=hrpxDwzfQx1P4ZGW9Vn1VcB7blx2ly+ln+asUEo4Vjx4+g9WFt3//VssAqTPmq3eBKuE+tZYh
 RIa56yS2PVJDCh8Z931Kae4EUCow8RYK/p8s15U0UtO3SP21LrhQlUT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] mount_setattr01: add open_tree_attr variant
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

This patch simply introduces a new variant to the mount_setattr01
test, in order to verify that open_tree_attr() works correctly.
The open_tree_attr() syscall has been introduced in the kernel v6.15 by
commit "c4a16820d901 - fs: add open_tree_attr()".

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../syscalls/mount_setattr/mount_setattr01.c       | 83 +++++++++++++++++-----
 1 file changed, 65 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
index eb32cd91a7fcb4cb303e184dd40d5e10a280874c..14927e1038e1333120bdd0bad33c3891301e71ec 100644
--- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -3,10 +3,11 @@
  * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
  * Author: Dai Shili <daisl.fnst@fujitsu.com>
  * Author: Chen Hanxiao <chenhx.fnst@fujitsu.com>
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*\
- * Basic mount_setattr() test.
+ * Basic mount_setattr()/open_tree_attr() test.
  * Test whether the basic mount attributes are set correctly.
  *
  * Verify some MOUNT_SETATTR(2) attributes:
@@ -22,7 +23,8 @@
  * - MOUNT_ATTR_NODIRATIME - prevents updating access time for
  *   directories on this mount
  *
- * The functionality was added in v5.12.
+ * The mount_setattr functionality was added in v5.12, while the open_tree_attr
+ * functionality was added in v6.15.
  */
 
 #define _GNU_SOURCE
@@ -30,6 +32,7 @@
 #include <sys/statvfs.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
+#include "lapi/syscalls.h"
 
 #define MNTPOINT        "mntpoint"
 #define OT_MNTPOINT     "ot_mntpoint"
@@ -40,7 +43,23 @@
 		.expect_attrs = exp_attrs       \
 	}
 
+static int open_tree_variant1(struct mount_attr *attr);
+static int open_tree_variant2(struct mount_attr *attr);
+
 static int mount_flag, otfd = -1;
+struct mount_attr *attr;
+
+static struct tsetattr_variant {
+	int (*child_variant)(struct mount_attr *attr);
+	char *desc;
+} tvariants[] = {
+#if (__NR_mount_setattr != __LTP__NR_INVALID_SYSCALL)
+	{ .child_variant = &open_tree_variant1, "mount_setattr()" },
+#endif
+#if (__NR_open_tree_attr != __LTP__NR_INVALID_SYSCALL)
+	{ .child_variant = &open_tree_variant2, "open_tree_attr()"},
+#endif
+};
 
 static struct tcase {
 	char *name;
@@ -66,39 +85,62 @@ static void cleanup(void)
 static void setup(void)
 {
 	fsopen_supported_by_kernel();
-	struct stat st = {0};
 
-	if (stat(OT_MNTPOINT, &st) == -1)
+	if (access(OT_MNTPOINT, F_OK) != 0)
 		SAFE_MKDIR(OT_MNTPOINT, 0777);
 }
 
+static int open_tree_variant1(struct mount_attr *attr)
+{
+	tst_res(TINFO, "Using variant open_tree() + mount_setattr()");
+
+	otfd = TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT,
+			AT_EMPTY_PATH | OPEN_TREE_CLONE));
+	if (otfd == -1)
+		return -1;
+
+	TST_EXP_PASS(mount_setattr(otfd, "", AT_EMPTY_PATH,
+			attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		SAFE_CLOSE(otfd);
+		return -1;
+	}
+
+	return otfd;
+}
+
+static int open_tree_variant2(struct mount_attr *attr)
+{
+	otfd = TST_EXP_FD(open_tree_attr(AT_FDCWD, MNTPOINT,
+			AT_EMPTY_PATH | OPEN_TREE_CLONE,
+			attr, sizeof(*attr)));
+
+	return otfd;
+}
+
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	struct mount_attr attr = {
-		.attr_set = tc->mount_attrs,
-	};
+	struct tsetattr_variant *tv = &tvariants[tst_variant];
 	struct statvfs buf;
 
-	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
-		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
-	if (!TST_PASS)
-		return;
+	tst_res(TINFO, "Using variant %s", tv->desc);
 
-	otfd = (int)TST_RET;
+	memset(attr, 0, sizeof(*attr));
+	attr->attr_set = tc->mount_attrs;
 
-	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
-		"%s set", tc->name);
-	if (!TST_PASS)
-		goto out1;
+	otfd = tv->child_variant(attr);
+	if (otfd == -1)
+		goto out2;
 
 	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
 	if (!TST_PASS)
 		goto out1;
+
 	mount_flag = 1;
 	SAFE_CLOSE(otfd);
 
-	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
+	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs success");
 	if (!TST_PASS)
 		goto out2;
 
@@ -123,9 +165,14 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.test_variants = ARRAY_SIZE(tvariants),
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.skip_filesystems = (const char *const []){"fuse", NULL},
+	.skip_filesystems = (const char *const []) {"fuse", NULL},
+	.bufs = (struct tst_buffers []) {
+		{&attr, .size = sizeof(struct mount_attr)},
+		{}
+	}
 };

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
