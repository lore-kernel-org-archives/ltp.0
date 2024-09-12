Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2A9EEB563
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 08:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A6833C247F
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 10:31:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A9CF3C1D41
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 10:31:05 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 278B51B61044
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 10:31:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 548E21F749;
 Thu, 12 Sep 2024 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726129864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fg+aXBVeiRdXH6mVgAensgAyk7s7ScOc6Gj8i5e9TxU=;
 b=mHnkO2pKjtxPCV6FC7I0GCnfz3g4BgOdrhPnHpddr5uNyKeORgN9Dur4IUsKobKIBDl4Bk
 PNGSqbVHUAaW3fEHzO6nLscO1RCKccBpqKQf1ZT//ZuQIEE66tqGKv5Js0dSQqyLk2pb9n
 bzAduCYPjVeKfZnomJEV+n1pZtvVf5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726129864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fg+aXBVeiRdXH6mVgAensgAyk7s7ScOc6Gj8i5e9TxU=;
 b=H3d5HRmbkxBix82j8sghWav9RZI1+ZH5WGOq4hWv0IIiWPvm9EeiLmy+AOjugwaclqNcS8
 5EcOb3JDKtmrRbCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=maEGX1b8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0ANCEkpU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726129863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fg+aXBVeiRdXH6mVgAensgAyk7s7ScOc6Gj8i5e9TxU=;
 b=maEGX1b8aFPxfOY3wjbj0gA/aK+rBuhjfNm2IBYvuRETdHL5Fghknbq/GncpPfbbRavJaz
 bNJ+DNRSbSSphcKm3sShTwAY6m/RbGsGMNCYDY4EOQWEJWo63QAtNHJPLsdZeUaUjlFR5B
 KCr0S6afwAundLYlJvGjAY6mnZSzcTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726129863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fg+aXBVeiRdXH6mVgAensgAyk7s7ScOc6Gj8i5e9TxU=;
 b=0ANCEkpUyz0qgz21S+66covS/athAkt5xFZj//HAkv/XSERH6MIeetQnzfuPP6P7ekG2cm
 ZZCN0MsoSCzf0pCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 392D013AD8;
 Thu, 12 Sep 2024 08:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id km2ADMem4mb3DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 12 Sep 2024 08:31:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 12 Sep 2024 10:31:01 +0200
Message-ID: <20240912083102.3216-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 548E21F749
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Add rename15 test
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
rename tst_tmpdir_mkpath -> tst_tmpdir_genpath

 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/rename/.gitignore |   1 +
 testcases/kernel/syscalls/rename/rename15.c | 109 ++++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/rename/rename15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a9fc8c432..2ae02c6af 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1183,7 +1183,6 @@ removexattr01 removexattr01
 removexattr02 removexattr02
 
 rename01 rename01
-rename01A symlink01 -T rename01
 rename03 rename03
 rename04 rename04
 rename05 rename05
@@ -1196,6 +1195,7 @@ rename11 rename11
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
index 000000000..923877f01
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
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
