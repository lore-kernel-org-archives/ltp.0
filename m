Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817A7ECAAD8
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 02:16:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A42423CAB98
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 04:16:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F1163CAAD0
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 04:16:01 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 43528601DD9
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 04:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1663208160; i=@fujitsu.com;
 bh=tEMeFXINk38T1qqPTMprvpNRjZOfzUUUQZxaEfpytcw=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=I0eQqv5dgIoYQ/nfhni/cljvVoWJf8XRjyO3Qx4otOWFXZOszSDFcuroC+4WXFBlV
 2NJ+XH0ko97tj2jj7PUH6fRtksnJil4HLLGvEjzXf+fyKS3aW+sLNsw/nTJYSjsGNg
 xlkNcJlb1SXcjuImVoYVkro6DwhxKbP07YMGKGGKAgULW9DfCmU5Q+EtRjTf+CtyOq
 nE4i68SubE2jNbzf5W8NV7W13nGPC5pRiKqu+3vZ9f8EW9Knu5uquLDFA9iA8XWW8R
 KFnimb0MbbpqNYEJi8gWGUa3vKQ0Q9SjMn6McheE0xFWcNdcRSznu5suejc2crExVv
 41llQ99ugDl3w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRWlGSWpSXmKPExsViZ8ORpHu/Syn
 Z4P0sMYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP5E7OChaIVu5euZWlgnCTYxcjFISRwilHi
 zsZOFghnL5PEgi/tzBDOdkaJvadnATmcHGwC2hJ3emYwgtgiAhISHQ1v2UFsZgFNiXtXDoPFh
 YFqbnX+AYuzCKhKdE+9BTSVg4NXwEVi/g4RkLCEgILElIfvwUbyCghKnJz5hAVijITEwRcvmC
 FqFCWunt7LCmFXSDROP8QEYatJXD23iXkCI/8sJO2zkLQvYGRaxWidVJSZnlGSm5iZo2toYKB
 raGiqa2wBpAz1Eqt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OTc1L08lJLNjECgzKlWC1/B+Pf
 lT/1DjFKcjApifIyySklC/El5adUZiQWZ8QXleakFh9ilOHgUJLgrW8HygkWpaanVqRl5gAjB
 CYtwcGjJMJ7phMozVtckJhbnJkOkTrFqMsxdfa//cxCLHn5ealS4rxHQIoEQIoySvPgRsCi9R
 KjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV4JkCk8mXklcJteAR3BBHSEkbU8yBEliQgpqQa
 mvI98s7z+BX+WOX9f8+mh9w2sFwuESq+1/mmb8KuP2eFW5YvpoZ3l1z8ujmbPshH/dvlRkVE8
 390a3o0fZoXwLrru5hmu9JZn7u8/ipME9koefDJPMKXx592bBzKvd26IWs8g8L9Wdt3R7Mf6J
 3vWJxxbKCzromQz40BeF+sPQ5szklcvONrfvFNQfdms5HHgbtMaj4oLPxS6q6c25x1bIL12vn
 avxjqOWDHVV5zf22Z4v40Kt72UnnlNbIHMnVrWdXban/cWc5hP9mV5MeWkQd+cZbyix17FxSX
 lpqkv+KWXcTJR/6rEGuMZ6Zy7TuQdPnnBTNrpw+N/OUuzXS1kDziuPv8vzf7xtePR8zZXK7EU
 ZyQaajEXFScCANlYx0tRAwAA
X-Env-Sender: liaohj.jy@fujitsu.com
X-Msg-Ref: server-17.tower-548.messagelabs.com!1663208159!62888!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5022 invoked from network); 15 Sep 2022 02:15:59 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-17.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Sep 2022 02:15:59 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 126161B2
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 03:15:59 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 06A531B1
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 03:15:59 +0100 (BST)
Received: from rhel-server--7.5 (10.167.215.42) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 15 Sep 2022 03:15:57 +0100
From: Liao Huangjie <liaohj.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 15 Sep 2022 10:15:46 +0800
Message-ID: <1663208146-5239-1-git-send-email-liaohj.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.42]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fork02: Remove it
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

From: Huangjie Liao <liaohj.jy@fujitsu.com>

This test case has been covered in fork01,so remove it

Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
---
 testcases/kernel/syscalls/fork/fork02.c | 99 -------------------------
 1 file changed, 99 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fork/fork02.c

diff --git a/testcases/kernel/syscalls/fork/fork02.c b/testcases/kernel/syscalls/fork/fork02.c
deleted file mode 100644
index 6fe66f823..000000000
--- a/testcases/kernel/syscalls/fork/fork02.c
+++ /dev/null
@@ -1,99 +0,0 @@
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
- *	fork02.c
- *
- * DESCRIPTION
- *	Test correct operation of fork:
- *		pid == 0 in child;
- *		pid > 0 in parent from wait;
- *
- * ALGORITHM
- *	Fork one process, check for pid == 0 in child.
- *	Check for pid > 0 in parent after wait.
- *
- * USAGE
- *	fork02
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
- */
-
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <stdio.h>
-#include <unistd.h>
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "fork02";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int pid1, pid2, status;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		pid1 = fork();
-		if (pid1 == -1)
-			tst_brkm(TBROK, cleanup, "fork() failed");
-
-		if (pid1 == 0) {
-			tst_resm(TINFO, "Inside child");
-			_exit(0);
-		} else {
-			tst_resm(TINFO, "Inside parent");
-			pid2 = wait(&status);
-			tst_resm(TINFO, "exit status of wait %d", status);
-
-			if (pid1 == pid2)
-				tst_resm(TPASS, "test 1 PASSED");
-			else
-				tst_resm(TFAIL, "test 1 FAILED");
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
