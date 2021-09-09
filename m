Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B62C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9D461101
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E9D461101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 347033C8E51
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 17:52:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC2C33C8D80
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC0322005DC
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB4EF223C8
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631202687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTNwCxDURqDqTHPqBcZ2EaFZQjFLUUKhELbFGnCg3Ko=;
 b=NTP4zX1lvelyT0xNU5mBXo90hGLlRfwOw3Bkfp68FD8b+QYOO74y4mL6wRfIO9qSdv4+19
 B9Ns91EhIZFrGbxwIz9JK8wA9opAo+FX6EoFZYPweOG0n1d5aGcJNEpk/vN3ImTzaIH8fl
 YelXY3CmYBx1w0I2Z5COzdddp8UbOXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631202687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yTNwCxDURqDqTHPqBcZ2EaFZQjFLUUKhELbFGnCg3Ko=;
 b=DENBIjHH+GhF+395sNx+j2+gWm/FwmltUaY8xLWUS268o7/MlxCiUp3RM8CH7llRL+3/8C
 wWI+QbByKMY4RtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7DAF13E37
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sB72K38tOmFZXwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Sep 2021 15:51:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Sep 2021 17:51:22 +0200
Message-ID: <20210909155126.2720-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909155126.2720-1-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/8] syscalls/setresgid02: Convert to new API
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
Message-ID: <20210909155122.64SJL-9W36WBN6Awo68aMERzjG__E-rcJDlY57uZno0@z>

The original test looks up specific usernames which may not exist on some
systems. Use any two non-root IDs instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/setresgid/setresgid02.c   | 271 ++++--------------
 1 file changed, 62 insertions(+), 209 deletions(-)

diff --git a/testcases/kernel/syscalls/setresgid/setresgid02.c b/testcases/kernel/syscalls/setresgid/setresgid02.c
index 2c45fc27a..13b8689f0 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid02.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid02.c
@@ -1,237 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
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
+ *    AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : setresgid02
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking functionality of setresgid(2) for
- *			  non-root group id.
- *
- *    TEST CASE TOTAL   : 6
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *      Verify that for non-root effective group id,
- *	1. setresgid(2) is successful for setresgid(-1, -1, -1)
- *	2. setresgid(2) is successful for setresgid(-1, -1, bin)
- *	3. setresgid(2) is successful for setresgid(-1, bin, -1)
- *	4. setresgid(2) is successful for setresgid(bin, -1, -1)
- *	5. setresgid(2) is successful for setresgid(root, root, root)
- *	6. setresgid(2) is successful for setresgid(root, nobody, nobody)
- *
- *      Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Check existence of root, bin and nobody user id's
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return value and functionality, if success,
- *		 Issue PASS message
- *	Otherwise,
- *		Issue FAIL message
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  setresgid02 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- * CHANGE:  Madhu T L <madhu.tarikere@wipro.com>
- * Date: April 9 2003
- * Replaced setegid() by setresgid() in setup()
- ****************************************************************/
 
-#define _GNU_SOURCE 1
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+/*\
+ * [Description]
+ *
+ * Verify that setresgid() will successfully set the expected GID when called
+ * by root with the following combinations of arguments:
+ * 1. setresgid(-1, -1, -1)
+ * 2. setresgid(-1, -1, other)
+ * 3. setresgid(-1, other, -1)
+ * 4. setresgid(other, -1, -1)
+ * 5. setresgid(root, root, root)
+ * 6. setresgid(root, main, main)
+ */
 
-#define EXP_RET_VAL	0
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
 struct test_case_t {		/* test case structure */
-	uid_t *rgid;		/* real GID */
-	uid_t *egid;		/* effective GID */
-	uid_t *sgid;		/* saved GID */
-	struct passwd *exp_rgid;	/* Expected real GID */
-	struct passwd *exp_egid;	/* Expected effective GID */
-	struct passwd *exp_sgid;	/* Expected saved GID */
+	gid_t *rgid;		/* real GID */
+	gid_t *egid;		/* effective GID */
+	gid_t *sgid;		/* saved GID */
+	gid_t *exp_rgid;	/* Expected real GID */
+	gid_t *exp_egid;	/* Expected effective GID */
+	gid_t *exp_sgid;	/* Expected saved GID */
 	char *desc;		/* Test description */
 };
 
-TCID_DEFINE(setresgid02);
-static int testno;
-static struct passwd nobody, bin, root;
-static uid_t nobody_gid, root_gid, bin_gid, neg = -1;
-
-static int test_functionality(uid_t, uid_t, uid_t);
-static void setup(void);
-static void cleanup(void);
+static gid_t root_gid, main_gid, other_gid, neg = -1;
 
 /* Don't change order of these test cases */
