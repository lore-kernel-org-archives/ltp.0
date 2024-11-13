Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A14D41C3E
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 13:03:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FF573D66AF
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 14:03:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48F623D662E
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 14:02:22 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9434711F236D
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 14:02:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9361321133
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731502939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twk1JbzatRLFZnUgoPrytipPtTynrTKgy9EdzNqBwq0=;
 b=kywDep8mzjGpmXX3TZEPKkvfVXvRdx/OFFdzzrEdtJoZ6GgE6IZo29MbQty2FZDiF6R3e4
 3EWVjRzOKYwdHZUPjdvsJEL0QUfzp1m2tMzrCTAcUyHzQQlfmzXQHoWyogcbELUUzFaiYx
 f2AOeIZVEUcy8vL0Z2NizDHIQa4wFFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731502939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twk1JbzatRLFZnUgoPrytipPtTynrTKgy9EdzNqBwq0=;
 b=HcR1oAQIQphzWE6cTvuPB0jonaOb6+FJTUayN9iTLqIv+JR1p2K4qmOLDC8GffyhYxVDpp
 JHncuDxaLRh19ZDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731502939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twk1JbzatRLFZnUgoPrytipPtTynrTKgy9EdzNqBwq0=;
 b=kywDep8mzjGpmXX3TZEPKkvfVXvRdx/OFFdzzrEdtJoZ6GgE6IZo29MbQty2FZDiF6R3e4
 3EWVjRzOKYwdHZUPjdvsJEL0QUfzp1m2tMzrCTAcUyHzQQlfmzXQHoWyogcbELUUzFaiYx
 f2AOeIZVEUcy8vL0Z2NizDHIQa4wFFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731502939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twk1JbzatRLFZnUgoPrytipPtTynrTKgy9EdzNqBwq0=;
 b=HcR1oAQIQphzWE6cTvuPB0jonaOb6+FJTUayN9iTLqIv+JR1p2K4qmOLDC8GffyhYxVDpp
 JHncuDxaLRh19ZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AE7013AEE
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OJlgFFujNGfrPgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 13 Nov 2024 14:02:11 +0100
MIME-Version: 1.0
Message-Id: <20241113-setresgid_refactoring-v1-1-b6d07400e374@suse.com>
References: <20241113-setresgid_refactoring-v1-0-b6d07400e374@suse.com>
In-Reply-To: <20241113-setresgid_refactoring-v1-0-b6d07400e374@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731502939; l=8784;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=PXKce1+4RuG0v6b5cfbFitFFkvElQgjiKwLJJswYlto=;
 b=0pJK1B40xa+3W9gsBc8GT3WPDV00uq7l/GSBD6zz4gE6Xxdl+iK7eDNP94yeiXeCB7FAMj671
 Qj3aWP9E/EnBqQr5kx0aNR5t6Rh7COz5LkNUiGx1M/rTuCYr1/n3YJk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Refactor setresgit01 test
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

Simplify general structure, using struct passwd only when it's strictly
needed and use new LTP API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/setresgid/setresgid01.c | 264 ++++++----------------
 1 file changed, 69 insertions(+), 195 deletions(-)

diff --git a/testcases/kernel/syscalls/setresgid/setresgid01.c b/testcases/kernel/syscalls/setresgid/setresgid01.c
index d66c42261e635c03c81b80955d1966b7be61efc9..a6692aedc6bb681696b7a17a41d8b6e20f1fd95d 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid01.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid01.c
@@ -1,216 +1,90 @@
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
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : setresgid01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking functionality of setresgid(2)
- *
- *    TEST CASE TOTAL   : 5
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *      Verify that,
- *	1. setresgid(2) is successful for setresgid(-1, -1, -1)
- *	2. setresgid(2) is successful for setresgid(-1, -1, nobody)
- *	3. setresgid(2) is successful for setresgid(-1, nobody, -1)
- *	4. setresgid(2) is successful for setresgid(nobody, -1, -1)
- *	5. setresgid(2) is successful for setresgid(root, root, root)
- *
- *      Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Check existence of root and nobody user id's
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
- *  setresgid01 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
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
+ * Verify that setresgid() syscall correctly sets real user ID, effective user
+ * ID and the saved set-user ID in the calling process.
+ */
 
-#define EXP_RET_VAL	0
+#define _GNU_SOURCE
 
