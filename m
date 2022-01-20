Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BEBC433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 09:51:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E9273C96AD
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 10:50:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 256623C960F
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 10:50:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 554941A00E17
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 10:50:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A70F218E0
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642672245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sQGN3qLA4VzQADxegsrrzFuJh1fQFZm1kExWrs5wnbI=;
 b=dPdEHji55AMD33WjvFTo/nOfFCYCeymrqbHuXPtAxRrg8vz54YwFa4XRsZ/4SJCh71BVEL
 uMDlP3t/KP0FMPNuwu6/PJJnwKO392ys37aUcviJoQISgEyaMFruFFp4C/OkTSu/Jxtnih
 OyiRFsBOagem5X+IO2e1YEueC/qDIUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642672245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sQGN3qLA4VzQADxegsrrzFuJh1fQFZm1kExWrs5wnbI=;
 b=S+D2NwdM/wWddX2zQK7saDdFlicoXlRUbD9j/kOi8QtEGva5HmCgKldepza0tcVB81NwKC
 rSOsKzvmr5C4sBDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2374B13D27
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 09:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2AccB3Uw6WH8FAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 09:50:45 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jan 2022 10:50:44 +0100
Message-Id: <20220120095044.19789-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Rewrite statx04 test
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

statx04 is supposed verify that inode attribute support in statx() matches
what should actually be implemented. However, we already have functional tests
for this in statx08 and lack a test of the stx_attribute_mask field which
reports inode attribute support to userspace.

Rewrite the test to drop the duplicate code and add the missing coverage.

Also disable FUSE filesystems because they return wrong errno codes
in the ioctl() check and NTFS3g now has some rudimentary support for inode
attributes but no support for them in statx().

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- changed copyright header to SUSE since this is a near-complete rewrite

Changes since v2:
- removed strict mode, will be redesigned and added later
- fixed compiler warnings
- simplified test using TST_EXP_PASS_SILENT()

This also fixes Btrfs failures on kernels v4.11 and v4.12 where the attributes
are not supported at all. LTP is supposed to check for bugs, not force people
to backport features from newer kernels.

 testcases/kernel/syscalls/statx/statx04.c | 185 ++++++----------------
 1 file changed, 51 insertions(+), 134 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index a3ca436f5..083298310 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
- * Email: code@zilogic.com
+ * Copyright (c) 2022 SUSE LLC <mdoucha@suse.cz>
  */
 
 /*\
  * [Description]
  *
- * This code tests if the attributes field of statx received expected value.
- * File set with following flags by using SAFE_IOCTL:
+ * Test whether the kernel properly advertises support for statx() attributes:
  *
  * - STATX_ATTR_COMPRESSED: The file is compressed by the filesystem.
  * - STATX_ATTR_IMMUTABLE: The file cannot be modified.
@@ -16,9 +14,6 @@
  * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
  *                        program such as dump(8) is run.
  *
- * Two directories are tested.
- * First directory has all flags set. Second directory has no flags set.
- *
  * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
  * three other flags.
  *
@@ -56,160 +51,82 @@
 #include "lapi/stat.h"
 
 #define MOUNT_POINT "mntpoint"
-#define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
-#define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
-
-static int fd, clear_flags;
-
-static void test_flagged(void)
-{
-	struct statx buf;
-
-	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
-	if (TST_RET == 0)
-		tst_res(TPASS,
-			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
-	else
-		tst_brk(TFAIL | TTERRNO,
-			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
-
-	if (strcmp(tst_device->fs_type, "xfs")) {
-		if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
-			tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
-		else
-			tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is not set");
-	}
-
-	if (buf.stx_attributes & STATX_ATTR_APPEND)
-		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_APPEND flag is not set");
-
-	if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
-		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is not set");
-
-	if (buf.stx_attributes & STATX_ATTR_NODUMP)
-		tst_res(TPASS, "STATX_ATTR_NODUMP flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is not set");
-}
-
-static void test_unflagged(void)
-{
-	struct statx buf;
-
-	TEST(statx(AT_FDCWD, TESTDIR_UNFLAGGED, 0, 0, &buf));
-	if (TST_RET == 0)
-		tst_res(TPASS,
-			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
-			TESTDIR_UNFLAGGED);
-	else
-		tst_brk(TFAIL | TTERRNO,
-			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
-			TESTDIR_UNFLAGGED);
-
-	if ((buf.stx_attributes & STATX_ATTR_COMPRESSED) == 0)
-		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is set");
-
-	if ((buf.stx_attributes & STATX_ATTR_APPEND) == 0)
-		tst_res(TPASS, "STATX_ATTR_APPEND flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_APPEND flag is set");
-
-	if ((buf.stx_attributes & STATX_ATTR_IMMUTABLE) == 0)
-		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is set");
-
-	if ((buf.stx_attributes & STATX_ATTR_NODUMP) == 0)
-		tst_res(TPASS, "STATX_ATTR_NODUMP flag is not set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is set");
-}
-
-static struct test_cases {
-	void (*tfunc)(void);
-} tcases[] = {
-	{&test_flagged},
-	{&test_unflagged},
+#define TESTDIR MOUNT_POINT "/testdir"
+
+#define ATTR(x) {.attr = x, .name = #x}
+
+static struct {
+	uint64_t attr;
+	const char *name;
+} attr_list[] = {
+	ATTR(STATX_ATTR_COMPRESSED),
+	ATTR(STATX_ATTR_APPEND),
+	ATTR(STATX_ATTR_IMMUTABLE),
+	ATTR(STATX_ATTR_NODUMP)
 };
 
-static void run(unsigned int i)
-{
-	tcases[i].tfunc();
-}
+static uint64_t expected_mask;
 
-static void caid_flags_setup(void)
+static void setup(void)
 {
-	int attr, ret;
+	size_t i;
+	int fd;
 
-	fd = SAFE_OPEN(TESTDIR_FLAGGED, O_RDONLY | O_DIRECTORY);
+	SAFE_MKDIR(TESTDIR, 0777);
 
-	ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
-	if (ret < 0) {
-		if (errno == ENOTTY)
-			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
+	/* Check general inode attribute support */
+	fd = SAFE_OPEN(TESTDIR, O_RDONLY | O_DIRECTORY);
+	TEST(ioctl(fd, FS_IOC_GETFLAGS, &i));
+	SAFE_CLOSE(fd);
 
