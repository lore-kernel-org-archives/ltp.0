Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091B8C4345F
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 12:58:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 604E93CFFA5
	for <ltp@archiver.kernel.org>; Tue, 23 Apr 2024 14:58:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 631543CF38F
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 14:57:45 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B2A0E20174B
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 14:57:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FB5F5FF1A;
 Tue, 23 Apr 2024 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713877063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=myjNUKtRTse3PfX7TOhc9XbvqjVSkNoOloeV+ea5szE=;
 b=SRePBiAUBwTOEA+egYRzA9KuhdzfB4rj63MMOXoUMQ1g/l2N70mxTsFpTA86GhPWN1+NMo
 grpet8fLsfIjV3v6nQXaqlJn/U7ei+CeqMK/PXJReYYXhJJigi+w5suigMO9V3UOLCSeLS
 cE8K3xTCiQyqtt2G4whdY4x4AfrqnPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713877063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=myjNUKtRTse3PfX7TOhc9XbvqjVSkNoOloeV+ea5szE=;
 b=RmYoC9bC7olDIY2y/QyYCHm3Fg+AapCa2gMDUP64cb4wPHH1ES3hCRCqEy+KAjUsdQmv3n
 mtFjbKdgxyu1zUCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SRePBiAU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RmYoC9bC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713877063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=myjNUKtRTse3PfX7TOhc9XbvqjVSkNoOloeV+ea5szE=;
 b=SRePBiAUBwTOEA+egYRzA9KuhdzfB4rj63MMOXoUMQ1g/l2N70mxTsFpTA86GhPWN1+NMo
 grpet8fLsfIjV3v6nQXaqlJn/U7ei+CeqMK/PXJReYYXhJJigi+w5suigMO9V3UOLCSeLS
 cE8K3xTCiQyqtt2G4whdY4x4AfrqnPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713877063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=myjNUKtRTse3PfX7TOhc9XbvqjVSkNoOloeV+ea5szE=;
 b=RmYoC9bC7olDIY2y/QyYCHm3Fg+AapCa2gMDUP64cb4wPHH1ES3hCRCqEy+KAjUsdQmv3n
 mtFjbKdgxyu1zUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A06813894;
 Tue, 23 Apr 2024 12:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id We9ADEewJ2bsXAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Apr 2024 12:57:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 23 Apr 2024 14:57:42 +0200
Message-Id: <20240423125742.25834-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5FB5F5FF1A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add utime07 test
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

This test has been extracted from symlink01 test and it verifies that
utime() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Update license
Add check for symlink as requested
Text output is easier to read now

 runtest/smoketest                          |   2 +-
 runtest/syscalls                           |   2 +-
 testcases/kernel/syscalls/utime/.gitignore |   1 +
 testcases/kernel/syscalls/utime/utime07.c  | 100 +++++++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/utime/utime07.c

diff --git a/runtest/smoketest b/runtest/smoketest
index 83eebfe7b..f6f14fd2b 100644
--- a/runtest/smoketest
+++ b/runtest/smoketest
@@ -9,7 +9,7 @@ wait02 wait02
 write01 write01
 symlink01 symlink01
 stat04 symlink01 -T stat04
-utime01A symlink01 -T utime01
+utime07 utime07
 rename01A symlink01 -T rename01
 splice02 splice02 -s 20
 df01_sh df01.sh
diff --git a/runtest/syscalls b/runtest/syscalls
index b9dd9fec6..4d1c52221 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1677,12 +1677,12 @@ ustat01 ustat01
 ustat02 ustat02
 
 utime01 utime01
-utime01A symlink01 -T utime01
 utime02 utime02
 utime03 utime03
 utime04 utime04
 utime05 utime05
 utime06 utime06
+utime07 utime07
 
 utimes01 utimes01
 
diff --git a/testcases/kernel/syscalls/utime/.gitignore b/testcases/kernel/syscalls/utime/.gitignore
index 94c0ae07c..403764521 100644
--- a/testcases/kernel/syscalls/utime/.gitignore
+++ b/testcases/kernel/syscalls/utime/.gitignore
@@ -4,3 +4,4 @@
 /utime04
 /utime05
 /utime06
+/utime07
diff --git a/testcases/kernel/syscalls/utime/utime07.c b/testcases/kernel/syscalls/utime/utime07.c
new file mode 100644
index 000000000..2647bc897
--- /dev/null
+++ b/testcases/kernel/syscalls/utime/utime07.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+ * This test verifies that utime() is working correctly on symlink()
+ * generated files.
+ */
+
+#include <utime.h>
+#include "tst_test.h"
+
+static void create_symlink(const char* path, const char* symname)
+{
+	struct stat asymlink;
+
+	SAFE_SYMLINK(path, symname);
+	SAFE_LSTAT(symname, &asymlink);
+
+	if ((asymlink.st_mode & S_IFMT) != S_IFLNK) {
+		tst_brk(TBROK,
+			"symlink generated a non-symbolic link %s to %s",
+			symname,
+			path);
+	}
+}
+
+static void test_utime(void)
+{
+	char *symname = "my_symlink0";
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	tst_res(TINFO, "Test if utime() changes access time");
+
+	create_symlink(tst_get_tmpdir(), symname);
+	SAFE_STAT(symname, &oldsym_stat);
+
+	struct utimbuf utimes = {
+		.actime = oldsym_stat.st_atime + 100,
+		.modtime = oldsym_stat.st_mtime + 100
+	};
+
+	TST_EXP_PASS(utime(symname, &utimes));
+	SAFE_STAT(symname, &newsym_stat);
+
+	time_t temp, diff;
+
+	temp = newsym_stat.st_atime - oldsym_stat.st_atime;
+	diff = newsym_stat.st_mtime - oldsym_stat.st_mtime - temp;
+
+	TST_EXP_EXPR(diff == 0,
+		"utime() correctly changed access time");
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_utime_no_path(void)
+{
+	char *symname = "my_symlink1";
+	struct utimbuf utimes;
+
+	tst_res(TINFO, "Test if utime() raises ENOENT when symlink points to nowhere");
+
+	create_symlink("bc+eFhi!k", symname);
+	TST_EXP_FAIL(utime(symname, &utimes), ENOENT);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_utime_loop(void)
+{
+	char *symname = "my_symlink2";
+	struct utimbuf utimes;
+
+	tst_res(TINFO, "Test if utime() raises ELOOP when symlink is looping");
+
+	create_symlink(symname, symname);
+	TST_EXP_FAIL(utime(symname, &utimes), ELOOP);
+
+	SAFE_UNLINK(symname);
+}
+
+static void run(void)
+{
+	test_utime();
+	test_utime_no_path();
+	test_utime_loop();
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
