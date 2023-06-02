Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FF0C7EE24
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 09:54:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B5943CCEEF
	for <ltp@archiver.kernel.org>; Fri,  2 Jun 2023 11:54:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222FA3CCDD8
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 11:54:42 +0200 (CEST)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 520A81A00439
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 11:54:40 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="119122168"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; d="scan'208";a="119122168"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 18:54:39 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A219DD424F
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 18:54:36 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C59F9D9A8B
 for <ltp@lists.linux.it>; Fri,  2 Jun 2023 18:54:35 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id EEF732FC8341;
 Fri,  2 Jun 2023 18:54:34 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri,  2 Jun 2023 17:53:51 +0800
Message-Id: <1685699631-4671-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1685699631-4671-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1685699631-4671-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27666.006
X-TMASE-Result: 10--24.658100-10.000000
X-TMASE-MatchedRID: gfPLl/E7ZuUKK0r2G9VU7k7nLUqYrlslFIuBIWrdOeOU8ftiyKjZreCG
 89wh97wnaj3ypNjZX+1WTBAeKqaX9Spe4ofkluPsqug9vIA2WODZobCTg4s1LL54YCapH5tAXsR
 1Vlexc+/4XJPAGTaiPAeWR71HtRmwaEsmopAJRAldhZyafgPiqzEvENg7dSUMUYkZd9+4t296+4
 Y3holm5YnfCN7LFTxDeoRDfBlv2T/Ko0CaSbP6EDz6L+U/pejxtOtXYgbXjdfG5dXdQTj2OFRG1
 tpaU7lUwR5/YsCEtnP+7Vem91xE3wZhlKhs1jTDSs47mbT7SASOVGny5q72hjzNRqQN9SIrZEh6
 0BrOMi1tqA7rUOit0yDLhawxlpdkVPVUF2N3LyOGp0fwr2DvF3O1oaQ51CuNd/Ex8BlUR52bJQP
 XTpvU5poi4Fk1Ww9PgDLqnrRlXrZ8nn9tnqel2JBlLa6MK1y4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/munlock02: Convert into new api
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

1.remove uclinux and ia64 code
2.use safe_macro macro

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/munlock/munlock02.c | 212 +++---------------
 1 file changed, 31 insertions(+), 181 deletions(-)

diff --git a/testcases/kernel/syscalls/munlock/munlock02.c b/testcases/kernel/syscalls/munlock/munlock02.c
index 75906a1df..f51c3d21f 100644
--- a/testcases/kernel/syscalls/munlock/munlock02.c
+++ b/testcases/kernel/syscalls/munlock/munlock02.c
@@ -1,198 +1,48 @@
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
- *    TEST IDENTIFIER	: munlock02
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Test for checking basic error conditions for
- * 	   		  munlock(2)
- *
- *    TEST CASE TOTAL	: 2
- *
- *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- * 	Check for basic errors returned by munlock(2) system call.
- *
- * 	Verify that munlock(2) returns -1 and sets errno to
- *
- * 	1) ENOMEM - Some of the specified address range does not correspond to
- *			mapped pages in the address space of the process.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	  Do necessary setup for each test.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
+
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  munlock02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *		where,		-c n : Run n copies concurrently
- *				-e   : Turn on errno logging.
- *				-h   : Show this help screen
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
+ * Test for ENOMEM error.
  *
- * RESTRICTIONS
- *	Test must run as root.
- *****************************************************************************/
-#include <errno.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <pwd.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "munlock02";
-int TST_TOTAL = 1;
-
-#define LEN	1024
-
-void *addr1;
+ * munlock(2) fails with ENOMEM if some of the specified address range
+ * does not correspond to mapped pages in the address space of the
+ * process.
+ */
 
-struct test_case_t {
-	void *addr;
-	int len;
-	int error;
-	char *edesc;
-} TC[] = {
-	{
-NULL, 0, ENOMEM, "address range out of address space"},};
+#include <sys/mman.h>
+#include "tst_test.h"
 
-#if !defined(UCLINUX)
+static size_t len, pg_size;
+static void *addr;
 
-int main(int ac, char **av)
+static void run(void)
 {
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
-		for (i = 0; i < TST_TOTAL; i++) {
-#ifdef __ia64__
-			TC[0].len = 8 * getpagesize();
-#endif
-			TEST(munlock(TC[i].addr, TC[i].len));
-
-			/* check return code */
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO != TC[i].error)
-					tst_brkm(TFAIL, cleanup,
-						 "munlock() Failed with wrong "
-						 "errno, expected errno=%s, "
-						 "got errno=%d : %s",
-						 TC[i].edesc, TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-				else
-					tst_resm(TPASS,
-						 "expected failure - errno "
-						 "= %d : %s",
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-			} else {
-				tst_brkm(TFAIL, cleanup,
-					 "munlock() Failed, expected "
-					 "return value=-1, got %ld",
-					 TEST_RETURN);
-			}
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-
-	tst_exit();
+	TST_EXP_FAIL(munlock(addr, len), ENOMEM, "munlock(%p, %lu)",
+		      addr, len);
 }
 
-/* setup() - performs all ONE TIME setup for this test. */
-
-void setup(void)
+static void setup(void)
 {
-
-	char *address;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TC[0].len = 8 * getpagesize();
-	address = mmap(0, TC[0].len, PROT_READ | PROT_WRITE,
-		       MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (address == MAP_FAILED)
-		tst_brkm(TFAIL, cleanup, "mmap_failed");
-	memset(address, 0x20, TC[0].len);
-	TEST(mlock(address, TC[0].len));
-
-	/* check return code */
-	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TTERRNO, cleanup,
-			 "mlock(%p, %d) Failed with return=%ld", address,
-			 TC[0].len, TEST_RETURN);
-	}
-	TC[0].addr = address;
+	pg_size = getpagesize();
+	len = 8 * pg_size;
+	addr = SAFE_MMAP(NULL, len, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	memset(addr, 0x20, len);
+	SAFE_MLOCK(addr, len);
 	/*
 	 * unmap part of the area, to create the condition for ENOMEM
 	 */
-	address += 2 * getpagesize();
-	munmap(address, 4 * getpagesize());
-
-	TEST_PAUSE;
-
-	return;
-}
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
+	addr += 2 * pg_size;
+	SAFE_MUNMAP(addr, 4 * pg_size);
 }
 
-#endif /* if !defined(UCLINUX) */
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-	return;
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
