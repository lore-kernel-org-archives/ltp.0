Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC65BC77B7A
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 09:54:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E794D3CCDFF
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 11:54:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C433A3CCDD8
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 11:54:08 +0200 (CEST)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B25A910009A0
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 11:54:06 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="120401583"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; d="scan'208";a="120401583"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 18:54:05 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 13C1BD3EA3
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 18:54:03 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 48B08D67D1
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 18:54:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 577572FC8341;
 Fri,  2 Jun 2023 18:54:01 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri,  2 Jun 2023 17:53:50 +0800
Message-Id: <1685699631-4671-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27666.006
X-TMASE-Result: 10--20.884000-10.000000
X-TMASE-MatchedRID: t1TP0uXPV06hhjsqgSuNbxF4zyLyne+AVBDQSDMig9EnyU5/nZpxUL4q
 7wkSW5bKbnRB47KLJ1QzLmfGY6iDkYF+91Q/EzGtN70wXhI0DX4yhLY8urUHvmvlGb+24NaZuJE
 UmdYPGSVrPg89NCqC9syK5YNF2aor/r2K6wdIm9/X3j/lf1V8LD92Og3IOZltS1jK4vkKprHE68
 3wZxeesm5/m6vlvI+luGvA9nymq1lDQYe+1GQPNfCCu8kVj0TRgbNN0R684zOKso3EN6f9DAtgH
 DHbgC1ShthwNVVpqbC3xElUZX+x22+w5IlbLL18dXu122+iJtosYZ+FvRRQ3Z8SKrzgiUxNa0IE
 kYOsokUYnaS0r6Dt+K69+qEZoIxB0FQxfjRHOzieAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8jpP8t
 MOyYmaA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/munlock01: Convert into new api
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/munlock/munlock01.c | 181 ++++--------------
 1 file changed, 35 insertions(+), 146 deletions(-)

diff --git a/testcases/kernel/syscalls/munlock/munlock01.c b/testcases/kernel/syscalls/munlock/munlock01.c
index 8a52f032d..31d749e66 100644
--- a/testcases/kernel/syscalls/munlock/munlock01.c
+++ b/testcases/kernel/syscalls/munlock/munlock01.c
@@ -1,162 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * AUTHOR: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
  */
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: munlock01
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Basic test for munlock(2)
- *
- *    TEST CASE TOTAL	: 4
- *
- *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the munlock(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  munlock01 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *		where,		-c n : Run n copies concurrently
- *				-e   : Turn on errno logging.
- *				-h   : Show this help screen
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
- * RESTRICTIONS
- * Must be root/superuser to run it.
- *****************************************************************************/
-
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
+ * Test munlock with various valid addresses and lengths.
+ */
 
-char *TCID = "munlock01";
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
-	{
-	&addr1, 1, setup1}, {
-	&addr1, 1024, setup1}, {
-	&addr1, 1024 * 1024, setup1}, {
-	&addr1, 1024 * 1024 * 10, setup1}
+} tcases[] = {
+	{"munlock 1 byte", 1},
+	{"munlock 1024 bytes", 1024},
+	{"munlock 1024 * 1024 bytes", 1024 * 1024},
+	{"munlock 1024 * 1024 * 10 bytes", 1024 * 1024 * 10}
 };
 
-int main(int ac, char **av)
-{
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* check looping state */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (TC[i].setupfunc != NULL)
-				TC[i].setupfunc(i);
-
-			TEST(munlock(*(TC[i].addr), TC[i].len));
-
-			/* check return code */
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO,
-					 "mlock(%p, %d) Failed with "
-					 "return=%ld", TC[i].addr, TC[i].len,
-					 TEST_RETURN);
-			} else {
-				tst_resm(TPASS, "test %d passed length = %d",
-					 i, TC[i].len);
-			}
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-
-	tst_exit();
-}
-
-void setup1(int i)
+static void verify_munlock(unsigned int i)
 {
-	addr1 = malloc(TC[i].len);
-	if (addr1 == NULL)
-		tst_brkm(TFAIL, cleanup, "malloc failed");
-	TEST(mlock(*(TC[i].addr), TC[i].len));
-
-	/* check return code */
-	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TTERRNO, cleanup,
-			 "mlock(%p, %d) Failed with return=%ld", TC[i].addr,
-			 TC[i].len, TEST_RETURN);
-	}
+	struct tcase *tc = &tcases[i];
+
+	tst_res(TINFO, "%s", tc->msg);
+	addr = SAFE_MALLOC(tc->len);
+	SAFE_MLOCK(addr, tc->len);
+	TST_EXP_PASS(munlock(addr, tc->len), "munlock(%p, %d)", addr, tc->len);
+	free(addr);
+	addr = NULL;
 }
 
-/* setup() - performs all ONE TIME setup for this test. */
-void setup(void)
+static void cleanup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	if (addr)
+		free(addr);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.test = verify_munlock,
+	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = cleanup,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
