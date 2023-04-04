Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4AEC7618D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 05:45:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F83E3CC7D8
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 07:45:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C0193CC7D4
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 07:44:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 968CF2005FD
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 07:44:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0A46203C1
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1680587092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nu8t0Ky6nLuaBF1ELwQlPN6kLwljcWJwI6zz8h0uyfs=;
 b=YndVRHYY8m4YPT0+ihpFH0SZ1cKQwz6WLSYymCOIxI7+GxBzCG+eZnCtloNilgcs08xcar
 vcpzYVINN0BB4Yx8/RA79Xq/6Q6bFobEFnQYP4tvuTfwu0VziZ6kSNyzkWCPw4QZvkvoP7
 VC4h4+jQ42d67EMhRzSX8EQ0NmiaT08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1680587092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nu8t0Ky6nLuaBF1ELwQlPN6kLwljcWJwI6zz8h0uyfs=;
 b=8zKTQOUXMIB5RhQrmrZ+fGeyF4cQhH6uYEMBZS9DfwhHeAfKPyh7RXb/56GrZV/TmYDF3u
 7/7dez/NQ3uGziCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5817D13416
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PAReDFS5K2TgPwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 04 Apr 2023 05:44:52 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  4 Apr 2023 11:14:47 +0530
Message-Id: <20230404054448.23095-2-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404054448.23095-1-akumar@suse.de>
References: <20230404054448.23095-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] getpgid02.c: Rewrite using new LTP API
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
 testcases/kernel/syscalls/getpgid/getpgid02.c | 143 +++---------------
 1 file changed, 20 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/getpgid/getpgid02.c b/testcases/kernel/syscalls/getpgid/getpgid02.c
index 92482e3ae..30d0129bc 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid02.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid02.c
@@ -1,137 +1,34 @@
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
+ *   07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- * 	getpgid02.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of getpgid().
- *
- * ALGORITHM
- * 	test 1: Does getpgid(-99) and expects ESRCH.
- * 	test 2: Searches an unused pid and expects ESRCH.
- *
- * USAGE:  <for command-line>
- *  getpgid02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	none
+ * Verify that getpgid(2) fails with errno ESRCH when
+ * pid does not match any process.
  */
-#define _GNU_SOURCE 1
 
-#include <errno.h>
-#include <unistd.h>
-#include <stdarg.h>
-#include <sys/wait.h>
-#include <sys/types.h>
-#include "test.h"
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+static pid_t unused_pid;
+static pid_t neg_pid = -99;
 
-char *TCID = "getpgid02";
-int TST_TOTAL = 2;
-
-int pgid_0, pgid_1;
-#define BADPID -99
-
-struct test_case_t {
-	int *id;
-	int error;
-} TC[] = {
-	/* The pid value is negative */
-	{
-	&pgid_0, ESRCH},
-	    /* The pid value does not match any process */
-	{
-	&pgid_1, ESRCH}
-};
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(getpgid(*TC[i].id));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
+	unused_pid = tst_get_unused_pid();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	pgid_0 = BADPID;
-
-	pgid_1 = tst_get_unused_pid(cleanup);
+	TST_EXP_FAIL2(getpgid(neg_pid), ESRCH, "getpgid(%d)", neg_pid);
+	TST_EXP_FAIL2(getpgid(unused_pid), ESRCH, "getpgid(%d)", unused_pid);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run
+};
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
