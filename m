Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B2CC433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 09:33:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B8C03CA41D
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 11:33:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B1193C6463
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 11:33:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E4AA11A0027D
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 11:33:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0359A1F38C;
 Tue,  5 Apr 2022 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649151192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aUQAjUbzFDyI39rcoXhgwsvT0IeSUzQUHtEklINTSxw=;
 b=zKqVs3tsmkPclmCz0V74biDusgUb7vYZFmbj4pIr5RhDFP+G1RLjwsjV4WTC996nLelEOt
 ciJw4d38A7cBRooKHuOEDwN51pNsPVrkvgWd0fAVGOrs4DFLovIU8Yi09dbw3GHxnakX20
 HaeVn1n116tkFrQMEPQfj8TJLtXXE9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649151192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aUQAjUbzFDyI39rcoXhgwsvT0IeSUzQUHtEklINTSxw=;
 b=IuNIg4rYE+EcC2us5lTytWj5UCOU3dpdb5wD8/t3Dh8TQmNL8tYnvfHD+A9yKJ/BApCZ3k
 G1kfFVDO3cwnRVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C454A132B7;
 Tue,  5 Apr 2022 09:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gHdALtcMTGJ3NgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 05 Apr 2022 09:33:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  5 Apr 2022 11:33:07 +0200
Message-Id: <20220405093307.6156-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] syslog12: Rewrite into new API
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

Changes:
* set also GID
* move non-root user test to the last in case SAFE_SETEGID() or
  SAFE_SETEUID() fails
* simplify test structure
* usual cleanup (remove bogus code, use safe macros, tst_syscall())

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/syslog/syslog12.c | 257 ++++----------------
 1 file changed, 54 insertions(+), 203 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog12.c b/testcases/kernel/syscalls/syslog/syslog12.c
index ac28d43c96..2b40e3abc2 100644
--- a/testcases/kernel/syscalls/syslog/syslog12.c
+++ b/testcases/kernel/syscalls/syslog/syslog12.c
@@ -1,233 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
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
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Author: Madhu T L <madhu.tarikere@wipro.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : syslog12
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking error conditions for syslog(2)
- *
- *    TEST CASE TOTAL   : 7
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify that,
- *	1. syslog(2) fails with EINVAL for invalid type/command
- *	2. syslog(2) fails with EFAULT for buffer outside program's  accessible
- *	   address space.
- *	3. syslog(2) fails with EINVAL for NULL buffer argument.
- *	4. syslog(2) fails with EINVAL for length arg. set to negative value.
- *	5. syslog(2) fails with EPERM for non-root user.
- *	6. syslog(2) fails with EINVAL for console level less than 0.
- *	7. syslog(2) fails with EINVAL for console level greater than 8.
- *
- *      Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Check existence of user nobody
- *	  Set expected errnos
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return value and errno, if matching,
- *		 Issue PASS message
- *	  Otherwise,
- *		Issue FAIL message
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
+
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  syslog12 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
+ * Verify that syslog(2) system call fails with appropriate error number:
  *
- ****************************************************************/
+ * 1. EINVAL &ndash; invalid type/command
+ * 2. EFAULT &ndash; buffer outside program's accessible address space
+ * 3. EINVAL &ndash; NULL buffer argument
+ * 4. EINVAL &ndash; length argument set to negative value
+ * 5. EINVAL &ndash; console level less than 0
+ * 6. EINVAL &ndash; console level greater than 8
+ * 7. EPERM &ndash; non-root user
+ */
 
 #include <errno.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <signal.h>
-#include <linux/unistd.h>
-#include <sys/syscall.h>
-#include "test.h"
-#include "safe_macros.h"
-
-#define EXP_RET_VAL	-1
 
-struct test_case_t {		/* test case structure */
-	int type;		/* 1st arg */
-	char *buf;		/* 2nd arg */
-	int len;		/* 3rd arg */
-	int exp_errno;		/* Expected errno */
-	int (*setup) (void);	/* Individual setup routine */
-	void (*cleanup) (void);	/* Individual cleanup routine */
-	char *desc;		/* Test description */
-};
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "tst_safe_macros.h"
 
-char *TCID = "syslog12";
-static int testno;
+#define syslog(arg1, arg2, arg3) tst_syscall(__NR_syslog, arg1, arg2, arg3)
 
 static char buf;
 static struct passwd *ltpuser;
 
