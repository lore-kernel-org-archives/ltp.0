Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD8BC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 12:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 918823CFD7D
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 14:32:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 459DB3CDCA9
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 14:31:45 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7FEFF60B2EA
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 14:31:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D126E37747;
 Fri, 19 Apr 2024 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713529902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=toY7er1He5+3aawJNzuBeoTBNvCR4GgNk1ULFgJMePI=;
 b=g0oH+Ldpuus00f/X9CdHO4SFHBTbaThxZVMo5B72WJnHKZceMBYQErKitJNtIiDgvRy5Wm
 awtoN4KV0PMEs2PwMTjBuBU4wKT51Jduy29rXfLn2dcvLdkrQNTn7WvmYTCol5GQ1TLXRr
 TjQtaJIkH2SkMAeOzFg/aD5bU6yjd5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713529902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=toY7er1He5+3aawJNzuBeoTBNvCR4GgNk1ULFgJMePI=;
 b=DUbG+f5cIQOds7p4OhujiputjCWWpkDP96ii3b3/oLEu0DEFexsR5gUzF9hMW2k/dbZRoL
 FKCXulbsMP4x8bCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713529902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=toY7er1He5+3aawJNzuBeoTBNvCR4GgNk1ULFgJMePI=;
 b=g0oH+Ldpuus00f/X9CdHO4SFHBTbaThxZVMo5B72WJnHKZceMBYQErKitJNtIiDgvRy5Wm
 awtoN4KV0PMEs2PwMTjBuBU4wKT51Jduy29rXfLn2dcvLdkrQNTn7WvmYTCol5GQ1TLXRr
 TjQtaJIkH2SkMAeOzFg/aD5bU6yjd5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713529902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=toY7er1He5+3aawJNzuBeoTBNvCR4GgNk1ULFgJMePI=;
 b=DUbG+f5cIQOds7p4OhujiputjCWWpkDP96ii3b3/oLEu0DEFexsR5gUzF9hMW2k/dbZRoL
 FKCXulbsMP4x8bCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABDC513687;
 Fri, 19 Apr 2024 12:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id td/xJy5kImbSQQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Apr 2024 12:31:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 14:31:37 +0200
Message-Id: <20240419123137.6731-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add lstat03 test
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
lstat() provides the right information, according with device, access
time, block size, ownership, etc.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changed algorithm into multiple test cases checking for specific information
in `struct stat`

 runtest/syscalls                           |   4 +-
 testcases/kernel/syscalls/lstat/.gitignore |   2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 204 +++++++++++++++++++++
 3 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/lstat/lstat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 010a1a752..3e46bc2aa 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -721,12 +721,12 @@ lseek02 lseek02
 lseek07 lseek07
 lseek11 lseek11
 
-lstat01A symlink01 -T lstat01
-lstat01A_64 symlink01 -T lstat01_64
 lstat01 lstat01
 lstat01_64 lstat01_64
 lstat02 lstat02
 lstat02_64 lstat02_64
+lstat03 lstat03
+lstat03_64 lstat03_64
 
 mallinfo02 mallinfo02
 
diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
index a497a445f..72cba871f 100644
--- a/testcases/kernel/syscalls/lstat/.gitignore
+++ b/testcases/kernel/syscalls/lstat/.gitignore
@@ -2,3 +2,5 @@
 /lstat01_64
 /lstat02
 /lstat02_64
