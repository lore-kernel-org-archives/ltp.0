Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517EEC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 03:41:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8A803CA502
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 05:41:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 122993C9E2C
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 05:40:53 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A308910006B2
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 05:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1651030851; i=@fujitsu.com;
 bh=a0NSFKWlk7yH1uGi5VqI+lPTrSITBHX60Pzei6vEzvU=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ycEI4doMjh5hpuWpQIPasgVUT3lKgOTExBPZV7Mwc88ywmdsIbxtqL5AW6nCdwrjk
 vP3Oen28b4gwKMHjIwYcJ+NZAbWxwfe4+JCdY1v0gN8GWQvdJDCHFQxdT6mhPpdWgF
 KMDbdrsCSTrI1RnL1XTc2mC8WzWGY6lJWE5QtDHV/ddaWMNnLEFCobQ6xVc3zPsv21
 NrbhRSfXidNq05qEydcfTxqPFGdU3l8uM0irNj9rRpjGzq2Sk2kBMDrisZrSEbeHzv
 gaRkGJOZ7K6GHKwMkRa66h4Y5mGpNU16VqzT8aoQVIKtdXsC9rNK1G0upAjCBeP0rA
 1GjshuLWNFfpw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRWlGSWpSXmKPExsViZ8MRouu0OyP
 JoPOArMWK7zsYHRg99v1exxrAGMWamZeUX5HAmrFtygumgla9ijUnb7I1MP5S6WLk5BASaGGS
 +L1TqIuRC8jewyixcW4nG0iCTUBT4lnnAmYQW0RAQqKj4S07iM0s4Cex7+5VsLiwgLnE96cPw
 OIsAqoSKx9OBbI5OHgFPCW2n1AFCUsIKEhMefgerJxXQFDi5MwnLBBjJCQOvnjBDFGjKHGp4x
 sjhF0hMWtWG9MERt5ZSFpmIWlZwMi0itEqqSgzPaMkNzEzR9fQwEDX0NBU11DXyNBcL7FKN1E
 vtVS3PLW4RNdQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMMBSihlv7mBs7fupd4hRkoNJSZQ3eWpG
 khBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3o6dQDnBotT01Iq0zBxgsMOkJTh4lER4J4OkeYsLE
 nOLM9MhUqcYFaXEeX+uAUoIgCQySvPg2mARdolRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO
 8mkPE8mXklcNNfAS1mAlr8qTYVZHFJIkJKqoHJ4NjPu8f+rZl1c9+GT9Yn043E7MQVqh7Y5wt
 XTmBSXLt/8dH8KRkbIm2z/oYpf0w53sPwxaiCd26Yq/+Nyr9FSStMa8V2uxSnTi/knT53z6E9
 7++xtDmuTf0QeIFD/hzX/pQ5c0rk/vFemTdRUbb/5v1pDt9eJi0/nKtnO+fVpXeXTzhkbn794
 SHbZL03dxaeUzU/vLRrt4NB3I2zX/jcPXKWPPc3y24Jvm+yV2xr+bNHwatSbuY9+PG3aEmabG
 mhReiKwO46772Meg8e9vIe1p2ocGf5QkbWHczlU84o7rm4hO3Nsw/sc02TT8cqx/H4Mb97L9V
 spjR36pVL0x8GHfJRat8mfsH408ZNFWtFnJVYijMSDbWYi4oTAcCeY64rAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-591.messagelabs.com!1651030850!58944!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18221 invoked from network); 27 Apr 2022 03:40:50 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-6.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Apr 2022 03:40:50 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23R3egrN000320
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 04:40:50 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 27 Apr 2022 04:40:40 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Apr 2022 12:42:04 +0800
Message-ID: <1651034524-18799-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fcntl05: Convert into new api
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
 testcases/kernel/syscalls/fcntl/fcntl05.c | 186 ++++------------------
 1 file changed, 34 insertions(+), 152 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl05.c b/testcases/kernel/syscalls/fcntl/fcntl05.c
index fb4a0f9a8..33602d76f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl05.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl05.c
@@ -1,25 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
+ * Copyright (c) 2000 Silicon Graphics, Inc. All Rights Reserved.
  * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
  * Mountain View, CA  94043, or:
  *
@@ -29,158 +10,59 @@
  *
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  *
+ * AUTHOR            : William Roske
+ * CO-PILOT          : Dave Fenner
  */
-/* $Id: fcntl05.c,v 1.8 2009/11/02 13:57:16 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: fcntl05
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for fcntl(2) using F_GETLK argument.
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
- *	1.) fcntl(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- *	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *
- *    DURATION
- *	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- *	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- *	None
- *
- *    INTERCASE DEPENDENCIES
- *	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the fcntl(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	fcntl(2).
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
+
+/*\
+ * [Description]
  *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+ * Basic test for fcntl(2) using F_GETLK argument.
+ */
 
+#include <stdio.h>
 #include <sys/types.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "fcntl05";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-char fname[255];
-int fd;
+static int fd = -1;
 struct flock flocks;
 
-int main(int ac, char **av)
+static void verify_fcntl(void)
 {
-	int lc;
+	/* F_GETLK will change flock.l_type to F_UNLCK, so need to reset */
+	flocks.l_type = F_RDLCK;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		flocks.l_type = F_RDLCK;
-		TEST(fcntl(fd, F_GETLK, &flocks));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "fcntl failed");
-		else {
-			tst_resm(TPASS, "fcntl returned %ld",
-				 TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(fcntl(fd, F_GETLK, &flocks), "fcntl(%d, F_GETLK, &flocks)", fd);
 }
 
-void setup(void)
+static void setup(void)
 {
+	char fname[255];
+	int pid;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	pid = getpid();
 
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	sprintf(fname, "testfile_%d", pid);
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 
-	/* set needed flags in the flocks structure */
-	flocks.l_whence = 1;
+	flocks.l_whence = SEEK_CUR;
 	flocks.l_start = 0;
 	flocks.l_len = 0;
-	flocks.l_pid = getpid();
+	flocks.l_pid = pid;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
-
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = verify_fcntl,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
