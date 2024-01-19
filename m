Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA8CC4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 09:26:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB7A53CC841
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 10:26:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 936F03C08CF
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:26:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DF341601163
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 10:26:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D912E21FC1;
 Fri, 19 Jan 2024 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705656360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2meAEJ2XaKQi7UucOoTkQIKTXh6S7GOH8QKWxr0aYHI=;
 b=R+YCZzUOuxI8OlUTVqfsgSez6X4g9UlYLdx8yChUdX5D65FqVwrybLjZS8y0gptcKygSRQ
 vsmyxPu+Fq4zHmfU0npJ2gxZdlkV2qSjsUqTy4c9dSWtP07PaAHqdyXoD6ObReS9hWIw9p
 hq8gYkVcv79p260Xplb8IIeqBunpRWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705656360;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2meAEJ2XaKQi7UucOoTkQIKTXh6S7GOH8QKWxr0aYHI=;
 b=T9HFdtd4StYI7WaYm4KsaAfdEfpL/1PLQe7Rk45KDjCENAz40CnYOcVO7WPglHWInP6Dem
 j1goWYEGahf571BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705656359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2meAEJ2XaKQi7UucOoTkQIKTXh6S7GOH8QKWxr0aYHI=;
 b=NXAeW/aHxIkvINrLe7JEoTZ9ryKMfwMhdGKvlyV4+LxPOP5zdgcT5Y3oec1mClX0cIdGYZ
 aiJ3/3d035bh3MibSomWeoyMAbAqNyBapb4TPS+d4Czti+r840rSlWJcER75tCyLmQOV7w
 MAZloZQIR/afy21jgKl/bFfKbd7deEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705656359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2meAEJ2XaKQi7UucOoTkQIKTXh6S7GOH8QKWxr0aYHI=;
 b=BiCAwT0FAHmqmr9OIvaqyYtsNYKmRrVFRdl54rDDWXSQupqHEcX8emQUBUCRLPFU2W+qLp
 MFEbHhqKnzqTF2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98E5F1388C;
 Fri, 19 Jan 2024 09:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fGKhISdAqmUYUwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Jan 2024 09:25:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 10:25:54 +0100
Message-Id: <20240119092554.21332-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="NXAeW/aH";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BiCAwT0F
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D912E21FC1
X-Spamd-Bar: +
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add open15 test
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
open() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                          |   2 +-
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open15.c   | 147 ++++++++++++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/open/open15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..dc14b952f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -922,7 +922,6 @@ nice04 nice04
 nice05 nice05
 
 open01 open01
-open01A symlink01 -T open01
 open02 open02
 open03 open03
 open04 open04
@@ -935,6 +934,7 @@ open11 open11
 open12 open12
 open13 open13
 open14 open14
+open15 open15
 
 openat01 openat01
 openat02 openat02
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
index 001d874d6..af5997572 100644
--- a/testcases/kernel/syscalls/open/.gitignore
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -12,3 +12,4 @@
 /open12_child
 /open13
 /open14
+/open15
diff --git a/testcases/kernel/syscalls/open/open15.c b/testcases/kernel/syscalls/open/open15.c
new file mode 100644
index 000000000..0a94f613a
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,147 @@
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
+ * This test verifies that open() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+#define BIG_STRING "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
+
+static char myfile_path[PATH_MAX];
+
+static void test_open_symlink(void)
+{
+	int fd;
+	int str_size;
+	char buff[128];
+	char *symname = "my_symlink0";
+
+	str_size = strlen(BIG_STRING);
+
+	SAFE_SYMLINK(myfile_path, symname);
+
+	fd = SAFE_OPEN(symname, O_CREAT | O_RDWR, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, BIG_STRING, str_size);
+	SAFE_LSEEK(fd, 0, 0);
+	SAFE_READ(1, fd, buff, str_size);
+	SAFE_CLOSE(fd);
+
+	TST_EXP_EXPR(!strncmp(buff, BIG_STRING, str_size),
+		"symlink generated file can be opened to write data");
+
+	SAFE_UNLINK(symname);
+	remove(myfile_path);
+}
+
+static void test_open_compare(void)
+{
+	int fd_file, fd_symlink;
+	int str_size;
+	char buff_file[128];
+	char buff_symlink[128];
+	char *symname = "my_symlink1";
+
+	str_size = strlen(BIG_STRING);
+
+	fd_file = SAFE_OPEN(myfile_path, O_CREAT | O_RDWR, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file, BIG_STRING, str_size);
+
+	SAFE_SYMLINK(myfile_path, symname);
+
+	SAFE_LSEEK(fd_file, 0, 0);
+	SAFE_READ(1, fd_file, buff_file, str_size);
+
+	fd_symlink = SAFE_OPEN(symname, O_RDWR, 0777);
+	SAFE_LSEEK(fd_symlink, 0, 0);
+	SAFE_READ(1, fd_symlink, buff_symlink, str_size);
+
+	TST_EXP_EXPR(!strncmp(buff_file, buff_symlink, str_size),
+		"file data is the equivalent to symlink generated file data");
+
+	SAFE_CLOSE(fd_file);
+	SAFE_CLOSE(fd_symlink);
+
+	SAFE_UNLINK(symname);
+	remove(myfile_path);
+}
+
+static void test_open_already_exist(void)
+{
+	char *symname = "my_symlink2";
+
+	SAFE_TOUCH(myfile_path, 0644, NULL);
+	SAFE_SYMLINK(myfile_path, symname);
+
+	TST_EXP_FAIL(open(myfile_path, O_EXCL | O_CREAT, 0644), EEXIST);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+
+	SAFE_UNLINK(symname);
+	remove(myfile_path);
+}
+
+static void test_open_no_path(void)
+{
+	char *symname = "my_symlink3";
+
+	SAFE_SYMLINK(myfile_path, symname);
+
+	TST_EXP_FAIL(open(myfile_path, O_RDWR, 0644), ENOENT);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+
+	SAFE_UNLINK(symname);
+	remove(myfile_path);
+}
+
+static void test_open_loop(void)
+{
+	char *symname = "my_symlink4";
+
+	SAFE_SYMLINK(symname, symname);
+
+	TST_EXP_FAIL(open(symname, O_CREAT, 0644), ELOOP);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+
+	SAFE_UNLINK(symname);
+	remove(myfile_path);
+}
+
+static void setup(void)
+{
+	int size;
+	char *tmpdir;
+
+	tmpdir = tst_get_tmpdir();
+	size = strlen(tmpdir);
+
+	myfile_path[size] = '/';
+	memcpy(myfile_path, tmpdir, size);
+	memcpy(myfile_path + size + 1, "myfile.txt", 6);
+}
+
+static void run(void)
+{
+	test_open_symlink();
+	test_open_compare();
+	test_open_already_exist();
+	test_open_no_path();
+	test_open_loop();
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
