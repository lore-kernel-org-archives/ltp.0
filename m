Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F938C433FE
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 02:40:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CE6B3C9111
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 04:40:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04F733C0763
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:40:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4C1E1A006ED
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:40:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666579214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiNr81udfHKIK5RRTr81dryDFJIm4mM+gx8k8ku4WiY=;
 b=VUO60Nvg42WSoxYLww3rF2WCebL9xJrJ/KJ1NIrABBoJkEN4qOSlzDnl7A/ybCJCoImz5b
 91zvtmLlnJmFQ5D2dSAIapoEs3YOi+MqZp73kKL77EOG0RECYdgYfXSAQWMQ7HTX4hdT8/
 xovVIraejEh37lZY6vEDkl5au/9ZFf0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-FWnySF6_NOWOnTMteYJpcg-1; Sun, 23 Oct 2022 22:40:12 -0400
X-MC-Unique: FWnySF6_NOWOnTMteYJpcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F28FD3806723
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 02:40:11 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05F897AE5
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 02:40:10 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 24 Oct 2022 10:40:08 +0800
Message-Id: <20221024024009.3553633-1-liwang@redhat.com>
In-Reply-To: <20221009085745.3239893-1-liwang@redhat.com>
References: <20221009085745.3239893-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] setitimer03: convert to new API
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

Combine this EINVAL test into setitimer02 and add one additional
ITIMER_VIRTUAL verification.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/syscalls                              |   1 -
 .../kernel/syscalls/setitimer/.gitignore      |   1 -
 .../kernel/syscalls/setitimer/setitimer02.c   |  29 +++-
 .../kernel/syscalls/setitimer/setitimer03.c   | 158 ------------------
 4 files changed, 21 insertions(+), 168 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/setitimer/setitimer03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a52b93c92..3dc6fa397 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1327,7 +1327,6 @@ sethostname03 sethostname03
 
 setitimer01 setitimer01
 setitimer02 setitimer02
-setitimer03 setitimer03
 
 setns01 setns01
 setns02 setns02
diff --git a/testcases/kernel/syscalls/setitimer/.gitignore b/testcases/kernel/syscalls/setitimer/.gitignore
index 048db9b31..35779a32c 100644
--- a/testcases/kernel/syscalls/setitimer/.gitignore
+++ b/testcases/kernel/syscalls/setitimer/.gitignore
@@ -1,3 +1,2 @@
 /setitimer01
 /setitimer02
-/setitimer03
diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index 9ac9ce1fa..b012d71fa 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -8,8 +8,10 @@
 /*\
  * [Description]
  *
- * Check that a setitimer() call fails with EFAULT with invalid itimerval
- * pointer.
+ * Check that setitimer() call fails:
+ *
+ * 1. EFAULT with invalid itimerval pointer
+ * 2. EINVAL when called with an invalid first argument
  */
 
 #include <errno.h>
@@ -18,17 +20,26 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-static struct itimerval *value;
+static struct itimerval *value, *ovalue;
 
 static int sys_setitimer(int which, void *new_value, void *old_value)
 {
 	return tst_syscall(__NR_setitimer, which, new_value, old_value);
 }
 
-static void verify_setitimer(void)
+static void verify_setitimer(unsigned int i)
 {
-	TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (struct itimerval *)-1),
-	             EFAULT);
+	switch (i) {
+	case 0:
+		TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (void *)-1), EFAULT);
+		break;
+	case 1:
+		TST_EXP_FAIL(sys_setitimer(ITIMER_VIRTUAL, value, (void *)-1), EFAULT);
+		break;
+	case 2:
+		TST_EXP_FAIL(sys_setitimer(-ITIMER_PROF, value, ovalue), EINVAL);
+		break;
+	}
 }
 
 static void setup(void)
@@ -40,10 +51,12 @@ static void setup(void)
 }
 
 static struct tst_test test = {
-	.test_all = verify_setitimer,
+	.tcnt = 3,
+	.test = verify_setitimer,
 	.setup = setup,
 	.bufs = (struct tst_buffers[]) {
-		{&value, .size = sizeof(struct itimerval)},
+		{&value,  .size = sizeof(struct itimerval)},
+		{&ovalue, .size = sizeof(struct itimerval)},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/setitimer/setitimer03.c b/testcases/kernel/syscalls/setitimer/setitimer03.c
deleted file mode 100644
index 418ec71f0..000000000
--- a/testcases/kernel/syscalls/setitimer/setitimer03.c
+++ /dev/null
@@ -1,158 +0,0 @@
-/*
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
- */
-
-/*
- * NAME
- *	setitimer03.c
- *
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
-char *TCID = "setitimer03";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
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
