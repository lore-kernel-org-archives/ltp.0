Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DAEC433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 03:38:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BD4B3CA5A8
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 05:38:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 971A03C9E2C
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 05:38:30 +0200 (CEST)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01C9820035A
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 05:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1651030707; i=@fujitsu.com;
 bh=53IjtsZqUuy2+X8oY7Ydp2iRdngr/C9kLle7a0kJh/s=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=PpgajvmXRzu+L0U+MaAWsxc8xPkXQJswqnsGOvgYyGOUPhgZWVQmp21jESy/E4ros
 EszIViIKKCxwJ6fMnGOZE0R7K7M289NK5jksxDQLoGK397wpOZLBhcNOdZowL3Klo5
 Z7gjJMIEcCDomsq2XT02e2YFPpjQhbztihUXM8PI3RF0G5AzlOH7V5scVlil8AILgT
 ohg1YEsNQ4iHn1L6cBqUetpa5/Hh8K2qTB40oqEXT+uWaJlTVkjOn+fB/2eXz7Lf9F
 iTfIeccrQxZdyc3WyORghN6MhURjkaYKvkLqTnhLnHNuJs2174tNUe89LI8ZmYu0Gb
 WcUJhjgLj9teA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRWlGSWpSXmKPExsViZ8ORqLt5V0a
 Swfvb0hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aP5WdYCz6pVyz/NYepgXGWQhcjJ4eQwFlG
 iecforsYuYDsnUwSu14vZodw9jBKtN76yQpSxSagKfGscwEziC0iICHR0fCWHcRmFvCT2Hf3K
 lCcg0NYwFri+TxpkDCLgKpE+7K5bCA2r4CnxKGtXWC2hICCxJSH78HGcAp4SbRPW8wEcYSnxI
 aNG1kg6gUlTs58wgIxXkLi4IsXzBC9ihKXOr4xQtgVErNmtTFB2GoSV89tYp7AKDgLSfssJO0
 LGJlWMdomFWWmZ5TkJmbm6BoaGOgaGprqmpnoGpvoJVbpJuqlluomp+aVFCUCZfUSy4v1UouL
 9Yorc5NzUvTyUks2MQIDOaXYQWkH49m+n3qHGCU5mJREeZOnZiQJ8SXlp1RmJBZnxBeV5qQWH
 2KU4eBQkuDt2AmUEyxKTU+tSMvMAUYVTFqCg0dJhHcySJq3uCAxtzgzHSJ1ilGXY8Hva3uZhV
 jy8vNSpcR5f64BKhIAKcoozYMbAYvwS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeTeBrOL
 JzCuB2/QK6AgmoCM+1aaCHFGSiJCSamCKSVQzLbNYpHXbuL5N79mdE5Yp1v0TW2esqj9/6l5D
 Unrv9hMaeimZoru/9vOf5Ul7uVHo5jamaCe72jW/OMPK5SY/N72zWP3q3olfyi6VO/Fk1C0Kc
 tF1Sf6ZusHfh4OP7dnpppqAt2/3vIt4vFIv74OIqvjuhu4p9pOzXIxm5/3JO7nGlPFx86K66s
 m/Zqn/8f7c4njPtjfvTefNqQo3xSbLffeQaZdIX2xV5+7FfIHd+5fastiz1rIX9fw+vZmkrFP
 nWPBNR4fn+OeXUvYesfc3MIYye35lMHpow+zwLFA7rIV1xx1WrnkHo9f/+n/zQeWSU2ahrL/P
 8MqsNV8sOjGGa9ILvgP7u0pWflViKc5INNRiLipOBAAh/JPyawMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-528.messagelabs.com!1651030707!27937!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7927 invoked from network); 27 Apr 2022 03:38:27 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-4.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Apr 2022 03:38:27 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id E00B9100190
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 04:38:26 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id C320810018E
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 04:38:26 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 27 Apr 2022 04:38:14 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Apr 2022 12:39:22 +0800
Message-ID: <1651034362-18672-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651034362-18672-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1651034362-18672-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/shmdt02: Convert into new api
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

Signed-off-by: Liao Huangjie <liaohj.jy@fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmdt/Makefile  |   7 +-
 testcases/kernel/syscalls/ipc/shmdt/shmdt02.c | 134 +++++-------------
 2 files changed, 34 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/ipc/shmdt/Makefile
index a48dbf48f..6b2b26d05 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -3,13 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc ltpnewipc
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-shmdt01: LTPLDLIBS = -lltpnewipc
-shmdt02: LTPLDLIBS = -lltpipc
-
-LTPLDLIBS  = -lltpipc ltpnewipc
+LTPLDLIBS  = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
index 5cab2596b..782c6f488 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
@@ -1,118 +1,48 @@
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
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * NAME
- *	shmdt02.c
- *
- * DESCRIPTION
- *	shmdt02 - check for EINVAL error
- *
- * ALGORITHM
- *	loop if that option was specified
- *	  call shmdt() using an invalid shared memory address
- *	  check the errno value
- *	    issue a PASS message if we get EINVAL
- *	  otherwise, the tests fails
- *	    issue a FAIL message
- *	call cleanup
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  shmdt02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+ * Tests basic error handing of the shmdt syscall.
  *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
+ * -EINVAL there is no shared memory segment attached at shmaddr.
+ * -EINVAL shmaddr is not aligned on a page boundary.
  */
 
-#include "ipcshm.h"
-
-char *TCID = "shmdt02";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
-	int unshared;		/* a local variable to use to produce *//* the error in the shmdt() call */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+#include <sys/types.h>
+#include <sys/shm.h>
+#include "tst_test.h"
+#include "libnewipc.h"
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+static void *non_attched_addr;
+static void *unaligned_addr;
 
-		/*
-		 * make the call using the TEST() macro - attempt to
-		 * remove an invalid shared memory address
-		 */
+struct tcase {
+	void **addr;
+	char *des;
+} tcases[] = {
+	{&non_attched_addr, "shmdt(non_attched_addr)"},
+	{&unaligned_addr, "shmdt(unaligned_addr)"}
+};
 
-		TEST(shmdt(&unshared));
-
-		if (TEST_RETURN != -1) {
-			tst_brkm(TFAIL, cleanup, "call succeeded unexpectedly");
-		}
-
-		switch (TEST_ERRNO) {
-		case EINVAL:
-			tst_resm(TPASS, "expected failure - errno = %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed with an unexpected error "
-				 "- %d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
-
-		}
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
+static void verify_shmdt(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	TST_EXP_FAIL(shmdt(*tc->addr), EINVAL, "%s", tc->des);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
-
+	non_attched_addr = PROBE_FREE_ADDR();
+	unaligned_addr = non_attched_addr + SHMLBA - 1;
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_shmdt,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
