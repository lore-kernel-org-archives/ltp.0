Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750DCC433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 10:44:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0DD83C1AE9
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 12:44:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A724A3C1AE9
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 12:44:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C72D61A0121C
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 12:44:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04DF93769B
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658313874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XN1HGxXEs9e5G663w7Ibtjo5XIJ5pdVC0VDDPe+mFoE=;
 b=JfoxVSGpUbm/717dkNQBnwDwe7163R5ajrC78v7wKQKsUJa///LohLm6uVS64dEVB+NBQ7
 1V738q6P93k4xi/86xYTDgO3X/7GpXnq/BDM6ObySrtdt9TQDCp/TM36yOqsOB/6n1dcRz
 c5xzOryAF2eFZFxRNKK4APtv3IOpNhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658313874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XN1HGxXEs9e5G663w7Ibtjo5XIJ5pdVC0VDDPe+mFoE=;
 b=BQo60MrsMhZsYtq0BXRyRuaxyZW3rrPxpmm1TE6GTfAF1uk9lZeSIb64sRBtK7pHEzRwDt
 hIQLhINkl/LFNGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 730D313AAD
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 10:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cYC6DJHc12JgMgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 10:44:33 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 20 Jul 2022 16:14:30 +0530
Message-Id: <20220720104430.8614-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getitimer03.c: convert to new LTP API
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
 .../kernel/syscalls/getitimer/getitimer03.c   | 156 ++----------------
 1 file changed, 17 insertions(+), 139 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer03.c b/testcases/kernel/syscalls/getitimer/getitimer03.c
index cc5e83fad..e26a121c1 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer03.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer03.c
@@ -1,152 +1,30 @@
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
+ *	03/2001 - Written by Wayne Boyer
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/* $Header: /cvsroot/ltp/ltp/testcases/kernel/syscalls/getitimer/getitimer03.c,v 1.7 2009/08/28 10:18:24 vapier Exp $ */
-
-/*
- * NAME
- *	getitimer03.c
- *
- * DESCRIPTION
- *	getitimer03 - check that a getitimer() call fails as expected
- *		      with an incorrect first argument.
- *
- * CALLS
- *	getitimer()
- *
- * ALGORITHM
- *	loop if that option was specified
- *	allocate space and set up needed values
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get EINVAL
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  getitmer03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * USAGE
- *	./getitimer03
+/*\
+ * [Description]
  *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
+ * Verify that getitimer() fails with EINVAL when called with
+ * an invalid first argument.
  */
 
-#include "test.h"
-
-#include <errno.h>
-#include <sys/time.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "getitimer03";
-int TST_TOTAL = 1;
+#include <stdlib.h>
+#include "tst_test.h"
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
 	struct itimerval *value;
 
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
-		/* allocate some space for the timer structure */
-
-		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "value malloc failed");
-		}
-
-		/*
-		 * issue the system call with the TEST() macro
-		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
-		 */
-
-		/* make the first value negative to get a failure */
-		TEST(getitimer(-ITIMER_PROF, value));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EINVAL:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-
-		/*
-		 * clean up things in case we are looping
-		 */
-
-		free(value);
-		value = NULL;
-	}
-
-	cleanup();
-
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
+	value = SAFE_MALLOC(sizeof(struct itimerval));
+	TST_EXP_FAIL(getitimer(-ITIMER_PROF, value), EINVAL);
+	free(value);
+	value = NULL;
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
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