+/lstat03
+/lstat03_64
diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
new file mode 100644
index 000000000..af852169f
--- /dev/null
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner, Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that lstat() provides correct information according
+ * with device, access time, block size, ownership, etc.
+ * The implementation provides a set of tests which are specific for each one
+ * of the `struct stat` used to read file and symlink information.
+ */
+
+#include "tst_test.h"
+
+#define MNTPOINT "mntpoint"
+
+static void test_dev(void)
+{
+	char *filename = "file_dev";
+	char *symname = MNTPOINT"/sym_dev";
+
+	tst_res(TINFO, "Test symlink device");
+
+	SAFE_TOUCH(filename, 0777, NULL);
+	SAFE_SYMLINK(filename, symname);
+
+	struct stat path;
+	struct stat link;
+
+	TST_EXP_PASS(lstat(filename, &path));
+	TST_EXP_PASS(lstat(symname, &link));
+
+	TST_EXP_EXPR(path.st_dev != link.st_dev, "path.st_dev != link.st_dev");
+	TST_EXP_EXPR(path.st_ino != link.st_ino, "path.st_ino != link.st_ino");
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_nlink(void)
+{
+	char *filename = "file_nlink";
+	char *symname = "sym_nlink";
+
+	tst_res(TINFO, "Test symlink hard link");
+
+	SAFE_TOUCH(filename, 0777, NULL);
+	SAFE_SYMLINK(filename, symname);
+
+	struct stat path;
+	struct stat link;
+
+	TST_EXP_PASS(lstat(filename, &path));
+	TST_EXP_PASS(lstat(symname, &link));
+
+	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_ownership(void)
+{
+	char *filename = "file_all";
+	char *symname = "sym_ownership";
+
+	tst_res(TINFO, "Test symlink ownership");
+
+	SAFE_TOUCH(filename, 0777, NULL);
+	SAFE_SYMLINK(filename, symname);
+
+	SAFE_CHOWN(symname, 1000, 1000);
+
+	struct stat path;
+	struct stat link;
+
+	TST_EXP_PASS(lstat(filename, &path));
+	TST_EXP_PASS(lstat(symname, &link));
+
+	TST_EXP_EXPR(path.st_uid != link.st_uid, "path.st_uid != link.st_uid");
+	TST_EXP_EXPR(path.st_gid != link.st_gid, "path.st_gid != link.st_gid");
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_filesize(void)
+{
+	char *filename = "file_size";
+	char *symname = "sym_size";
+	int fd;
+
+	tst_res(TINFO, "Test symlink filesize");
+
+	SAFE_TOUCH(filename, 0777, NULL);
+
+	fd = SAFE_OPEN(filename, O_WRONLY, 0777);
+	tst_fill_fd(fd, 'a', TST_KB, 500);
+	SAFE_CLOSE(fd);
+
+	SAFE_SYMLINK(filename, symname);
+
+	struct stat path;
+	struct stat link;
+
+	TST_EXP_PASS(lstat(filename, &path));
+	TST_EXP_PASS(lstat(symname, &link));
+
+	TST_EXP_EXPR(path.st_size != link.st_size, "path.st_size != link.st_size");
+	TST_EXP_EXPR(path.st_blocks != link.st_blocks, "path.st_blocks != link.st_blocks");
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_blksize(void)
+{
+	char *filename = "file_blksize";
+	char *symname = MNTPOINT"/sym_blksize";
+
+	tst_res(TINFO, "Test symlink blksize");
+
+	SAFE_TOUCH(filename, 0777, NULL);
+	SAFE_SYMLINK(filename, symname);
+
+	struct stat path;
+	struct stat link;
+
+	TST_EXP_PASS(lstat(filename, &path));
+	TST_EXP_PASS(lstat(symname, &link));
+
+	TST_EXP_EXPR(path.st_blksize != link.st_blksize, "path.st_blksize != link.st_blksize");
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_timestamp(void)
+{
+	char *filename = "file_timestamp";
+	char *symname = "sym_timestamp";
+
+	tst_res(TINFO, "Test symlink timestamp");
+
+	SAFE_TOUCH(filename, 0777, NULL);
+
+	/* we wait a bit before creating symlink in order to obtain
+	 * different timestamp values
+	 */
+	sleep(1);
+	SAFE_SYMLINK(filename, symname);
+
+	struct stat path;
+	struct stat link;
+
+	TST_EXP_PASS(lstat(filename, &path));
+	TST_EXP_PASS(lstat(symname, &link));
+
+	TST_EXP_EXPR(path.st_atime != link.st_atime, "path.st_atime != link.st_atime");
+	TST_EXP_EXPR(path.st_mtime != link.st_mtime, "path.st_mtime != link.st_mtime");
+	TST_EXP_EXPR(path.st_ctime != link.st_ctime, "path.st_ctime != link.st_ctime");
+
+	SAFE_UNLINK(symname);
+}
+
+static void run(void)
+{
+	test_dev();
+	test_nlink();
+	test_ownership();
+	test_filesize();
+	test_blksize();
+	test_timestamp();
+}
+
+static void setup(void)
+{
+	char opt_bsize[32];
+	const char *const fs_opts[] = {opt_bsize, NULL};
+	struct stat sb;
+	int pagesize;
+
+	SAFE_STAT(".", &sb);
+	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
+
+	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
+}
+
+static void cleanup(void)
+{
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
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