-		/* ntfs3g fuse fs returns wrong errno for unimplemented ioctls */
-		if (!strcmp(tst_device->fs_type, "ntfs")) {
-			tst_brk(TCONF | TERRNO,
-				"ntfs3g does not support FS_IOC_GETFLAGS");
-		}
+	if (TST_RET == -1 && TST_ERR == ENOTTY)
+		tst_brk(TCONF | TTERRNO, "Inode attributes not supported");
 
-		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
-	}
+	if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "Unexpected ioctl() error");
 
+	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
+		expected_mask |= attr_list[i].attr;
+
+	/* STATX_ATTR_COMPRESSED not supported on XFS */
 	if (!strcmp(tst_device->fs_type, "xfs"))
-		attr |= FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
-	else
-		attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
-
-	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP)
-			tst_brk(TCONF, "Flags not supported");
-		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
-	}
+		expected_mask &= ~STATX_ATTR_COMPRESSED;
 
-	clear_flags = 1;
+	/* Attribute support was added to Btrfs statx() in kernel v4.13 */
+	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
+		tst_brk(TCONF, "statx() attributes not supported on Btrfs");
 }
 
-static void setup(void)
+static void run(void)
 {
-	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
-	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
+	size_t i;
+	struct statx buf;
 
-	caid_flags_setup();
-}
+	TST_EXP_PASS_SILENT(statx(AT_FDCWD, TESTDIR, 0, 0, &buf));
 
-static void cleanup(void)
-{
-	int attr;
+	for (i = 0; i < ARRAY_SIZE(attr_list); i++) {
+		if (!(expected_mask & attr_list[i].attr))
+			continue;
 
-	if (clear_flags) {
-		SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
-		attr &= ~(FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL);
-		SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
+		if (buf.stx_attributes_mask & attr_list[i].attr)
+			tst_res(TPASS, "%s is supported", attr_list[i].name);
+		else
+			tst_res(TFAIL, "%s not supported", attr_list[i].name);
 	}
-
-	if (fd > 0)
-		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
-	.test = run,
-	.tcnt = ARRAY_SIZE(tcases),
+	.test_all = run,
 	.setup = setup,
-	.cleanup = cleanup,
 	.needs_root = 1,
 	.all_filesystems = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_POINT,
 	.min_kver = "4.11",
+	.skip_filesystems = (const char *const[]) {
+		"fuse",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "93bc420ed41d"},
 		{"linux-git", "99652ea56a41"},
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
