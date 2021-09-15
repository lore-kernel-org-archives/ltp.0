Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F0C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 13:45:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017306105A
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 13:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 017306105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95ED93C9183
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:45:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 738803C8999
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:45:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 663521A00890
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:45:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83589201A8
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631713506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+fqzP5UtfMtQnlm3uDojfrm/1bToEN+r/FoSnYTVOs8=;
 b=Kw4DBAJ7Dlc+LnPxBCli+UQfJq32iw3tLWRo22EcWWuJ+VjHWJexE+FLtwiIS6E9G5UMZ9
 3U2kNlZO23G/yWn/agGUp3ZQydwQjjv1XcVb5Xmm623qQa0ydLByNRorzptBCdaHp+6tWg
 ObeAIFMtRCBpRjW4g5WGP0lMSG2qrhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631713506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+fqzP5UtfMtQnlm3uDojfrm/1bToEN+r/FoSnYTVOs8=;
 b=SQhSGC2i1SBocw4JRWCOER2lf0Bmst4Hfx8LWBVQ/0cA/xyk5llSugVT7cJR8ww9eCE+Tp
 KZgixCbjDTnZJRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E61613C37
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kq7lGeL4QWHZaQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Sep 2021 15:45:02 +0200
Message-ID: <20210915134505.22771-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] syscalls/setreuid02: Convert to new API
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
Message-ID: <20210915134502.Zv5SX408sBwYkykN1cHCQTugbQLTRQtJrLmXhMRt5u0@z>

The original test looks up specific usernames which may not exist on some
systems. Use any non-root UID instead.

Also add verification that saved UID gets updated according to
documentation.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/setreuid/setreuid02.c     | 175 ++++++------------
 1 file changed, 58 insertions(+), 117 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index 695386cbc..2fa4cbc80 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -1,145 +1,86 @@
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
  * Test setreuid() when executed by root.
  */
 
-#include <errno.h>
+#include <sys/types.h>
 #include <pwd.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include "test.h"
-#include "compat_16.h"
 
-TCID_DEFINE(setreuid02);
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
-static uid_t neg_one = -1;
-static struct passwd nobody, daemonpw, root, bin;
-
-/*
- * The following structure contains all test data.  Each structure in the array
- * is used for a separate test.  The tests are executed in the for loop below.
- */
+static uid_t root_uid, nobody_uid, other_uid, neg_one = -1;
 
 static struct test_data_t {
 	uid_t *real_uid;
 	uid_t *eff_uid;
-	struct passwd *exp_real_usr;
-	struct passwd *exp_eff_usr;
-	char *test_msg;
+	uid_t *exp_real_uid;
+	uid_t *exp_eff_uid;
+	uid_t *exp_sav_uid;
+	const char *test_msg;
 } test_data[] = {
-	{
-	&neg_one, &neg_one, &root, &root, "After setreuid(-1, -1),"}, {
-	&nobody.pw_uid, &neg_one, &nobody, &root, "After setreuid(nobody, -1)"},
-	{
-	&root.pw_uid, &neg_one, &root, &root, "After setreuid(root,-1),"}, {
-	&neg_one, &daemonpw.pw_uid, &root, &daemonpw,
-		    "After setreuid(-1, daemon)"}, {
-	&neg_one, &root.pw_uid, &root, &root, "After setreuid(-1,root),"}, {
-	&bin.pw_uid, &neg_one, &bin, &root, "After setreuid(bin, -1)"}, {
-&root.pw_uid, &neg_one, &root, &root, "After setreuid(-1, root)"},};
-
-int TST_TOTAL = ARRAY_SIZE(test_data);
+	{&neg_one, &neg_one, &root_uid, &root_uid, &root_uid,
+		"setreuid(-1, -1)"},
+	{&nobody_uid, &neg_one, &nobody_uid, &root_uid, &root_uid,
+		"setreuid(nobody, -1)"},
+	{&root_uid, &neg_one, &root_uid, &root_uid, &root_uid,
+		"setreuid(root, -1)"},
+	{&neg_one, &nobody_uid, &root_uid, &nobody_uid, &nobody_uid,
+		"setreuid(-1, nobody)"},
+	{&neg_one, &root_uid, &root_uid, &root_uid, &nobody_uid,
+		"setreuid(-1, root)"},
+	{&other_uid, &neg_one, &other_uid, &root_uid, &root_uid,
+		"setreuid(other, -1)"},
+	{&root_uid, &neg_one, &root_uid, &root_uid, &root_uid,
+		"setreuid(root, -1)"},
+};
 
-static void setup(void);
-static void cleanup(void);
-static void uid_verify(struct passwd *ru, struct passwd *eu, char *when);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	uid_t test_users[2];
+	struct passwd *pw;
 
-	setup();
+	root_uid = getuid();
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_uid = test_users[0] = pw->pw_uid;
+	tst_get_uids(test_users, 1, 2);
+	other_uid = test_users[1];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i;
+	UID16_CHECK(root_uid, setreuid);
+	UID16_CHECK(nobody_uid, setreuid);
+	UID16_CHECK(other_uid, setreuid);
 
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			/* Set the real or effective user id */
-			TEST(SETREUID(cleanup, *test_data[i].real_uid,
-				      *test_data[i].eff_uid));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TBROK, "setreuid(%d, %d) failed",
-					 *test_data[i].real_uid,
-					 *test_data[i].eff_uid);
-			} else {
-				uid_verify(test_data[i].exp_real_usr,
-					   test_data[i].exp_eff_usr,
-					   test_data[i].test_msg);
-			}
-		}
-	}
-	cleanup();
-	tst_exit();
+	/* Make sure that saved UID is also set to root */
+	SAFE_SETUID(root_uid);
 }
 
-static void setup(void)
+static void run(unsigned int n)
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
+	const struct test_data_t *tc = test_data + n;
 
-	root = *(getpwnam("root"));
-	UID16_CHECK(root.pw_uid, setreuid, cleanup);
+	TST_EXP_PASS_SILENT(SETREUID(*tc->real_uid, *tc->eff_uid), "%s",
+		tc->test_msg);
 
-	nobody = *(getpwnam("nobody"));
-	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
+	if (!TST_PASS)
+		return;
 
-	daemonpw = *(getpwnam("daemon"));
-	UID16_CHECK(daemonpw.pw_uid, setreuid, cleanup);
-
-	bin = *(getpwnam("bin"));
-	UID16_CHECK(bin.pw_uid, setreuid, cleanup);
-
-	TEST_PAUSE;
+	if (tst_check_resuid(tc->test_msg, *tc->exp_real_uid, *tc->exp_eff_uid,
+		*tc->exp_sav_uid))
+		tst_res(TPASS, "%s works as expected", tc->test_msg);
 }
 
-static void cleanup(void)
-{
-}
-
-static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
-{
-	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
-		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
-			 when, getuid(), geteuid());
-		tst_resm(TFAIL, "Expected: real uid = %d; effective uid = %d",
-			 ru->pw_uid, eu->pw_uid);
-	} else {
-		tst_resm(TPASS, "real or effective uid was modified as "
-			 "expected");
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
