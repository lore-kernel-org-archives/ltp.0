Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F45C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 04:02:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 330C93D010C
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 05:02:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 924F73CFB18
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 05:01:48 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 139301400074
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 05:01:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706241707; x=1737777707;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7aKWHiDqqLaTN65bg+yOBXRtWo8bwEziF8t65eZ9bhA=;
 b=MaK1hSMgBbWtAFtN1/ezVnwyygh4yY7tVpljzKJV1dSw+QBNRKW6QK9z
 ZG0SwLVH61RkRZRlDNZM3kMgEImHJfr/4ouOwVwqHXpc8/O4ZiGpIuNxf
 4gRWzIkbs28a60CqNeT5l3MCwyUqZVqsGreRmcUqCh8PU8lTYaPc/ZcUc
 aAhQAWJgnCZIHp31ElbrghKveQOeBagVOgbtbjqjGnZ0Dx148TpyLaIsy
 TeYvV3nbA0CfQbxMVAJy9rkWBge8ELc4LtTizk+7kDjz9+Pen2KyD6M8u
 Y0sAKe61UZZpdkA+K4Is1OcmtJCnIpy9gSHmQjWYGzgBQYUxDYu178xBB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="147604329"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; d="scan'208";a="147604329"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 13:01:44 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C1B4D9DA6
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:42 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EA4EED2965
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D9B16B4C1
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:40 +0900 (JST)
Received: from irides.. (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2008D1A006C
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 12:01:40 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 12:01:38 +0800
Message-Id: <20240126040139.2534873-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
References: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.004
X-TMASE-Result: 10--19.373900-10.000000
X-TMASE-MatchedRID: Pb1HNPK8sDryq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUL4q
 7wkSW5bKbnRB47KLJ1QzLmfGY6iDkYF+91Q/EzGtN70wXhI0DX4yhLY8urUHvmvlGb+24NaZuJE
 UmdYPGSXiTzfmGp/ZBzTiWC5C1sf/sIm8s6bJZMU5ZRbFNAl0j79cAlQW5Yprr2Pto2emO2WkkT
 GZnjve6+14wOm5RFSV22skxEv+S/UO9fZKTjt+zwA+Y0oNaxbQyqyllX6UJIs1Y73PdzvXZJClV
 uR6WzhZIVhz3157EfnJuTpHnCXm39XQ2R27CZyzGYJhRh6ssesfimmlcABuNxj4eND0g8+sggEK
 sdd1+9z76oy6MPOJDWN26yr2I7RBhVgj6N6wwHCF0P4btTlf9KTYf9v9flolACF5TKaad18phVB
 O6Z0CBjxfxSdl51k89Cg8TV2EmpA3KXWd30Ii3RRFJJyf5BJe3QfwsVk0UbslCGssfkpInQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] fdatasync02: Convert to new API
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .../kernel/syscalls/fdatasync/fdatasync02.c   | 207 +++---------------
 1 file changed, 33 insertions(+), 174 deletions(-)

diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync02.c b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
index 9ce4fc7bb..89a815219 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync02.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
@@ -1,197 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * Copyright (c) Linux Test Project, 2003-2024
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : fdatasync02
- *
- *    EXECUTED BY       : Any user
- *
- *    TEST TITLE        : Checking error conditions for fdatasync(2)
- *
- *    TEST CASE TOTAL   : 2
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *      Verify that,
- *      1. fdatasync(2) returns -1 and sets errno to EBADF for invalid
- *	   file descriptor.
- *      2. fdatasync(2) returns -1 and sets errno to EINVAL for file
- *         descriptor to a special file.
- *
- *      Setup:
- *        Setup signal handling.
- *        Set expected errnos for logging
- *        Pause for SIGUSR1 if option specified.
- *
- *      Test:
- *       Loop if the proper options are given.
- *	  Perform testcase specific setup (if needed)
- *        Execute system call
- *        Check return code and error number, if matching,
- *                   Issue PASS message
- *        Otherwise,
- *                   Issue FAIL message
- *	  Perform testcase specific cleanup (if needed)
- *
- *      Cleanup:
- *        Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  fdatasync02 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
+
+/*\
+ * [Description]
  *
- ****************************************************************/
+ * Verify that,
+ * 1. fdatasync(2) returns -1 and sets errno to EBADF for invalid file
+ *    descriptor.
+ * 2. fdatasync(2) returns -1 and sets errno to EINVAL for file descriptor to a
+ *    special file.
+ */
 
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define EXP_RET_VAL	-1
 #define SPL_FILE	"/dev/null"
 
-struct test_case_t {		/* test case structure */
+static struct tcase {		/* test case structure */
+	int fd;
 	int experrno;		/* expected errno */
 	char *desc;
-	int (*setup) (void);	/* Individual setup routine */
-	void (*cleanup) (void);	/* Individual cleanup routine */
+} tcases[] = {
+	{ -1, EBADF, "invalid file descriptor" },
+	// initialize this fd later in setup()
+	{ -1, EINVAL, "file descriptor to a special file" },
 };
 
-char *TCID = "fdatasync02";
-
-static int testno;
-static int fd;
-
-static void setup(void);
-static void cleanup(void);
-static int setup1(void);
-static int setup2(void);
-static void cleanup2(void);
-
-static struct test_case_t tdat[] = {
-	{EBADF, "invalid file descriptor", setup1, NULL},
-	{EINVAL, "file descriptor to a special file", setup2, cleanup2},
-};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
+static void run(unsigned int n)
 {
-	int lc;
+	struct tcase *tc = &tcases[n];
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if ((tdat[testno].setup) && (tdat[testno].setup())) {
-				/* setup() failed, skip this test */
-				continue;
-			}
-
-			/* Test the system call */
-			TEST(fdatasync(fd));
-			if ((TEST_RETURN == EXP_RET_VAL) &&
-			    (TEST_ERRNO == tdat[testno].experrno)) {
-				tst_resm(TPASS, "Expected failure for %s, "
-					 "errno: %d", tdat[testno].desc,
-					 TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "Unexpected results for %s ; "
-					 "returned %ld (expected %d), errno %d "
-					 "(expected %d)", tdat[testno].desc,
-					 TEST_RETURN, EXP_RET_VAL,
-					 TEST_ERRNO, tdat[testno].experrno);
-			}
-			if (tdat[testno].cleanup) {
-				tdat[testno].cleanup();
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
-int setup1(void)
-{
-	fd = -1;
-	return 0;
-}
-
-int setup2(void)
-{
-	/* Open special file */
-	if ((fd = open(SPL_FILE, O_RDONLY)) == -1) {
-		tst_resm(TBROK, "Failed to open %s", SPL_FILE);
-		return 1;
-	}
-	return 0;
+	TST_EXP_FAIL(fdatasync(tc->fd), tc->experrno,
+		     "fdatasync() for %s(%d)", tc->desc, tc->fd);
 }
 
-void cleanup2(void)
+static void setup(void)
 {
-	/* close special file */
-	SAFE_CLOSE(NULL, fd);
+	tcases[1].fd = SAFE_OPEN(SPL_FILE, O_RDONLY);
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void cleanup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
+	SAFE_CLOSE(tcases[1].fd);
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
