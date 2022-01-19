Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C611C433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 11:15:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED6153C9698
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 12:15:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35EB3C9685
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:15:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E515F60080D
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:15:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63A6D2177B
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642590934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SzDoiaXnmeu6h5wvdIghDIw1m8DIHTYMaAseqDYm0mw=;
 b=IdjcsWIzX745QnRnvgODFZqJXEESUhe+kcTrlBon9KEGdXS7qgyh+s06mob706aSeAlI6q
 pcgRVYDvtm3KVel2gflPEv2CT+RD2zpuABHgbKtmPj5VNs8DWOqiYyAEzdo1llhg+AwJS9
 oXx5pj1Z1tFJmPZb7c1FwAziJhjoPWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642590934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SzDoiaXnmeu6h5wvdIghDIw1m8DIHTYMaAseqDYm0mw=;
 b=NCAhKD2IOJ+YLsO9MgQSfb6ZU4M/kvr3gZbiIcW03JMvbZIxJSuktVpz3NwBZEXdluVzU3
 9z4mmTgBc0qXOFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43C4313E11
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 11:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wTaOD9by52ErYwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 11:15:34 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Jan 2022 12:15:33 +0100
Message-Id: <20220119111533.8356-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Rewrite statx04 test
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- added known-fail tag for XFS in strict mode
- changed copyright header to SUSE since this is a near-complete rewrite

This also fixes Btrfs failures on kernels v4.11 and v4.12 where the attributes
are not supported at all. LTP is supposed to check for bugs, not force people
to backport features from newer kernels.

If anybody want to backport the Btrfs support, the test now has strict mode
which disables kernel version exceptions.

I've also disabled FUSE filesystems because they return wrong errno codes
in the ioctl() check and NTFS3g now has some rudimentary support for inode
attributes but no support for them in statx().

 testcases/kernel/syscalls/statx/statx04.c | 196 +++++++---------------
 1 file changed, 64 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index a3ca436f5..6ac47a8bd 100644
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
@@ -56,165 +51,102 @@
 #include "lapi/stat.h"
 
 #define MOUNT_POINT "mntpoint"
-#define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
-#define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
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
+};
 
-static int fd, clear_flags;
+static uint64_t expected_mask;
+static char *strict;
 
-static void test_flagged(void)
+static void setup(void)
 {
-	struct statx buf;
+	int i, fd;
 
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
+	SAFE_MKDIR(TESTDIR, 0777);
 
-	if (buf.stx_attributes & STATX_ATTR_APPEND)
-		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_APPEND flag is not set");
+	/* Check general inode attribute support */
+	fd = SAFE_OPEN(TESTDIR, O_RDONLY | O_DIRECTORY);
+	TEST(ioctl(fd, FS_IOC_GETFLAGS, &i));
+	SAFE_CLOSE(fd);
 
-	if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
-		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is not set");
+	if (TST_RET == -1 && TST_ERR == ENOTTY)
+		tst_brk(TCONF | TTERRNO, "Inode attributes not supported");
 
-	if (buf.stx_attributes & STATX_ATTR_NODUMP)
-		tst_res(TPASS, "STATX_ATTR_NODUMP flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is not set");
-}
+	if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "Unexpected ioctl() error");
 
-static void test_unflagged(void)
-{
-	struct statx buf;
+	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
+		expected_mask |= attr_list[i].attr;
 
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
+	/* Strict mode: No exceptions, all attributes must be supported */
+	if (strict)
+		return;
 
-static struct test_cases {
-	void (*tfunc)(void);
-} tcases[] = {
-	{&test_flagged},
-	{&test_unflagged},
-};
+	/* STATX_ATTR_COMPRESSED not supported on XFS */
+	if (!strcmp(tst_device->fs_type, "xfs"))
+		expected_mask &= ~STATX_ATTR_COMPRESSED;
 
-static void run(unsigned int i)
-{
-	tcases[i].tfunc();
+	/* Attribute support was added to Btrfs statx() in kernel v4.13 */
+	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
+		tst_brk(TCONF, "statx() attributes not supported on Btrfs");
 }
 
-static void caid_flags_setup(void)
+static void run(void)
 {
-	int attr, ret;
-
-	fd = SAFE_OPEN(TESTDIR_FLAGGED, O_RDONLY | O_DIRECTORY);
-
-	ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
-	if (ret < 0) {
-		if (errno == ENOTTY)
-			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
-
-		/* ntfs3g fuse fs returns wrong errno for unimplemented ioctls */
-		if (!strcmp(tst_device->fs_type, "ntfs")) {
-			tst_brk(TCONF | TERRNO,
-				"ntfs3g does not support FS_IOC_GETFLAGS");
-		}
+	int i;
+	struct statx buf;
 
-		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
-	}
+	TEST(statx(AT_FDCWD, TESTDIR, 0, 0, &buf));
 
-	if (!strcmp(tst_device->fs_type, "xfs"))
-		attr |= FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
-	else
-		attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
-
-	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP)
-			tst_brk(TCONF, "Flags not supported");
-		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO, "sys_statx() failed");
+	} else if (TST_RET) {
+		tst_brk(TBROK | TTERRNO,
+			"sys_statx() returned invalid value %ld", TST_RET);
 	}
 
-	clear_flags = 1;
-}
-
-static void setup(void)
-{
-	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
-	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
+	for (i = 0; i < ARRAY_SIZE(attr_list); i++) {
+		if (!(expected_mask & attr_list[i].attr))
+			continue;
 
-	caid_flags_setup();
-}
-
-static void cleanup(void)
-{
-	int attr;
-
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
+	.options = (struct tst_option[]) {
+		{"s", &strict, "Strict mode (disable special exceptions)"}
+	},
+	.skip_filesystems = (const char *const[]) {
+		"fuse",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "93bc420ed41d"},
 		{"linux-git", "99652ea56a41"},
 		{"linux-git", "04a87e347282"},
 		{"linux-git", "5f955f26f3d4"},
+		{"known-fail", "STATX_ATTR_COMPRESSED is not implemented on XFS (strict mode)"},
 		{}
 	},
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
