Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A41C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 15:16:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F9AA3CFCD2
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 16:16:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 147D63C62C0
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:15:51 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1471214011A4
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 16:15:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3448521DB0;
 Thu, 18 Jan 2024 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705590950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xpb9fZ5YH9gOjvmeSjbX//+dN6uKYYcHyll1xdDtKmc=;
 b=AGgIvoP+JXjgAtZV7VFYQ0UTq92WXqo5qg3RZMjz9JZo6yLFO5v+21dC1rMT3ATVqoBZll
 i75s34ze1f5ACOp/3Xla0CenvcIi86YjChLpC0cuE80fS4gwzXR4CLRC3hCSB+zTbt7uCV
 djSvTtS3rloyScoFrs8HBzTjN2DJxYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705590950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xpb9fZ5YH9gOjvmeSjbX//+dN6uKYYcHyll1xdDtKmc=;
 b=qHD6UzcUDGS950mhSsIfzF47zbs4A0YCiLJEuR+5qJRYpV6857t2BKcYCS7A9JtkXzo8lw
 /adB1cNPewnlpUAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705590950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xpb9fZ5YH9gOjvmeSjbX//+dN6uKYYcHyll1xdDtKmc=;
 b=AGgIvoP+JXjgAtZV7VFYQ0UTq92WXqo5qg3RZMjz9JZo6yLFO5v+21dC1rMT3ATVqoBZll
 i75s34ze1f5ACOp/3Xla0CenvcIi86YjChLpC0cuE80fS4gwzXR4CLRC3hCSB+zTbt7uCV
 djSvTtS3rloyScoFrs8HBzTjN2DJxYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705590950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xpb9fZ5YH9gOjvmeSjbX//+dN6uKYYcHyll1xdDtKmc=;
 b=qHD6UzcUDGS950mhSsIfzF47zbs4A0YCiLJEuR+5qJRYpV6857t2BKcYCS7A9JtkXzo8lw
 /adB1cNPewnlpUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01D8013874;
 Thu, 18 Jan 2024 15:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6aZSOaVAqWWiKwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jan 2024 15:15:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 18 Jan 2024 16:15:47 +0100
Message-Id: <20240118151547.12980-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AGgIvoP+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qHD6UzcU
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3448521DB0
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add stat04 test
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

This test has been extracted from symlink01 test and it tests stat()
functionalities on symlink generated file.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/smoketest                         |  2 +-
 runtest/syscalls                          |  4 +-
 testcases/kernel/syscalls/stat/.gitignore |  2 +
 testcases/kernel/syscalls/stat/stat04.c   | 75 +++++++++++++++++++++++
 4 files changed, 80 insertions(+), 3 deletions(-)
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
index 6e2407879..8dd8a49ca 100644
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
index 000000000..879eec996
--- /dev/null
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner
+ *    Copilot: Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that stat() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+static void test_stat(void)
+{
+	char *symname = "my_symlink0";
+
+	TST_EXP_PASS(symlink(tst_get_tmpdir(), symname));
+
+	struct stat path_stat;
+	struct stat link_stat;
+
+	SAFE_STAT(tst_get_tmpdir(), &path_stat);
+	SAFE_STAT(symname, &link_stat);
+
+	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
+	TST_EXP_EQ_LI(path_stat.st_mode, link_stat.st_mode);
+	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
+	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
+	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
+	TST_EXP_EQ_LI(path_stat.st_size, link_stat.st_size);
+	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
+	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
+	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_stat_no_path(void)
+{
+	char *symname = "my_symlink1";
+	struct stat link_stat;
+
+	TST_EXP_PASS(symlink("bc+eFhi!k", symname));
+	TST_EXP_FAIL(stat(symname, &link_stat), ENOENT);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_stat_loop(void)
+{
+	char *symname = "my_symlink2";
+	struct stat link_stat;
+
+	TST_EXP_PASS(symlink(symname, symname));
+	TST_EXP_FAIL(stat(symname, &link_stat), ELOOP);
+
+	SAFE_UNLINK(symname);
+}
+
+static void run(void)
+{
+	test_stat();
+	test_stat_no_path();
+	test_stat_loop();
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
