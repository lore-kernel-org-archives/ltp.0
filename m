Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chandru@in.ibm.com>) id 1MxxY9-0006yF-Mh
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 06:41:29 +0000
Received: from e28smtp06.in.ibm.com ([59.145.155.6])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxxY3-0003WO-TT
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 06:41:29 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id n9E6fC1H012930
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 12:11:12 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9E6fCRe2670818
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 12:11:12 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9E6fBX5012306
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 12:11:12 +0530
From: Chandru <chandru@in.ibm.com>
Date: Wed, 14 Oct 2009 12:11:11 +0530
References: <200910011340.32046.chandru@in.ibm.com>
	<1255436017.8438.36.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1255436017.8438.36.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200910141211.11379.chandru@in.ibm.com>
Subject: Re: [LTP] [PATCH V2] ppoll01: add signal() syscall to register the
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

On Tuesday 13 October 2009 17:43:37 Subrata Modak wrote:
> On Thu, 2009-10-01 at 13:40 +0530, Chandru wrote: 
> > The ppoll01 testcase has a signal handler in it but this signal handler is not registered with the kernel through the signal() syscall. The testcase fails when it sends a SIGINT to itself as part of one of the case of the test run.
> > The following patch
> > 1. Adds a signal() syscall to register the signal handler
> > 2. Corrects the expected 'revents' for the case where ppoll() is called on a file which is only opened in read/write mode, i.e case00.
> > 
> > Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
> 
> Hi Chandru,
> 
> Can you please resend this with a diff from the Latest CVS snapshot ?
> 

Hi Subrata, 

Thanks for letting me know. Here is the patch taken from the latest snapshot. 

The following patch adds a signal() syscall to the ppoll01 testcase. The testcase has a signal handler in it but this signal handler is not registered with the kernel through the signal() syscall.  Without the patch the testcase fails when it sends a SIGINT to itself as part of one of the case of the test run.

Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
---

--- ltp/testcases/kernel/syscalls/ppoll/ppoll01.c.orig	2009-10-14 16:58:45.547235527 +0530
+++ ltp/testcases/kernel/syscalls/ppoll/ppoll01.c	2009-10-14 16:53:42.828486675 +0530
@@ -106,6 +106,8 @@ extern void cleanup() {
         tst_exit();
 }
 
+void sighandler(int sig);       /* signals handler function for the test */
+
 /* Local  Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -126,6 +128,8 @@ extern void cleanup() {
 /******************************************************************************/
 void setup() {
         /* Capture signals if any */
+	signal(SIGINT, &sighandler);
+
         /* Create temporary directories */
         TEST_PAUSE;
         tst_tmpdir();

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
