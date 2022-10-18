Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47674C433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 09:44:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A40433CB06A
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 11:44:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE4BA3C7319
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 11:43:50 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6BA0F1400BDE
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 11:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1666086228; i=@fujitsu.com;
 bh=Ly36ep19IWTobVhYWuCtokCkOYpZ5ejhSTi+V/n5jOA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=a9uAZls5XfrCtnxxfxNjB+DJGGi+xCif1ANpdAp80emO1DQ59ZW0wWQR74Xlk/hmP
 5R3BkQ5CkHHoopfZD0vWS181QZ0gCut7x85QODaq1Id91+TqP0PnP1EhlOxs4kx7Dk
 RaCdPcLsKF1KXBlzHT7Ypo5bTKf/inVU+CXCRem1E/+C0BNaMcd5w9fC0gRI/whZOp
 DbvfmjZXCmOYp7lU3Z7mexRrOcA9tbNWa107NceZmMmHi5JMPTp48MI3X+TB96M22Y
 L6PFlx8eUC0pkHcjfHv6wpJzes3W95XX4WWiqHa8vH34nxNjBWBpzJiXg7EaQv/2dT
 rDCA+SVlUAK9w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRWlGSWpSXmKPExsViZ8OxWTe41C/
 ZYGKPvsWK7zsYHRg99v1exxrAGMWamZeUX5HAmnH60VHmghk2Fet+NzA2ML7R62Lk4hASOMUo
 cXTjMiYIZy+TxPLlh9i6GDmBnD2MEtubWUFsNgFNiWedC5hBbBEBCYmOhrfsIDazgIPE3on7w
 WqEBSwlPv1ZDtbLIqAqcen5N7A4r4CHRMe5uWC2hICCxJSH75kh4oISJ2c+YYGYIyFx8MULZo
 gaRYlLHd8YIewKiVmz2pggbDWJq+c2MU9g5J+FpH0WkvYFjEyrGM2KU4vKUot0DY30kooy0zN
 KchMzc/QSq3QT9VJLdctTi0t0DfUSy4v1UouL9Yorc5NzUvTyUks2MQKDMaWYPXkH4/9lf/QO
 MUpyMCmJ8kak+yUL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuDlAskJFqWmp1akZeYAIwMmLcHBo
 yTCO6UIKM1bXJCYW5yZDpE6xagoJc6bVwyUEABJZJTmwbXBovESo6yUMC8jAwODEE9BalFuZg
 mq/CtGcQ5GJWFefpApPJl5JXDTXwEtZgJanLHfC2RxSSJCSqqBSWrxmzlKvGrRrQ2/nqVOe/z
 6dPp/3prrR3x3Tm07EHn1pYHeQZ3Zlh9CN+ZY63X8XNTB1y50NqD5wVyu5BmcG6v/aBSuFX7M
 da7yfFOw9txk5d4FfbciVSo/FB1TuyKe4lv9+tqu2Fqd+9dZqy8eOL+2UVL/usmOGz+alvv+z
 LwReIyV93K45wTtRyfnHT4dpcrRfqU8sanpi+nBuuBpwlsVt5slxF1jOpFz0u2F5Drvr6tcPm
 vts9icsvdBAtv0O4wKpZ0TzjVYf9xkzuW/eOH9+oCsm5c37xF5kmbkbrw/J7dhWtVN63dvmlZ
 /a9c/vL1LNmtbbMTMyn1+ma03O1eqfornZa+s8b3y5B5vuxJLcUaioRZzUXEiALYjvLxBAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-587.messagelabs.com!1666086227!14215!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22623 invoked from network); 18 Oct 2022 09:43:47 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-6.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Oct 2022 09:43:47 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 618B1150
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:43:47 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 54794142
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:43:47 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 18 Oct 2022 10:43:45 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 18 Oct 2022 18:44:15 +0800
Message-ID: <1666089855-7282-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/fork01: Convert into new api
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

Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/fork/fork01.c | 249 +++++-------------------
 1 file changed, 46 insertions(+), 203 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork01.c b/testcases/kernel/syscalls/fork/fork01.c
index 00d7c45c4..31ec5d4c1 100644
--- a/testcases/kernel/syscalls/fork/fork01.c
+++ b/testcases/kernel/syscalls/fork/fork01.c
@@ -1,234 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Author: Kathy Olmsted
+ * Co-Pilot: Steve Shaw
+ */
+
+/*\
+ *[Description]
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
- *
- *    OS Test - Silicon Graphics, Inc.
- *    TEST IDENTIFIER	: fork01
- *    EXECUTED BY	: anyone
- *    TEST TITLE	: Basic test for fork(2)
- *    PARENT DOCUMENT	: frktds02
- *    TEST CASE TOTAL	: 2
- *    WALL CLOCK TIME	: 1
- *    CPU TYPES		: ALL
- *    AUTHOR		: Kathy Olmsted
- *    CO-PILOT		: Steve Shaw
- *    DATE STARTED	: 06/17/92
- *    INITIAL RELEASE	: UNICOS 7.0
- *    TEST CASES
- *	1.) fork returns without error
- *	2.) fork returns the pid of the child
- *    INPUT SPECIFICATIONS
- *	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *    OUTPUT SPECIFICATIONS
- *    DURATION
- *	Terminates - with frequency and infinite modes.
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *    RESOURCES
- *	None
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *    SPECIAL PROCEDURAL REQUIREMENTS
- *	None
- *    INTERCASE DEPENDENCIES
- *	None
- *    DETAILED DESCRIPTION
- *	Setup:
- *	Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	Test:
- *	 Loop if the proper options are given.
- *        fork()
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *        CHILD:
- *           determine PID
- *           write to PID to a file and close the file
- *           exit
- *        PARENT:
- *           wait for child to exit
- *           read child PID from file
- *           compare child PID to fork() return code and report
- *           results
- *
- *	  Cleanup:
- *           Print errno log and/or timing stats if options given
+ * - fork returns without error
+ * - fork returns the pid of the child
  */
 
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
-#include <fcntl.h>
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "test.h"
+#include "tst_test.h"
 
 #define	KIDEXIT	42
