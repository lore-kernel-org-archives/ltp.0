Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC1AC30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BAAD3D3ED7
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 16:14:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 265693D0F6E
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:17 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A0CD600D23
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E12C621B35;
 Tue,  2 Jul 2024 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxGIOTjfgranbi7OPz+BNSoi416zFnO1MmmSbqLAyuo=;
 b=MFa45ff0tTRUrPdO1xXalkQeWFQMTebKlH3Dc/E456kFXHz/B0iQklQMMwpZZkCIJlZamO
 rgisgXcZfGeXejkYN897tRkEhAgkh+iqa/U1gDm3CuhA6D57qJF+Ps+DDHnMayDRTyMp0X
 00EjYY/jo/3kKKZZzyl6DA4vjtTgEz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxGIOTjfgranbi7OPz+BNSoi416zFnO1MmmSbqLAyuo=;
 b=NwGA6vLJ36scMKThu6mZp915gEZbxbdx8Atd0C6Lo1yojj2SRmuCWpZZq2hYch+Ox5DXSJ
 +ivUclZNpn3XerBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GuNKtWEQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qP6gp6Zl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxGIOTjfgranbi7OPz+BNSoi416zFnO1MmmSbqLAyuo=;
 b=GuNKtWEQ0sDrMtSypO6q5y2gU/2Fj64gjYNgr6UdNjobixk2IzGlyctE+IBUaTkhUNBMzh
 u9cr2aU1GYaY5lHnM9Go5O4CXdqVqk18XnMitFHRjnOSp42kBetmsbUYZDRFgmLqDGyKWZ
 5j9TWI+ilSyHr3WnIL8JxspbXWrNrnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxGIOTjfgranbi7OPz+BNSoi416zFnO1MmmSbqLAyuo=;
 b=qP6gp6Zl0UOs55YZmo6yqbodpG+W7OfJ+ImfwhdQ4vNVE2sr/gty3Q2UQOfNCPgXepPRbE
 MjmW67ySiBSwD0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E14513A9A;
 Tue,  2 Jul 2024 14:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wKRhG/oKhGbpDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 14:13:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 16:12:47 +0200
MIME-Version: 1.0
Message-Id: <20240702-stat04-v1-1-e27d9953210d@suse.com>
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
In-Reply-To: <20240702-stat04-v1-0-e27d9953210d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5111;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=ifalrRp01ciiUbE3cFDBK+rcFVgB1kxSQPxX9REuQ4Y=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmhArvLWRE442iOsSOuBZMZzQSY3YD28rf56OLG
 K5kzA2WKcCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoQK7wAKCRDLzBqyILPm
 RsdSC/9rbAUoz8DhdLSE4amzEgbqU7Mgczl0jEbS7kfBWKnRcCaLh6MDHYuzeHontlb5qCVfZcg
 P3tlUk3T0Bla6dgQmc8UrzsafCDEZesdsovNB/qXRp7GESl8GXeGKAn5e0LE0SMe+EhpEagi8/0
 jNvE0LBxuIqEgBDzI4bQ/rYSTMKMnniOVyRsKjvExbjJ9twZzTKFwvRqiAVvehC7/iBMWr9f4Nh
 9rXYDY69ZUjIkSSbjRxenM7sYyslA8G7ho/UjkowAdYBsj5wRWGmDqg5Pts85VB4xonsr41Av9T
 WjzVnAbadcXKKLhMvbZ9DmY5F33jsBzF5kaSvj1c0dScQmmnxAjTqSZB57IxTUwhiCABwqz7Pna
 61Y96CkbLg6caT9aOhoQxmc/znSNjTyVADFgdmeAOFwuWvYohIJ/znLRxJjgapxyd761RVpmG0O
 pGFDuSjw3wBFFUpkZ5CWbPOBqj7XDFZ3W7pxhB1+efaut9H+EIsUj+a8h5HoxgmZhRyZA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E12C621B35
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] Add stat04 test
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

This test has been extracted from symlink01 test and it checks that
stat() executed on file provide the same information of symlink linking
to it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/smoketest                         |   4 +-
 runtest/syscalls                          |   4 +-
 testcases/kernel/syscalls/stat/.gitignore |   2 +
 testcases/kernel/syscalls/stat/stat04.c   | 121 ++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/runtest/smoketest b/runtest/smoketest
index f6f14fd2b..5608417f9 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -8,8 +8,8 @@ time01 time01
 wait02 wait02
 write01 write01
 symlink01 symlink01
