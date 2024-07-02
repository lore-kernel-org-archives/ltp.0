Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B421EC3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 07:39:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F40D3D3EE8
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:39:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6086B3D3EB2
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:38:40 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4744160562B
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:38:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B09BC1FB8C;
 Tue,  2 Jul 2024 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719905916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh+MMOiHTzIj7LFr2zk+Wt2TQ5bbX3agnT/6S8wnzPk=;
 b=za+JCPGoagQgGZEiZGmzrXZWDT3/kaQEtx/WtRHcU/QbTAm23LyQWXibEhL0YvCwZZO3i6
 jK+MhAFaFmMK8EH4N5gMFle16eeAqPFf04jEqvYgb4LzGcjNgK/zO5xk50hGjMUBs3dLMd
 VIZjL4iZmezN08EoX5Kw3JtHw6+szkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719905916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh+MMOiHTzIj7LFr2zk+Wt2TQ5bbX3agnT/6S8wnzPk=;
 b=T8PH7GQ5VkkuPr3KooeUZLryyYqrudzaFObsPjf7VSLMgSm5zzNoA704UtkRD2C1ppFjVf
 ELBAc0C0qfG0yBBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=za+JCPGo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T8PH7GQ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719905916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh+MMOiHTzIj7LFr2zk+Wt2TQ5bbX3agnT/6S8wnzPk=;
 b=za+JCPGoagQgGZEiZGmzrXZWDT3/kaQEtx/WtRHcU/QbTAm23LyQWXibEhL0YvCwZZO3i6
 jK+MhAFaFmMK8EH4N5gMFle16eeAqPFf04jEqvYgb4LzGcjNgK/zO5xk50hGjMUBs3dLMd
 VIZjL4iZmezN08EoX5Kw3JtHw6+szkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719905916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh+MMOiHTzIj7LFr2zk+Wt2TQ5bbX3agnT/6S8wnzPk=;
 b=T8PH7GQ5VkkuPr3KooeUZLryyYqrudzaFObsPjf7VSLMgSm5zzNoA704UtkRD2C1ppFjVf
 ELBAc0C0qfG0yBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DEF113AAD;
 Tue,  2 Jul 2024 07:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4KW4IHyug2aUCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 07:38:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 09:38:17 +0200
MIME-Version: 1.0
Message-Id: <20240702-unlink09-v4-1-d8df24772a76@suse.com>
References: <20240702-unlink09-v4-0-d8df24772a76@suse.com>
In-Reply-To: <20240702-unlink09-v4-0-d8df24772a76@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5542;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=I4KjoW9W9z1r2g9c/vgqFo8b0+uhoLWl0LVuc9nYLq4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmg65zQ7dycP7Nm606zJ36/4q8DpKDfVld31C9s
 4imPPyYOtGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoOucwAKCRDLzBqyILPm
 RukNC/0fUbCrjwgdZHx9StreRv5vlIX3ZYspgvFfKecOIJXIhmELrOtsP8q0uHAqIcTxg33AvFp
 IlHCpRQUztfLHxCEwq8RdIluRN3dS/5+y1NSCbCLE6kCn1UxLVr6BHgCa0DL20Hzg7PZtEX/wdv
 HU6ZpOuzcFl4ijVGfPGWGdD7zMUSmARs5jxLwU+gVPWNAoCIxM6vCAzcoXzT+fAIqcHvQ4RxLcl
 pWF51kyssSufm3tkuFsqq2SKlAvt4Itz5TLlerS4Y44SMl8p1kiiQrFXZJM+Azlbv+LGeM5gW6U
 uBzYgf7ojDDl0+CJob+eCtwkp4dcQhor5irJCEX11en46IqePDgxiUXTOTRjq3TUFWnvzaf3O3H
 3YSH0N2/zyd+YSvoEau8LHeQd0YqlR/KDY4Ym/XpvFAxQW2wqC4I+TLhEEocLosGC7ue0g4SoXY
 TJ1C0S4OxscHM0Egkllk6QFh0hhVlRxEakEsnPJn9j8TOdW9+hDt7A+kUWY8H6XEABXp0=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B09BC1FB8C
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] Fix unlink09 test
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

This patch will fix unlink09 test by checking for filesystems which
are not supporting inode attributes. At the same time, it removes the
read-only filesystem unlink() check in order to add .all_filesystems
support.

Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/unlink/unlink09.c | 108 ++++++++++++++++------------
 1 file changed, 64 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index cc4b4a07e..5e438569f 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -2,92 +2,103 @@
 /*
  * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
  * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*\
  * [Description]
  *
- * Verify that unlink(2) fails with
- *
- * - EPERM when target file is marked as immutable or append-only
- * - EROFS when target file is on a read-only filesystem.
+ * Verify that unlink(2) fails with EPERM when target file is marked as
+ * immutable or append-only.
  */
 
 #include <sys/ioctl.h>
 #include "tst_test.h"
 #include "lapi/fs.h"
 
