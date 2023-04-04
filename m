Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F431C761A6
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 10:37:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D2E3CAC2D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 12:37:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 718693C990C
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:08 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 090931A00813
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680604625; i=@fujitsu.com;
 bh=rci7LyrQ9NiQh+gZgG14oCPt/4sULf5XmBrMH3T3uGw=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=n4D8wM1QFA4pHpuJCtcT0SXaEz5cOixd0xC48fPALtQfjamxhajE80ena3ZvTIiAD
 tD+7DP8K4gyYo6rS0ghHrYeFxhDymgu8yaxI/YNjtv89Zbp9tb87RS55K/yDiUPb3M
 NEOLinq0qsMZZD1nCticJAYq1gJFoX05Q9JNVAmVbMvC1cWtYxhFy0Lt0lrEvDGyVI
 DllKsIUwkloLfMae+kznySAEiUcSxQWr2pdRtfflQwWjWA6DAzmjF8DtpNPjDVfTtd
 sFE9E8hCEIQ7bvH5YNr3TU+9b0FV3gXIqZ7QzuXUe/b/DWLst74nUPot+4HjUJX8SO
 Rsay7LY8daeFA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsViZ8ORqHvxr3a
 KwcYL3BYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8axGWfYCn6qVGy/9YqtgbFJtouRi0NI4Cyj
 RPuqx4wQzgEmiQn3m9khnD2MEtd6frF0MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6x
 QRiCwtYSxxaNoUNxGYRUJF48+04WC+vgKfElgUnwGokBBQkpjx8zwwRF5Q4OfMJC8QcCYmDL1
 4wQ9QoSbS1XmGFsCskGqcfgupVk7h6bhPzBEb+WUjaZyFpX8DItIrRrDi1qCy1SNfQVC+pKDM
 9oyQ3MTNHL7FKN1EvtVS3PLW4RNdQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMBxTilnidzBe6/ur
 d4hRkoNJSZT30UbtFCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvHavgXKCRanpqRVpmTnA2IBJS
 3DwKInwCv8BSvMWFyTmFmemQ6ROMSpKifMaASNKSAAkkVGaB9cGi8dLjLJSwryMDAwMQjwFqU
 W5mSWo8q8YxTkYlYR55/8CmsKTmVcCN/0V0GImoMWtURogi0sSEVJSDUyWleozS05ueW99ZZa
 9yJ8i6bvr03mPb/qScfxk+5cNfK0CXEIOmi8+FkdLRysJaX4JenFPOPLU3OsPZ9Yfn6LtP2mT
 2cO7L5PuPTffuGld087VKxPCpuuonJ0d+X/y61nOzPO91LVPmKzc9Dv5ybndKq4T8hIeHPIOD
 OdzlAwyWH/Kddn0fcfebjr2MOZPiarf78B/xRuLLt/eyRtdcuZCj1mp+M3knY2SjWo5l968Ne
 ha69ds+XGtSGsiV175pKR3XwoLep+v0aq7vyvj5Kz5cwyfH3OctEIhpVA1ytt/l41ow6PQKTO
 uLDBS1V2ysDfrQetslcmnb/C/W8q49Z/bxK+t85amrpqX2X3AZr7tLSWW4oxEQy3mouJEAKnz
 K61CAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-585.messagelabs.com!1680604624!545435!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25388 invoked from network); 4 Apr 2023 10:37:05 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-6.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 10:37:05 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id BA38F1001BE
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:04 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id ADB881001A5
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:04 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 11:37:03 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 18:36:31 +0800
Message-ID: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] syscalls/mlock01: Convert into new api
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

Also use safe macros and TST_EXP_PASS macro.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock01.c | 159 +++++-----------------
 1 file changed, 33 insertions(+), 126 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock01.c b/testcases/kernel/syscalls/mlock/mlock01.c
index 2338d4d56..0b079f8be 100644
--- a/testcases/kernel/syscalls/mlock/mlock01.c
+++ b/testcases/kernel/syscalls/mlock/mlock01.c
@@ -1,145 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
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
- * 	mlock01.c
- *
- * DESCRIPTION
- * 	Test to see that mlock works
- *$
- * ALGORITHM
- * 	test 1:
- *		Call mlock with various valid addresses and lengths.  No
- *		error should be returned
- *
- * USAGE:  <for command-line>
- *         -c n    Run n copies concurrently
- *         -e      Turn on errno logging
- *         -f      Turn off functional testing
- *         -h      Show this help screen
- *         -i n    Execute test n times
- *         -I x    Execute test for x seconds
- *         -p      Pause for SIGUSR1 before starting
- *         -P x    Pause for x seconds between iterations
- *         -t      Turn on syscall timing
+ * Copyright (c) International Business Machines Corp., 2002
  *
  * HISTORY
  *	06/2002 Written by Paul Larson
- *
- * RESTRICTIONS
- * 	None
  */
-#include <errno.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include "test.h"
 
-void setup();
-void setup1(int);
-void cleanup();
+/*\
+ * [Description]
+ *
+ * Test mlock with various valid addresses and lengths.
+ */
 
-char *TCID = "mlock01";
-int TST_TOTAL = 4;
+#include <stdlib.h>
+#include "tst_test.h"
 
-void *addr1;
+static void *addr;
 
-struct test_case_t {
-	void **addr;
+static struct tcase {
+	char *msg;
 	int len;
-	void (*setupfunc) ();
-} TC[] = {
-	/* mlock should return ENOMEM when some or all of the address
-	 * range pointed to by addr and len are not valid mapped pages
-	 * in the address space of the process
-	 */
-	{
-	&addr1, 1, setup1}, {
-	&addr1, 1024, setup1}, {
-	&addr1, 1024 * 1024, setup1}, {
-	&addr1, 1024 * 1024 * 10, setup1}
+} tcases[] = {
+	{"mlock 1 byte", 1},
+	{"mlock 1024 bytes", 1024},
+	{"mlock 1024 * 1024 bytes", 1024 * 1024},
+	{"mlock 1024 * 1024 * 10 bytes", 1024 * 1024 * 10}
 };
 
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * FIXME (garrcoop): this should really test out whether or not the
-	 * process's mappable address space is indeed accessible by the
-	 * current user, instead of needing to be run by root all the time.
-	 */
-	tst_require_root();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (TC[i].setupfunc != NULL)
-				TC[i].setupfunc(TC[i].len);
-
-			TEST(mlock(*(TC[i].addr), TC[i].len));
-
-			/* I'm confused -- given the description above this
-			 * should fail as designed, but this application
-			 * */
-			if (TEST_RETURN == -1)
-				tst_resm(TFAIL | TTERRNO, "mlock failed");
-			else
-				tst_resm(TPASS, "mlock passed");
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-#else
-
-int main(void)
+static void do_mlock(unsigned int i)
 {
-	tst_brkm(TCONF, NULL, "test is not available on uClinux");
-}
-
-#endif /* if !defined(UCLINUX) */
+	struct tcase *tc = &tcases[i];
 
-void setup(void)
-{
-	TEST_PAUSE;
+	tst_res(TINFO, "%s", tc->msg);
+	addr = SAFE_MALLOC(tc->len);
+	TST_EXP_PASS(mlock(addr, tc->len), "mlock(%p, %d)", addr, tc->len);
+	free(addr);
+	addr = NULL;
 }
 
-void setup1(int len)
+static void cleanup(void)
 {
-	addr1 = malloc(len);
-	if (addr1 == NULL)
-		tst_brkm(TFAIL, cleanup, "malloc failed");
+	if (addr)
+		free(addr);
 }
 
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.test = do_mlock,
+	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = cleanup,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
