Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A8C433FE
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:45:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667AA60FDA
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 667AA60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21E13C92A5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 16:45:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CB723C1DF5
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 16:44:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B7A51000CF8
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 16:44:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B933421C77
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631544295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09TsKFUbDgibu5Jwrsnlfm8skYPN+8CEeBbavnjVCNw=;
 b=a4brVDyqUOB8lOBCBuXKh5FMtojsM87nAwsK1Bz2MF6+TLrKp6U4vWQmlMshAsj92+2ZRp
 PPeBrL4fpwuiQZdWIomoh9h0ARV7vNWux0/UHcNlbS3e+pfbbuxbSv/idVcpwECpYx92ox
 pmGFrZVz3Ql7UuxwqUuMzdFXornXsKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631544295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09TsKFUbDgibu5Jwrsnlfm8skYPN+8CEeBbavnjVCNw=;
 b=7UP4Ug5hJ1LKq0GZ58KgU+8jg4duONslT0xUZXJ3UlwAn3yORQo7gXdVDZH5xEULSYYDzq
 3+B+Ic0EeL0c+YAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94AAB13F17
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4NQ2I+djP2FYbgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:44:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Sep 2021 16:44:54 +0200
Message-ID: <20210913144454.22992-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913144454.22992-1-mdoucha@suse.cz>
References: <20210913144454.22992-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] syscalls/setresuid03: Convert to new API
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
Message-ID: <20210913144454.xytbn-aRYa4SUO2uvNfQDgjMX-mbifDXR2shvmiWw8k@z>

The original test looks up specific usernames which may not exist on some
systems. Use any two non-root UIDs instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- use TST_EXP_FAIL() to simplify result validation

 .../kernel/syscalls/setresuid/setresuid03.c   | 263 ++++--------------
 1 file changed, 47 insertions(+), 216 deletions(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid03.c b/testcases/kernel/syscalls/setresuid/setresuid03.c
index ea06e02bf..6761df1c3 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid03.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid03.c
@@ -1,245 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
+ *	07/2001 ported by John George
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * NAME
- * 	setresuid03.c
- *
- * DESCRIPTION
- * 	Test that the setresuid system call sets the proper errno
- *	values when a non-root user attempts to change the real, effective or
- *	saved uid to a value other than one of the current uid, the current
- *	effective uid of the current saved uid.  Also verify that setresuid
- *	fails if an invalid uid value is given.
- *
- * ALGORITHM
- *
- *	Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *
- *	Setup test values.
- *	Loop if the proper options are given.
- * 	For each test set execute the system call
- * 	  Check that we received the expected result.
- *	  Verify that the uid, euid and suid values are still correct.
- *	Cleanup:
- *	  Print errno log and/or timing stats if option given.
- *
- * USAGE:  <for command-line>
- *	setresuid03 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
+/*\
+ * [Description]
  *
- * Restrictions
- * 	This test must be run by root.
- *	nobody and bin must be a valid users.
+ * Test that the setresuid system call sets the proper errno values when
+ * a non-root user attempts to change the real, effective or saved uid
+ * to a value other than one of the current uid, the current effective uid
+ * or the current saved uid.
  */
 
-#define _GNU_SOURCE 1
-#include <pwd.h>
-#include <stdlib.h>
-#include "test.h"
-#include <errno.h>
-#include <sys/wait.h>
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
-#include <compat_16.h>
+static uid_t root_uid, main_uid, other_uid, neg_one = -1;
 
-TCID_DEFINE(setresuid03);
-
-uid_t neg_one = -1;
-
-/* flag to tell parent if child passed or failed. */
-int flag = 0;
-
-uid_t root_pw_uid, nobody_pw_uid, bin_pw_uid;
-char user1name[] = "nobody";
-char user2name[] = "bin";
-char rootname[] = "root";
-
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
 	int exp_errno;
-	struct passwd *exp_real_usr;
-	struct passwd *exp_eff_usr;
-	struct passwd *exp_sav_usr;
+	uid_t *exp_real_uid;
+	uid_t *exp_eff_uid;
+	uid_t *exp_sav_uid;
 	char *test_msg;
 } test_data[] = {
-	{
-	&nobody_pw_uid, &neg_one, &neg_one, EPERM, &root, &bin, &bin,
-		    "After setresuid(root, -1, -1),"}, {
-	&neg_one, &neg_one, &nobody_pw_uid, EPERM, &root, &bin, &bin,
-		    "After setresuid(-1, -1, bin),"}, {
-	&neg_one, &nobody_pw_uid, &neg_one, EPERM, &root, &bin, &bin,
-		    "After setresuid(-1, -1, bin),"}
+	{&other_uid, &neg_one, &neg_one, EPERM, &root_uid, &main_uid,
+		&main_uid, "setresuid(other, -1, -1)"},
+	{&neg_one, &neg_one, &other_uid, EPERM, &root_uid, &main_uid,
+		&main_uid, "setresuid(-1, -1, other)"},
+	{&neg_one, &other_uid, &neg_one, EPERM, &root_uid, &main_uid,
+		&main_uid, "setresuid(-1, other, -1)"}
 };
 
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
-
-void setup(void);
-void cleanup(void);
-
-void
-uid_verify(struct passwd *ru, struct passwd *eu, struct passwd *su, char *);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
+	uid_t test_users[2];
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	root_uid = getuid();
+	tst_get_uids(test_users, 0, 2);
+	main_uid = test_users[0];
+	other_uid = test_users[1];
 