-struct test_case_t {		/* test case structure */
-	uid_t *rgid;		/* real GID */
-	uid_t *egid;		/* effective GID */
-	uid_t *sgid;		/* saved GID */
-	struct passwd *exp_rgid;	/* Expected real GID */
-	struct passwd *exp_egid;	/* Expected effective GID */
-	struct passwd *exp_sgid;	/* Expected saved GID */
-	char *desc;		/* Test description */
+#include <pwd.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"
+
+struct tcase {
+	uid_t *rgid;
+	uid_t *egid;
+	uid_t *sgid;
+	uid_t *exp_rgid;
+	uid_t *exp_egid;
+	uid_t *exp_sgid;
 };
 
-TCID_DEFINE(setresgid01);
-static int testno;
-static struct passwd nobody, root;
-static uid_t nobody_gid, root_gid, neg = -1;
-
-static int test_functionality(uid_t, uid_t, uid_t);
-static void setup(void);
-static void cleanup(void);
-
-/* Don't change order of these test cases */
-static struct test_case_t tdat[] = {
-	{&neg, &neg, &neg, &root, &root, &root,
-	 "setresgid(-1, -1, -1)"},
-	{&neg, &neg, &nobody.pw_gid, &root, &root, &nobody,
-	 "setresgid(-1, -1, nobody)"},
-	{&neg, &nobody.pw_gid, &neg, &root, &nobody, &nobody,
-	 "setresgid(-1, nobody, -1)"},
-	{&nobody.pw_gid, &neg, &neg, &nobody, &nobody, &nobody,
-	 "setresgid(nobody, -1, -1)"},
-	{&root.pw_gid, &root.pw_gid, &root.pw_gid, &root, &root, &root,
-	 "setresgid(root, root, root)"},
+static uid_t nobody_gid;
+static uid_t root_gid;
+static uid_t neg = -1;
+
+static struct tcase tcases[] = {
+	{
+		&neg, &neg, &neg,
+		&root_gid, &root_gid, &root_gid,
+	},
+	{
+		&neg, &neg, &nobody_gid,
+		&root_gid, &root_gid, &nobody_gid,
+	},
+	{
+		&neg, &nobody_gid, &neg,
+		&root_gid, &nobody_gid, &nobody_gid,
+	},
+	{
+		&nobody_gid, &neg, &neg,
+		&nobody_gid, &nobody_gid, &nobody_gid,
+	},
+	{
+		&root_gid, &root_gid, &root_gid,
+		&root_gid, &root_gid, &root_gid,
+	},
 };
 
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
+static void run(unsigned int n)
 {
-	int lc;
+	struct tcase *tc = &tcases[n];
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	uid_t cur_rgid;
+	uid_t cur_egid;
+	uid_t cur_sgid;
 
-	setup();
+	SAFE_SETRESGID(*tc->rgid, *tc->egid, *tc->sgid);
+	SAFE_GETRESGID(&cur_rgid, &cur_egid, &cur_sgid);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			TEST(SETRESGID(cleanup, *tdat[testno].rgid, *tdat[testno].egid,
-				       *tdat[testno].sgid));
-
-			if (TEST_RETURN == EXP_RET_VAL) {
-				if (!test_functionality
-				    (tdat[testno].exp_rgid->pw_gid,
-				     tdat[testno].exp_egid->pw_gid,
-				     tdat[testno].exp_sgid->pw_gid)) {
-
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
+	TST_EXP_EQ_LI(*tc->exp_rgid, cur_rgid);
+	TST_EXP_EQ_LI(*tc->exp_egid, cur_egid);
+	TST_EXP_EQ_LI(*tc->exp_sgid, cur_sgid);
 }
 
-static int test_functionality(uid_t exp_rgid, uid_t exp_egid, uid_t exp_sgid)
+static void setup(void)
 {
-	uid_t cur_rgid, cur_egid, cur_sgid;
+	struct passwd *pwd_buf;
 
-	/* Get current real, effective and saved group id's */
-	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
+	pwd_buf = SAFE_GETPWNAM("root");
+	GID16_CHECK(pwd_buf->pw_gid, "setresgid");
+	root_gid = pwd_buf->pw_gid;
 
-	if ((cur_rgid == exp_rgid) && (cur_egid == exp_egid)
-	    && (cur_sgid == exp_sgid)) {
-		return 0;
-	}
-	return 1;
+	pwd_buf = SAFE_GETPWNAM("nobody");
+	GID16_CHECK(pwd_buf->pw_gid, "setresgid");
+	nobody_gid = pwd_buf->pw_gid;
 }
 
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
-
-	}
-	root = *passwd_p;
-	GID16_CHECK((root_gid = root.pw_gid), "setresgid", cleanup)
-
-	if ((passwd_p = getpwnam("nobody")) == NULL) {
-		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
-
-	}
-	nobody = *passwd_p;
-	GID16_CHECK((nobody_gid = nobody.pw_gid), "setresgid", cleanup)
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-}
-
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
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
