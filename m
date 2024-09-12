Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47745EED61E
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 16:34:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9C243C26CD
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 18:34:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D7D03C232A
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 18:34:02 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E7A460E68B
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 18:34:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 941F91FD0B;
 Thu, 12 Sep 2024 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726158840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hpMBM/A9lRqKUgE8bxgFGRAYxKEOlw0lMzGs7R8eZjc=;
 b=Zu1+dDFmCxnpBUjnd9UJplTZpP0bRImLnCWdNmqr5X8gybu71zoxwqpCrWifmiX1wPxh9T
 Gqpz8ZiwJJ3E26V5ySLfH7pdM8ZVjH63aElL2vLz/tAnFSYbVU03CqSCWlt3dpbvKGs1X1
 dpA77htT+VdUzJoaTOlpIP6fI7q/UwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726158840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hpMBM/A9lRqKUgE8bxgFGRAYxKEOlw0lMzGs7R8eZjc=;
 b=sHQ8VZQoliZquenIFlqjKmJcLrPgB1M0Xcgd5uGwePiBSLz/eMWcXS08qPPOM0L1hzbubm
 Z6Mi3VFNpT5CqWDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zu1+dDFm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sHQ8VZQo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726158840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hpMBM/A9lRqKUgE8bxgFGRAYxKEOlw0lMzGs7R8eZjc=;
 b=Zu1+dDFmCxnpBUjnd9UJplTZpP0bRImLnCWdNmqr5X8gybu71zoxwqpCrWifmiX1wPxh9T
 Gqpz8ZiwJJ3E26V5ySLfH7pdM8ZVjH63aElL2vLz/tAnFSYbVU03CqSCWlt3dpbvKGs1X1
 dpA77htT+VdUzJoaTOlpIP6fI7q/UwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726158840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hpMBM/A9lRqKUgE8bxgFGRAYxKEOlw0lMzGs7R8eZjc=;
 b=sHQ8VZQoliZquenIFlqjKmJcLrPgB1M0Xcgd5uGwePiBSLz/eMWcXS08qPPOM0L1hzbubm
 Z6Mi3VFNpT5CqWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B66D13AD8;
 Thu, 12 Sep 2024 16:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AE26HPgX42bILAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 12 Sep 2024 16:34:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 12 Sep 2024 18:33:54 +0200
MIME-Version: 1.0
Message-Id: <20240912-rename15-v7-1-546aba5b929f@suse.com>
X-B4-Tracking: v=1; b=H4sIAPEX42YC/23MQQ7CIBCF4as0sxYD2FJx5T1MF0gHO4vShlGia
 bi72LXL/+Xl24AxETJcmg0SZmJaYo3+0ICfXHygoLE2aKlbaZUWCaObUXUiWOeUbDt1NgHqfU0
 Y6L1Tt6H2RPxc0meXs/mtf5BshBLKu/vordb9yV75xXj0ywxDKeULV5wanJ8AAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726158840; l=5096;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=M4ztIfkxY2rIGoXUZ0CHiI2KmA+frcS7bqHL5/adJt4=;
 b=UGvgPDImNDvEUJGJpzqtKFz6mduir6TFl6YP+JXF0En/Aq39poo+9F1JZtZ3t6qlfHlhiZ4KT
 TCTrbJiaB8mCYoenyTuroVD5x6YxoB4bbSUB3V11YrIvV6csJcBHoW5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 941F91FD0B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] Add rename15 test
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
Changes in v7:
- add a bit more checks to ensure rename() correctly changed the file
  name, using lstat()
- Link to v6: https://lore.kernel.org/r/20240912-rename15-v6-1-1cabdc922739@suse.com
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/rename/.gitignore |   1 +
 testcases/kernel/syscalls/rename/rename15.c | 131 ++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

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
index 000000000..d08b1e67f
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/rename15.c
@@ -0,0 +1,131 @@
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
+	struct stat buff_stat;
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_SYMLINK(tmpdir, oldname);
+	SAFE_STAT(oldname, &oldsym_stat);
+
+	SAFE_RENAME(oldname, newname);
+
+	TST_EXP_PASS(lstat(newname, &buff_stat));
+	TST_EXP_FAIL(lstat(oldname, &buff_stat), ENOENT);
+
+	SAFE_STAT(newname, &newsym_stat);
+	TST_EXP_EQ_LI(oldsym_stat.st_ino, newsym_stat.st_ino);
+	TST_EXP_EQ_LI(oldsym_stat.st_dev, newsym_stat.st_dev);
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
+	TST_EXP_PASS(lstat(oldname, &path_stat));
+
+	SAFE_RENAME(oldname, newname);
+
+	TST_EXP_FAIL(lstat(oldname, &path_stat), ENOENT);
+	TST_EXP_PASS(lstat(newname, &path_stat));
+	TST_EXP_FAIL(stat(newname, &path_stat), ENOENT);
+
+	SAFE_UNLINK(newname);
+}
+
+static void test_creat(void)
+{
+	tst_res(TINFO, "Test rename() on symlink pointing to a path created lately");
+
+	struct stat path_stat;
+
+	SAFE_SYMLINK(objname, oldname);
+	TST_EXP_FAIL(stat(oldname, &path_stat), ENOENT);
+	TST_EXP_PASS(lstat(oldname, &path_stat));
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
+
+	TST_EXP_PASS(lstat(newname, &path_stat));
+	TST_EXP_PASS(stat(newname, &path_stat));
+
+	TST_EXP_FAIL(lstat(oldname, &path_stat), ENOENT);
+	TST_EXP_PASS(stat(objname, &path_stat));
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
