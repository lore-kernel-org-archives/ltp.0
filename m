Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A24BCDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 09:38:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAA243CD04B
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 11:38:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 717A73C8927
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:38:18 +0200 (CEST)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0755E1000CB4
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:38:16 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="137027344"
X-IronPort-AV: E=Sophos;i="6.03,238,1694703600"; d="scan'208";a="137027344"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2023 18:38:14 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C166D9DA9
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 18:38:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6568EF943
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 18:38:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E047820050193
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 18:38:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8BCB21A0071;
 Fri, 20 Oct 2023 17:38:10 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 20 Oct 2023 17:37:56 +0800
Message-Id: <1697794677-14892-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27946.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27946.006
X-TMASE-Result: 10--15.150100-10.000000
X-TMASE-MatchedRID: 3UHCnQ5jp7VnQCQAG5wcwTU9EK4+H8U19LMB0hXFSejAuQ0xDMaXkH4q
 tYI9sRE/w/kunvvd5s3Zvor6qg8CpUeXEeTXarDS7TovvZPhLcB1zSnwpu89bYAjsy+r+wvn2JH
 TTqNG6YpUzndbBQKrMojqLBCPdE946tgv1S39I0ZdnSd5JiRhlhB0ENZnw1vtXZmAtjip/rFcfd
 b7nucZ+RBPzZigGafMMVObZjZKQv6+yza4Wm1Q8e9VsdrlGzy3xMZq+YajS9Y+LVWZNfdejlXKJ
 0T+EEPnvaNqd3Y9EXzOFDEYTSdNXrCJvLOmyWTFyCvBIqsqjUf+wG4sVAq2B6L0Xt/8vZHxqbs+
 nJ/tFJFp66ZRoBRi30qGW42c0HkY4GDafdAMMvc5ZRbFNAl0jxyzHcgfiyrczAdJD7JeNMPHLN3
 eLMgRKbapfeJhlwtKCoeEzyhqd5TIY6JevWs4vlhRyidsElYkyqyllX6UJIs1Y73PdzvXZDavMp
 at2LKSQA5yz5TdUE0dNHqsRxGuHm37Tua3mPR3dXu122+iJtpa9oWcYwi86iy30dOC2b5HaDh/J
 dlmcfAR+1MbcnIby4Yj9NPA4+LIHxPMjOKY7A8WeMpVNhsMwMRB0bsfrpPIfiAqrjYtFiS1MduF
 WAZn2MwsY34gWL/SYBUf+9u58Btf2kAmEVJuBX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/symlink02: Convert to new API
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

The original test didn't produce any output results.
Use tst_macro to enable test to produce output results.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/symlink/symlink02.c | 218 ++----------------
 1 file changed, 25 insertions(+), 193 deletions(-)

diff --git a/testcases/kernel/syscalls/symlink/symlink02.c b/testcases/kernel/syscalls/symlink/symlink02.c
index c18db2b37..c152bb2b7 100644
--- a/testcases/kernel/syscalls/symlink/symlink02.c
+++ b/testcases/kernel/syscalls/symlink/symlink02.c
@@ -1,208 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: William Roske
  */
-/* $Id: symlink02.c,v 1.6 2009/08/28 14:17:14 vapier Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: symlink02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for symlink(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 03/30/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) symlink(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the symlink(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	symlink(2).
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of the symlink() system call.
+ */
 
-char *TCID = "symlink02";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-char fname[255], symlnk[255];
-int fd;
+static char *fname, *symlnk;
 
-int main(int ac, char **av)
+static void verify_symlink(void)
 {
-	int lc;
-
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
-	tst_parse_opts(ac, av, NULL, NULL);
-
-    /***************************************************************
-     * perform global setup for test
-     ***************************************************************/
-	setup();
-
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call symlink(2)
-		 */
-		TEST(symlink(fname, symlnk));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "symlink(%s, %s) Failed, errno=%d : %s",
-				 fname, symlnk, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		} else {
-			SAFE_UNLINK(cleanup, symlnk);
-		}
-	}
-
-    /***************************************************************
-     * cleanup and exit
-     ***************************************************************/
-	cleanup();
-	tst_exit();
+	TST_EXP_POSITIVE(symlink(fname, symlnk), "symlink(%s, %s)",
+			 fname, symlnk);
 
+	if (TST_RET == -1)
+		tst_res(TFAIL, "symlink(%s, %s) Failed", fname, symlnk);
+	else
+		SAFE_UNLINK(symlnk);
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void setup(void)
 {
+	fname = tst_aprintf("tfile_%d", getpid());
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-
-	if (close(fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-	sprintf(symlnk, "st_%d", getpid());
+	symlnk = tst_aprintf("st_%d", getpid());
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = verify_symlink,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
