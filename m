Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4053EC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA45B3CAE9C
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 13:04:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42AF33C7319
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:04:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 395621000A22
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 13:04:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D78021E4E
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665486280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fBQYsoFmdB/0fO2TauTg+W83/AttrnCUFg+wrmDLf6Q=;
 b=RAZv0C2lUcDkQHIa/zyIPrpPi5504aOOCb3OuvO1ryugMxVJHdKr9MBktt3ojCja2+EG6r
 T5fs6O6u4MSwdSF2Yb7A1Yl3etxM7tnSlI284gEDANqN/V3eBDtsvXEPzuxDhEGWfPBxS/
 By1OvWt6koNsyyg3WWUwguY2HFX+mHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665486280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fBQYsoFmdB/0fO2TauTg+W83/AttrnCUFg+wrmDLf6Q=;
 b=R3vCei31ZRNk6/hoN6fSU+oJ+o15AqHqrnHayONz5ec+EdKHg7Q7PhuQmkKwvHvdC/z+Bz
 1cqmbggdDph15kAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0B2613AAC
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id awl9KMdNRWNgKAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:04:39 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 11 Oct 2022 16:34:37 +0530
Message-Id: <20221011110437.21572-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setitimer03: Rewrite using new LTP API
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
 .../kernel/syscalls/setitimer/setitimer03.c   | 168 +++---------------
 1 file changed, 25 insertions(+), 143 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer03.c b/testcases/kernel/syscalls/setitimer/setitimer03.c
index 418ec71f0..659eac9a3 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer03.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer03.c
@@ -1,158 +1,40 @@
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
- *	setitimer03.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	setitimer03 - check that a setitimer() call fails as expected
- *		      with incorrect values.
- *
- * ALGORITHM
- *	loop if that option was specified
- *	allocate needed space and set up needed values
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get EINVAL
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setitimer03 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
+ * Verify that setitimer(2) syscall fails with EINVAL when given
+ * an invalid timer.
  */
 
-#include "test.h"
-
-#include <errno.h>
-#include <sys/time.h>
+#include "tst_test.h"
 
-void cleanup(void);
-void setup(void);
+static struct itimerval *new_value, *old_value;
 
-char *TCID = "setitimer03";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void setup(void)
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
-		/* allocate some space for timer structures */
-
-		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "value malloc failed");
-		}
-
-		if ((ovalue = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "value malloc failed");
-		}
-
-		/* set up some reasonable values */
-
-		value->it_value.tv_sec = 30;
-		value->it_value.tv_usec = 0;
-		value->it_interval.tv_sec = 0;
-		value->it_interval.tv_usec = 0;
-
-		/*
-		 * issue the system call with the TEST() macro
-		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
-		 */
-
-		/* make the first value negative to get a failure */
-		TEST(setitimer(-ITIMER_PROF, value, ovalue));
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
-		free(value);
-		free(ovalue);
-		value = NULL;
-		ovalue = NULL;
-	}
-
-	cleanup();
-	tst_exit();
-
+	new_value->it_value.tv_sec = 30;
+	new_value->it_value.tv_usec = 0;
+	new_value->it_interval.tv_sec = 0;
+	new_value->it_interval.tv_usec = 0;
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	TST_EXP_FAIL(setitimer(-ITIMER_PROF, new_value, old_value), EINVAL);
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
+	.test_all = run,
+	.setup = setup,
+	.bufs = (struct tst_buffers[]) {
+		{&new_value, .size = sizeof(struct itimerval)},
+		{&old_value, .size = sizeof(struct itimerval)},
+		{}
+	}
+};
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
