Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A282AC77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 15:20:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39BA63CC62B
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 17:20:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A6353CCAB9
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 17:19:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 97F931400E79
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 17:19:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DC332118A
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750778362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ab7TKjE3zKHA5bd986SQnSSrwnIXalK7iS2UJJUpIi8=;
 b=DbH8o4eBIIzq6oAbgM/qVhroICD3coRXWgs9tiTpgclH08hqbgheGz1O2RVMejIFRx/kBu
 F6Di0gpPvXDIFf5I7PioM6cQ/t/QYalGtRJNjJ4BP29crRPqrMm017ShPcfvQQfuJHFZDO
 qzgDloTIR7PHmEkXDF1wmNEtFtnjVHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750778362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ab7TKjE3zKHA5bd986SQnSSrwnIXalK7iS2UJJUpIi8=;
 b=3HpmMaJD2p64CNhd14GVfVf5N3Us4FZ/cWWEhqpt4bBcTG0REcj78T8CuV9siPIRx6G5nq
 YqXwUBw+Oyp7x5Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hDCWbBQC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3JmnSUr+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750778361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ab7TKjE3zKHA5bd986SQnSSrwnIXalK7iS2UJJUpIi8=;
 b=hDCWbBQCOL5r1dktY6J43721WdK16w9iifvbfug56u6tnkMO7M8oticLQs4/r9/KID3Nke
 0xGz/SCQ/vju/KUUTTcifHbBMgQ14puGug/rAX3OeL5tNB1CRqwuFaNoYkmB5m6p2TbhGD
 547PsPr0W+1ZtX9J2+5C8QLlJb+YM+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750778361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ab7TKjE3zKHA5bd986SQnSSrwnIXalK7iS2UJJUpIi8=;
 b=3JmnSUr+2B5ke9+bIZYGZFGGtfOWiQ32VTpmSu9oznojUVBkaU/WpO6L8f4/owi3m26H2g
 7VKrw0pO9GSioZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F8D013751
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5R7cEvnBWmh7DAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:19:21 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Jun 2025 17:19:14 +0200
Message-ID: <20250624151918.32145-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5DC332118A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,fujitsu.com:email,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] open13: Convert to new API
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The original test created a file with christmas tree access flags. There's
no need for such risky behavior here so I've changed it to standard 0644.
Follow-up patches also add subtests for mmap() and ioctl() syscalls
as well as a verification that a new file descriptor created with dup()
will keep the O_PATH flag.

 testcases/kernel/syscalls/open/open13.c | 153 ++++++++----------------
 1 file changed, 51 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
index e777a305d..88cba4640 100644
--- a/testcases/kernel/syscalls/open/open13.c
+++ b/testcases/kernel/syscalls/open/open13.c
@@ -1,21 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2015 Fujitsu Ltd.
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.
+ * Copyright (c) 2025 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * DESCRIPTION
+/*\
  *  Basic test for O_PATH flag of open(2).
  *  "Obtain a file descriptor that can be used to perform operations
  *   that act purely at the file descriptor level, the file itself is
@@ -25,139 +15,98 @@
  *  The operations include but are not limited to the syscalls above.
  */
 
-#define _GNU_SOURCE
-
 #include "config.h"
 
-#include <errno.h>
 #ifdef HAVE_SYS_XATTR_H
 #include <sys/types.h>
 #include <sys/xattr.h>
 #endif
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 #include "lapi/fcntl.h"
 
 #define TESTFILE	"testfile"
-#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
 
-static void setup(void);
-static void verify_read(void);
-static void verify_write(void);
-static void verify_fchmod(void);
-static void verify_fchown(void);
+static int path_fd = -1;
+
+static int verify_read(int fd);
+static int verify_write(int fd);
+static int verify_fchmod(int fd);
+static int verify_fchown(int fd);
 #ifdef HAVE_SYS_XATTR_H
-static void verify_fgetxattr(void);
+static int verify_fgetxattr(int fd);
 #endif
-static void check_result(const char *call_name);
-static void cleanup(void);
 
-static int fd;
-
-static void (*test_func[])(void) = {
-	verify_read,
-	verify_write,
-	verify_fchmod,
-	verify_fchown,
+static const struct {
+	int (*func)(int fd);
+	const char *name;
+} testcases[] = {
+	{verify_read, "read"},
+	{verify_write, "write"},
+	{verify_fchmod, "fchmod"},
+	{verify_fchown, "fchown"},
 #ifdef HAVE_SYS_XATTR_H
-	verify_fgetxattr
+	{verify_fgetxattr, "fgetxattr"},
 #endif
+	{}
 };
 
-char *TCID = "open13";
-int TST_TOTAL = ARRAY_SIZE(test_func);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-	int tc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_PATH);
-
-		for (tc = 0; tc < TST_TOTAL; tc++)
-			(*test_func[tc])();
-
-		SAFE_CLOSE(cleanup, fd);
-		fd = 0;
-	}
-
-	cleanup();
-	tst_exit();
+	path_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
+	SAFE_CLOSE(path_fd);
+	path_fd = SAFE_OPEN(TESTFILE, O_PATH);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	SAFE_TOUCH(cleanup, TESTFILE, FILE_MODE, NULL);
+	int i;
 
-	TEST_PAUSE;
+	for (i = 0; testcases[i].func; i++) {
+		TST_EXP_FAIL(testcases[i].func(path_fd), EBADF, "%s()",
+			testcases[i].name);
+	}
 }
 
-static void verify_read(void)
+static int verify_read(int fd)
 {
 	char buf[255];
 
-	TEST(read(fd, buf, sizeof(buf)));
-	check_result("read(2)");
+	return read(fd, buf, sizeof(buf));
 }
 
-static void verify_write(void)
+static int verify_write(int fd)
 {
-	TEST(write(fd, "w", 1));
-	check_result("write(2)");
+	return write(fd, "w", 1);
 }
 
-static void verify_fchmod(void)
+static int verify_fchmod(int fd)
 {
-	TEST(fchmod(fd, 0666));
-	check_result("fchmod(2)");
+	return fchmod(fd, 0666);
 }
 
-static void verify_fchown(void)
+static int verify_fchown(int fd)
 {
-	TEST(fchown(fd, 1000, 1000));
-	check_result("fchown(2)");
+	return fchown(fd, 1000, 1000);
 }
 
 #ifdef HAVE_SYS_XATTR_H
-static void verify_fgetxattr(void)
+static int verify_fgetxattr(int fd)
 {
-	TEST(fgetxattr(fd, "tkey", NULL, 1));
-	check_result("fgetxattr(2)");
+	return fgetxattr(fd, "tkey", NULL, 0);
 }
 #endif
 
-static void check_result(const char *call_name)
-{
-	if (TEST_RETURN == 0) {
-		tst_resm(TFAIL, "%s succeeded unexpectedly", call_name);
-		return;
-	}
-
-	if (TEST_ERRNO != EBADF) {
-		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly, "
-			"expected EBADF", call_name);
-		return;
-	}
-
-	tst_resm(TPASS, "%s failed with EBADF", call_name);
-}
-
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "failed to close file");
-
-	tst_rmdir();
+	if (path_fd >= 0)
+		SAFE_CLOSE(path_fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