-static void setup();
-static void cleanup();
-
-#define LINE_SZ	20
 #define FILENAME "childpid"
 
-char *TCID = "fork01";
-int TST_TOTAL = 2;
-
-/*
- * child_pid - the child side of the test
- *             determine the PID and write to a file
- */
-static void child_pid(void)
-{
-
-	int fildes;
-	char tmp_line[LINE_SZ];
-
-	fildes = creat(FILENAME, 0700);
-	sprintf(tmp_line, "%d\n", getpid());
-	write(fildes, tmp_line, LINE_SZ);
-	close(fildes);
-
-}
+static int fd = -1;
 
-/*
- * parent_pid - the parent side of the test
- *              read the value determined by the child
- *              compare and report results
- */
-static void parent_pid(void)
+static void verify_fork(void)
 {
+	int kid_status, term_pid, child_pid, pid, ret;
 
-	int fildes;
-	char tmp_line[LINE_SZ];
-	pid_t child_id;
-
-	fildes = open(FILENAME, O_RDWR);
-	if (fildes == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "parent open failed. errno: %d (%s)\n",
-			 errno, strerror(errno));
-	} else {
-		if (read(fildes, tmp_line, LINE_SZ) == 0) {
-			tst_brkm(TBROK, cleanup,
-				 "fork(): parent failed to read PID from file errno: %d (%s)",
-				 errno, strerror(errno));
-		} else {
-			child_id = atoi(tmp_line);
-			if (TEST_RETURN != child_id) {
-				tst_resm(TFAIL,
-					 "child reported a pid of %d. parent received %ld from fork()",
-					 child_id, TEST_RETURN);
-			} else {
-				tst_resm(TPASS,
-					 "child pid and fork() return agree: %d",
-					 child_id);
-			}
-		}
-		close(fildes);
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_FILE_PRINTF(FILENAME, "%d", getpid());
+		exit(KIDEXIT);
 	}
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	int fails;
-	int kid_status, wait_status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		fails = 0;
-
-		TEST(fork());
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "fork() Failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			tst_resm(TBROK, "unable to continue");
+	term_pid = SAFE_WAITPID(pid, &kid_status, 0);
+	if (term_pid == pid) {
+		if (!WIFEXITED(kid_status)) {
+			tst_res(TFAIL, "child exited abnormally");
+			return;
 		}
-		if (TEST_RETURN == 0) {
-			/* child */
-			child_pid();
-			exit(KIDEXIT);
-		} else {
-			/* parent */
-			tst_resm(TPASS, "fork() returned %ld",
-				 TEST_RETURN);
-			/* wait for the child to complete */
-			wait_status = waitpid(TEST_RETURN, &kid_status, 0);
-
-			if (wait_status == TEST_RETURN) {
-				if (kid_status != KIDEXIT << 8) {
-					tst_resm(TBROK,
-						 "incorrect child status returned on wait(): %d",
-						 kid_status);
-					fails++;
-				}
-			} else {
-				tst_resm(TBROK,
-					 "wait() for child status failed with %d errno: %d : %s",
-					 wait_status, errno,
-					 strerror(errno));
-				fails++;
-			}
-			if (fails == 0) {
-				/* verification tests */
-				parent_pid();
-			}
-		}		/* TEST_RETURN */
+		ret = WEXITSTATUS(kid_status);
+		if (ret != KIDEXIT)
+			tst_res(TFAIL, "incorrect child status returned %d", ret);
+		else
+			tst_res(TPASS, "correct child status returned %d", ret);
+
+		SAFE_FILE_SCANF(FILENAME, "%d", &child_pid);
+		TST_EXP_EQ_LI(child_pid, pid);
+	} else {
+		tst_res(TFAIL, "waitpid() returns %d instead of expected pid %d",
+				term_pid, pid);
 	}
 
-	cleanup();
-	tst_exit();
+	tst_reap_children();
 }
 
 static void setup(void)
 {
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	fd = SAFE_CREAT(FILENAME, 0700);
+	SAFE_CLOSE(fd);
 }
 
 static void cleanup(void)
 {
-
-	tst_rmdir();
-
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.test_all = verify_fork,
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
