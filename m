Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E583C433F5
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 08:58:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E6E23CAE77
	for <ltp@archiver.kernel.org>; Sun,  9 Oct 2022 10:58:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0C363CA0DB
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 10:57:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8E10100076B
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 10:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665305870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xxlG/Xw6FdcP5e6fYKjQznF2U1TQD6+gJn0tJ0WvkNA=;
 b=DyRM8pTnAnv9kRzImx6tLLS7Qksuy6ZoJ3AUiuNTyI8ynk+XJjXsbFR6ew3hvOPBw8q+Pe
 LACAP3QVkKA6av9eQ2ESnJDE8gtrOjG90ZNEtU/GDjgP5MzM1mBCuIlMyHZLxlo6+457sf
 eVEoxduxkDewN74gFJwXglzvYx3tiEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-yMR15yBKPQGBaD_-kA5D_A-1; Sun, 09 Oct 2022 04:57:48 -0400
X-MC-Unique: yMR15yBKPQGBaD_-kA5D_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90CCD811726
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 08:57:48 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99FB4112D401
 for <ltp@lists.linux.it>; Sun,  9 Oct 2022 08:57:47 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun,  9 Oct 2022 16:57:45 +0800
Message-Id: <20221009085745.3239893-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setitimer01: rewrite using new API
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

Also add signal checking when the timer take effection.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/syscalls/setitimer/setitimer01.c   | 230 ++++++++----------
 1 file changed, 99 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index 6874b94ad..def559db8 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -1,157 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 03/2001 - Written by Wayne Boyer
  *
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
  */
 
-/*
- * NAME
- *	setitimer01.c
- *
- * DESCRIPTION
- *	setitimer01 - check that a resonable setitimer() call succeeds.
+/*\
+ * [Description]
  *
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
- *
- * RESTRICTIONS
- *	none
+ * Check that a setitimer() call pass with timer seting.
+ * Check if signal is generated correctly when when timer expiration.
  */
 
-#include "test.h"
-
 #include <errno.h>
 #include <sys/time.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "setitimer01";
-int TST_TOTAL = 1;
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
 #define SEC0	0
-#define SEC1	20
-#define SEC2	40
-
-int main(int ac, char **av)
+#define SEC1	3
+#define SEC2	5
+
+static volatile int si_flag;
+static struct itimerval *value, *ovalue;
+
+static struct tcase {
+       int which;
+       struct itimerval **val;
+       struct itimerval **oval;
+       int signo;
+} tcases[] = {
+       {ITIMER_REAL,    &value, &ovalue, SIGALRM},
+       {ITIMER_VIRTUAL, &value, &ovalue, SIGVTALRM},
+       {ITIMER_PROF,    &value, &ovalue, SIGPROF},
+};
+
+static int sys_setitimer(int which, void *new_value, void *old_value)
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
-
-		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "value malloc failed");
-		}
-
-		if ((ovalue = malloc((size_t)sizeof(struct itimerval))) ==
-		    NULL) {
-			tst_brkm(TBROK, cleanup, "ovalue malloc failed");
-		}
-
-		/* set up some reasonable values */
-
-		value->it_value.tv_sec = SEC1;
-		value->it_value.tv_usec = SEC0;
-		value->it_interval.tv_sec = 0;
-		value->it_interval.tv_usec = 0;
-		/*
-		 * issue the system call with the TEST() macro
-		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
-		 */
+	return tst_syscall(__NR_setitimer, which, new_value, old_value);
+}
 
-		TEST(setitimer(ITIMER_REAL, value, ovalue));
+static void sig_routine(int signo)
+{
+	switch(signo){
+	case SIGALRM:
+		si_flag = 1;
+		break;
+	case SIGVTALRM:
+		si_flag = 2;
+		break;
+	case SIGPROF:
+		si_flag = 3;
+		break;
+	default:
+		break;
+	}
+}
 
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "call failed - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
+static void verify_setitimer(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	si_flag = 0;
+	value->it_value.tv_sec = SEC1;
+	value->it_value.tv_usec = SEC0;
+	value->it_interval.tv_sec = SEC0;
+	value->it_interval.tv_usec = SEC0;
+
+	TST_EXP_PASS(sys_setitimer(tc->which, *(tc->val), *(tc->oval)));
+
+	/*
+	 * call setitimer again with new values.
+	 * the old values should be stored in ovalue
+	 */
+	value->it_value.tv_sec = SEC2;
+	value->it_value.tv_usec = SEC0;
+
+	TST_EXP_PASS(sys_setitimer(tc->which, *(tc->val), *(tc->oval)));
+
+	if (ovalue->it_value.tv_sec <= SEC1)
+		tst_res(TPASS, "setitimer functionality is correct");
+	else
+		tst_brk(TFAIL, "old timer value is not equal to expected value");
+
+	for (;;) {
+		if (tc->which == ITIMER_REAL && si_flag == 1) {
+			tst_res(TPASS, "SIGALRM signal is generated");
+			break;
 		}
 
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
+		if (tc->which == ITIMER_VIRTUAL && si_flag == 2) {
+			tst_res(TPASS, "SIGVTALRM signal is generated");
+			break;
 		}
 
-		if (ovalue->it_value.tv_sec <= SEC1) {
-			tst_resm(TPASS, "functionality is correct");
-		} else {
-			tst_brkm(TFAIL, cleanup, "old timer value is "
-				 "not equal to expected value");
+		if (tc->which == ITIMER_PROF && si_flag == 3) {
+			tst_res(TPASS, "SIGPROF signal is generated");
+			break;
 		}
 	}
 
-	cleanup();
-	tst_exit();
+	if (si_flag == 0)
+		tst_res(TFAIL, "signal is incorrect");
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_SIGNAL(SIGALRM, sig_routine);
+	SAFE_SIGNAL(SIGVTALRM, sig_routine);
+	SAFE_SIGNAL(SIGPROF, sig_routine);
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
+        .tcnt = ARRAY_SIZE(tcases),
+	.test = verify_setitimer,
+	.setup = setup,
+	.max_runtime = 60,
+	.bufs = (struct tst_buffers[]) {
+		{&value,  .size = sizeof(struct itimerval)},
+		{&ovalue, .size = sizeof(struct itimerval)},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