-stat04 symlink01 -T stat04
-utime07 utime07
+stat04 stat04
+utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 df01_sh df01.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index 44a577db3..3e7a5ca1b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1535,8 +1535,8 @@ stat02 stat02
 stat02_64 stat02_64
 stat03 stat03
 stat03_64 stat03_64
-stat04 symlink01 -T stat04
-stat04_64 symlink01 -T stat04_64
+stat04 stat04
+stat04_64 stat04_64
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
index fa0a4ce9f..0a62dc6ee 100644
--- a/testcases/kernel/syscalls/stat/.gitignore
+++ b/testcases/kernel/syscalls/stat/.gitignore
@@ -4,3 +4,5 @@
 /stat02_64
 /stat03
 /stat03_64
+/stat04
+/stat04_64
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
new file mode 100644
index 000000000..ee635dbd9
--- /dev/null
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner, Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test checks that stat() executed on file provide the same information
+ * of symlink linking to it.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define FILENAME "file.txt"
+#define MNTPOINT "mntpoint"
+#define SYMBNAME MNTPOINT"/file_symlink"
+
+static struct stat *file_stat;
+static struct stat *symb_stat;
+static char *tmpdir;
+
+static void run(void)
+{
+	TST_EXP_EQ_LI(file_stat->st_dev, symb_stat->st_dev);
+	TST_EXP_EQ_LI(file_stat->st_mode, symb_stat->st_mode);
+	TST_EXP_EQ_LI(file_stat->st_nlink, symb_stat->st_nlink);
+	TST_EXP_EQ_LI(file_stat->st_uid, symb_stat->st_uid);
+	TST_EXP_EQ_LI(file_stat->st_gid, symb_stat->st_gid);
+	TST_EXP_EQ_LI(file_stat->st_size, symb_stat->st_size);
+	TST_EXP_EQ_LI(file_stat->st_atime, symb_stat->st_atime);
+	TST_EXP_EQ_LI(file_stat->st_mtime, symb_stat->st_mtime);
+	TST_EXP_EQ_LI(file_stat->st_ctime, symb_stat->st_ctime);
+}
+
+static void setup(void)
+{
+	char opt_bsize[32];
+	char symb_path[PATH_MAX];
+	char file_path[PATH_MAX];
+	const char *const fs_opts[] = {opt_bsize, NULL};
+	struct stat sb;
+	int pagesize;
+	int fd;
+
+	tmpdir = tst_get_tmpdir();
+
+	if (strlen(tmpdir) >= (PATH_MAX - strlen(FILENAME))) {
+		tst_brk(TCONF, "Temporary folder name is too long. "
+			"Can't create file");
+	}
+
+	if (strlen(tmpdir) >= (PATH_MAX - strlen(SYMBNAME))) {
+		tst_brk(TCONF, "Temporary folder name is too long. "
+			"Can't create symbolic link");
+	}
+
+	/* change st_blksize / st_dev */
+	SAFE_STAT(".", &sb);
+	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
+
+	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
+
+	SAFE_TOUCH(FILENAME, 0777, NULL);
+
+	/* change st_nlink */
+	SAFE_LINK(FILENAME, "linked_file");
+
+	/* change st_uid and st_gid */
+	SAFE_CHOWN(FILENAME, 1000, 1000);
+
+	/* change st_size */
+	fd = SAFE_OPEN(FILENAME, O_WRONLY, 0777);
+	tst_fill_fd(fd, 'a', TST_KB, 500);
+	SAFE_CLOSE(fd);
+
+	/* change st_atime / st_mtime / st_ctime */
+	sleep(1);
+
+	memset(file_path, 0, PATH_MAX);
+	snprintf(file_path, PATH_MAX, "%s/%s", tmpdir, FILENAME);
+
+	memset(symb_path, 0, PATH_MAX);
+	snprintf(symb_path, PATH_MAX, "%s/%s", tmpdir, SYMBNAME);
+
+	SAFE_SYMLINK(file_path, symb_path);
+
+	SAFE_STAT(file_path, file_stat);
+	SAFE_STAT(symb_path, symb_stat);
+}
+
+static void cleanup(void)
+{
+	free(tmpdir);
+
+	SAFE_UNLINK(SYMBNAME);
+
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_device = 1,
+	.mntpoint = MNTPOINT,
+	.dev_fs_type = "ext2",
+	.bufs = (struct tst_buffers []) {
+		{&file_stat, .size = sizeof(struct stat)},
+		{&symb_stat, .size = sizeof(struct stat)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