-#define TEST_EPERM_IMMUTABLE "test_eperm_immutable"
-#define TEST_EPERM_APPEND_ONLY "test_eperm_append_only"
-#define DIR_EROFS "erofs"
-#define TEST_EROFS "erofs/test_erofs"
+#define MNTPOINT "mnt"
+#define TEST_EPERM_IMMUTABLE MNTPOINT"/test_eperm_immutable"
+#define TEST_EPERM_APPEND_ONLY MNTPOINT"/test_eperm_append_only"
 
-static int fd_immutable;
-static int fd_append_only;
+static int fd_immutable = -1;
+static int fd_append_only = -1;
 
 static struct test_case_t {
 	char *filename;
 	int *fd;
 	int flag;
-	int expected_errno;
 	char *desc;
 } tcases[] = {
-	{TEST_EPERM_IMMUTABLE, &fd_immutable, FS_IMMUTABLE_FL, EPERM,
+	{TEST_EPERM_IMMUTABLE, &fd_immutable, FS_IMMUTABLE_FL,
 		"target file is immutable"},
-	{TEST_EPERM_APPEND_ONLY, &fd_append_only, FS_APPEND_FL, EPERM,
+	{TEST_EPERM_APPEND_ONLY, &fd_append_only, FS_APPEND_FL,
 		"target file is append-only"},
-	{TEST_EROFS, NULL, 0, EROFS, "target file in read-only filesystem"},
 };
 
+static void setup_inode_flag(const int fd, const int flag, const int reset)
+{
+	int attr;
+
+	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
+
+	if (reset)
+		attr &= ~flag;
+	else
+		attr |= flag;
+
+	SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
+}
+
 static void setup(void)
 {
 	int attr;
 
-	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
-	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	/* inode attributes in tmpfs are supported from kernel 6.0
+	 * https://lore.kernel.org/all/20220715015912.2560575-1-tytso@mit.edu/
+	 */
+	if (!strcmp(tst_device->fs_type, "tmpfs") && tst_kvercmp(6, 0, 0) < 0)
+		tst_brk(TCONF, "FS_IOC_GETFLAGS on tmpfs not supported for kernel<6.0");
+
+	fd_immutable = SAFE_CREAT(TEST_EPERM_IMMUTABLE, 0600);
+	TEST(ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr));
+
+	if (TST_RET == -1 && TST_ERR == ENOTTY) {
+		SAFE_CLOSE(fd_immutable);
+
+		tst_brk(TBROK, "Inode attributes not supported by '%s'",
+			tst_device->fs_type);
+	}
+
 	attr |= FS_IMMUTABLE_FL;
 	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
 
-	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
-	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
-	attr |= FS_APPEND_FL;
-	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
+	fd_append_only = SAFE_CREAT(TEST_EPERM_APPEND_ONLY, 0600);
+	setup_inode_flag(fd_append_only, FS_APPEND_FL, 0);
 }
 
 static void cleanup(void)
 {
-	int attr;
-
-	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
-	attr &= ~FS_IMMUTABLE_FL;
-	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
-	SAFE_CLOSE(fd_immutable);
+	if (fd_immutable != -1) {
+		setup_inode_flag(fd_immutable, FS_IMMUTABLE_FL, 1);
+		SAFE_CLOSE(fd_immutable);
+	}
 
-	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
-	attr &= ~FS_APPEND_FL;
-	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
-	SAFE_CLOSE(fd_append_only);
+	if (fd_append_only != -1) {
+		setup_inode_flag(fd_append_only, FS_APPEND_FL, 1);
+		SAFE_CLOSE(fd_append_only);
+	}
 }
 
 static void verify_unlink(unsigned int i)
 {
 	struct test_case_t *tc = &tcases[i];
-	int attr;
 
-	TST_EXP_FAIL(unlink(tc->filename), tc->expected_errno, "%s", tc->desc);
+	TST_EXP_FAIL(unlink(tc->filename), EPERM, "%s", tc->desc);
 
 	/* If unlink() succeeded unexpectedly, test file should be restored. */
 	if (!TST_RET) {
-		if (tc->fd) {
-			*(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
-			if (tc->flag) {
-				SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS, &attr);
-				attr |= tc->flag;
-				SAFE_IOCTL(*(tc->fd), FS_IOC_SETFLAGS, &attr);
-			}
-		} else {
-			SAFE_TOUCH(tc->filename, 0600, 0);
-		}
+		*(tc->fd) = SAFE_CREAT(tc->filename, 0600);
+		setup_inode_flag(*(tc->fd), tc->flag, 0);
 	}
 }
 
@@ -96,7 +107,16 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.cleanup = cleanup,
 	.test = verify_unlink,
-	.needs_rofs = 1,
-	.mntpoint = DIR_EROFS,
+	.mntpoint = MNTPOINT,
 	.needs_root = 1,
+	.format_device = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]) {
+		"fuse",
+		"exfat",
+		"vfat",
+		"ntfs",
+		NULL
+	},
 };

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
