Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BB7C47DDB
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 04:02:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED1DA3CFB1F
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 05:02:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC3EB3CFB2D
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 05:01:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 88ED520093F
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 05:01:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706241710; x=1737777710;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xMI1UjbLy7vvgLix5jTE+2lbEtSMG0YXBs8dPU1sZbI=;
 b=UxzdnFze59xZCHZVfwu6I9w564nUoI3gD+EAZb8UQBKa9AW/FDMGuTSr
 E1Ws5RtKchLXcHbk/z5K3Iir77Tk2b0EGULjSs0Od9dozgQSa4RH5UdML
 M8ArbJAgcD1rRcWNOMbtDtUB6nlQ1dRP/iLfiT18xwzjqVwjLAgBfpeAH
 W1t5ITmtbNZf/FqYQKjbyE/9cGJboGelfU3Itjrddj2QqQc55nzAPSSjY
 yLvGLuDbpWJ/qlmZDeGBGUyJMxNYai65D3NhBWaYz58KXLLA024jtEYgo
 GPYgNxKQBg0yCJUS49Ki3Hnl3KA22EQ2F4irTvBAW72wjVd4jz2rKhuoy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="126110251"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; d="scan'208";a="126110251"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 13:01:44 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5847CE8C08
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:42 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C79BAD8BCC
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 60D262007C3E2
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:01:40 +0900 (JST)
Received: from irides.. (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id EDD321A006A
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 12:01:39 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 12:01:37 +0800
Message-Id: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.004
X-TMASE-Result: 10--22.004700-10.000000
X-TMASE-MatchedRID: VRedb8S231nyq/cli2hvDU7nLUqYrlslFIuBIWrdOeMnyU5/nZpxUL4q
 7wkSW5bKbnRB47KLJ1QzLmfGY6iDkYF+91Q/EzGtN70wXhI0DX4yhLY8urUHvmvlGb+24NaZuJE
 UmdYPGSXiTzfmGp/ZBzTiWC5C1sf/sIm8s6bJZMU5ZRbFNAl0j79cAlQW5YprpjlkbDvDJ4djDe
 scmMp4DI2J1F/55TUPJEbUc8xGQ/ZXDwaouY0y7s2CuVPkCNzuBGvINcfHqhcvPRFFhcWhYNBBe
 W0QNlfKWLhiC/mMnN+ITE3HVSm/hYaYpgfhqlfrEzEoOqAAVLM2hINq/IswlJmPq8jhF/uENq8y
 lq3YspJADnLPlN1QTR00eqxHEa4eEd0YyW6tLbkdahq+rGDn/50JB6wB6CqmVC4aflv2vZlJI7w
 YmUmzrHJcwyKKWovqJKpa08oNRnyPJkelMnqjq1VeGWZmxN2MHhysWPN3OzibKItl61J/yZ+inT
 K0bC9eKrauXd3MZDUD/dHyT/Xh7Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] fdatasync01: Convert to new API
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
 .../kernel/syscalls/fdatasync/fdatasync01.c   | 164 +++---------------
 1 file changed, 26 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync01.c b/testcases/kernel/syscalls/fdatasync/fdatasync01.c
index 24a91785c..ba4375b68 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync01.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync01.c
@@ -1,155 +1,43 @@
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
- *    TEST IDENTIFIER   : fdatasync01
- *
- *    EXECUTED BY       : Any user
- *
- *    TEST TITLE        : Basic test for fdatasync(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the fdatasync(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	  Create a temp directory and cd to it
- *	  Initialize filename and open it in write mode for each child process.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Issue FAIL message with errno.
- *	  Otherwise, Issue PASS message.
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *	  Remove temporary directory and all files in it.
- *
- * USAGE:  <for command-line>
- *  fdatasync01 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
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
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "test.h"
+ * Basic test for fdatasync(). Call fdatasync() on a fd and expect it to pass.
+ */
 
-static int fd;
-static char filename[30];
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
 
-char *TCID = "fdatasync01";
-int TST_TOTAL = 1;
+static int fd;
+static char pfilename[30];
 
-int main(int argc, char **argv)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* Test the system call */
-		TEST(fdatasync(fd));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "fdatasync() failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			/* No Functional verification yet */
-			tst_resm(TPASS, "fdatasync() successful");
-		}
-	}
-
-	/* perform global cleanup and exit */
-	cleanup();
-
-	tst_exit();
-
+	TST_EXP_PASS(fdatasync(fd), "fdatasync(%d)", fd);
 }
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	/* Initialize unique filename for each child process */
-	if (sprintf(filename, "fdatasync_%d", getpid()) <= 0) {
-		tst_brkm(TBROK, cleanup, "Failed to initialize filename");
-	}
-	if ((fd = open(filename, O_CREAT | O_WRONLY, 0777)) == -1) {	//mode must be specified when O_CREATE is in the flag
-		tst_brkm(TBROK, cleanup, "open() failed");
-	}
-	if ((write(fd, filename, strlen(filename) + 1)) == -1) {
-		tst_brkm(TBROK, cleanup, "write() failed");
-	}
+	sprintf(pfilename, "fdatasync_%d", getpid());
+
+	/* mode must be specified when O_CREATE is in the flag */
+	fd = SAFE_OPEN(pfilename, O_CREAT | O_WRONLY, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, pfilename, strlen(pfilename) + 1);
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	close(fd);
-
-	tst_rmdir();
-
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
