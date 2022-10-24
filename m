Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79779C3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 02:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70C393C8FC1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 04:40:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41A733C0763
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:40:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F8691A006F3
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:40:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666579215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZ7aKzFD3CmISaCgkZDUyRwA9lBgb+bFOoUHJmV2obs=;
 b=IjqF+vtP6Qybuyn3XwSSiSG5hZOVdlPQyarmkqVXgLQZ/zBE/qvVKXMQTiWNym+l2LHLM2
 lFqjrC085h/4vP+/nRBTv+KrCrtZb44PxT0AoXt28W+AV19xO1wgLWFHGcpg5CiOAYUDHm
 8PJJm+YbchQq7L2yAy3JDVn+Z5WJ4eY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-CACoXt2iMIetQBNXCv2mtQ-1; Sun, 23 Oct 2022 22:40:13 -0400
X-MC-Unique: CACoXt2iMIetQBNXCv2mtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B9A385A583
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 02:40:13 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 963447AE5
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 02:40:12 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 24 Oct 2022 10:40:09 +0800
Message-Id: <20221024024009.3553633-2-liwang@redhat.com>
In-Reply-To: <20221024024009.3553633-1-liwang@redhat.com>
References: <20221009085745.3239893-1-liwang@redhat.com>
 <20221024024009.3553633-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] setitimer01: rewrite using new API
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
 .../kernel/syscalls/setitimer/setitimer01.c   | 214 +++++++-----------
 1 file changed, 77 insertions(+), 137 deletions(-)

diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index 6874b94ad..f04cb5a69 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -1,157 +1,97 @@
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
+/*\
+ * [Description]
  *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
+ * Check that a setitimer() call pass with timer seting.
+ * Check if signal is generated correctly when timer expiration.
  */
 
-#include "test.h"
-
 #include <errno.h>
 #include <sys/time.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define USEC1	10000
+#define USEC2	20000
+
+static struct itimerval *value, *ovalue;
+
+static struct tcase {
+	int which;
+	char *des;
+	int signo;
+} tcases[] = {
+	{ITIMER_REAL,    "ITIMER_REAL",    SIGALRM},
+	{ITIMER_VIRTUAL, "ITIMER_VIRTUAL", SIGVTALRM},
+	{ITIMER_PROF,    "ITIMER_PROF",    SIGPROF},
+};
+
+static int sys_setitimer(int which, void *new_value, void *old_value)
+{
+	return tst_syscall(__NR_setitimer, which, new_value, old_value);
+}
+
+static void set_setitimer_value(int usec, int o_usec)
+{
+	value->it_value.tv_sec = 0;
+	value->it_value.tv_usec = usec;
+	value->it_interval.tv_sec = 0;
+	value->it_interval.tv_usec = 0;
+
+	ovalue->it_value.tv_sec = o_usec;
+	ovalue->it_value.tv_usec = o_usec;
+	ovalue->it_interval.tv_sec = 0;
+	ovalue->it_interval.tv_usec = 0;
+}
 
-void cleanup(void);
-void setup(void);
+static void verify_setitimer(unsigned int i)
+{
+	pid_t pid;
+	int status;
+	struct tcase *tc = &tcases[i];
 
-char *TCID = "setitimer01";
-int TST_TOTAL = 1;
+	pid = SAFE_FORK();
 
-#define SEC0	0
-#define SEC1	20
-#define SEC2	40
+	if (pid == 0) {
+		tst_res(TINFO, "tc->which = %s", tc->des);
 
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
-
-		TEST(setitimer(ITIMER_REAL, value, ovalue));
-
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
+		tst_no_corefile(0);
 
-	cleanup();
-	tst_exit();
-}
+		set_setitimer_value(USEC1, 0);
+		TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
+		set_setitimer_value(USEC2, USEC2);
+		TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+		if (ovalue->it_value.tv_sec != 0 || ovalue->it_value.tv_usec >= USEC2)
+			tst_brk(TFAIL, "old timer value is not within the expected range");
 
-	TEST_PAUSE;
-}
+		for (;;)
+			;
+	}
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
+	SAFE_WAITPID(pid, &status, 0);
 
+	if (WIFSIGNALED(status) && WTERMSIG(status) == tc->signo)
+		tst_res(TPASS, "Child received signal: %s", tst_strsig(tc->signo));
+	else
+		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.test = verify_setitimer,
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
