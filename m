Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD21C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 13:45:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973C06105A
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 13:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 973C06105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76BD83C899E
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:45:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695FE3C8997
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:45:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7E0AA200DDC
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:45:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD7CE21DB7
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631713506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMLre+E0C9pstQ/09RVuLjzJhj8A1hTCRSvtAcELPsA=;
 b=HzErIuFJuAePO6wRMKtGqHeC8gJ9xMZd2J4sW0n7nDsJSVlCi7BPLbEQ5f+JLrGtSGucmI
 K/VfKlaQm3384UayP6NUgyWXQG+IxSV08O+9pp/VSnAB9YPsQMsh2L6YTCJDE1BXDhxG3X
 BPknHnBiamcuEHm0ju4XasTsUm6x8g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631713506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMLre+E0C9pstQ/09RVuLjzJhj8A1hTCRSvtAcELPsA=;
 b=vY19l2tt3n+KVZ4IGI9G7g/WdV8n2rZwtR4vYoUddWkrUeto4FuNzgKZzIrR8M/pgjxTqV
 jjVfZ28mbeVEl4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B13013C37
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gIARJeL4QWHZaQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Sep 2021 15:45:04 +0200
Message-ID: <20210915134505.22771-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915134505.22771-1-mdoucha@suse.cz>
References: <20210915134505.22771-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] syscalls/setreuid05: Convert to new API
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
Message-ID: <20210915134504.W-qSjB68NekmLxNiYn_5EuApgD3zekGo67C8sTEXpQQ@z>

The original test looks up specific usernames which may not exist on some
systems. Use any non-root UIDs instead.

Also add verification that saved UID gets updated according to
documentation.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/setreuid/setreuid05.c     | 260 +++++++-----------
 1 file changed, 92 insertions(+), 168 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index 39b30f950..4c1c94ee8 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -1,197 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Ported by John George
+ *    Ported by John George
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Test the setreuid() feature, verifying the role of the saved-set-uid
  * and setreuid's effect on it.
  */
 
-#include <errno.h>
+#include <sys/types.h>
 #include <pwd.h>
 #include <stdlib.h>
-#include <sys/wait.h>
-
-#include "test.h"
-#include "compat_16.h"
 
