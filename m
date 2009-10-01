Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chandru@in.ibm.com>) id 1MtGkY-00027g-QM
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 08:10:54 +0000
Received: from e28smtp06.in.ibm.com ([59.145.155.6])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MtGkS-00036z-CR
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 08:10:54 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id n918AZYk026949
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 13:40:35 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n918AZw52723974
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 13:40:35 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n918AYe5032365
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 18:10:35 +1000
From: Chandru <chandru@in.ibm.com>
Date: Thu, 1 Oct 2009 13:40:31 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200910011340.32046.chandru@in.ibm.com>
Subject: [LTP] [PATCH V2] ppoll01: add signal() syscall to register the
	signal handler
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
To: ltp-list@lists.sourceforge.net
Cc: vapier@gentoo.org

The ppoll01 testcase has a signal handler in it but this signal handler is not registered with the kernel through the signal() syscall. The testcase fails when it sends a SIGINT to itself as part of one of the case of the test run.
The following patch
1. Adds a signal() syscall to register the signal handler
2. Corrects the expected 'revents' for the case where ppoll() is called on a file which is only opened in read/write mode, i.e case00.

Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/ppoll/ppoll01.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- testcases/kernel/syscalls/ppoll/ppoll01.c.orig	2009-09-29 21:28:55.510487735 +0530
+++ testcases/kernel/syscalls/ppoll/ppoll01.c	2009-10-01 18:27:30.452236128 +0530
@@ -79,6 +79,8 @@ char *TCID = "ppoll01";  /* Test program
 int  testno;
 int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
 
+void sighandler(int sig);       /* signals handler function for the test */
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -125,7 +127,8 @@ extern void cleanup() {
 /*                                                                            */
 /******************************************************************************/
 void setup() {
-        /* Capture signals if any */
+        /* Capture signals */
+	signal(SIGINT, &sighandler);
         /* Create temporary directories */
         TEST_PAUSE;
         tst_tmpdir();
@@ -191,7 +194,7 @@ struct test_case {
 static struct test_case tcase[] = {
 	{ // case00
                 .ttype          = NORMAL,
-                .expect_revents = POLLOUT,
+                .expect_revents = POLLOUT | POLLIN,
                 .ret            = 0,
                 .err            = 0,
         },

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
