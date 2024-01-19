Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADB4C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 09:10:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A58E43CE2C0
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 10:10:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 929D73C8ADF
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:09:51 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 112C560311A
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:09:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D8A12115B;
 Fri, 19 Jan 2024 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705655390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0X9OtpWv8tsRotm98+coPWkbGo40eCCSQhL6oyf8rCw=;
 b=LXGiVaY46OI4y8KyFcNscpxhTqqcJjyc0tVeCmJKHe2Zp9FVcFIi2aGncmuXBw60DIFTCl
 0em097Tcy+5Dbmwd6xNir17NYUUy3ua6Lgr8jwF+Zsv4ZXG7EoV987zzmqQZPGycU5iGr4
 37A1I7ccg0XR9GZQ1CLc414PMcNKH8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705655390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0X9OtpWv8tsRotm98+coPWkbGo40eCCSQhL6oyf8rCw=;
 b=tVi4R6rkbX5nmiXBn9hlM/ZAQvgwkFH2HbnhU+TFPPDyvxEGusRQ+5N5hSbSIkri8QpFqy
 mRVeUAPiflKmcNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705655390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0X9OtpWv8tsRotm98+coPWkbGo40eCCSQhL6oyf8rCw=;
 b=LXGiVaY46OI4y8KyFcNscpxhTqqcJjyc0tVeCmJKHe2Zp9FVcFIi2aGncmuXBw60DIFTCl
 0em097Tcy+5Dbmwd6xNir17NYUUy3ua6Lgr8jwF+Zsv4ZXG7EoV987zzmqQZPGycU5iGr4
 37A1I7ccg0XR9GZQ1CLc414PMcNKH8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705655390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0X9OtpWv8tsRotm98+coPWkbGo40eCCSQhL6oyf8rCw=;
 b=tVi4R6rkbX5nmiXBn9hlM/ZAQvgwkFH2HbnhU+TFPPDyvxEGusRQ+5N5hSbSIkri8QpFqy
 mRVeUAPiflKmcNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C65136F5;
 Fri, 19 Jan 2024 09:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AOm8MF08qmUzTgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Jan 2024 09:09:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 10:09:48 +0100
Message-Id: <20240119090948.14698-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LXGiVaY4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tVi4R6rk
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.985];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 1D8A12115B
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add chmod08 test
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
chmod() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  2 +-
 testcases/kernel/syscalls/chmod/.gitignore |  1 +
 testcases/kernel/syscalls/chmod/chmod08.c  | 88 ++++++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/chmod/chmod08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 00a0dd87e..cd2dbf3c1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -65,11 +65,11 @@ chdir04 chdir04
 chdir05 chdir05
 
 chmod01 chmod01
-chmod01A symlink01 -T chmod01
 chmod03 chmod03
 chmod05 chmod05
 chmod06 chmod06
 chmod07 chmod07
+chmod08 chmod08
 
 chown01 chown01
 chown01_16 chown01_16
diff --git a/testcases/kernel/syscalls/chmod/.gitignore b/testcases/kernel/syscalls/chmod/.gitignore
index 27ddfce16..f295f4dcb 100644
--- a/testcases/kernel/syscalls/chmod/.gitignore
+++ b/testcases/kernel/syscalls/chmod/.gitignore
@@ -3,3 +3,4 @@
 /chmod05
 /chmod06
 /chmod07
+/chmod08
diff --git a/testcases/kernel/syscalls/chmod/chmod08.c b/testcases/kernel/syscalls/chmod/chmod08.c
new file mode 100644
index 000000000..f7c190776
--- /dev/null
+++ b/testcases/kernel/syscalls/chmod/chmod08.c
@@ -0,0 +1,88 @@
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
+ * This test verifies that chmod() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+#define PERMS 01777
+#define TESTFILE "myobject"
+
+static char testfile[PATH_MAX];
+
+static void test_chmod_symlink(void)
+{
+	char *symname = "my_symlink0";
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_TOUCH(testfile, 0644, NULL);
+	SAFE_SYMLINK(testfile, symname);
+	SAFE_STAT(symname, &oldsym_stat);
+
+	TST_EXP_PASS(chmod(symname, PERMS));
+	SAFE_STAT(symname, &newsym_stat);
+
+	TST_EXP_EQ_LI(newsym_stat.st_mode & PERMS, PERMS);
+	TST_EXP_EXPR(oldsym_stat.st_mode != newsym_stat.st_mode,
+		"file mode has changed");
+
+	SAFE_UNLINK(symname);
+	remove(testfile);
+}
+
+static void test_chmod_no_symlink(void)
+{
+	char *symname = "my_symlink1";
+
+	SAFE_SYMLINK("bc+eFhi!k", symname);
+	TST_EXP_FAIL(chmod(symname, 0644), ENOENT);
+
+	SAFE_UNLINK(symname);
+}
+
+static void test_chmod_loop(void)
+{
+	char *symname = "my_symlink2";
+
+	SAFE_SYMLINK(symname, symname);
+	TST_EXP_FAIL(chmod(symname, 0644), ELOOP);
+
+	SAFE_UNLINK(symname);
+}
+
+static void setup(void)
+{
+	int tmplen;
+	char *tmpdir;
+
+	tmpdir = tst_get_tmpdir();
+	tmplen = strlen(tmpdir);
+
+	testfile[tmplen] = '/';
+	memcpy(testfile, tmpdir, tmplen);
+	memcpy(testfile + tmplen + 1, TESTFILE, strlen(TESTFILE));
+}
+
+static void run(void)
+{
+	test_chmod_symlink();
+	test_chmod_no_symlink();
+	test_chmod_loop();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
