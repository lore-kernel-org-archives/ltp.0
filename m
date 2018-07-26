From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 26 Jul 2018 13:32:47 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/alarm03: Rewrite to new library
In-Reply-To: <1532583167-8455-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <20180725134828.GB23890@rei>
 <1532583167-8455-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1532583167-8455-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/alarm/alarm03.c | 220 ++++++------------------------
 1 file changed, 43 insertions(+), 177 deletions(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm03.c b/testcases/kernel/syscalls/alarm/alarm03.c
index 60141f1..6e4e66a 100644
--- a/testcases/kernel/syscalls/alarm/alarm03.c
+++ b/testcases/kernel/syscalls/alarm/alarm03.c
@@ -1,193 +1,59 @@
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
+ * Author: Richard Logan
+ *
+ * Test Description:
+ *  The process does a fork:
+ *	1) By the value returned by child's alarm(0), check whether child
+ *	   process cleared the previously specified alarm request or not.
+ *	2) By the value returned by parent's alarm(0), check whether parent
+ *	   process cleared the previously specified alarm request or not.
  */
-/* $Id: alarm03.c,v 1.10 2009/08/28 10:57:29 vapier Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: alarm03
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: alarm(2) cleared by a fork
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: Dennis Arason
- *
- *    DATE STARTED	: 08/96
- *
- *
- *    TEST CASES
- *
- * 	1.) alarm(100), fork, child's alarm(0) shall return 0;
- *	2.) alarm(100), fork, parent's alarm(0) shall return non-zero.
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the alarm(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	alarm(2).
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
 
 #include <errno.h>
-#include <string.h>
 #include <signal.h>
 #include <stdlib.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <unistd.h>
 
-void setup();
-void cleanup();
-void trapper();
+#include "tst_test.h"
 
-char *TCID = "alarm03";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_alarm(void)
 {
-	int lc;
-	int status, retval = 0;
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
-		 * Call alarm(2)
-		 */
-		TEST(alarm(100));
-
-		switch (FORK_OR_VFORK()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-			break;
-
-		case 0:
-			TEST(alarm(0));
-
-			if (TEST_RETURN != 0) {
-				retval = 1;
-				printf("%d: alarm(100), fork, alarm(0) child's "
-				       "alarm returned %ld\n",
-				       getpid(), TEST_RETURN);
-			} else {
-				printf("%d: alarm(100), fork, alarm(0) child's "
-				       "alarm returned %ld\n",
-				       getpid(), TEST_RETURN);
-			}
-
-			exit(retval);
-			break;
-
-		default:
-			tst_count++;
-			TEST(alarm(0));
-/* The timer may be rounded up to the next nearest second, this is OK */
-			if (TEST_RETURN <= 0 || TEST_RETURN > 101) {
-				retval = 1;
-				tst_resm(TFAIL,
-					 "alarm(100), fork, alarm(0) parent's alarm returned %ld",
-					 TEST_RETURN);
-			} else {
-				tst_resm(TPASS,
-					 "alarm(100), fork, alarm(0) parent's alarm returned %ld",
-					 TEST_RETURN);
-			}
-			SAFE_WAIT(cleanup, &status);
-			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_resm(TFAIL, "see failures reported above");
-
+	pid_t pid;
+
+	TEST(alarm(100));
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		TEST(alarm(0));
+		if (TEST_RETURN != 0) {
+			tst_res(TFAIL,
+				"alarm(100), fork, alarm(0) child's "
+				"alarm returned %ld", TEST_RETURN);
+		} else {
+			tst_res(TPASS,
+				"alarm(100), fork, alarm(0) child's "
+				"alarm returned %ld", TEST_RETURN);
 		}
-
+		exit(0);
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	signal(SIGALRM, trapper);
+	TEST(alarm(0));
+	if (TEST_RETURN != 100) {
+		tst_res(TFAIL,
+			"alarm(100), fork, alarm(0) parent's "
+			"alarm returned %ld", TEST_RETURN);
+	} else {
+		tst_res(TPASS,
+			"alarm(100), fork, alarm(0) parent's "
+			"alarm returned %ld", TEST_RETURN);
+	}
 
-	TEST_PAUSE;
+	tst_reap_children();
 }
 
-void cleanup(void)
-{
-}
-
-void trapper(int sig)
-{
-	signal(SIGALRM, trapper);
-}
+static struct tst_test test = {
+	.test_all = verify_alarm,
+	.forks_child = 1,
+};
-- 
1.8.3.1