-static void setup(void);
-static void cleanup(void);
-static int setup1(void);
-static void cleanup1(void);
-
-#define syslog(arg1, arg2, arg3) syscall(__NR_syslog, arg1, arg2, arg3)
-
-static struct test_case_t tdat[] = {
-	{100, &buf, 0, EINVAL, NULL, NULL, "invalid type/command"},
-	{2, NULL, 0, EINVAL, NULL, NULL, "NULL buffer argument"},
-	{3, &buf, -1, EINVAL, NULL, NULL, "negative length argument"},
-	{2, &buf, 0, EPERM, setup1, cleanup1, "non-root user"},
-	{8, &buf, -1, EINVAL, NULL, NULL, "console level less than 0"},
-	{8, &buf, 9, EINVAL, NULL, NULL, "console level greater than 8"},
-};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-void timeout(int sig)
+static void setup(void)
 {
-	tst_resm(TWARN, "syslog() timeout after 1s"
-		 " for %s", tdat[testno].desc);
+	ltpuser = SAFE_GETPWNAM("nobody");
 }
 
-int main(int argc, char **argv)
+static void setup_nonroot(void)
 {
-	int lc;
-	struct sigaction sa;
-	int ret;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	memset(&sa, 0, sizeof(struct sigaction));
-	sa.sa_handler = timeout;
-	sa.sa_flags = 0;
-	sigaction(SIGALRM, &sa, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			if (tdat[testno].setup && tdat[testno].setup()) {
-				/* Setup failed, skip this testcase */
-				continue;
-			}
-
-			alarm(1);
-
-			TEST(syslog(tdat[testno].type, tdat[testno].buf,
-				    tdat[testno].len));
-
-			alarm(0);
-			/* syslog returns an int, so we need to turn the long
-			 * TEST_RETURN into an int to test with */
-			ret = TEST_RETURN;
-			if ((ret == EXP_RET_VAL) &&
-			    (TEST_ERRNO == tdat[testno].exp_errno)) {
-				tst_resm(TPASS, "syslog() failed as expected"
-					 " for %s : errno %d",
-					 tdat[testno].desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "syslog() returned "
-					 "unexpected results for %s ; returned"
-					 " %d (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc,
-					 ret, EXP_RET_VAL, TEST_ERRNO,
-					 tdat[testno].exp_errno);
-			}
-
-			if (tdat[testno].cleanup) {
-				tdat[testno].cleanup();
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
+	SAFE_SETEGID(ltpuser->pw_gid);
+	SAFE_SETEUID(ltpuser->pw_uid);
 }
 
-int setup1(void)
+static void cleanup_nonroot(void)
 {
-	/* Change effective user id to nodody */
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TBROK, "seteuid failed to set the effective"
-			 " uid to %d", ltpuser->pw_uid);
-		return 1;
-	}
-	return 0;
+	SAFE_SETEUID(0);
 }
 
-void cleanup1(void)
-{
-	/* Change effective user id to root */
-	SAFE_SETEUID(NULL, 0);
-}
+static struct tcase {
+	int type;
+	char *buf;
+	int len;
+	int exp_errno;
+	char *desc;
+} tcases[] = {
+	{100, &buf, 0, EINVAL, "invalid type/command"},
+	{2, NULL, 0, EINVAL, "NULL buffer argument"},
+	{3, &buf, -1, EINVAL, "negative length argument"},
+	{8, &buf, -1, EINVAL, "console level less than 0"},
+	{8, &buf, 9, EINVAL, "console level greater than 8"},
+	{2, &buf, 0, EPERM, "non-root user"},
+};
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void run(unsigned int n)
 {
-	tst_require_root();
+	struct tcase *tc = &tcases[n];
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (n == ARRAY_SIZE(tcases)-1)
+		setup_nonroot();
 
-	/* Check for nobody_uid user id */
-	if ((ltpuser = getpwnam("nobody")) == NULL) {
-		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
-	}
+	TST_EXP_FAIL(syslog(tc->type, tc->buf, tc->len), tc->exp_errno,
+		"syslog() with %s", tc->desc);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
+	if (n == ARRAY_SIZE(tcases)-1)
+		cleanup_nonroot();
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