-TCID_DEFINE(setreuid05);
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
-static int fail = -1;
-static int pass;
-static uid_t neg_one = -1;
-
-static struct passwd nobody, daemonpw, root, bin;
+static uid_t root_uid, nobody_uid, main_uid, other_uid, neg_one = -1;
 
 struct test_data_t {
 	uid_t *real_uid;
 	uid_t *eff_uid;
-	int *exp_ret;
-	struct passwd *exp_real_usr;
-	struct passwd *exp_eff_usr;
-	char *test_msg;
+	int exp_ret;
+	uid_t *exp_real_uid;
+	uid_t *exp_eff_uid;
+	uid_t *exp_sav_uid;
+	const char *test_msg;
 } test_data[] = {
-	{
-	&nobody.pw_uid, &root.pw_uid, &pass, &nobody, &root, "Initially"}, {
-	&neg_one, &nobody.pw_uid, &pass, &nobody, &nobody,
-		    "After setreuid(-1, nobody),"}, {
-	&neg_one, &root.pw_uid, &pass, &nobody, &root,
-		    "After setreuid(-1, root),"}, {
-	&daemonpw.pw_uid, &neg_one, &pass, &daemonpw, &root,
-		    "After setreuid(daemon, -1),"}, {
-	&neg_one, &bin.pw_uid, &pass, &daemonpw, &bin,
-		    "After setreuid(-1, bin),"}, {
-	&neg_one, &root.pw_uid, &fail, &daemonpw, &bin,
-		    "After setreuid(-1, root),"}, {
-	&neg_one, &nobody.pw_uid, &fail, &daemonpw, &bin,
-		    "After setreuid(-1, nobody),"}, {
-	&neg_one, &daemonpw.pw_uid, &pass, &daemonpw, &daemonpw,
-		    "After setreuid(-1, daemon),"}, {
-	&neg_one, &bin.pw_uid, &pass, &daemonpw, &bin,
-		    "After setreuid(-1, bin),"}, {
-	&bin.pw_uid, &daemonpw.pw_uid, &pass, &bin, &daemonpw,
-		    "After setreuid(bin, daemon),"}, {
-	&neg_one, &bin.pw_uid, &pass, &bin, &bin, "After setreuid(-1, bin),"},
-	{
-	&neg_one, &daemonpw.pw_uid, &pass, &bin, &daemonpw,
-		    "After setreuid(-1, daemon),"}, {
-	&daemonpw.pw_uid, &neg_one, &pass, &daemonpw, &daemonpw,
-		    "After setreuid(daemon, -1),"}, {
-	&neg_one, &bin.pw_uid, &fail, &daemonpw, &daemonpw,
-		    "After setreuid(-1, bin),"},};
-
-int TST_TOTAL = ARRAY_SIZE(test_data);
-
-static void setup(void);
-static void cleanup(void);
-static void uid_verify(struct passwd *, struct passwd *, char *);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	pass = 0;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i, pid;
-
-		tst_count = 0;
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork failed");
-		} else if (pid == 0) {	/* child */
-			for (i = 0; i < TST_TOTAL; i++) {
-				/* Set the real or effective user id */
-				TEST(SETREUID(cleanup, *test_data[i].real_uid,
-					      *test_data[i].eff_uid));
-
-				if (TEST_RETURN == *test_data[i].exp_ret) {
-					if (TEST_RETURN == neg_one) {
-						if (TEST_ERRNO != EPERM) {
-							tst_resm(TFAIL,
-								 "setreuid(%d, %d) "
-								 "did not set errno "
-								 "value as expected.",
-								 *test_data
-								 [i].real_uid,
-								 *test_data
-								 [i].eff_uid);
-							continue;
-						}
-						tst_resm(TPASS,
-							 "setreuid(%d, %d) "
-							 "failed as expected.",
-							 *test_data[i].real_uid,
-							 *test_data[i].eff_uid);
-					} else {
-						tst_resm(TPASS,
-							 "setreuid(%d, %d) "
-							 "succeeded as expected.",
-							 *test_data[i].real_uid,
-							 *test_data[i].eff_uid);
-					}
-				} else {
-					tst_resm(TFAIL, "setreuid(%d, %d) "
-						 "did not return as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid);
-				}
-
-				if (TEST_RETURN == -1) {
-				}
-				uid_verify(test_data[i].exp_real_usr,
-					   test_data[i].exp_eff_usr,
-					   test_data[i].test_msg);
-			}
-			tst_exit();
-		} else {	/* parent */
-			tst_record_childstatus(cleanup, pid);
-		}
-	}
-	cleanup();
-	tst_exit();
-}
+	{&nobody_uid, &root_uid, 0, &nobody_uid, &root_uid, &root_uid,
+		"setreuid(nobody, root)"},
+	{&neg_one, &nobody_uid, 0, &nobody_uid, &nobody_uid, &root_uid,
+		"setreuid(-1, nobody)"},
+	{&neg_one, &root_uid, 0, &nobody_uid, &root_uid, &root_uid,
+		"setreuid(-1, root)"},
+	{&main_uid, &neg_one, 0, &main_uid, &root_uid, &root_uid,
+		"setreuid(main, -1)"},
+	{&neg_one, &other_uid, 0, &main_uid, &other_uid, &other_uid,
+		"setreuid(-1, other)"},
+	{&neg_one, &root_uid, -1, &main_uid, &other_uid, &other_uid,
+		"setreuid(-1, root)"},
+	{&neg_one, &nobody_uid, -1, &main_uid, &other_uid, &other_uid,
+		"setreuid(-1, nobody)"},
+	{&neg_one, &main_uid, 0, &main_uid, &main_uid, &other_uid,
+		"setreuid(-1, main)"},
+	{&neg_one, &other_uid, 0, &main_uid, &other_uid, &other_uid,
+		"setreuid(-1, other)"},
+	{&other_uid, &main_uid, 0, &other_uid, &main_uid, &main_uid,
+		"setreuid(other, main)"},
+	{&neg_one, &other_uid, 0, &other_uid, &other_uid, &main_uid,
+		"setreuid(-1, other)"},
+	{&neg_one, &main_uid, 0, &other_uid, &main_uid, &main_uid,
+		"setreuid(-1, main)"},
+	{&main_uid, &neg_one, 0, &main_uid, &main_uid, &main_uid,
+		"setreuid(main, -1)"},
+	{&neg_one, &other_uid, -1, &main_uid, &main_uid, &main_uid,
+		"setreuid(-1, other)"},
+};
 
 static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	if (getpwnam("nobody") == NULL)
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-
-	if (getpwnam("daemon") == NULL)
-		tst_brkm(TBROK, NULL, "daemon must be a valid user.");
-
-	if (getpwnam("bin") == NULL)
-		tst_brkm(TBROK, NULL, "bin must be a valid user.");
-
-	nobody = *(getpwnam("nobody"));
-	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
-
-	daemonpw = *(getpwnam("daemon"));
-	UID16_CHECK(daemonpw.pw_uid, setreuid, cleanup);
+	uid_t test_users[3];
+	struct passwd *pw;
+
+	root_uid = getuid();
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_uid = test_users[0] = pw->pw_uid;
+	tst_get_uids(test_users, 1, 3);
+	main_uid = test_users[1];
+	other_uid = test_users[2];
+
+	UID16_CHECK(root_uid, setreuid);
+	UID16_CHECK(nobody_uid, setreuid);
+	UID16_CHECK(main_uid, setreuid);
+	UID16_CHECK(other_uid, setreuid);
+
+	/* Make sure that saved UID is also set to root */
+	SAFE_SETUID(root_uid);
+}
 
-	root = *(getpwnam("root"));
-	UID16_CHECK(root.pw_uid, setreuid, cleanup);
+static void run_child(const struct test_data_t *tc)
+{
+	if (tc->exp_ret) {
+		TST_EXP_FAIL(SETREUID(*tc->real_uid, *tc->eff_uid), EPERM,
+			"%s", tc->test_msg);
+	} else {
+		TST_EXP_PASS(SETREUID(*tc->real_uid, *tc->eff_uid), "%s",
+			tc->test_msg);
+	}
 
-	bin = *(getpwnam("bin"));
-	UID16_CHECK(bin.pw_uid, setreuid, cleanup);
+	if (!TST_PASS)
+		return;
 
-	TEST_PAUSE;
+	tst_check_resuid(tc->test_msg, *tc->exp_real_uid, *tc->exp_eff_uid,
+		*tc->exp_sav_uid);
 }
 
-static void cleanup(void)
+static void run(void)
 {
-}
+	if (!SAFE_FORK()) {
+		unsigned int i;
 
-static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
-{
-	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
-		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
-			 when, getuid(), geteuid());
-		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
-			 ru->pw_uid, eu->pw_uid);
+		for (i = 0; i < ARRAY_SIZE(test_data); i++)
+			run_child(test_data + i);
+
+		exit(0);
 	}
+
+	tst_reap_children();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
