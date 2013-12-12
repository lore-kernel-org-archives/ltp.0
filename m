Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vr2TB-0001JT-Pu
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 09:22:09 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vr2TA-00045o-MW
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 09:22:09 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBC9M1rK027981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 09:22:02 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBC9M1t2000943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 09:22:01 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBC9M02I024295
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 09:22:00 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 12 Dec 2013 13:21:54 +0400
Message-Id: <1386840115-9703-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V3 1/2] setpgid03: handle children errors and cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

If one of the children exits with non zero value we can't see
it until DEBUG is set. Now if the exit value is not 0, we
print this value with tst_resm(TFAIL).

Also performed minor cleanup.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setpgid/setpgid03.c |  160 +++++++++----------------
 1 files changed, 58 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 4429fe4..2c47bc4 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -1,38 +1,25 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- * 	setpgid03.c
- *
- * DESCRIPTION
- * 	Test to check the error and trivial conditions in setpgid system call
- *
- * USAGE
- * 	setuid03
- *
- * RESTRICTIONS
- * 	This test is not completely written in the LTP format - PLEASE FIX!
+ * Test to check the error and trivial conditions in setpgid system call
  */
 
-#define DEBUG 0
-
 #include <wait.h>
 #include <limits.h>
 #include <signal.h>
@@ -47,16 +34,15 @@
 char *TCID = "setpgid03";
 int TST_TOTAL = 1;
 
-void do_child(void);
-void setup(void);
-void cleanup(void);
+static void do_child(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
 	int pid;
-	int rval, fail = 0;
-	int ret, status;
-	int exno = 0;
+	int rval;
+	int status;
 
 	int lc;
 	char *msg;
@@ -68,14 +54,10 @@ int main(int ac, char **av)
 	maybe_run_child(&do_child, "");
 #endif
 
-	/*
-	 * perform global setup for the test
-	 */
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 //test1:
@@ -92,35 +74,27 @@ int main(int ac, char **av)
 #else
 			do_child();
 #endif
-		} else {	/* parent */
-			sleep(1);
-			rval = setpgid(pid, getppid());
-			if (errno == EPERM) {
-				tst_resm(TPASS, "setpgid SUCCESS to set "
-					 "errno to EPERM");
-			} else {
-				tst_resm(TFAIL, "setpgid FAILED, "
-					 "expect %d, return %d", EPERM, errno);
-				fail = 1;
-			}
-			sleep(1);
-			if ((ret = wait(&status)) > 0) {
-				if (DEBUG)
-					tst_resm(TINFO, "Test {%d} exited "
-						 "status 0x%0x", ret, status);
-
-				if (status != 0) {
-					fail = 1;
-				}
-			}
 		}
-		if (DEBUG) {
-			if (fail || exno) {
-				tst_resm(TINFO, "Test test 1: FAILED");
-			} else {
-				tst_resm(TINFO, "Test test 1: PASSED");
-			}
+
+		sleep(1);
+		rval = setpgid(pid, getppid());
+		if (errno == EPERM) {
+			tst_resm(TPASS,
+				"setpgid SUCCESS to set errno to EPERM");
+		} else {
+			tst_resm(TFAIL,
+				"setpgid FAILED, expect %d, return %d",
+				EPERM, errno);
 		}
+		sleep(1);
+
+		if (wait(&status) < 0)
+			tst_resm(TFAIL | TERRNO, "wait() for child 1 failed");
+
+		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
+			tst_resm(TFAIL, "child 1 failed with status %d",
+				WEXITSTATUS(status));
+
 //test2:
 		/*
 		 * Value of pid matches the pid of the child process and
@@ -135,51 +109,43 @@ int main(int ac, char **av)
 				perror("exec failed");
 			}
 			exit(127);
+		}
+
+		sleep(1);
+		rval = setpgid(pid, getppid());
+		if (errno == EACCES) {
+			tst_resm(TPASS,
+				"setpgid SUCCEEDED to set errno to EACCES");
 		} else {
-			sleep(1);
-			rval = setpgid(pid, getppid());
-			if (errno == EACCES) {
-				tst_resm(TPASS, "setpgid SUCCEEDED to set "
-					 "errno to EACCES");
-			} else {
-				tst_resm(TFAIL, "setpgid FAILED, expect EACCES "
-					 "got %d", errno);
-			}
-			if ((ret = wait(&status)) > 0) {
-				if (DEBUG)
-					tst_resm(TINFO, "Test {%d} exited "
-						 "status 0x%0x", ret, status);
-				if (status != 0) {
-					fail = 1;
-				}
-			}
+			tst_resm(TFAIL,
+				"setpgid FAILED, expect EACCES got %d", errno);
 		}
+
+		if (wait(&status) < 0)
+			tst_resm(TFAIL | TERRNO, "wait() for child 2 failed");
+
+		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
+			tst_resm(TFAIL, "child 2 failed with status %d",
+				WEXITSTATUS(status));
 	}
+
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * do_child()
- */
-void do_child()
+static void do_child(void)
 {
 	int exno = 0;
 
 	if (setsid() < 0) {
-		tst_resm(TFAIL, "setsid failed, errno :%d", errno);
+		printf("setsid() failed, errno: %d\n", errno);
 		exno = 1;
 	}
 	sleep(2);
 	exit(exno);
 }
 
-/*
- * setup()
- * 	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
@@ -189,17 +155,7 @@ void setup(void)
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- * 	performs all the ONE TIME cleanup for this test at completion
- * 	or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing status if that option was specified
-	 * print errno log if that option was specified
-	 */
 	TEST_CLEANUP;
-
 }
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
