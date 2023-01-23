Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8907BC05027
	for <ltp@archiver.kernel.org>; Mon, 23 Jan 2023 06:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4B053CB3C0
	for <ltp@archiver.kernel.org>; Mon, 23 Jan 2023 07:49:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14F483CB16F
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 07:48:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31A6B60045E
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 07:48:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B4261F750
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1674456529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IrimNWTri8hu+Kt/cPiAaR3cWxAbisG37MkP4lrRVs=;
 b=YmRTJfumeAMDUWmr90nm+4nJ+X2b3uHqM74l59TnjYclnZ1hfOh+03uH4q4aPRxUv7c1UJ
 y4waNt0Xcn+LuOWJAVxOlJqegctzwJtA0E3EkB5GECrDSiFL4XZ5G4HKUj9CY+Mty90u3f
 7xZEGK/qFiaRVKH+tJ5+8aSjQup3JI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1674456529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IrimNWTri8hu+Kt/cPiAaR3cWxAbisG37MkP4lrRVs=;
 b=Kqk83p2fii+vkL7icYDoX0uH+iQcn6v+OV+n50hIVwRGbmmzl1ESlgmMHzMXhS+8zF3Jod
 q1A5FoYvwxeOP0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A94731357F
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 06:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BRK/E9AtzmO7JAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 06:48:48 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 23 Jan 2023 12:18:45 +0530
Message-Id: <20230123064845.13564-1-akumar@suse.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <87sfgawyei.fsf@suse.de>
References: <87sfgawyei.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] setreuid04.c: Rewrite using new LTP API
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

changes in v2:
further cleanup to remove the testcases struct as we are testing
only single scenario.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/setreuid/setreuid04.c     | 150 ++++--------------
 1 file changed, 29 insertions(+), 121 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index 8eed90df0..d0b9e3f8a 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -1,141 +1,49 @@
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
  * Ported by John George
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test that root can change the real and effective uid to an
- * unpriviledged user.
+/*\
+ * [Description]
+ *
+ * Verify that root user can change the real and effective uid to an
+ * unprivileged user.
  */
 
-#include <errno.h>
-#include <stdlib.h>
 #include <pwd.h>
-#include <sys/wait.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-TCID_DEFINE(setreuid04);
-
-static uid_t neg_one = -1;
-
-static struct passwd nobody, root;
-
-/*
- * The following structure contains all test data.  Each structure in the array
- * is used for a separate test.  The tests are executed in the for loop below.
- */
-
-struct test_data_t {
-	uid_t *real_uid;
-	uid_t *eff_uid;
-	struct passwd *exp_real_usr;
-	struct passwd *exp_eff_usr;
-	char *test_msg;
-} test_data[] = {
-	{
-	&neg_one, &neg_one, &root, &root, "After setreuid(-1, nobody),"}, {
-&nobody.pw_uid, &nobody.pw_uid, &nobody, &nobody,
-		    "After setreuid(-1, -1),"},};
-
-int TST_TOTAL = ARRAY_SIZE(test_data);
-
-static void setup(void);
-static void cleanup(void);
-static void uid_verify(struct passwd *, struct passwd *, char *);
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i, pid;
-
-		tst_count = 0;
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork failed");
-		} else if (pid == 0) {	/* child */
-
-			for (i = 0; i < TST_TOTAL; i++) {
-
-				/* Set the real or effective user id */
-				TEST(SETREUID(cleanup, *test_data[i].real_uid,
-					      *test_data[i].eff_uid));
-
-				if (TEST_RETURN != -1) {
-					tst_resm(TPASS, "setreuid(%d, %d) "
-						 "succeeded as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid);
-				} else {
-					tst_resm(TFAIL, "setreuid(%d, %d) "
-						 "did not return as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid);
-				}
-
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
+static uid_t root_uid, nobody_uid;
 
 static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	if (getpwnam("nobody") == NULL)
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
+	struct passwd *nobody;
 
-	root = *(getpwnam("root"));
-	UID16_CHECK(root.pw_uid, setreuid, cleanup);
+	root_uid = getuid();
+	nobody = SAFE_GETPWNAM("nobody");
+	nobody_uid = nobody->pw_uid;
 
-	nobody = *(getpwnam("nobody"));
-	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
-
-	TEST_PAUSE;
+	UID16_CHECK(nobody_uid, setreuid);
+	UID16_CHECK(root_uid, setreuid);
 }
 
-static void cleanup(void)
+static void run(void)
 {
-}
+	if (!SAFE_FORK()) {
+		TST_EXP_PASS(SETREUID(nobody_uid, nobody_uid));
 
-static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
-{
-	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
-		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
-			 when, getuid(), geteuid());
-		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
-			 ru->pw_uid, eu->pw_uid);
+		TST_EXP_EQ_LI(getuid(), nobody_uid);
+		TST_EXP_EQ_LI(geteuid(), nobody_uid);
 	}
+	tst_reap_children();
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1
+};
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
