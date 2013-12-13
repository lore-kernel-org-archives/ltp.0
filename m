Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VrRLU-0006fc-IO
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 11:55:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VrRLS-00055F-6H
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 11:55:52 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBDBteiD012511
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Dec 2013 19:55:41 +0800
Message-ID: <1386935735.1665.1.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 13 Dec 2013 19:55:35 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/2] getpeername/getpeername01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Add "safe_macros.h" and use SAFE_XXX().
* Some cleanup.

Signed-off-by: Zuo Faqi <zuofq.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/getpeername/getpeername01.c    | 236 +++++++++------------
 1 file changed, 99 insertions(+), 137 deletions(-)

diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c b/testcases/kernel/syscalls/getpeername/getpeername01.c
index a30cd08..7aa72cb 100644
--- a/testcases/kernel/syscalls/getpeername/getpeername01.c
+++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   07/2001 Ported by Wayne Boyer
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,214 +14,175 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * Test Name: getpeername01
- *
- * Test Description:
  *  Verify that getpeername() returns the proper errno for various failure cases
- *
- * Usage:  <for command-line>
- *  getpeername01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
- *
  */
 
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
-
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/signal.h>
 #include <sys/ioctl.h>
-
 #include <netinet/in.h>
 
 #include "test.h"
 #include "usctest.h"
-
-char *TCID = "getpeername01";
-int testno;
-
-int s, s2;			/* socket descriptors */
-struct sockaddr_in sin0, fsin1;
-socklen_t sinlen;
-
-void setup(void), setup0(void), setup1(void), setup2(void),
-cleanup(void), cleanup0(void), cleanup1(void), cleanup2(void);
-
-struct test_case_t {		/* test case structure */
-	int domain;		/* PF_INET, PF_UNIX, ... */
-	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
-	int proto;		/* protocol number (usually 0 = default) */
-	struct sockaddr *sockaddr;	/* socket address buffer */
-	socklen_t *salen;	/* getpeername's 3rd argument */
-	int retval;		/* syscall return value */
-	int experrno;		/* expected errno */
-	void (*setup) (void);
-	void (*cleanup) (void);
-	char *desc;
-} tdat[] = {
-	{
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, EBADF, setup0, cleanup0,
-		    "bad file descriptor"}, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, ENOTSOCK, setup0, cleanup0,
-		    "bad file descriptor"}, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    &sinlen, -1, ENOTCONN, setup1, cleanup1, "invalid salen"},
+#include "safe_macros.h"
+
+static struct sockaddr_in server_addr;
+static struct sockaddr_in fsin1;
+static socklen_t sinlen;
+static int sv[2];
+
+static void setup(void);
+static void setup2(int);
+static void setup3(int);
+static void setup4(int);
+static void cleanup(void);
+static void cleanup2(int);
+static void cleanup4(int);
+
+struct test_case_t {
+	int sockfd;
+	struct sockaddr *sockaddr;
+	socklen_t *addrlen;
+	int expretval;
+	int experrno;
+	void (*setup) (int);
+	void (*cleanup) (int);
+	char *name;
+} test_cases[] = {
+	{-1, (struct sockaddr *)&fsin1, &sinlen, -1, EBADF, NULL, NULL,
+	 "EBADF"},
+	{-1, (struct sockaddr *)&fsin1, &sinlen, -1, ENOTSOCK, setup2, cleanup2,
+	 "ENOTSOCK"},
+	{-1, (struct sockaddr *)&fsin1, &sinlen, -1, ENOTCONN, setup3, cleanup2,
+	 "ENOTCONN"},
 #ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	{
-	PF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)0,
-		    &sinlen, -1, EFAULT, setup2, cleanup1,
-		    "invalid socket buffer"}, {
-	PF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    (socklen_t *) 0, -1, EFAULT, setup2, cleanup1,
-		    "invalid aligned salen"}, {
-	PF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
-		    (socklen_t *) 1, -1, EFAULT, setup2, cleanup1,
-		    "invalid unaligned salen"},
+	{-1, (struct sockaddr *)-1, &sinlen, -1, EFAULT, setup4, cleanup4,
+	 "EFAULT"},
+	{-1, (struct sockaddr *)&fsin1, (socklen_t *)0, -1, EFAULT, setup4,
+	 cleanup4, "EFAULT"},
+	{-1, (struct sockaddr *)&fsin1, (socklen_t *)1, -1, EFAULT, setup4,
+	 cleanup4, "EFAULT"},
 #endif
 };
 
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int exp_enos[] = { EBADF, ENOTSOCK, ENOTCONN, EFAULT, 0 };
+char *TCID = "getpeername01";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EBADF, ENOTSOCK, ENOTCONN, EFAULT, 0 };
 
 int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;
+	int i;
 
 	msg = parse_opts(argc, argv, NULL, NULL);
