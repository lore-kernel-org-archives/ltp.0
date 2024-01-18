Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90559C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 15:24:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 143143CFCCA
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 16:24:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB5543C62C0
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:24:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E56F6019B4
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:24:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EB1B1FD04;
 Thu, 18 Jan 2024 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705591479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VSkQs338MxvEcgbx4hpEpKFz9lhYL364N3JZ6lDsVek=;
 b=w415vXHm9IViPePOL32u+Q48aJb+4Kn/GTjlZoPOgSnbk9vu3CsVbY/vgkLCUZpYkbCupb
 1Hqh/jgaHsBZtNGIvQ7scr7IMGyriw7OQZ6/GSTtjWqX+LWiw9LXJ1l8RC9D8xEOLWEA/S
 3y6mg818Gr5eTfHlHeTlngK7NeP29zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705591479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VSkQs338MxvEcgbx4hpEpKFz9lhYL364N3JZ6lDsVek=;
 b=b9NSMAhvS5JbpKh5aDAgvnSuEVLXp3us0XPtNVRe8l/7oJ4Ca1PM4DLmbCWC12+NOCmyaB
 Z5beiIS0nm5B5ICA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705591479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VSkQs338MxvEcgbx4hpEpKFz9lhYL364N3JZ6lDsVek=;
 b=w415vXHm9IViPePOL32u+Q48aJb+4Kn/GTjlZoPOgSnbk9vu3CsVbY/vgkLCUZpYkbCupb
 1Hqh/jgaHsBZtNGIvQ7scr7IMGyriw7OQZ6/GSTtjWqX+LWiw9LXJ1l8RC9D8xEOLWEA/S
 3y6mg818Gr5eTfHlHeTlngK7NeP29zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705591479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VSkQs338MxvEcgbx4hpEpKFz9lhYL364N3JZ6lDsVek=;
 b=b9NSMAhvS5JbpKh5aDAgvnSuEVLXp3us0XPtNVRe8l/7oJ4Ca1PM4DLmbCWC12+NOCmyaB
 Z5beiIS0nm5B5ICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1E9713874;
 Thu, 18 Jan 2024 15:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mltmOLZCqWV1LgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jan 2024 15:24:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 18 Jan 2024 16:24:38 +0100
Message-Id: <20240118152438.15668-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w415vXHm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b9NSMAhv
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 2EB1B1FD04
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add lstat03 test
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

This test has been extracted from symlink01 test and it verifies
lstat() syscall functionalities on symlink generated file.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  4 +-
 testcases/kernel/syscalls/lstat/.gitignore |  2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 69 ++++++++++++++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/lstat/lstat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..69ac20b49 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -723,12 +723,12 @@ lseek02 lseek02
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
index 000000000..86efed348
--- /dev/null
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -0,0 +1,69 @@
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
+ * This test verifies that lstat() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+static void test_lstat(void)
+{
+	char *symname = "my_symlink0";
+
+	TST_EXP_PASS(symlink(tst_get_tmpdir(), symname));
+
+	struct stat path_stat;
+	struct stat link_stat;
+
+	SAFE_LSTAT(tst_get_tmpdir(), &path_stat);
+	SAFE_LSTAT(symname, &link_stat);
+
+	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
+	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
+	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
+	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
+	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
+	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
+	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
+
+	TST_EXP_EXPR(path_stat.st_mode != link_stat.st_mode,
+		"object and symbolic link have different st_mode");
+	TST_EXP_EXPR(path_stat.st_size != link_stat.st_size,
+		"object and symbolic link have different st_size");
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_lstat_no_path(void)
+{
+	char *symname = "my_symlink1";
+	struct stat link_stat;
+
+	TST_EXP_PASS(symlink("bc+eFhi!k", symname));
+
+	SAFE_LSTAT(symname, &link_stat);
+	TST_EXP_EXPR((link_stat.st_mode & S_IFMT) == S_IFLNK,
+		"can read symlink file information");
+
+	SAFE_UNLINK(symname);
+}
+
+static void run(void)
+{
+	test_lstat();
+	test_lstat_no_path();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
