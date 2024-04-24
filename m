Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA6BC4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 09:24:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44B983CFFD2
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 11:24:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E38043CF915
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 11:24:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 258A2207A04
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 11:24:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BD2E612BB;
 Wed, 24 Apr 2024 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713950638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tdcx1pv4roPGKTjyT1OwhGCLJJNlufHcfqzmPyB0CWQ=;
 b=OAFlxQaeQhpzT357DmhOSNWpUW7kXssP/gx2A7O/RklflnOB3yhzoEdVi4KDHDR+TQKVA+
 dhzzRD7ERlNVe4FbsF83Jn6vYNmGsutBTsWYUeF3rtiz/W4Vns6T+2m1xGBis1ruNMpOKW
 2C9mMRXHefRTC0Dmr+XgAimmXc+a7UI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713950638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tdcx1pv4roPGKTjyT1OwhGCLJJNlufHcfqzmPyB0CWQ=;
 b=C7t8gmzD8q6AhnlVnjs9jDz4QvGLEs5kA9U7x/m8wkCbkfTgcy3YQuMUg4gCFMO7S/Pzqa
 zgdZVaCS7lnsGyCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713950638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tdcx1pv4roPGKTjyT1OwhGCLJJNlufHcfqzmPyB0CWQ=;
 b=OAFlxQaeQhpzT357DmhOSNWpUW7kXssP/gx2A7O/RklflnOB3yhzoEdVi4KDHDR+TQKVA+
 dhzzRD7ERlNVe4FbsF83Jn6vYNmGsutBTsWYUeF3rtiz/W4Vns6T+2m1xGBis1ruNMpOKW
 2C9mMRXHefRTC0Dmr+XgAimmXc+a7UI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713950638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tdcx1pv4roPGKTjyT1OwhGCLJJNlufHcfqzmPyB0CWQ=;
 b=C7t8gmzD8q6AhnlVnjs9jDz4QvGLEs5kA9U7x/m8wkCbkfTgcy3YQuMUg4gCFMO7S/Pzqa
 zgdZVaCS7lnsGyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 767C513690;
 Wed, 24 Apr 2024 09:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vWIAG67PKGbvNwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 24 Apr 2024 09:23:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 11:23:57 +0200
Message-Id: <20240424092357.11207-1-andrea.cervesato@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add rename15 test
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
Added 2 more tests
* Test rename() on symlink pointing to a non-existent path
* Test rename() on symlink pointing to a path created lately

Usage of macros for file names
Resolve tmpdir memory leakage

 runtest/smoketest                           |   2 +-
 runtest/syscalls                            |   2 +-
 testcases/kernel/syscalls/rename/.gitignore |   1 +
 testcases/kernel/syscalls/rename/rename15.c | 100 ++++++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/rename/rename15.c

diff --git a/runtest/smoketest b/runtest/smoketest
index 83eebfe7b..19fa257d6 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -10,7 +10,7 @@ write01 write01
 symlink01 symlink01
 stat04 symlink01 -T stat04
 utime01A symlink01 -T utime01
-rename01A symlink01 -T rename01
+rename15 rename15
 splice02 splice02 -s 20
 df01_sh df01.sh
 shell_test01 echo "SUCCESS" | shell_pipe01.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index b9dd9fec6..f515d46aa 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1156,7 +1156,6 @@ removexattr01 removexattr01
 removexattr02 removexattr02
 
 rename01 rename01
-rename01A symlink01 -T rename01
 rename03 rename03
 rename04 rename04
 rename05 rename05
@@ -1169,6 +1168,7 @@ rename11 rename11
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
index 000000000..d410758a2
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/rename15.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner
+ *    Copilot: Jon Hendrickson
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
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define OLDNAME "msymlink0"
+#define NEWNAME "asymlink0"
+
+static char *tmpdir;
+
+static void test_existing(void)
+{
+	tst_res(TINFO, "Test rename() on symlink pointing to an existent path");
+
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_SYMLINK(tmpdir, OLDNAME);
+	SAFE_STAT(OLDNAME, &oldsym_stat);
+
+	SAFE_RENAME(OLDNAME, NEWNAME);
+	SAFE_STAT(NEWNAME, &newsym_stat);
+
+	TST_EXP_EQ_LI(oldsym_stat.st_ino, newsym_stat.st_ino);
+	TST_EXP_EQ_LI(oldsym_stat.st_dev, newsym_stat.st_dev);
+
+	SAFE_UNLINK(NEWNAME);
+}
+
+static void test_non_existing(void)
+{
+	tst_res(TINFO, "Test rename() on symlink pointing to a non-existent path");
+
+	struct stat path_stat;
+
+	SAFE_SYMLINK("this_path_doesnt_exist", OLDNAME);
+	TST_EXP_FAIL(stat(OLDNAME, &path_stat), ENOENT);
+
+	SAFE_RENAME(OLDNAME, NEWNAME);
+	TST_EXP_FAIL(stat(NEWNAME, &path_stat), ENOENT);
+
+	SAFE_UNLINK(NEWNAME);
+}
+
+static void test_creat(void)
+{
+	tst_res(TINFO, "Test rename() on symlink pointing to a path created lately");
+
+	char *objpath = "object";
+	struct stat path_stat;
+
+	SAFE_SYMLINK(objpath, OLDNAME);
+	TST_EXP_FAIL(stat(OLDNAME, &path_stat), ENOENT);
+
+	tst_res(TINFO, "Create object file");
+
+	SAFE_CREAT(objpath, 0700);
+	SAFE_RENAME(OLDNAME, NEWNAME);
+	TST_EXP_PASS(stat(NEWNAME, &path_stat));
+
+	SAFE_UNLINK(objpath);
+	SAFE_UNLINK(NEWNAME);
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
+	tmpdir = tst_get_tmpdir();
+}
+
+static void cleanup(void)
+{
+	free(tmpdir);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