-	if (msg != NULL) {
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
 
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+
 		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
 
-			TEST(getpeername(s, tdat[testno].sockaddr,
-					 tdat[testno].salen));
-			if (TEST_RETURN > 0) {
-				TEST_RETURN = 0;
-			} else {
-				TEST_ERROR_LOG(TEST_ERRNO);
-			}
-			if (TEST_RETURN != tdat[testno].retval ||
-			    (TEST_RETURN < 0 &&
-			     TEST_ERRNO != tdat[testno].experrno)) {
-				tst_resm(TFAIL, "%s ; returned"
-					 " %ld (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc,
-					 TEST_RETURN, tdat[testno].retval,
-					 TEST_ERRNO, tdat[testno].experrno);
+		for (i = 0; i < TST_TOTAL; ++i) {
+
+			if (test_cases[i].setup != NULL)
+				test_cases[i].setup(i);
+
+			TEST(getpeername(test_cases[i].sockfd,
+					 test_cases[i].sockaddr,
+					 test_cases[i].addrlen));
+
+			TEST_ERROR_LOG(TEST_ERRNO);
+
+			if (TEST_RETURN == test_cases[i].expretval &&
+			    TEST_ERRNO == test_cases[i].experrno) {
+				tst_resm(TPASS,
+					 "test getpeername() %s successful",
+					 test_cases[i].name);
 			} else {
-				tst_resm(TPASS, "%s successful",
-					 tdat[testno].desc);
+				tst_resm(TFAIL,
+					 "test getpeername() %s failed; "
+					 "returned %ld (expected %d), errno %d "
+					 "(expected %d)", test_cases[i].name,
+					 TEST_RETURN, test_cases[i].expretval,
+					 TEST_ERRNO, test_cases[i].experrno);
 			}
-			tdat[testno].cleanup();
+
+			if (test_cases[i].cleanup != NULL)
+				test_cases[i].cleanup(i);
 		}
 	}
+
 	cleanup();
 
 	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
 	TEST_PAUSE;
 
-	/* initialize local sockaddr */
-	sin0.sin_family = AF_INET;
-	sin0.sin_port = 0;
-	sin0.sin_addr.s_addr = INADDR_ANY;
-}
-
-void cleanup(void)
-{
-	TEST_CLEANUP;
+	server_addr.sin_family = AF_INET;
+	server_addr.sin_port = 0;
+	server_addr.sin_addr.s_addr = INADDR_ANY;
 
+	sinlen = sizeof(fsin1);
 }
 
-void setup0(void)
+static void cleanup(void)
 {
-	if (tdat[testno].experrno == EBADF)
-		s = 400;	/* anything not an open file */
-	else if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
-
+	TEST_CLEANUP;
 }
 
-void cleanup0(void)
+static void setup2(int i)
 {
-	s = -1;
+	test_cases[i].sockfd = SAFE_OPEN(cleanup, "/dev/null", O_WRONLY, 0666);
 }
 
-void setup1(void)
+static void setup3(int i)
 {
-	s = socket(tdat[testno].domain, tdat[testno].type, tdat[testno].proto);
-	if (s < 0) {
+	test_cases[i].sockfd = socket(PF_INET, SOCK_STREAM, 0);
+	if (test_cases[i].sockfd < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
-			 "socket setup failed for getpeername " " test %d",
-			 testno);
+			 "socket setup failed for getpeername test %d", i);
 	}
-	if (bind(s, (struct sockaddr *)&sin0, sizeof(sin0)) < 0) {
+	if (bind(test_cases[i].sockfd, (struct sockaddr *)&server_addr,
+		 sizeof(server_addr)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup,
-			 "socket bind failed for getpeername " "test %d",
-			 testno);
+			 "socket bind failed for getpeername test %d", i);
 	}
-	sinlen = sizeof(fsin1);
 }
 
-void cleanup1(void)
+static void setup4(int i)
 {
-	(void)close(s);
-	s = -1;
+	if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "socketpair failed for getpeername test %d", i);
+	}
+	test_cases[i].sockfd = sv[0];
 }
 
-void setup2(void)
+static void cleanup2(int i)
 {
-	int sv[2];
-
-	if (socketpair(tdat[testno].domain, tdat[testno].type,
-		       tdat[testno].proto, sv) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "socketpair failed for getpeername " "test %d",
-			 testno);
-	}
-	s = sv[0];
-	s2 = sv[1];
+	SAFE_CLOSE(cleanup, test_cases[i].sockfd);
 }
 
-void cleanup2(void)
+static void cleanup4(int i)
 {
-	(void)close(s);
-	(void)close(s2);
-	s = s2 = -1;
+	SAFE_CLOSE(cleanup, sv[0]);
+	SAFE_CLOSE(cleanup, sv[1]);
 }
-- 
1.8.2.1




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
