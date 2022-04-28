Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04A5C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 01:51:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92F373CA6DE
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 03:51:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B54A23C9482
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 03:51:41 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6D4E1401132
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 03:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1651110699; i=@fujitsu.com;
 bh=/DJIG7nywre38z9lOWEOFi9XPSL9YKB8NDuj2DuSkhE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=AkLexrYrov0Sqg6uHTe25Y/siLSe5e5NddUY43ft50/WHUedTpT9lTrZDmKAGQCOd
 S7pSrgbSLdJhcO3N5pg4z9VzjUFkMGiRgOo3OHdLKgAGkfFZ5pLChkZ+j3gFX52/GC
 IXodu8VjG/rshPUpEsoJkkML4quYO482RUYlb7Wl4rgWGh14UHZg1QE+HjC6n7ValB
 PScpcXw28gvOfsdRzEtdGKgHZAJR/wXWvWb63vbPo2+1TFI0jbYWN5/3ZkP2o8KZQA
 IN9dbGSy0e337C7ys9c00a1CsTJtQvmzSkYQL8UMz4H3Xw5PopS5DX6yO1HwdvP5ik
 fovAFAe2p30bA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8MxSVfrc2a
 SwbLFqhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bmXysZC64aVHyf95qtgXGuehcjF4eQwFlG
 iUV3GpggnJ1MEv8+zGPtYuQEcvYwSlztiwKx2QQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9Y
 gKxhQWsJFafmQtWwyKgKjH3YysLiM0r4CHxa/4dsLiEgILElIfvwWxOARWJe+0NbBC7lCUmtL
 1ngqgXlDg58wkLxHwJiYMvXkD1Kkpc6vjGCGFXSMya1cYEYatJXD23iXkCo+AsJO2zkLQvYGR
 axWidVJSZnlGSm5iZo2toYKBraGiqa2yqa2hhopdYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZ
 m5yTopeXWrKJERjGKcXKO3Ywtq36qXeIUZKDSUmUN78+M0mILyk/pTIjsTgjvqg0J7X4EKMMB
 4eSBO+Jj0A5waLU9NSKtMwcYEzBpCU4eJREeEs+AKV5iwsSc4sz0yFSpxgVpcR5l4P0CYAkMk
 rz4NpgcXyJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDvz6dAU3gy80rgpr8CWswEtHhlEdj
 ikkSElFQD0/RAb4naSZw8wltefVqUxxNg7cJ/feEHMfbSHrmo5XLZ4lqsN/Z/21Sz+fefq4xL
 tJtMo1zbje6rWIYeUvxwdv9xj1y7N3emzJcNlhCZs+O81IEvT3wCLk8omZIjOzndLXl9y0RHK
 e3leX0t+ddM9ySeO+frvpFLVKrb4c/rSR9uX/2UEc71jHG1oNJeM89fhj4KM0/qLDE7wm+6Vj
 zNo2zGo/yrfXlXRJb8v6y2U7vkhHRj5/SV+1Lfm2r8uvFO0Wry72tvZgSKln+31IvaGdLINd2
 19qlY/eHG7ULRd1ouFm/vOS1mP+3XmoedUcE6p7oX+l59u9mS/5Pfp0rzO3kTzuSL8bk2sTOw
 T3mgq8RSnJFoqMVcVJwIAPMZgxZeAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1651110698!22015!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32030 invoked from network); 28 Apr 2022 01:51:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 28 Apr 2022 01:51:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 3A52210032A
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 02:51:38 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 2DECF1000FB
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 02:51:38 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 28 Apr 2022 02:51:19 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 28 Apr 2022 10:51:52 +0800
Message-ID: <1651114312-2143-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YmlVv3QSmAmIIwA/@yuki>
References: <YmlVv3QSmAmIIwA/@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/fcntl05: Convert into new api
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/fcntl/fcntl05.c | 196 +++++-----------------
 1 file changed, 41 insertions(+), 155 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl05.c b/testcases/kernel/syscalls/fcntl/fcntl05.c
index fb4a0f9a8..b2f9e2caa 100644
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
@@ -29,158 +10,63 @@
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
+
+/*\
+ * [Description]
  *
+ * Basic test for fcntl(2) using F_GETLK argument.
  *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+ * If the lock could be placed, fcntl() does not actually place it, but
+ * returns F_UNLCK in the l_type field of lock  and leaves the other field
+ * of the structure unchanged.
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
-struct flock flocks;
+static int fd = -1, pid;
+static struct flock flocks;
 
-int main(int ac, char **av)
+static void verify_fcntl(void)
 {
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
+	/* F_GETLK will change flock.l_type to F_UNLCK, so need to reset */
+	flocks.l_type = F_RDLCK;
+
+	TST_EXP_PASS(fcntl(fd, F_GETLK, &flocks), "fcntl(%d, F_GETLK, &flocks)", fd);
+	TST_EXP_EQ_LI(flocks.l_type, F_UNLCK);
+	TST_EXP_EQ_LI(flocks.l_whence, SEEK_CUR);
+	TST_EXP_EQ_LI(flocks.l_start, 0);
+	TST_EXP_EQ_LI(flocks.l_len, 0);
+	TST_EXP_EQ_LI(flocks.l_pid, pid);
 }
 
-void setup(void)
+static void setup(void)
 {
+	pid = getpid();
+	fd = SAFE_OPEN("filename", O_RDWR | O_CREAT, 0700);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
-
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
