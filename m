Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chandru@in.ibm.com>) id 1MqiIw-0007Jh-Fq
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 06:59:50 +0000
Received: from e28smtp09.in.ibm.com ([59.145.155.9])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MqiIr-0005UP-Nc
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 06:59:50 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id n8O6rEa4012021
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Sep 2009 12:23:14 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8O6xYjJ1925282
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Sep 2009 12:29:34 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8O6xY8E031830
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Sep 2009 16:59:34 +1000
Received: from guara.localnet (guara-009124035039.in.ibm.com [9.124.35.39])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	n8O6xYxj031827
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Sep 2009 16:59:34 +1000
From: Chandru <chandru@in.ibm.com>
Date: Thu, 24 Sep 2009 12:29:32 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200909241229.32866.chandru@in.ibm.com>
Subject: [LTP] [PATCH] ppoll01: add signal() syscall to register the signal
	handler
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

The ppoll01 testcase has a signal handler in it but this signal handler is not registered with the kernel through the signal() syscal. The testcase fails when it sends a SIGINT to itself as part of one of the case of the test run.
The following patch
1. Adds a signal() syscall to register the signal handler
2. Corrects the expected 'revents' for the case where ppoll() is called on a file which is only opened in read/write mode, i.e case00.
3. Takes away printing the type of error ( i.e strerror(errno) ) since it only prints the last error seen and does not report the failures seen in the cases before the last failed one. The reporting of NG or OK shoudl take care of 
    letting the user know the cases that have passed and cases that have failed.

Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
---

--- ppoll01.c.orig	2009-09-22 19:22:39.371235396 +0530
+++ ppoll01.c	2009-09-24 01:24:38.706487228 +0530
@@ -106,6 +106,8 @@ extern void cleanup() {
         tst_exit();
 }
 
+void sighandler(int sig);       /* signals handler function for the test */
+
 /* Local  Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -125,7 +127,8 @@ extern void cleanup() {
 /*                                                                            */
 /******************************************************************************/
 void setup() {
-        /* Capture signals if any */
+        /* Capture signals*/
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
@@ -463,7 +466,7 @@ int main(int ac, char **av) {
 		                break;
 
 	        default:
-                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+                 	   	tst_resm(TFAIL, "%s failed", TCID);
         		        RPRINTF("NG");
 				cleanup();
 				tst_exit();



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
