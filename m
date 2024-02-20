Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1863FC48BC4
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 12:38:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 835FB3CF1F0
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 13:38:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3291D3C06DF
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:37:49 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 916AE1400F25
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:37:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B71381FD5E;
 Tue, 20 Feb 2024 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708432667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNUJItEzw4T+94lgCEa1sm4aJR7soM3Wbnfc57TS1iQ=;
 b=sTiAThja2Ort7f+xtUm2/hjVwbjKOKlIrlxRz7dYzruOsHT/SnCrAh0EqCsZyuW4e+nePU
 SfSPmE9QWtoV2AuBxvBZwiJNhKypshjVUsGOehTF2TR7FXlLhdKuL2ucjInR5PHq7RuEo1
 8f2A9jzwYnEDQo2HCw8HGc4ECxucgKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708432667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNUJItEzw4T+94lgCEa1sm4aJR7soM3Wbnfc57TS1iQ=;
 b=eVweE8VNBKbP8S+HuehWmWFHUO2/GkwCfTpRqzVZpnmaTRzmMUcAWV+S3VPZIPT4Y9ILHT
 amahXzPoGjeyORAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708432667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNUJItEzw4T+94lgCEa1sm4aJR7soM3Wbnfc57TS1iQ=;
 b=sTiAThja2Ort7f+xtUm2/hjVwbjKOKlIrlxRz7dYzruOsHT/SnCrAh0EqCsZyuW4e+nePU
 SfSPmE9QWtoV2AuBxvBZwiJNhKypshjVUsGOehTF2TR7FXlLhdKuL2ucjInR5PHq7RuEo1
 8f2A9jzwYnEDQo2HCw8HGc4ECxucgKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708432667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KNUJItEzw4T+94lgCEa1sm4aJR7soM3Wbnfc57TS1iQ=;
 b=eVweE8VNBKbP8S+HuehWmWFHUO2/GkwCfTpRqzVZpnmaTRzmMUcAWV+S3VPZIPT4Y9ILHT
 amahXzPoGjeyORAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 787F5139D0;
 Tue, 20 Feb 2024 12:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nSgGGhud1GVuGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Feb 2024 12:37:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 13:37:43 +0100
Message-Id: <20240220123743.7181-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add more testcases in mkdir03
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

We add more test cases in mkdir03 in order to check that mkdir()
can't overwrite certain types of files, such as simlinks, directories,
pipes, devices, etc.
These test cases come from symlink01 refactoring.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  2 +-
 testcases/kernel/syscalls/mkdir/.gitignore |  1 +
 testcases/kernel/syscalls/mkdir/mkdir03.c  | 10 ++++
 testcases/kernel/syscalls/mkdir/mkdir10.c  | 57 ++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/mkdir/mkdir10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ef90076e4..aabc37519 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -757,8 +757,8 @@ mkdir02 mkdir02
 mkdir03 mkdir03
 mkdir04 mkdir04
 mkdir05 mkdir05
-mkdir05A symlink01 -T mkdir05
 mkdir09 mkdir09
+mkdir10 mkdir10
 
 #mkdirat test cases
 mkdirat01 mkdirat01
diff --git a/testcases/kernel/syscalls/mkdir/.gitignore b/testcases/kernel/syscalls/mkdir/.gitignore
index 880ff50c0..416fbbd7c 100644
--- a/testcases/kernel/syscalls/mkdir/.gitignore
+++ b/testcases/kernel/syscalls/mkdir/.gitignore
@@ -3,3 +3,4 @@
 /mkdir04
 /mkdir05
 /mkdir09
+/mkdir10
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index d5141bb64..42dfdb9f0 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -19,6 +19,9 @@
 #include "tst_test.h"
 
 #define TST_EEXIST	"tst_eexist"
+#define TST_PIPE	"tst_pipe"
+#define TST_FOLDER	"tst_folder"
+#define TST_SYMLINK "tst_symlink"
 #define TST_ENOENT	"tst_enoent/tst"
 #define TST_ENOTDIR_FILE "tst_enotdir"
 #define TST_ENOTDIR_DIR	"tst_enotdir/tst"
@@ -41,6 +44,9 @@ static struct tcase {
 	{NULL, EFAULT},
 	{long_dir, ENAMETOOLONG},
 	{TST_EEXIST, EEXIST},
+	{TST_FOLDER, EEXIST},
+	{TST_PIPE, EEXIST},
+	{TST_SYMLINK, EEXIST},
 	{TST_ENOENT, ENOENT},
 	{TST_ENOTDIR_DIR, ENOTDIR},
 	{loop_dir, ELOOP},
@@ -70,7 +76,11 @@ static void verify_mkdir(unsigned int n)
 static void setup(void)
 {
 	unsigned int i;
+	char *tmpdir = tst_get_tmpdir();
 
+	SAFE_SYMLINK(tmpdir, TST_SYMLINK);
+	SAFE_MKFIFO(TST_PIPE, 0777);
+	SAFE_MKDIR(TST_FOLDER, 0777);
 	SAFE_TOUCH(TST_EEXIST, MODE, NULL);
 	SAFE_TOUCH(TST_ENOTDIR_FILE, MODE, NULL);
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir10.c b/testcases/kernel/syscalls/mkdir/mkdir10.c
new file mode 100644
index 000000000..87f419916
--- /dev/null
+++ b/testcases/kernel/syscalls/mkdir/mkdir10.c
@@ -0,0 +1,57 @@
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
+ * This test verifies that mkdir() can't overwrite certain generated files, such
+ * as symlinks, pipes, devices, folders, etc.
+ */
+
+#include "tst_test.h"
+
+#define FILE_FOLDER "myfolder"
+#define FILE_MYFILE "myfile"
+#define FILE_FIFO "mypipe"
+#define FILE_SYMLINK "mylink"
+#define FILE_DEVICE "/dev/null"
+
+struct tcase {
+	char *file;
+	char *msg;
+};
+
+static struct tcase tcases[] = {
+	{FILE_FOLDER,	"folder already exists"},
+	{FILE_MYFILE,	"file already exists"},
+	{FILE_FIFO,		"fifo already exists"},
+	{FILE_SYMLINK,	"symlink already exists"},
+	{FILE_DEVICE,	"device already exists"},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(mkdir(tc->file, 0777), EEXIST, "%s", tc->msg);
+}
+
+static void setup(void)
+{
+	SAFE_SYMLINK(tst_get_tmpdir(), FILE_SYMLINK);
+	SAFE_MKFIFO(FILE_FIFO, 0777);
+	SAFE_MKDIR(FILE_FOLDER, 0777);
+	SAFE_TOUCH(FILE_MYFILE, 0777, NULL);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
