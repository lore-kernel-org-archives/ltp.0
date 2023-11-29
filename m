Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFD2C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 06:13:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7530D3CD946
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 07:13:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE8883CD784
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 07:12:56 +0100 (CET)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 82A791A00918
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 07:12:54 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="129363887"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; d="scan'208";a="129363887"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 15:12:52 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E9275D64BC
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:12:50 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E35AD60F6
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:12:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A3C446B805
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:12:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2F1D21A0071;
 Wed, 29 Nov 2023 14:12:49 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed, 29 Nov 2023 01:12:44 -0500
Message-Id: <20231129061244.72829-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28026.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28026.005
X-TMASE-Result: 10--17.448700-10.000000
X-TMASE-MatchedRID: tGJ02YVcvxcRcrxK+AdK7zU9EK4+H8U1aZATGA5/BXhgPgeggVwCFpYv
 gWqjMEzaNYCBzzxsUnv/hDDq/XyZmS/7QU2czuUNA9lly13c/gFzNCdGumZsScSiwizsgluQiH6
 Yv5yIUKludEHjsosnVDMuZ8ZjqIORfm5R+E2+crM5ZRbFNAl0jxRli5ttSPYMu3gEBpQvABUl/m
 i29q85l/29Pl68xfi0WS2NwPsUPtJZQ4rley4x/kz7FUUjXG1jl9q75JzWJRNujEcOZiInj5/bu
 mQx78u3oekUdArZ14HOyd98r1P+4fVACeiFsAcyEzEoOqAAVLM2hINq/IswlCkvFki4e3OUzPNl
 EtpUdaIQrkzWMsBTmoVjahLr+ZTJR+vpYbhOH1r4Zi3x/9WFO79cAlQW5YprrblmM/aFaC+Trr+
 C1WNmxdVlIlxlHyS47pwlAnoEcLCPGYLjOKcfyoanR/CvYO8XsbIL/j/u56ryPC7FUFMmiJ7VNy
 7+UW/9/I+yd0mcY0W310iilwWxWkIYiAJlkvRNngIgpj8eDcCbifj2/J/1cUp0ODI8GjvXKrauX
 d3MZDUD/dHyT/Xh7Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Refactor and merge symlink04/05 using new LTP API
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

symlink04 and symlink05 has been merged together, testing
the results of symlink(2) for the existence or non-existence
of a file

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 -
 testcases/kernel/syscalls/symlink/.gitignore  |   1 -
 testcases/kernel/syscalls/symlink/symlink04.c | 213 ++++--------------
 testcases/kernel/syscalls/symlink/symlink05.c | 180 ---------------
 4 files changed, 42 insertions(+), 353 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/symlink/symlink05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 61444c86b..3c1fc5e86 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1563,7 +1563,6 @@ symlink01 symlink01
 symlink02 symlink02
 symlink03 symlink03
 symlink04 symlink04
-symlink05 symlink05
 
 #symlinkat test cases
 symlinkat01 symlinkat01
diff --git a/testcases/kernel/syscalls/symlink/.gitignore b/testcases/kernel/syscalls/symlink/.gitignore
index d1497e680..6ea587ff3 100644
--- a/testcases/kernel/syscalls/symlink/.gitignore
+++ b/testcases/kernel/syscalls/symlink/.gitignore
@@ -2,4 +2,3 @@
 /symlink02
 /symlink03
 /symlink04
-/symlink05
diff --git a/testcases/kernel/syscalls/symlink/symlink04.c b/testcases/kernel/syscalls/symlink/symlink04.c
index 2190b3b1b..c43a03a26 100644
--- a/testcases/kernel/syscalls/symlink/symlink04.c
+++ b/testcases/kernel/syscalls/symlink/symlink04.c
@@ -1,193 +1,64 @@
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) Linux Test Project, 2001-2023
+ * Author: John George
  */
 
-/*
- * Test Name : symlink04
- *
- * Test Description :
- *  Verify that, symlink will succeed to creat a symbolic link of an existing
- *  object name path.
- *
- * Expected Result:
- *  symlink() should return value 0 on success and symbolic link of an
- *  existing object should be created.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  symlink04 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  None.
+/*\
+ * [Description]
  *
+ * Check that a symbolic link may point to an existing file or
+ * to a nonexistent one.
  */
 
+#include <stdlib.h>
 #include <stdio.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-#define  TESTFILE	"testfile"
-#define  SYMFILE	"slink_file"
-#define FILE_MODE       S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
+#define TESTFILE    "testfile"
+#define NONFILE     "noexistfile"
+#define SYMFILE     "slink_file"
 
-char *TCID = "symlink04";
-int TST_TOTAL = 1;
+static char *testfile;
+static char *nonfile;
 
