Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F87C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 14:44:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FF453CFB5D
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 16:44:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 801A13CFA7C
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 16:44:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C10851000CED
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 16:44:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDF9B20A92;
 Wed, 17 Apr 2024 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713365054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JK8nqcO0xG+RqZmJYDt8I8HLnQwtQ3AFPyyj8fD0QAg=;
 b=kr/pVazzoN90hvwcxv6C0tCD4Xcl3Rkfs6basDP/NSp5kHnf3pLSXXjJpNnUKZiKFEwYcB
 w9awYbsnNNWxbQzH5iL8jum0e1h+PWvrljijOuS1RAogkKGYZtoyGzKZujT9mntCrTgv3s
 0RN8qpYWN4s+963I6bGBu6d0SduX8eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713365054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JK8nqcO0xG+RqZmJYDt8I8HLnQwtQ3AFPyyj8fD0QAg=;
 b=NQdZz6NwLMo94AgXVMF1Dk8fj3m6I5fvlZB/yIG24vTQwgJGN9833G1bSW7pm5hXPPaVCY
 3MNkSRrac13wYCCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="kr/pVazz";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NQdZz6Nw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713365054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JK8nqcO0xG+RqZmJYDt8I8HLnQwtQ3AFPyyj8fD0QAg=;
 b=kr/pVazzoN90hvwcxv6C0tCD4Xcl3Rkfs6basDP/NSp5kHnf3pLSXXjJpNnUKZiKFEwYcB
 w9awYbsnNNWxbQzH5iL8jum0e1h+PWvrljijOuS1RAogkKGYZtoyGzKZujT9mntCrTgv3s
 0RN8qpYWN4s+963I6bGBu6d0SduX8eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713365054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JK8nqcO0xG+RqZmJYDt8I8HLnQwtQ3AFPyyj8fD0QAg=;
 b=NQdZz6NwLMo94AgXVMF1Dk8fj3m6I5fvlZB/yIG24vTQwgJGN9833G1bSW7pm5hXPPaVCY
 3MNkSRrac13wYCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B83BE1384C;
 Wed, 17 Apr 2024 14:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V2LpKj7gH2Z5UgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 17 Apr 2024 14:44:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 17 Apr 2024 16:44:09 +0200
Message-Id: <20240417144409.11411-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DDF9B20A92
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] Add stat04 test
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
stat() executed on file provide the same information of symlink linking
to it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Change Author description adding copilot
Fetch tmpdir in setup() and free it in cleanup()

 runtest/smoketest                         |  2 +-
 runtest/syscalls                          |  4 +-
 testcases/kernel/syscalls/stat/.gitignore |  2 +
 testcases/kernel/syscalls/stat/stat04.c   | 60 +++++++++++++++++++++++
 4 files changed, 65 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/stat/stat04.c

diff --git a/runtest/smoketest b/runtest/smoketest
index 83eebfe7b..5608417f9 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -8,7 +8,7 @@ time01 time01
 wait02 wait02
 write01 write01
 symlink01 symlink01
-stat04 symlink01 -T stat04
+stat04 stat04
 utime01A symlink01 -T utime01
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
diff --git a/runtest/syscalls b/runtest/syscalls
index 010a1a752..b18e14d7c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1529,8 +1529,8 @@ stat02 stat02
 stat02_64 stat02_64
 stat03 stat03
 stat03_64 stat03_64
-stat04 symlink01 -T stat04
-stat04_64 symlink01 -T stat04_64
+stat04 stat04
+stat04_64 stat04_64
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
index fa0a4ce9f..0a62dc6ee 100644
--- a/testcases/kernel/syscalls/stat/.gitignore
+++ b/testcases/kernel/syscalls/stat/.gitignore
@@ -4,3 +4,5 @@
 /stat02_64
 /stat03
 /stat03_64
+/stat04
+/stat04_64
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
new file mode 100644
index 000000000..edb94656d
--- /dev/null
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner, Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test checks that stat() executed on file provide the same information
+ * of symlink linking to it.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+static char *tmpdir;
+
+static void run(void)
+{
+	char *symname = "my_symlink0";
+
+	SAFE_SYMLINK(tmpdir, symname);
+
+	struct stat path;
+	struct stat link;
+
+	TST_EXP_PASS(stat(tmpdir, &path));
+	TST_EXP_PASS(stat(symname, &link));
+
+	TST_EXP_EQ_LI(path.st_dev, link.st_dev);
+	TST_EXP_EQ_LI(path.st_mode, link.st_mode);
+	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);
+	TST_EXP_EQ_LI(path.st_uid, link.st_uid);
+	TST_EXP_EQ_LI(path.st_gid, link.st_gid);
+	TST_EXP_EQ_LI(path.st_size, link.st_size);
+	TST_EXP_EQ_LI(path.st_atime, link.st_atime);
+	TST_EXP_EQ_LI(path.st_mtime, link.st_mtime);
+	TST_EXP_EQ_LI(path.st_ctime, link.st_ctime);
+
+	SAFE_UNLINK(symname);
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
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
