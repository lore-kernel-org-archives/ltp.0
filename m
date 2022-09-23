Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755CCECAAD8
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 13:29:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 980E73CADA7
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 15:29:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 982043C9573
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 15:29:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA76F14000E5
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 15:29:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B3DC1F92C
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1663939780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c59bL6EtLJp6eRufdnFLLDsL1UKoPw6aNNZVMNXIZH8=;
 b=trFq0ZexS5qU2OsNH0JrqLY5aXddoa3TA5FBlC3uW4l7kDwGAwu0CWfOS9zV8A1XltdMWE
 akkZuN6yvlCdPBRSdSdf29Um5fFeKdD2Z4pQ3vZWRc6M7IQ0L3Wz4JzEY1UFtfGPbrI8wX
 WZhc1i/jmEuyittX1GEkZY5eKRm8YOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1663939780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c59bL6EtLJp6eRufdnFLLDsL1UKoPw6aNNZVMNXIZH8=;
 b=QKu+iLMSIHyen91dOZH9Iw1mRgVfLZ6oR8YUV8+TrElJS067xp5fNKMAVnGSriCT/HCdZn
 U69p4WExxiqDqwDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99D7313AA5
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 13:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +JzHFcO0LWPeDgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 13:29:39 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 23 Sep 2022 18:59:36 +0530
Message-Id: <20220923132936.7602-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setitimer01: Rewrite using new LTP API
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
 .../kernel/syscalls/setitimer/setitimer01.c   | 162 +++---------------
 1 file changed, 27 insertions(+), 135 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index 6874b94ad..ff443c532 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -1,157 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ *		03/2001 - Written by Wayne Boyer
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	setitimer01.c
- *
- * DESCRIPTION
- *	setitimer01 - check that a resonable setitimer() call succeeds.
- *
- * ALGORITHM
- *	loop if that option was specified
- *	allocate needed space and set up needed values
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get zero
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setitimer01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	none
+ * Verify that setitimer(2) successfully sets the specified timer to
+ * the value provided in new_value argument.
  */
 
-#include "test.h"
-
-#include <errno.h>
 #include <sys/time.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "setitimer01";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #define SEC0	0
 #define SEC1	20
 #define SEC2	40
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-	struct itimerval *value, *ovalue;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* allocate some space for the timer structures */
+	struct itimerval *new_value, *old_value;
 
-		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "value malloc failed");
-		}
+	new_value = SAFE_MALLOC(sizeof(struct itimerval));
+	old_value = SAFE_MALLOC(sizeof(struct itimerval));
 
-		if ((ovalue = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "ovalue malloc failed");
-		}
+	new_value->it_value.tv_sec = SEC1;
+	new_value->it_value.tv_usec = SEC0;
+	new_value->it_interval.tv_sec = 0;
+	new_value->it_interval.tv_usec = 0;
 
-		/* set up some reasonable values */
+	TST_EXP_PASS(setitimer(ITIMER_REAL, new_value, old_value));
 
-		value->it_value.tv_sec = SEC1;
-		value->it_value.tv_usec = SEC0;
-		value->it_interval.tv_sec = 0;
-		value->it_interval.tv_usec = 0;
-		/*
-		 * issue the system call with the TEST() macro
-		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
-		 */
+	new_value->it_value.tv_sec = SEC2;
+	new_value->it_value.tv_usec = SEC0;
 
-		TEST(setitimer(ITIMER_REAL, value, ovalue));
+	TST_EXP_PASS_SILENT(setitimer(ITIMER_REAL, new_value, old_value));
 
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "call failed - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-
-		/*
-		 * call setitimer again with new values.
-		 * the old values should be stored in ovalue
-		 */
-		value->it_value.tv_sec = SEC2;
-		value->it_value.tv_usec = SEC0;
-
-		if ((setitimer(ITIMER_REAL, value, ovalue)) == -1) {
-			tst_brkm(TBROK, cleanup, "second setitimer "
-				 "call failed");
-		}
-
-		if (ovalue->it_value.tv_sec <= SEC1) {
-			tst_resm(TPASS, "functionality is correct");
-		} else {
-			tst_brkm(TFAIL, cleanup, "old timer value is "
-				 "not equal to expected value");
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	if ((old_value->it_value.tv_sec <= SEC1) && (old_value->it_value.tv_sec > SEC1 - 5))
+		tst_res(TPASS, "old_value correctly updated with previous timer value");
+	else
+		tst_res(TFAIL, "old_value is not correctly updated with previous timer value");
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = run
+};
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