-	setup();
+	UID16_CHECK(root_uid, setresuid);
+	UID16_CHECK(main_uid, setresuid);
+	UID16_CHECK(other_uid, setresuid);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i, pid;
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* set the appropriate ownership values */
-		if (setresuid(root_pw_uid, bin_pw_uid, bin_pw_uid)
-		    == -1) {
-			tst_brkm(TFAIL, cleanup, "Initial setresuid failed");
-		}
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork failed");
-		} else if (pid == 0) {	/* child */
-
-			for (i = 0; i < TST_TOTAL; i++) {
-
-				/* Set the real, effective or saved user id */
-				TEST(SETRESUID(NULL, *test_data[i].real_uid,
-					       *test_data[i].eff_uid,
-					       *test_data[i].sav_uid));
-
-				if (TEST_RETURN == -1 && TEST_ERRNO ==
-				    test_data[i].exp_errno) {
-					tst_resm(TPASS, "setresuid(%d, %d, %d) "
-						 "failed as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid,
-						 *test_data[i].sav_uid);
-				} else {
-					tst_resm(TFAIL, "setresuid(%d, %d, %d) "
-						 "did not fail as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid,
-						 *test_data[i].sav_uid);
-					flag = -1;
-				}
-
-				uid_verify(test_data[i].exp_real_usr,
-					   test_data[i].exp_eff_usr,
-					   test_data[i].exp_sav_usr,
-					   test_data[i].test_msg);
-			}
-			exit(flag);
-		} else {	/* parent */
-			tst_record_childstatus(cleanup, pid);
-		}
-	}
-	cleanup();
-	tst_exit();
+	SAFE_SETRESUID(root_uid, main_uid, main_uid);
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
+	const struct test_data_t *tc = test_data + n;
 
-	if (getpwnam("bin") == NULL) {
-		tst_brkm(TBROK, NULL, "bin must be a valid user.");
-	}
+	TST_EXP_FAIL(SETRESUID(*tc->real_uid, *tc->eff_uid, *tc->sav_uid),
+		tc->exp_errno, "%s", tc->test_msg);
 
-	root = *(getpwnam("root"));
-	UID16_CHECK((root_pw_uid = root.pw_uid), "setresuid", cleanup)
+	if (!TST_PASS)
+		return;
 
-	nobody = *(getpwnam("nobody"));
-	UID16_CHECK((nobody_pw_uid = nobody.pw_uid), "setresuid", cleanup)
-
-	bin = *(getpwnam("bin"));
-	UID16_CHECK((bin_pw_uid = bin.pw_uid), "setresuid", cleanup)
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
+	tst_check_resuid(tc->test_msg, *tc->exp_real_uid, *tc->exp_eff_uid,
+		*tc->exp_sav_uid);
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
-		flag = -1;
-		tst_brkm(TBROK, cleanup, "Set getresuid() failed");
-	}
-	if ((cur_ru != ru->pw_uid) || (cur_eu != eu->pw_uid) || (cur_su !=
-								 su->pw_uid)) {
-		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d; "
-			 "saved uid = %d", when, cur_ru, cur_eu, cur_su);
-		tst_resm(TINFO, "Expected: real uid = %d, effective uid = %d "
-			 "saved uid = %d", ru->pw_uid, eu->pw_uid, su->pw_uid);
-		flag = -1;
-	} else {
-		tst_resm(TINFO, "real uid = %d, effective uid = %d, and "
-			 "saved uid = %d as expected", cur_ru, cur_eu, cur_su);
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
