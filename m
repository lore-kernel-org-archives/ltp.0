Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chandru@in.ibm.com>) id 1MtG5A-0001sX-UT
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 07:28:08 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MtG54-0001Cd-B9
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 07:28:08 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n917Iitl012706
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 17:18:44 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n917PV3r381078
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 17:25:31 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n917RpKe008513
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Oct 2009 17:27:51 +1000
From: Chandru <chandru@in.ibm.com>
Date: Thu, 1 Oct 2009 12:57:46 +0530
References: <200909241229.32866.chandru@in.ibm.com>
	<200909260725.29279.vapier@gentoo.org>
In-Reply-To: <200909260725.29279.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200910011257.47226.chandru@in.ibm.com>
Subject: Re: [LTP] [PATCH] ppoll01: add signal() syscall to register the
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Saturday 26 September 2009 16:55:28 Mike Frysinger wrote:
> On Thursday 24 September 2009 02:59:32 Chandru wrote:
> >  3. Takes away
> >  printing the type of error ( i.e strerror(errno) ) since it only prints
> >  the last error seen and does not report the failures seen in the cases
> >  before the last failed one. The reporting of NG or OK shoudl take care of
> >  letting the user know the cases that have passed and cases that have
> >  failed.
> >
> > -                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID,
> >  TEST_ERRNO, strerror(TEST_ERRNO));
> >  +                 	   	tst_resm(TFAIL, "%s failed", TCID);
> 
> why dont you *fix* the issues you see with this output instead of making the 
> output even more useless ?  also, this should be converted to TFAIL|TTERRNO.
> -mike
> 

em, the change was not useless, the existing reporting of failure was. The output on failure of only the
first case prints as
"ppoll01     1  TFAIL  :  ppoll01 failed - errno = 0 : Success"

The words 'failed' and 'Success' on the same line could confuse us. The testcase has 8 scenarios of which 5 are
made to fail by passing invalid arguments. Although we could have a fix as the following

=====================================================================

--- ppoll01.c.orig	2009-09-29 21:28:55.510487735 +0530
+++ ppoll01.c	2009-10-01 17:34:42.651235797 +0530
@@ -242,6 +242,8 @@ static struct test_case tcase[] = {
 #endif
 };
 
+int tstatus, terrno[16];
+
 #define NUM_TEST_FDS    1
 
 /*
@@ -265,6 +267,7 @@ static int do_test(struct test_case *tc)
         sigset_t *p_sigmask, sigmask;
         size_t sigsetsize = 0;
         pid_t pid = 0;
+	static int tc_no;
 
 	TEST(fd = setup_file(progdir, "test.file", fpath));
         if (fd < 0)
@@ -331,6 +334,11 @@ static int do_test(struct test_case *tc)
         errno = 0;
         TEST(sys_ret = syscall(__NR_ppoll, p_fds, nfds, p_ts, p_sigmask, sigsetsize));
         sys_errno = errno;
+	if (((tc->ret == 0) && (sys_ret == -1)) || ((tc->ret == -1) && (sys_ret == 0))) {
+		tstatus |= (1 << tc_no);
+		terrno[tc_no] = errno;
+	}
+	tc_no++;
         if (sys_ret <= 0 || tc->ret < 0)
                 goto TEST_END;
 
@@ -463,7 +471,10 @@ int main(int ac, char **av) {
 		                break;
 
 	        default:
-                 	   	tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+        			tst_resm(TPASS, "ppoll result = %d  ",result);
+                                for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0])); i++)
+                                        if (tstatus & (1 << i))
+                                                tst_resm(TFAIL|TTERRNO, "%s failed - errno = %d : %s", TCID, terrno[i], strerror(terrno[i]));
         		        RPRINTF("NG");
 				cleanup();
 				tst_exit();



======================================================================

I will retain the current existing tst_resm lines and add TFAIL|TTERRNO to it as per your suggestion. The reason being that 
there is not much gain in making the above changes to the test case.

Thanks,
Chandru




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
