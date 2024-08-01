Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A3BC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 13:50:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B01B33D1F06
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 15:50:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C9883CEB69
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 15:50:30 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 62F951401262
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 15:50:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50BF21FB50;
 Thu,  1 Aug 2024 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722520228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6mtX1pW9Q06nrEqJ+jbjd2bvOkX5V+YfyfUMSAhrgo=;
 b=ao0M6A6c5W7OTVNHPJOlYCPYwMPpvKcKstWxCjr9rA5GNYtvwvZOd7hUsshy6IouMhiRcx
 lNp9CtsLz6EFPNeHASA6d/8tZmkP+IsmlV4ZqD+1PiIvxREnYuLxpnhvvgPbdtk3+3PC7i
 IQl2PHNMYq7/KJ1zOz3+d/ySDpAl9as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722520228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6mtX1pW9Q06nrEqJ+jbjd2bvOkX5V+YfyfUMSAhrgo=;
 b=ODObJbxsSS2b/ejEnmIKb5OxFRl9w7Kp3tn6QgFGU/hx2VZQGEgRJtrt14qOpPdONzk2IG
 pGpU0uxYFtzxt6Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ao0M6A6c;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ODObJbxs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722520228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6mtX1pW9Q06nrEqJ+jbjd2bvOkX5V+YfyfUMSAhrgo=;
 b=ao0M6A6c5W7OTVNHPJOlYCPYwMPpvKcKstWxCjr9rA5GNYtvwvZOd7hUsshy6IouMhiRcx
 lNp9CtsLz6EFPNeHASA6d/8tZmkP+IsmlV4ZqD+1PiIvxREnYuLxpnhvvgPbdtk3+3PC7i
 IQl2PHNMYq7/KJ1zOz3+d/ySDpAl9as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722520228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6mtX1pW9Q06nrEqJ+jbjd2bvOkX5V+YfyfUMSAhrgo=;
 b=ODObJbxsSS2b/ejEnmIKb5OxFRl9w7Kp3tn6QgFGU/hx2VZQGEgRJtrt14qOpPdONzk2IG
 pGpU0uxYFtzxt6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8806136CF;
 Thu,  1 Aug 2024 13:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YeVUL6OSq2ZhdgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 13:50:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  1 Aug 2024 15:50:21 +0200
Message-ID: <20240801135023.22125-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 50BF21FB50
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add rename15 test
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
- tst_tmpdir_path/tst_tmpdir_mkpath usage
- use absolute paths
- add all_filesystems = 1

 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/rename/.gitignore |   1 +
 testcases/kernel/syscalls/rename/rename15.c | 109 ++++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/rename/rename15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9b3cba667..6028c57c3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1173,7 +1173,6 @@ removexattr01 removexattr01
 removexattr02 removexattr02
 
 rename01 rename01
-rename01A symlink01 -T rename01
 rename03 rename03
 rename04 rename04
 rename05 rename05
@@ -1186,6 +1185,7 @@ rename11 rename11
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
index 000000000..234632879
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/rename15.c
@@ -0,0 +1,109 @@
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
+ * This test verifies that rename() is working correctly on symlink()
+ * generated files.
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
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_SYMLINK(tmpdir, oldname);
+	SAFE_STAT(oldname, &oldsym_stat);
+
+	SAFE_RENAME(oldname, newname);
+	SAFE_STAT(newname, &newsym_stat);
+
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
+
+	SAFE_RENAME(oldname, newname);
+	TST_EXP_FAIL(stat(newname, &path_stat), ENOENT);
+
+	SAFE_UNLINK(newname);
+}
+
+static void test_creat(void)
+{
+
+	tst_res(TINFO, "Test rename() on symlink pointing to a path created lately");
+
+	struct stat path_stat;
+
+	SAFE_SYMLINK(objname, oldname);
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
+	oldname = tst_tmpdir_mkpath(OLDNAME);
+	newname = tst_tmpdir_mkpath(NEWNAME);
+	objname = tst_tmpdir_mkpath(OBJNAME);
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
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