-void setup();
-void cleanup();
+static struct tcase {
+	char **srcfile;
+} tcases[] = {
+	{&testfile},
+	{&nonfile},
+};
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	struct stat stat_buf;	/* stat structure buffer */
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call symlink(2) to create a symlink of
-		 * testfile.
-		 */
-		TEST(symlink(TESTFILE, SYMFILE));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "symlink(%s, %s) Failed, errno=%d : %s",
-				 TESTFILE, SYMFILE, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			/*
-			 * Get the symlink file status information
-			 * using lstat(2).
-			 */
-			if (lstat(SYMFILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "lstat(2) of "
-					 "%s failed, error:%d", SYMFILE,
-					 errno);
-			}
-
-			/* Check if the st_mode contains a link  */
-			if (!S_ISLNK(stat_buf.st_mode)) {
-				tst_resm(TFAIL,
-					 "symlink of %s doesn't exist",
-					 TESTFILE);
-			} else {
-				tst_resm(TPASS, "symlink(%s, %s) "
-					 "functionality successful",
-					 TESTFILE, SYMFILE);
-			}
-		}
-
-		/* Unlink the symlink file for next loop */
-		SAFE_UNLINK(cleanup, SYMFILE);
-		tst_count++;	/* incr TEST_LOOP counter */
-	}
-
-	cleanup();
-	tst_exit();
-
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and close it
- */
-void setup(void)
+static void verify_symlink(unsigned int i)
 {
-	int fd;			/* file handle for testfile */
+	struct tcase *tc = &tcases[i];
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct stat stat_buf;
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
+	TST_EXP_PASS(symlink(*tc->srcfile, SYMFILE));
 
-	tst_tmpdir();
+	SAFE_LSTAT(SYMFILE, &stat_buf);
 
-	/* creat/open a testfile */
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) Failed, errno=%d : %s",
-			 TESTFILE, FILE_MODE, errno, strerror(errno));
-	}
+	if (!S_ISLNK(stat_buf.st_mode))
+		tst_res(TFAIL, "symlink of %s doesn't exist", *tc->srcfile);
 
-	/* Close the temporary file created above */
-	if (close(fd) == -1) {
-		tst_resm(TBROK, "close(%s) Failed, errno=%d : %s",
-			 TESTFILE, errno, strerror(errno));
-	}
+	SAFE_UNLINK(SYMFILE);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = verify_symlink,
+	.bufs = (struct tst_buffers []) {
+		{&testfile, .str = TESTFILE},
+		{&nonfile, .str = NONFILE},
+		{},
+	},
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/symlink/symlink05.c b/testcases/kernel/syscalls/symlink/symlink05.c
deleted file mode 100644
index 83b151f5d..000000000
--- a/testcases/kernel/syscalls/symlink/symlink05.c
+++ /dev/null
@@ -1,180 +0,0 @@
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
- * Test Name : symlink05
- *
- * Test Description :
- *  Verify that, symlink will succeed to creat a symbolic link of an
- *  non-existing object name path.
- *
- * Expected Result:
- *  symlink() should return value 0 on success and symlink of an
- *  non-existing object should be created.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  symlink05 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  This test should be run by 'non-super-user' only.
- *
- */
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define  TESTFILE	"testfile"
-#define  SYMFILE	"slink_file"
-
-char *TCID = "symlink05";
-int TST_TOTAL = 1;
-
-void setup();
-void cleanup();
-
-int main(int ac, char **av)
-{
-	struct stat stat_buf;	/* stat structure buffer */
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call symlink(2) to create a symlink of
-		 * an non-existing testfile.
-		 */
-		TEST(symlink(TESTFILE, SYMFILE));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "symlink(%s, %s) Failed, errno=%d : %s",
-				 TESTFILE, SYMFILE, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			/*
-			 * Get the symlink file status information
-			 * using lstat(2).
-			 */
-			if (lstat(SYMFILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "lstat(2) of "
-					 "%s failed, error:%d",
-					 SYMFILE, errno);
-			}
-
-			/* Check if the st_mode contains a link  */
-			if (!S_ISLNK(stat_buf.st_mode)) {
-				tst_resm(TFAIL,
-					 "symlink of %s doesn't exist",
-					 TESTFILE);
-			} else {
-				tst_resm(TPASS, "symlink(%s, %s) "
-					 "functionality successful",
-					 TESTFILE, SYMFILE);
-			}
-		}
-
-		/* Unlink the symlink file for next loop */
-		SAFE_UNLINK(cleanup, SYMFILE);
-		tst_count++;	/* incr TEST_LOOP counter */
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-}
-
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Remove the temporary directory created in the setup.
- */
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
