Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0084FC4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:45:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262D160FE6
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 262D160FE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EBD93C4EE0
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 16:45:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E5953C1DF5
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 16:44:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2EF471A00E03
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 16:44:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79BF81FFF3
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631544295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuscYu0maQ4TZKwehhyP0Lk2YDevuVExJzhyTY7hZbc=;
 b=L77IPK0aO9fcCbnXk9mJcqYyP+LLra7eXoAe/gBbmnXTo9vp6Id88nRYTpYF4hLcZNh2iR
 b24ZuigZirN2XIVdjkTXKUaptgemmcFjlCY6e75keaU3tNbo8Rhe+j1yNzYMeaplHaPhdo
 n8XSYd4k542q0pIFZfanfAnp7UzsPFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631544295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuscYu0maQ4TZKwehhyP0Lk2YDevuVExJzhyTY7hZbc=;
 b=cdDq1CaWXzM2O+WoWQgGwrxeBfxF56QcV+JZFgC6rieNvarpdp1KEwAlbXK8+l6sMSWx9d
 eSFrCIf2vyVmr8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62D9F13F17
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aLP1FudjP2FYbgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:44:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Sep 2021 16:44:52 +0200
Message-ID: <20210913144454.22992-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913144454.22992-1-mdoucha@suse.cz>
References: <20210913144454.22992-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] syscalls/setresuid01: Convert to new API
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
Message-ID: <20210913144452.7qJUS37rXnDUb8FMsIkyYMzplghx_pIzmuMLbIkgGco@z>

