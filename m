Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B02EED608
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 13:35:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F23023C2690
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 15:35:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 607623C0F5C
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:35:29 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 42C671B62004
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:35:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F02D1FB77
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726148126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/MgfGsl8JE96I9xnlKYCVgsGCQB2C1uSQrU2VcxMgzM=;
 b=ohi0ofNCLF90KrHR350aHOBg9DFnLWFxktsJ9ZXmubqeaUNL01WHhDfXGEnZY4VyKVsGaq
 Qm/o5/HV6W8VB/8XmjZbDz+KDe0EmVoAd4ULZVFKaCZjHcsldmu2GcQyi2+gCPxPB0CQfr
 Bho1+UhmSUwA4YZY6aPR5BV5ACmxosU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726148126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/MgfGsl8JE96I9xnlKYCVgsGCQB2C1uSQrU2VcxMgzM=;
 b=5Ob0OrmVI+QCNUCg+BLgglgnaS2Gt9nEja9W/EMHoLamCaGhlFTKe9NRnBBuFEEmsge/GD
 aUXq+dTsnHBGGfAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ohi0ofNC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5Ob0OrmV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726148126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/MgfGsl8JE96I9xnlKYCVgsGCQB2C1uSQrU2VcxMgzM=;
 b=ohi0ofNCLF90KrHR350aHOBg9DFnLWFxktsJ9ZXmubqeaUNL01WHhDfXGEnZY4VyKVsGaq
 Qm/o5/HV6W8VB/8XmjZbDz+KDe0EmVoAd4ULZVFKaCZjHcsldmu2GcQyi2+gCPxPB0CQfr
 Bho1+UhmSUwA4YZY6aPR5BV5ACmxosU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726148126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/MgfGsl8JE96I9xnlKYCVgsGCQB2C1uSQrU2VcxMgzM=;
 b=5Ob0OrmVI+QCNUCg+BLgglgnaS2Gt9nEja9W/EMHoLamCaGhlFTKe9NRnBBuFEEmsge/GD
 aUXq+dTsnHBGGfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1DE313A73
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 13:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U9kfOB3u4mbDcQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 13:35:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 12 Sep 2024 15:35:18 +0200
MIME-Version: 1.0
Message-Id: <20240912-rename15-v6-1-1cabdc922739@suse.com>
X-B4-Tracking: v=1; b=H4sIABXu4mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mj3aLUvMTcVENT3TTLxERDAxNTQwuzNCWg8oKi1LTMCrBR0bG1tQA
 sJHcpWgAAAA==
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726148125; l=4754;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ssFiZNCPKrujs0/D9bKuXPxRKul05KUe7JVeKrb9gsI=;
 b=3fs84UQakAIH2SF2FJlgrt/eX32UR2R82fh0ccx/TzWvY2EkQNFYPMRv7vONzfiBGIRA0td+s
 NxKY0jtdqc7DvNBoD1UIKnd5htWP+7rlLS3ZzycqZsMru9bqc4MwepY
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 0F02D1FB77
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] Add rename15 test
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

This test has been extracted from symlink01 and it verifies that
rename() is working correctly on symlink() generated files, renaming
symbolic link and checking if stat() information are preserved.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/rename/.gitignore |   1 +
 testcases/kernel/syscalls/rename/rename15.c | 126 ++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a9fc8c432..bc99e8272 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1196,6 +1196,7 @@ rename11 rename11
 rename12 rename12
 rename13 rename13
 rename14 rename14
+rename15 rename15
 
 #renameat test cases
 renameat01 renameat01
diff --git a/testcases/kernel/syscalls/rename/.gitignore b/testcases/kernel/syscalls/rename/.gitignore
index f95cf7d21..d17b80f09 100644
--- a/testcases/kernel/syscalls/rename/.gitignore
+++ b/testcases/kernel/syscalls/rename/.gitignore
@@ -11,3 +11,4 @@
 /rename12
 /rename13
 /rename14
