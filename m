Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0487C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 10:52:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 078F13CDEA0
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 11:52:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F02023C08CF
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 11:52:36 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BDC491402F96
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 11:52:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3286A1F7F9;
 Fri,  9 Feb 2024 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707475954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y7LjbEBHV7RPeK9DdZj8D0s5D6piQ5yiv6py3tPCAOg=;
 b=rrCoG8uqgHo/8EFmoYJYu6/tmxk3tmXKfQ7xgrbQHzZvRcGHy5huc53lrmFP02lQAp/sXN
 taEQtJ3BhB4FnEn9qE0yF6qNB719VAGtyDjyk7CDadhwjCJOujglVGa+bSB6TfVgrOPqQh
 4ijGdAG0rJ9GNjxKLBYKKcBydUsNfAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707475954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y7LjbEBHV7RPeK9DdZj8D0s5D6piQ5yiv6py3tPCAOg=;
 b=tPt9m1idLdN3FLspOr4lqEHVJhYwXm9JtbFmB/2gfFsanL9StBmqCagKoS/U3vTyJfBf3j
 wC7IS/fV7mYQK8Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707475952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y7LjbEBHV7RPeK9DdZj8D0s5D6piQ5yiv6py3tPCAOg=;
 b=vB89EmY3dMQGwOhh++ZXRIbk+YDiCAD+nu6TIMcVFn/QbsY0eWFrgq1KOle5Gqi9wu2Ra5
 pKaAfewm3PP/CQ3f05MNq0CRl/w+iDD14OIU5tlM6Ooec4Q3KAcSwabETI/HaPLVpPz0a6
 zjmfwogEJYkktv1ErkCHLRD6i14XV5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707475952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y7LjbEBHV7RPeK9DdZj8D0s5D6piQ5yiv6py3tPCAOg=;
 b=YANhsLECsEA+7qjAeMmdcW1wgbhP1T6gNHqdYvpKswRJD/Hd9z1vbN4bRGRLe7e4T/Yfaf
 UVuOGRTc+5OpgSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F21D81326D;
 Fri,  9 Feb 2024 10:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XqhWOO8DxmUSLAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 09 Feb 2024 10:52:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  9 Feb 2024 11:52:30 +0100
Message-Id: <20240209105230.28260-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vB89EmY3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YANhsLEC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.cz:email,wipro.com:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 3286A1F7F9
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactor mount02 test using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mount/mount02.c | 242 ++++++++--------------
 1 file changed, 84 insertions(+), 158 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index 392b4fd3a..d7d0d0063 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -1,212 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *  AUTHOR: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *               Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * Check for basic errors returned by mount(2) system call.
  *
+ * - ENODEV if filesystem type not configured
+ * - ENOTBLK if specialfile is not a block device
+ * - EBUSY if specialfile is already mounted or it  cannot  be remounted
+ *   read-only, because it still holds files open for writing.
+ * - EINVAL if specialfile or device is invalid or a remount was attempted,
+ *   while source was not already mounted on target.
+ * - EFAULT if special file or device file points to invalid address space.
+ * - ENAMETOOLONG if pathname was longer than MAXPATHLEN.
+ * - ENOENT if pathname was empty or has a nonexistent component.
+ * - ENOTDIR if not a directory.
  */
 
-/*
-
-   DESCRIPTION
-	Check for basic errors returned by mount(2) system call.
-
-	Verify that mount(2) returns -1 and sets errno to
-	1) ENODEV if filesystem type not configured
-	2) ENOTBLK if specialfile is not a block device
-	3) EBUSY if specialfile is already mounted or
-		it  cannot  be remounted read-only, because it still holds
-		files open for writing.
-	4) EINVAL if specialfile or device is invalid or
-		 a remount was attempted, while source was not already
-		 mounted on target.
-	5) EFAULT if specialfile or device file points to invalid address space.
-	6) ENAMETOOLONG if pathname was longer than MAXPATHLEN.
-	7) ENOENT if pathname was empty or has a nonexistent component.
-	8) ENOTDIR if not a directory.
-*/
-
-#include <errno.h>
+#include "tst_test.h"
 #include <sys/mount.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/sysmacros.h>
-#include <fcntl.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
 
-char *TCID = "mount02";
-
-#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
-#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
+#define MNTPOINT "mntpoint"
 
 static char path[PATH_MAX + 2];
 static const char *long_path = path;
+static const char *device;
 static const char *fs_type;
+static const char *null;
 static const char *wrong_fs_type = "error";
-static const char *mntpoint = "mntpoint";
-static const char *device;
-static const char *null = NULL;
-static const char *fault = (void*)-1;
+static const char *mntpoint = MNTPOINT;
+static const char *fault = (void *)-1;
 static const char *nonexistent = "nonexistent";
 static const char *char_dev = "char_device";
 static const char *file = "filename";
 static int fd;
 
