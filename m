Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF2BC48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 13:40:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C735A3D137E
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 14:40:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3045F3C0706
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 14:40:34 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 72B30201DDC
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 14:40:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE6B81F7FC
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708350032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lgC70GZN9cr2ExBOe6D3s73zcypG5q1YEv5YGjsYneQ=;
 b=KltfnWtAiVqaDhzDr1WVML/MHwPxfi2DArVBO95UyKHbJZ/TsDE/KLq4hjIehup/BFtCaf
 xAqdtWyP/HLvBbeJT10rYjfnyRils24+0232EY17Ws2t7nknNDWDqh8TLtMoWau2XyN6lr
 yjXL/ryvXAsXFEE7Sje/c07fGUdBbNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708350032;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lgC70GZN9cr2ExBOe6D3s73zcypG5q1YEv5YGjsYneQ=;
 b=agm8FIZaWaG9aYcsqWix3zX92ZFty5UNWgo1abAa2qPmI8e5xQBRG9zDxdYdCnIgjsGOp9
 /tzJlvuCSMBe+hBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708350031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lgC70GZN9cr2ExBOe6D3s73zcypG5q1YEv5YGjsYneQ=;
 b=w6RcWTUO6QfnqO3dUIP/2ayKp+YF2SoO1fIA9V6XUDQyiZHCewIGsYjJVipfwGDWvFRILH
 qRRfaP1udgoyFJBh1SmH4/2dnF6EOHjQ7P7socqzI2QGjXvaIq4AYXjGgnuirVXrGsKCx8
 +kkcYiXSTA42jD9NTbXOoA4p1aZu9D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708350031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lgC70GZN9cr2ExBOe6D3s73zcypG5q1YEv5YGjsYneQ=;
 b=7vR/bcSbmsJo9K2ZM2pcNJm3gA5zJ9UpK/z6x3nTwFS7494ZtOvv77IFgSkndKGCPZ3sy5
 p/rNisJrrAsWZhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF74C139D0
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 13:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SH/6LU9a02U7VAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 13:40:31 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 19 Feb 2024 14:40:29 +0100
Message-ID: <20240219134030.12693-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open07: Convert to new API
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
 testcases/kernel/syscalls/open/open07.c | 289 +++++-------------------
 1 file changed, 60 insertions(+), 229 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open07.c b/testcases/kernel/syscalls/open/open07.c
index f36db00cb..87743f51d 100644
--- a/testcases/kernel/syscalls/open/open07.c
+++ b/testcases/kernel/syscalls/open/open07.c
@@ -1,249 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
+ *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2024 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * NAME
- *	open07.c
- *
- * DESCRIPTION
- *	Test the open(2) system call to ensure that it sets ELOOP correctly.
- *
- * CALLS
- *	open()
- *
- * ALGORITHM
- *	1. Create a symbolic link to a file, and call open(O_NOFOLLOW). Check
- *	   that it returns ELOOP.
+/*\
+ * [Description]
  *
- *	2. Create a symbolic link to a directory, and call open(O_NOFOLLOW).
- *	   Check that it returns ELOOP.
- *
- *	3. Create a symbolic link to a symbolic link, and call open(O_NOFOLLOW).
- *	   Check that it returns ELOOP.
- *
- *	4. Create a symbolic link to a symbolically linked directory, and call
- *	   open(O_NOFOLLOW). Check that it returns ELOOP.
- *
- *	5. Create a symbolic link to a directory, and call
- *         open("link/", O_NOFOLLOW). Check that it succeeds.
- *
- * USAGE:  <for command-line>
- *  open07 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * Test functionality and error conditions of open(O_NOFOLLOW) system call.
  */
