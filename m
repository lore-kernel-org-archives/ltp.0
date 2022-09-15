Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DFDECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 07:49:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 090E43CAC2B
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:49:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FE663CA9FF
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 09:49:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DAAD56008F0
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 09:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663228147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryw6/VEjMXJr+xWzIUwo1J63qyj88WE9ybse5zQeQFM=;
 b=PhybB0UFPk12EoOSzr1wf+vCnAOfNmS/HryndpkTGdpSk0nSM4f6hSqwBMEtq6gi/5P4xU
 wYkOeJqGPgyD34IB0NLrWfKiFEDkm1KS8xkgQKX751IxbaaGU6a35zbAiKMSDTBJ2pwXRw
 U4qHQs54sgvSWHpkUBYH7d+57l15EZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-WNcLIqd9ME-hQo5um2bUOA-1; Thu, 15 Sep 2022 03:49:04 -0400
X-MC-Unique: WNcLIqd9ME-hQo5um2bUOA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCDCF8001B8;
 Thu, 15 Sep 2022 07:49:03 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98E38492B04;
 Thu, 15 Sep 2022 07:49:02 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 15:49:00 +0800
Message-Id: <20220915074900.2639623-1-liwang@redhat.com>
In-Reply-To: <YyI/KU10+zSi7Fpj@pevik>
References: <YyI/KU10+zSi7Fpj@pevik>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getitimer03.c: convert to new LTP API
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

From: Avinesh Kumar <akumar@suse.de>

Signed-off-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    Hi Avinesh,
    
        As this patch pending there with no action more than six weeks, I just
        help to moving on the test convert-work in my suggest way, if you have
        any different thought, please feel free add comments and review.
        Thanks!  -- Li Wang
    
    v1 --> v2
        * combine error test into 02 to better manage the error test in LTP

 .../kernel/syscalls/getitimer/getitimer02.c   |  45 +++++-
 .../kernel/syscalls/getitimer/getitimer03.c   | 152 ------------------
 2 files changed, 39 insertions(+), 158 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/getitimer/getitimer03.c

diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index a91e6434d..863e8e0a8 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -1,30 +1,63 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- * 03/2001 - Written by Wayne Boyer
+ *               03/2001 - Written by Wayne Boyer
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
 /*\
  * [Description]
  *
- * Check that a getitimer() call fails with EFAULT with invalid itimerval pointer.
+ * Check that getitimer() call fails:
+ *   1. EFAULT with invalid itimerval pointer
+ *   2. EINVAL when called with an invalid first argument
  */
 
+#include <stdlib.h>
 #include <errno.h>
 #include <sys/time.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
+static struct itimerval *value;
+static struct itimerval *invalid;
+
+static struct tcase {
+       int which;
+       struct itimerval **val;
+       int exp_errno;
+} tcases[] = {
+       {ITIMER_REAL, &invalid, EFAULT},
+       {-ITIMER_PROF, &value, EINVAL},
+};
+
 static int sys_getitimer(int which, void *curr_value)
 {
-	return tst_syscall(__NR_getitimer, which, curr_value);
+        return tst_syscall(__NR_getitimer, which, curr_value);
+}
+
+static void setup(void)
+{
+        value = SAFE_MALLOC(sizeof(struct itimerval));
+        invalid = (struct itimerval *)-1;
+}
+
+static void verify_getitimer(unsigned int i)
+{
+        struct tcase *tc = &tcases[i];
+
+        TST_EXP_FAIL(sys_getitimer(tc->which, *(tc->val)), tc->exp_errno);
 }
 
-static void verify_getitimer(void)
+static void cleanup(void)
 {
-	TST_EXP_FAIL(sys_getitimer(ITIMER_REAL, (struct itimerval *)-1), EFAULT);
+        free(value);
+        value = NULL;
 }
 
 static struct tst_test test = {
-	.test_all = verify_getitimer,
+        .tcnt = ARRAY_SIZE(tcases),
+        .test = verify_getitimer,
+        .setup = setup,
+        .cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/getitimer/getitimer03.c b/testcases/kernel/syscalls/getitimer/getitimer03.c
deleted file mode 100644
index cc5e83fad..000000000
--- a/testcases/kernel/syscalls/getitimer/getitimer03.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
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
- */
-
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
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
- */
-
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
-
-int main(int ac, char **av)
-{
-	int lc;
-	struct itimerval *value;
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
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