-static void do_umount(void);
-static void close_umount(void);
-static void do_mount(void);
-static void mount_open(void);
+static void pre_mount(void);
+static void post_umount(void);
+static void pre_create_file(void);
+static void post_delete_file(void);
 
 static struct test_case {
 	const char **device;
 	const char **mntpoint;
 	const char **fs_type;
+	const char *fs_str;
 	unsigned long flag;
 	int exp_errno;
 	void (*setup)(void);
 	void (*cleanup)(void);
-} tc[] = {
-	{&device, &mntpoint, &wrong_fs_type, 0, ENODEV, NULL, NULL},
-	{&char_dev, &mntpoint, &fs_type, 0, ENOTBLK, NULL, NULL},
-	{&device, &mntpoint, &fs_type, 0, EBUSY, do_mount, do_umount},
-	{&device, &mntpoint, &fs_type, MS_REMOUNT | MS_RDONLY, EBUSY,
-	 mount_open, close_umount},
-	{&null, &mntpoint, &fs_type, 0, EINVAL, NULL, NULL},
-	{&device, &mntpoint, &null, 0, EINVAL, NULL, NULL},
-	{&device, &mntpoint, &fs_type, MS_REMOUNT, EINVAL, NULL, NULL},
-	{&fault, &mntpoint, &fs_type, 0, EFAULT, NULL, NULL},
-	{&device, &mntpoint, &fault, 0, EFAULT, NULL, NULL},
-	{&device, &long_path, &fs_type, 0, ENAMETOOLONG, NULL, NULL},
-	{&device, &nonexistent, &fs_type, 0, ENOENT, NULL, NULL},
-	{&device, &file, &fs_type, 0, ENOTDIR, NULL, NULL},
+} test_cases[] = {
+	{&device, &mntpoint, &wrong_fs_type, "wrong FS type", 0, ENODEV, NULL, NULL},
+	{&char_dev, &mntpoint, &fs_type, "char device", 0, ENOTBLK, NULL, NULL},
+	{&device, &mntpoint, &fs_type, "mounted folder", 0, EBUSY, pre_mount, post_umount},
+	{&device, &mntpoint, &fs_type, "mounted folder containing file", MS_REMOUNT | MS_RDONLY, EBUSY, pre_create_file, post_delete_file},
+	{&null, &mntpoint, &fs_type, "invalid device", 0, EINVAL, NULL, NULL},
+	{&device, &mntpoint, &null, "invalid device type", 0, EINVAL, NULL, NULL},
+	{&device, &mntpoint, &fs_type, "mounted folder", MS_REMOUNT, EINVAL, NULL, NULL},
+	{&fault, &mntpoint, &fs_type, "fault device", 0, EFAULT, NULL, NULL},
+	{&device, &mntpoint, &fault, "fault device type", 0, EFAULT, NULL, NULL},
+	{&device, &long_path, &fs_type, "long name", 0, ENAMETOOLONG, NULL, NULL},
+	{&device, &nonexistent, &fs_type, "non existant folder", 0, ENOENT, NULL, NULL},
+	{&device, &file, &fs_type, "file", 0, ENOTDIR, NULL, NULL},
 };
 
-int TST_TOTAL = ARRAY_SIZE(tc);
-
-static void verify_mount(struct test_case *tc)
+static void pre_mount(void)
 {
-	if (tc->setup)
-		tc->setup();
-
-	TEST(mount(*tc->device, *tc->mntpoint, *tc->fs_type, tc->flag, NULL));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "mount() succeded unexpectedly (ret=%li)",
-		         TEST_RETURN);
-		goto cleanup;
-	}
-
-	if (TEST_ERRNO != tc->exp_errno) {
-		tst_resm(TFAIL | TTERRNO,
-		         "mount() was expected to fail with %s(%i)",
-		         tst_strerrno(tc->exp_errno), tc->exp_errno);
-		goto cleanup;
-	}
-
-	tst_resm(TPASS | TTERRNO, "mount() failed expectedly");
-
-cleanup:
-	if (tc->cleanup)
-		tc->cleanup();
+	SAFE_MOUNT(device, mntpoint, fs_type, 0, NULL);
 }
 
-int main(int ac, char **av)
+static void post_umount(void)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i)
-			verify_mount(tc + i);
-	}
-
-	cleanup();
-	tst_exit();
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
 }
 
-static void do_mount(void)
+static void pre_create_file(void)
 {
-	if (mount(device, mntpoint, fs_type, 0, NULL))
-		tst_brkm(TBROK | TERRNO, cleanup, "Failed to mount(mntpoint)");
+	pre_mount();
+	fd = SAFE_OPEN("mntpoint/file", O_CREAT | O_RDWR, 0700);
 }
 
-static void mount_open(void)
+static void post_delete_file(void)
 {
-	do_mount();
-
-	fd = SAFE_OPEN(cleanup, "mntpoint/file", O_CREAT | O_RDWR, S_IRWXU);
+	SAFE_CLOSE(fd);
+	post_umount();
 }
 
-static void close_umount(void)
+static void setup(void)
 {
-	SAFE_CLOSE(cleanup, fd);
-	do_umount();
+	device = tst_device->dev;
+	fs_type = tst_device->fs_type;
+
+	memset(path, 'a', PATH_MAX + 1);
+
+	SAFE_MKNOD(char_dev, S_IFCHR | 0777, 0);
+	SAFE_TOUCH(file, 0777, 0);
 }
 
-static void do_umount(void)
+static void cleanup(void)
 {
-	if (tst_umount(mntpoint))
-		tst_brkm(TBROK | TERRNO, cleanup, "Failed to umount(mntpoint)");
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
 }
 
-static void setup(void)
+static void run(unsigned int i)
 {
-	dev_t dev;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	SAFE_TOUCH(cleanup, file, FILE_MODE, NULL);
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	struct test_case *tc = &test_cases[i];
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
-
-	memset(path, 'a', PATH_MAX + 1);
+	if (tc->setup)
+		tc->setup();
 
-	dev = makedev(1, 3);
-	if (mknod(char_dev, S_IFCHR | FILE_MODE, dev)) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to mknod(char_dev, S_IFCHR | FILE_MODE, %lu)",
-			 dev);
-	}
+	TST_EXP_FAIL(mount(*tc->device, *tc->mntpoint, *tc->fs_type, tc->flag, NULL),
+		tc->exp_errno,
+		"mounting %s",
+		tc->fs_str);
 
-	TEST_PAUSE;
+	if (tc->cleanup)
+		tc->cleanup();
 }
 
-static void cleanup(void)
-{
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.format_device = 1,
+	.mntpoint = MNTPOINT,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