+
 #define _GNU_SOURCE		/* for O_NOFOLLOW */
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-static void setupfunc_test1();
-static void setupfunc_test2();
-static void setupfunc_test3();
-static void setupfunc_test4();
-static void setupfunc_test5();
-
-char *TCID = "open07";
-int TST_TOTAL = 5;
-
-static int fd1, fd2;
-
-static struct test_case_t {
-	char *desc;
-	char filename[100];
-	int flags;
-	int mode;
-	void (*setupfunc) ();
-	int exp_errno;
-} TC[] = {
-	{"Test for ELOOP on f2: f1 -> f2", {},
-	 O_NOFOLLOW, 00700, setupfunc_test1, ELOOP},
-	{"Test for ELOOP on d2: d1 -> d2", {},
-	 O_NOFOLLOW, 00700, setupfunc_test2, ELOOP},
-	{"Test for ELOOP on f3: f1 -> f2 -> f3", {},
-	 O_NOFOLLOW, 00700, setupfunc_test3, ELOOP},
-	{"Test for ELOOP on d3: d1 -> d2 -> d3", {},
-	 O_NOFOLLOW, 00700, setupfunc_test4, ELOOP},
-	{"Test for success on d2: d1 -> d2", {},
-	 O_NOFOLLOW, 00700, setupfunc_test5, 0},
-	{NULL, {}, 0, 0, NULL, 0}
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define TESTFILE "testfile"
+#define TESTDIR "testdir"
+#define SYMFILE1 "symfile1"
+#define SYMFILE2 "symfile2"
+#define SYMDIR1 "symdir1"
+#define SYMDIR2 "symdir2"
+#define PASSFILE "symdir1/testfile"
+
+static int fd = -1;
+
+static struct testcase {
+	const char *path;
+	int err;
+	const char *desc;
+} testcase_list[] = {
+	{SYMFILE1, ELOOP, "open(O_NOFOLLOW) a symlink to file"},
+	{SYMFILE2, ELOOP, "open(O_NOFOLLOW) a double symlink to file"},
+	{SYMDIR1, ELOOP, "open(O_NOFOLLOW) a symlink to directory"},
+	{SYMDIR2, ELOOP, "open(O_NOFOLLOW) a double symlink to directory"},
+	{PASSFILE, 0, "open(O_NOFOLLOW) a file in symlinked directory"},
 };
 
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* run the setup routines for the individual tests */
-	for (i = 0; i < TST_TOTAL; i++) {
-		if (TC[i].setupfunc != NULL)
-			TC[i].setupfunc();
-	}
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; TC[i].desc != NULL; ++i) {
-			TEST(open(TC[i].filename, TC[i].flags, TC[i].mode));
-
-			if (TC[i].exp_errno != 0) {
-				if (TEST_RETURN != -1) {
-					tst_resm(TFAIL, "open succeeded "
-						 "unexpectedly");
-				}
-
-				if (TEST_ERRNO != TC[i].exp_errno) {
-					tst_resm(TFAIL, "open returned "
-						 "unexpected errno, expected: "
-						 "%d, got: %d",
-						 TC[i].exp_errno, TEST_ERRNO);
-				} else {
-					tst_resm(TPASS, "open returned "
-						 "expected ELOOP error");
-				}
-			} else {
-				if (TEST_RETURN == -1) {
-					tst_resm(TFAIL, "open failed "
-						 "unexpectedly with errno %d",
-						 TEST_ERRNO);
-				} else {
-					tst_resm(TPASS, "open succeeded as "
-						 "expected");
-				}
-			}
-
-			if (TEST_RETURN != -1)
-				close(TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setupfunc_test1(void)
-{
-	char file1[100], file2[100];
-
-	sprintf(file1, "open03.1.%d", getpid());
-	sprintf(file2, "open03.2.%d", getpid());
-	fd1 = SAFE_CREAT(cleanup, file1, 00700);
-
-	SAFE_SYMLINK(cleanup, file1, file2);
-
-	strcpy(TC[0].filename, file2);
-}
-
-static void setupfunc_test2(void)
-{
-	char file1[100], file2[100];
-
-	sprintf(file1, "open03.3.%d", getpid());
-	sprintf(file2, "open03.4.%d", getpid());
-	SAFE_MKDIR(cleanup, file1, 00700);
-
-	SAFE_SYMLINK(cleanup, file1, file2);
-
-	strcpy(TC[1].filename, file2);
-}
-
-static void setupfunc_test3(void)
-{
-	char file1[100], file2[100], file3[100];
-
-	sprintf(file1, "open03.5.%d", getpid());
-	sprintf(file2, "open03.6.%d", getpid());
-	sprintf(file3, "open03.7.%d", getpid());
-	fd2 = SAFE_CREAT(cleanup, file1, 00700);
-
-	SAFE_SYMLINK(cleanup, file1, file2);
-
-	SAFE_SYMLINK(cleanup, file2, file3);
-
-	strcpy(TC[2].filename, file3);
-}
-
-static void setupfunc_test4(void)
-{
-	char file1[100], file2[100], file3[100];
-
-	sprintf(file1, "open03.8.%d", getpid());
-	sprintf(file2, "open03.9.%d", getpid());
-	sprintf(file3, "open03.10.%d", getpid());
-	SAFE_MKDIR(cleanup, file1, 00700);
-
-	SAFE_SYMLINK(cleanup, file1, file2);
-
-	SAFE_SYMLINK(cleanup, file2, file3);
-
-	strcpy(TC[3].filename, file3);
-}
-
-static void setupfunc_test5(void)
+static void setup(void)
 {
-	char file1[100], file2[100];
-
-	sprintf(file1, "open11.3.%d", getpid());
-	sprintf(file2, "open12.4.%d", getpid());
-	SAFE_MKDIR(cleanup, file1, 00700);
+	umask(0);
+	fd = SAFE_CREAT(TESTFILE, 0644);
+	SAFE_CLOSE(fd);
+	SAFE_MKDIR(TESTDIR, 0755);
 
-	SAFE_SYMLINK(cleanup, file1, file2);
+	SAFE_SYMLINK(TESTFILE, SYMFILE1);
+	SAFE_SYMLINK(SYMFILE1, SYMFILE2);
+	SAFE_SYMLINK(TESTDIR, SYMDIR1);
+	SAFE_SYMLINK(SYMDIR1, SYMDIR2);
 
-	strcpy(TC[4].filename, file2);
-	strcat(TC[4].filename, "/");
+	fd = SAFE_CREAT(PASSFILE, 0644);
+	SAFE_CLOSE(fd);
 }
 
-static void setup(void)
+static void run(unsigned int n)
 {
-	umask(0);
+	const struct testcase *tc = testcase_list + n;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TST_RET = -1;
 
-	TEST_PAUSE;
+	if (tc->err) {
+		TST_EXP_FAIL2(open(tc->path, O_NOFOLLOW | O_RDONLY), tc->err,
+			"%s", tc->desc);
+	} else {
+		TST_EXP_FD(open(tc->path, O_NOFOLLOW | O_RDONLY),
+			"%s", tc->desc);
+	}
 
-	tst_tmpdir();
+	if (TST_RET >= 0)
+		SAFE_CLOSE(TST_RET);
 }
 
-static void cleanup(void)
-{
-	close(fd1);
-	close(fd2);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.needs_tmpdir = 1
+};
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
