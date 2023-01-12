Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB41C54EBD
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 07:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C331F3CCA69
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 08:57:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 335CF3C1351
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 08:57:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04F0F2005DB
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 08:57:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C8123F7CD
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673510255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s3P1aN8wLCzEnlGSYVIBh1TBegAPQKNJw9hv0UlkzuU=;
 b=Lz2c0BjFdv7mTpa253UyuX1knB9q/tikaK29q2XTUqOQu+8XVUn7OIk61cje/lRzfE3Ttn
 v5uptflx58MrkfHNJ5caPdTTR0Q02xk7lonurgIj2d0cJyh7G2W3B2bZkoRAeqPo5Uthcu
 DYMr8l/7zjz7AXU9vyp6mXUe02VB+3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673510255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s3P1aN8wLCzEnlGSYVIBh1TBegAPQKNJw9hv0UlkzuU=;
 b=G3meidewjvFFNEDTh83yxKnJp7sSp8BuK1sh1erizmvUPwzwf82Jqj9iKr432Iz97TIXOl
 B17LC5RlbHBtTqAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2223134B3
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 07:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P8r5GG69v2P0YQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 07:57:34 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 12 Jan 2023 13:27:31 +0530
Message-Id: <20230112075731.7769-1-akumar@suse.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setreuid06: Rewrite the test using new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/setreuid/setreuid06.c     | 108 ++++++------------
 1 file changed, 34 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
index 22acd996f..72c7e5e47 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid06.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
@@ -1,95 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-later
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
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test that EPERM is set when setreuid is given an invalid user id.
+/*\
+ * [Description]
+ *
+ * Verify that setreuid(2) syscall fails with EPERM errno when the calling
+ * process is not privileged and a change other than
+ * (i) swapping the effective user ID with the real user ID, or
+ * (ii) setting one to the value of the other or
+ * (iii) setting the effective user ID to the value of the saved set-user-ID
+ * was specified.
  */
 
-#include <sys/wait.h>
-#include <limits.h>
-#include <signal.h>
-#include <errno.h>
-#include <unistd.h>
 #include <pwd.h>
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
-
-#define INVAL_USER		 (USHRT_MAX-2)
-
-TCID_DEFINE(setreuid06);
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
 static struct passwd *ltpuser;
+static uid_t other_uid;
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	uid_t test_user[1];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	tst_get_uids(test_user, 0, 1);
+	other_uid = test_user[0];
 
-		TEST(SETREUID(cleanup, -1, INVAL_USER));
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "%s did not fail as expected", TCID);
-		} else if (TEST_ERRNO == EPERM) {
-			tst_resm(TPASS, "setreuid set errno to EPERM as "
-				 "expected");
-		} else {
-			tst_resm(TFAIL, "setreuid FAILED, expected 1 but "
-				 "returned %d", TEST_ERRNO);
-		}
+	UID16_CHECK(other_uid, setreuid);
 
-	}
-	cleanup();
-	tst_exit();
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETUID(ltpuser->pw_uid);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	umask(0);
-
-	ltpuser = getpwnam("nobody");
-	if (ltpuser == NULL)
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
+	TST_EXP_FAIL(SETREUID(-1, other_uid), EPERM,
+				"setreuid(%d, %d)", -1, other_uid);
+	TST_EXP_FAIL(SETREUID(other_uid, -1), EPERM,
+				"setreuid(%d, %d)", other_uid, -1);
+	TST_EXP_FAIL(SETREUID(other_uid, other_uid), EPERM,
+				"setreuid(%d, %d)", other_uid, other_uid);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1
+};
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
