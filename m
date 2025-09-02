Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8ACA1005
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 08:30:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8DCE3CD35B
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 10:30:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F2EE3CD386
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 10:29:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 64AE8600121
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 10:29:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 716121F456;
 Tue,  2 Sep 2025 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756801781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94dq3jP+/6kyjlnbWLvb95PWTPN3a0xKC21B4IjUuMc=;
 b=gnrlECw1pUNFtjFTF82YpSv8tw36DBivzhtTYRq7LPTSHZU34geO4A+XC/pEt01SiUBYjv
 eL/eXiGBq+AyKPlwJPY4rqewBoEVPec6VepwZyM9MMF9a3Jvr2qyZorTFvAL3VmZQojLx2
 gYuwkaB9rGUaI+V2Wya4oGCN1K999T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756801781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94dq3jP+/6kyjlnbWLvb95PWTPN3a0xKC21B4IjUuMc=;
 b=E7gGbvqivqFMZFGZaaHnKRHRmkb6QNiZCB6W95jFp4CAJSsiOL1aOvCIoo5k4QH6ePbZnx
 uUeNRkgwV9Fx/aDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gnrlECw1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E7gGbvqi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756801781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94dq3jP+/6kyjlnbWLvb95PWTPN3a0xKC21B4IjUuMc=;
 b=gnrlECw1pUNFtjFTF82YpSv8tw36DBivzhtTYRq7LPTSHZU34geO4A+XC/pEt01SiUBYjv
 eL/eXiGBq+AyKPlwJPY4rqewBoEVPec6VepwZyM9MMF9a3Jvr2qyZorTFvAL3VmZQojLx2
 gYuwkaB9rGUaI+V2Wya4oGCN1K999T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756801781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94dq3jP+/6kyjlnbWLvb95PWTPN3a0xKC21B4IjUuMc=;
 b=E7gGbvqivqFMZFGZaaHnKRHRmkb6QNiZCB6W95jFp4CAJSsiOL1aOvCIoo5k4QH6ePbZnx
 uUeNRkgwV9Fx/aDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2063B13A54;
 Tue,  2 Sep 2025 08:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8F60AfWqtmiDdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Sep 2025 08:29:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Sep 2025 10:29:37 +0200
MIME-Version: 1.0
Message-Id: <20250902-open_tree_attr-v2-2-b23d2585986d@suse.com>
References: <20250902-open_tree_attr-v2-0-b23d2585986d@suse.com>
In-Reply-To: <20250902-open_tree_attr-v2-0-b23d2585986d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756801779; l=4052;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=01CjQPgsZae/ft83emtWKPg766r2IVgeXwyhoY3LLwA=;
 b=xDawHKdibwOTqqnMhs/NThM8hpMe8SZsogreYMUso2KbzjMR7kw0s07N15y+yyQz0uaoNIS+a
 dYEo8R+F3BsBSDlY8tVrb+DKMaTR7ETB3HFesl4z0IlkKmmvUgLMWD7
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 716121F456
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] mount_setattr01: add open_tree_attr variant
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
 .../syscalls/mount_setattr/mount_setattr01.c       | 68 ++++++++++++++++------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
index eb32cd91a7fcb4cb303e184dd40d5e10a280874c..2e3fee5cdda905858f89b12a2b3b65255d46297d 100644
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
@@ -41,6 +43,7 @@
 	}
 
 static int mount_flag, otfd = -1;
+struct mount_attr *attr;
 
 static struct tcase {
 	char *name;
@@ -66,35 +69,61 @@ static void cleanup(void)
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
+	tst_res(TINFO, "Variant using open_tree() + mount_setattr()");
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
+	tst_res(TINFO, "Variant using open_tree_attr()");
+
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
 	struct statvfs buf;
 
-	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
-		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
-	if (!TST_PASS)
-		return;
+	memset(attr, 0, sizeof(*attr));
+	attr->attr_set = tc->mount_attrs;
 
-	otfd = (int)TST_RET;
+	if (tst_variant)
+		otfd = open_tree_variant1(attr);
+	else
+		otfd = open_tree_variant2(attr);
 
-	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
-		"%s set", tc->name);
-	if (!TST_PASS)
-		goto out1;
+	if (otfd == -1)
+		goto out2;
 
 	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
 	if (!TST_PASS)
 		goto out1;
+
 	mount_flag = 1;
 	SAFE_CLOSE(otfd);
 
@@ -123,9 +152,14 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.test_variants = 2,
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