The original test needs user "bin" which may not exist on some systems. Use
any non-root UID instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 .../kernel/syscalls/setresuid/setresuid01.c   | 256 ++++--------------
 1 file changed, 59 insertions(+), 197 deletions(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid01.c b/testcases/kernel/syscalls/setresuid/setresuid01.c
index 9f448896b..e9eb8517e 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid01.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid01.c
@@ -1,221 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+ *	07/2001 ported by John George
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * NAME
- * 	setresuid01.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- * 	Test setresuid() when executed by root.
- *
- * ALGORITHM
- *
- *	Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *	Setup test values.
- *	Loop if the proper options are given.
- *	For each test execute the system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise,
- *		Verify the Functionality of system call
- *		if successful,
- *			Issue Functionality-Pass message.
- *		Otherwise,
- *			Issue Functionality-Fail message.
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given.
- *
- * USAGE:  <for command-line>
- *	setresuid01 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- * 	This test must be ran as root.
- *	nobody and bin must be valid users.
+ * Test setresuid() when executed by root.
  */
 
-#define _GNU_SOURCE 1
-#include <pwd.h>
-#include <stdlib.h>
-#include <string.h>
-#include "test.h"
-#include <errno.h>
-#include "compat_16.h"
-
-TCID_DEFINE(setresuid01);
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
-uid_t nobody_pw_uid, root_pw_uid, bin_pw_uid;
-uid_t neg_one = -1;
+static uid_t root_uid, main_uid, other_uid, neg_one = -1;
 
-struct passwd nobody, bin, root;
-
-/*
- * The following structure contains all test data.  Each structure in the array
- * is used for a separate test.  The tests are executed in the for loop below.
- */
-
-struct test_data_t {
+static struct test_data_t {
 	uid_t *real_uid;
 	uid_t *eff_uid;
 	uid_t *sav_uid;
-	struct passwd *exp_real_usr;
-	struct passwd *exp_eff_usr;
-	struct passwd *exp_sav_usr;
+	uid_t *exp_real_uid;
+	uid_t *exp_eff_uid;
+	uid_t *exp_sav_uid;
 	char *test_msg;
 } test_data[] = {
-	{
-	&neg_one, &neg_one, &neg_one, &root, &root, &root,
-		    "After setresuid(-1, -1, -1),"}, {
-	&neg_one, &neg_one, &nobody_pw_uid, &root, &root, &nobody,
-		    "After setresuid(-1, -1, nobody),"}, {
-	&neg_one, &bin_pw_uid, &neg_one, &root, &bin, &nobody,
-		    "After setresuid(-1, bin, -1),"}, {
-	&neg_one, &neg_one, &root_pw_uid, &root, &bin, &root,
-		    "After setresuid(-1, -1, root),"}, {
-	&neg_one, &neg_one, &bin_pw_uid, &root, &bin, &bin,
-		    "After setresuid(-1, -1, bin),"}, {
-	&neg_one, &root_pw_uid, &neg_one, &root, &root, &bin,
-		    "After setresuid(-1, root, -1),"}, {
-	&nobody_pw_uid, &neg_one, &neg_one, &nobody, &root, &bin,
-		    "After setresuid(nobody, -1, -1)"}, {
-	&neg_one, &root_pw_uid, &neg_one, &nobody, &root, &bin,
-		    "After setresuid(-1, root, -1),"}, {
-&root_pw_uid, &neg_one, &root_pw_uid, &root, &root, &root,
-		    "After setresuid(root, -1, -1),"},};
-
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
-
-void setup(void);
-void cleanup(void);
-
-void
-uid_verify(struct passwd *ru, struct passwd *eu, struct passwd *su, char *when);
-
-int main(int ac, char **av)
+	{&neg_one, &neg_one, &neg_one, &root_uid, &root_uid, &root_uid,
+		"After setresuid(-1, -1, -1),"},
+	{&neg_one, &neg_one, &main_uid, &root_uid, &root_uid, &main_uid,
+		"After setresuid(-1, -1, main),"},
+	{&neg_one, &other_uid, &neg_one, &root_uid, &other_uid, &main_uid,
+		"After setresuid(-1, other, -1),"},
+	{&neg_one, &neg_one, &root_uid, &root_uid, &other_uid, &root_uid,
+		"After setresuid(-1, -1, root),"},
+	{&neg_one, &neg_one, &other_uid, &root_uid, &other_uid, &other_uid,
+		"After setresuid(-1, -1, other),"},
+	{&neg_one, &root_uid, &neg_one, &root_uid, &root_uid, &other_uid,
+		"After setresuid(-1, root, -1),"},
+	{&main_uid, &neg_one, &neg_one, &main_uid, &root_uid, &other_uid,
+		"After setresuid(main, -1, -1)"},
+	{&neg_one, &root_uid, &neg_one, &main_uid, &root_uid, &other_uid,
+		"After setresuid(-1, root, -1),"},
+	{&root_uid, &neg_one, &root_uid, &root_uid, &root_uid, &root_uid,
+		"After setresuid(root, -1, -1),"},
+};
+
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	uid_t test_users[2];
 
-	setup();
+	root_uid = getuid();
+	tst_get_uids(test_users, 0, 2);
+	main_uid = test_users[0];
+	other_uid = test_users[1];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i;
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			/* Set the real, effective or user id */
-			TEST(SETRESUID(cleanup, *test_data[i].real_uid,
-				       *test_data[i].eff_uid,
-				       *test_data[i].sav_uid));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "setresuid(%d, %d, %d) failed",
-					 *test_data[i].real_uid,
-					 *test_data[i].eff_uid,
-					 *test_data[i].sav_uid);
-			} else {
-				uid_verify(test_data[i].exp_real_usr,
-					   test_data[i].exp_eff_usr,
-					   test_data[i].exp_sav_usr,
-					   test_data[i].test_msg);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	UID16_CHECK(root_uid, setresuid);
+	UID16_CHECK(main_uid, setresuid);
+	UID16_CHECK(other_uid, setresuid);
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void run(unsigned int n)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	if (getpwnam("nobody") == NULL) {
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-	}
-
-	if (getpwnam("bin") == NULL) {
-		tst_brkm(TBROK, NULL, "bin must be a valid user.");
-	}
+	const struct test_data_t *tc = test_data + n;
 
-	root = *(getpwnam("root"));
-	UID16_CHECK((root_pw_uid = root.pw_uid), "setresuid", cleanup)
+	TST_EXP_PASS_SILENT(SETRESUID(*tc->real_uid, *tc->eff_uid,
+		*tc->sav_uid), "%s", tc->test_msg);
 
-	nobody = *(getpwnam("nobody"));
-	UID16_CHECK((nobody_pw_uid = nobody.pw_uid), "setresuid", cleanup)
+	if (!TST_PASS)
+		return;
 
-	bin = *(getpwnam("bin"));
-	UID16_CHECK((bin_pw_uid = bin.pw_uid), "setresuid", cleanup)
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
+	if (tst_check_resuid(tc->test_msg, *tc->exp_real_uid,
+		*tc->exp_eff_uid, *tc->exp_sav_uid))
+		tst_res(TPASS, "%s works as expected", tc->test_msg);
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
-
-void
-uid_verify(struct passwd *ru, struct passwd *eu, struct passwd *su, char *when)
-{
-	uid_t cur_ru, cur_eu, cur_su;
-	if (getresuid(&cur_ru, &cur_eu, &cur_su) != 0) {
-		tst_brkm(TBROK, cleanup, "Set getresuid() failed");
-	}
-	if ((cur_ru != ru->pw_uid) || (cur_eu != eu->pw_uid) || (cur_su !=
-								 su->pw_uid)) {
-		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d; "
-			 "saved uid = %d", when, cur_ru, cur_eu, cur_su);
-		tst_resm(TINFO, "Expected: real uid = %d, effective uid = %d "
-			 "saved uid = %d", ru->pw_uid, eu->pw_uid, su->pw_uid);
-	} else {
-		tst_resm(TPASS,
-			 "real uid = %d, effective uid = %d, and saved uid = "
-			 "%d as expected", cur_ru, cur_eu, cur_su);
-	}
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_data),
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