-static struct test_case_t tdat[] = {
-	{&neg, &neg, &neg, &root, &nobody, &nobody,
+static struct test_case_t test_cases[] = {
+	{&neg, &neg, &neg, &root_gid, &main_gid, &main_gid,
 	 "setresgid(-1, -1, -1)"},
-	{&neg, &neg, &bin.pw_gid, &root, &nobody, &bin,
-	 "setresgid(-1, -1, bin)"},
-	{&neg, &bin.pw_gid, &neg, &root, &bin, &bin,
-	 "setresgid(-1, bin, -1)"},
-	{&bin.pw_gid, &neg, &neg, &bin, &bin, &bin,
-	 "setresgid(bin, -1, -1)"},
-	{&root.pw_gid, &root.pw_gid, &root.pw_gid, &root, &root, &root,
+	{&neg, &neg, &other_gid, &root_gid, &main_gid, &other_gid,
+	 "setresgid(-1, -1, other)"},
+	{&neg, &other_gid, &neg, &root_gid, &other_gid, &other_gid,
+	 "setresgid(-1, other, -1)"},
+	{&other_gid, &neg, &neg, &other_gid, &other_gid, &other_gid,
+	 "setresgid(other, -1, -1)"},
+	{&root_gid, &root_gid, &root_gid, &root_gid, &root_gid, &root_gid,
 	 "setresgid(root, root, root)"},
-	{&root.pw_gid, &nobody.pw_gid, &nobody.pw_gid, &root, &nobody, &nobody,
-	 "setresgid(root, nobody, nobody)"},
+	{&root_gid, &main_gid, &main_gid, &root_gid, &main_gid, &main_gid,
+	 "setresgid(root, main, main)"},
 };
 
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
+	gid_t test_groups[3];
 
-			TEST(SETRESGID(cleanup, *tdat[testno].rgid, *tdat[testno].egid,
-				       *tdat[testno].sgid));
+	root_gid = test_groups[0] = getgid();
+	tst_get_gids(test_groups, 1, 3);
+	main_gid = test_groups[1];
+	other_gid = test_groups[2];
 
-			if (TEST_RETURN == EXP_RET_VAL) {
-				if (!test_functionality
-				    (tdat[testno].exp_rgid->pw_gid,
-				     tdat[testno].exp_egid->pw_gid,
-				     tdat[testno].exp_sgid->pw_gid)) {
+	GID16_CHECK(root_gid, setresgid);
+	GID16_CHECK(main_gid, setresgid);
+	GID16_CHECK(other_gid, setresgid);
 
-					tst_resm(TPASS, "Test for %s "
-						 "successful",
-						 tdat[testno].desc);
-				} else {
-					tst_resm(TFAIL, "Functionality test "
-						 "for %s failed",
-						 tdat[testno].desc);
-				}
-			} else {
-				tst_resm(TFAIL, "Test for %s failed; returned"
-					 " %ld (expected %d), errno %d (expected"
-					 " 0)", tdat[testno].desc,
-					 TEST_RETURN, EXP_RET_VAL, TEST_ERRNO);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
+	/* Set effective/saved GID to main GID */
+	SAFE_SETRESGID(-1, main_gid, main_gid);
 }
 
-static int test_functionality(uid_t exp_rgid, uid_t exp_egid, uid_t exp_sgid)
+static void run(unsigned int n)
 {
-	uid_t cur_rgid, cur_egid, cur_sgid;
-
-	/* Get current real, effective and saved group id */
-	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
-
-	if ((cur_rgid == exp_rgid) && (cur_egid == exp_egid)
-	    && (cur_sgid == exp_sgid)) {
-		return 0;
-	}
-	return 1;
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-	struct passwd *passwd_p;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	if ((passwd_p = getpwnam("root")) == NULL) {
-		tst_brkm(TBROK, NULL, "getpwnam() failed for root");
+	const struct test_case_t *tc = test_cases + n;
 
-	}
-	root = *passwd_p;
-	GID16_CHECK((root_gid = root.pw_gid), "setresgid", cleanup)
+	TST_EXP_PASS_SILENT(SETRESGID(*tc->rgid, *tc->egid, *tc->sgid), "%s",
+		tc->desc);
 
-	if ((passwd_p = getpwnam("bin")) == NULL) {
-		tst_brkm(TBROK, NULL, "bin user id doesn't exist");
+	if (!TST_PASS)
+		return;
 
-	}
-	bin = *passwd_p;
-	GID16_CHECK((bin_gid = bin.pw_gid), "setresgid", cleanup)
-
-	if ((passwd_p = getpwnam("nobody")) == NULL) {
-		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
-
-	}
-	nobody = *passwd_p;
-	GID16_CHECK((nobody_gid = nobody.pw_gid), "setresgid", cleanup)
-
-	/* Set effective/saved gid to nobody */
-	if (setresgid(-1, nobody_gid, nobody_gid) == -1) {
-		tst_brkm(TBROK, NULL, "setup() failed for setting while"
-			 " setting real/effective/saved gid");
-
-	}
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
+	if (tst_check_resgid(tc->desc, *tc->exp_rgid, *tc->exp_egid,
+		*tc->exp_sgid))
+		tst_res(TPASS, "%s works as expected", tc->desc);
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
+	.tcnt = ARRAY_SIZE(test_cases),
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
