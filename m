Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFE0C04A6A
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 10:00:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A78D53CB2E7
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:59:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DED93C1812
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:59:47 +0200 (CEST)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5FEE3140111D
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:59:45 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="125162222"
X-IronPort-AV: E=Sophos;i="6.01,216,1684767600"; d="scan'208";a="125162222"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2023 18:59:44 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 381C8DE628
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 18:59:42 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 58CA0D9464
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 18:59:41 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A1BD86F10;
 Wed, 19 Jul 2023 18:59:40 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 17:59:14 +0800
Message-Id: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27760.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27760.006
X-TMASE-Result: 10--20.984900-10.000000
X-TMASE-MatchedRID: GyhbhdD5alShhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkM+a
 lSM7Pep8j/bvtfhhXEtvp+b/wK4TT0m99yxxlnCoypiC33/79mcL//VMxXlyE8VlCE9ePslpEbx
 xHhRXg6L96UokutaAnH/2kt2fPfl2yerVBy1azTPZJrfdkZdZ1qj9/FPNtMXwGxcaNtdfmf0l/m
 i29q85l/29Pl68xfi0RNiIxTeXWS+InHjrjZy8lisIuzCLc2mNNmpKEeax85mEIBA870lREt93W
 9FvgC9taz4PPTQqgvYT37J0rHCBEfhR9YlfgTUK194/5X9VfCxGmC2qcPUEPktYyuL5CqaxTbIv
 25NGrv3RNGhNaHf3SGPKQgbIX4yu+/CYwUsia6FFrcjXqV+YAD92Og3IOZltMGqHura0AtGzhHc
 t+GcMBG5/m6vlvI+luGvA9nymq1lDQYe+1GQPNb0dPFETpBAHZgUJ0qWuzGc8zUakDfUiKxFEt9
 7pQ+C82oaNzETwSs5dllc1XXqB23JjEpTLCKd7hdD+G7U5X/TvFrxMChrhqehMlzQE/9cKo8WMk
 QWv6iVfx6Zf83Do5eTCMddcL/gjkGUtrowrXLg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] syscalls/setgroups01: Convert to new API
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
 testcases/kernel/syscalls/setgroups/setgroups01.c | 212 +++-------------------
 1 file changed, 26 insertions(+), 186 deletions(-)

diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
index fed7f8e..0cb04b0 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups01.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
@@ -1,202 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
  *
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
+ * Author: William Roske
+ * CO-PILOT: Dave Fenner
  */
-/* $Id: setgroups01.c,v 1.7 2009/11/02 13:57:18 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: setgroups01
- *
- *    EXECUTED BY	: root
- *
- *    TEST TITLE	: Basic test for setgroups(2)
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
- * 	1.) setgroups(2) returns...(See Description)
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
- *	This is a Phase I test for the setgroups(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	setgroups(2).
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
 
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/param.h>
-#include <unistd.h>
-#include <grp.h>
-
-#include "test.h"
-
-#include "compat_16.h"
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of the setgroups() system call.
+ */
 
-void setup();
-void cleanup();
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(setgroups01);
-int TST_TOTAL = 1;
+static int len = NGROUPS, ngrps;
 
-int len = NGROUPS, ngrps = 0;
-GID_T list[NGROUPS];
+static GID_T list[NGROUPS];
 
-int main(int ac, char **av)
+static void verify_setgroups(void)
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
-		 * Call setgroups(2)
-		 */
-		TEST(SETGROUPS(cleanup, ngrps, list));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setgroups(%d, list) Failed, errno=%d : %s",
-				 len, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setgroups(%d, list) returned %ld",
-				 len, TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_POSITIVE(SETGROUPS(ngrps, list),
+			 "setgroups(%d, list)", len);
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void setup(void)
 {
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	ngrps = GETGROUPS(cleanup, len, list);
-	if (ngrps == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "getgroups(%d, list) Failure. errno=%d : %s",
-			 len, errno, strerror(errno));
+	if (GETGROUPS(len, list) < 0) {
+		tst_brk(TBROK,
+			"getgroups(%d, list) Failure. errno=%d : %s",
+			len, errno, strerror(errno));
 	}
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = verify_setgroups,
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