+/rename15
diff --git a/testcases/kernel/syscalls/rename/rename15.c b/testcases/kernel/syscalls/rename/rename15.c
new file mode 100644
index 000000000..7b8daaa5b
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/rename15.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Authors: David Fenner, Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test suite validates the behavior of the `rename()` system call on
+ * symbolic links under three scenarios:
+ *
+ * - rename a symlink pointing to an existing file and verifies that the
+ *   symlink's inode and device number remain unchanged.
+ *
+ * - rename a symlink pointing to a non-existent path, ensuring that the
+ *   original symlink remains unaffected.
+ *
+ * - rename a symlink pointing to a created file, confirming that the new
+ *   symlink points to the correct file.
+ */
+
+#include "tst_test.h"
+#include "tst_tmpdir.h"
+
+#define MNTPOINT "mnt"
+#define OLDNAME MNTPOINT"/msymlink0"
+#define NEWNAME MNTPOINT"/asymlink0"
+#define OBJNAME MNTPOINT"/object"
+
+static char *tmpdir;
+static char *oldname;
+static char *newname;
+static char *objname;
+
+static void test_existing(void)
+{
+	tst_res(TINFO, "Test rename() on symlink pointing to an existent path");
+
+	struct stat sym_stat;
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_SYMLINK(tmpdir, oldname);
+	TST_EXP_PASS(lstat(oldname, &sym_stat));
+	SAFE_STAT(oldname, &oldsym_stat);
+
+	SAFE_RENAME(oldname, newname);
+	SAFE_STAT(newname, &newsym_stat);
+
+	TST_EXP_EQ_LI(oldsym_stat.st_ino, newsym_stat.st_ino);
+	TST_EXP_EQ_LI(oldsym_stat.st_dev, newsym_stat.st_dev);
+	TST_EXP_FAIL(access(oldname, F_OK), ENOENT);
+
+	SAFE_UNLINK(newname);
+}
+
+static void test_non_existing(void)
+{
+	tst_res(TINFO, "Test rename() on symlink pointing to a non-existent path");
+
+	struct stat path_stat;
+
+	SAFE_SYMLINK("this_path_doesnt_exist", oldname);
+	TST_EXP_FAIL(stat(oldname, &path_stat), ENOENT);
+
+	SAFE_RENAME(oldname, newname);
+	TST_EXP_FAIL(stat(newname, &path_stat), ENOENT);
+	TST_EXP_FAIL(access(oldname, F_OK), ENOENT);
+
+	SAFE_UNLINK(newname);
+}
+
+static void test_creat(void)
+{
+
+	tst_res(TINFO, "Test rename() on symlink pointing to a path created lately");
+
+	struct stat sym_stat;
+	struct stat path_stat;
+
+	SAFE_SYMLINK(objname, oldname);
+	TST_EXP_PASS(lstat(oldname, &sym_stat));
+	TST_EXP_FAIL(stat(oldname, &path_stat), ENOENT);
+
+	tst_res(TINFO, "Create object file");
+
+	int fd;
+
+	fd = SAFE_CREAT(objname, 0700);
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+
+	SAFE_RENAME(oldname, newname);
+	TST_EXP_PASS(stat(newname, &path_stat));
+	TST_EXP_FAIL(access(oldname, F_OK), ENOENT);
+	TST_EXP_PASS(access(objname, F_OK));
+
+	SAFE_UNLINK(objname);
+	SAFE_UNLINK(newname);
+}
+
+static void run(void)
+{
+	test_existing();
+	test_creat();
+	test_non_existing();
+}
+
+static void setup(void)
+{
+	tmpdir = tst_tmpdir_path();
+	oldname = tst_tmpdir_genpath(OLDNAME);
+	newname = tst_tmpdir_genpath(NEWNAME);
+	objname = tst_tmpdir_genpath(OBJNAME);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.needs_root = 1,
+};

---
base-commit: 0ae6bcc6fc2a91b280aeb4ad2f9d3ca1844d64f2
change-id: 20240912-rename15-f9aa1045186f

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
