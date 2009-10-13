Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxhhN-0003JC-Da
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 13:45:57 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxhhG-0005Cb-Py
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 13:45:57 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DCAAvf016785
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:10:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DCDots233762
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:13:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DCAOke031782
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:10:24 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910011340.32046.chandru@in.ibm.com>
References: <200910011340.32046.chandru@in.ibm.com>
Date: Tue, 13 Oct 2009 17:43:37 +0530
Message-Id: <1255436017.8438.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH V2] ppoll01: add signal() syscall to
	register	the	signal handler
Reply-To: subrata@linux.vnet.ibm.com
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
To: Chandru <chandru@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

On Thu, 2009-10-01 at 13:40 +0530, Chandru wrote: 
> The ppoll01 testcase has a signal handler in it but this signal handler is not registered with the kernel through the signal() syscall. The testcase fails when it sends a SIGINT to itself as part of one of the case of the test run.
> The following patch
> 1. Adds a signal() syscall to register the signal handler
> 2. Corrects the expected 'revents' for the case where ppoll() is called on a file which is only opened in read/write mode, i.e case00.
> 
> Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>

Hi Chandru,

Can you please resend this with a diff from the Latest CVS snapshot ?

patching file testcases/kernel/syscalls/ppoll/ppoll01.c
Hunk #3 FAILED at 194.
1 out of 3 hunks FAILED -- saving rejects to file
testcases/kernel/syscalls/ppoll/ppoll01.c.rej

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/ppoll/ppoll01.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- testcases/kernel/syscalls/ppoll/ppoll01.c.orig	2009-09-29 21:28:55.510487735 +0530
> +++ testcases/kernel/syscalls/ppoll/ppoll01.c	2009-10-01 18:27:30.452236128 +0530
> @@ -79,6 +79,8 @@ char *TCID = "ppoll01";  /* Test program
>  int  testno;
>  int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
> 
> +void sighandler(int sig);       /* signals handler function for the test */
> +
>  /* Extern Global Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -125,7 +127,8 @@ extern void cleanup() {
>  /*                                                                            */
>  /******************************************************************************/
>  void setup() {
> -        /* Capture signals if any */
> +        /* Capture signals */
> +	signal(SIGINT, &sighandler);
>          /* Create temporary directories */
>          TEST_PAUSE;
>          tst_tmpdir();
> @@ -191,7 +194,7 @@ struct test_case {
>  static struct test_case tcase[] = {
>  	{ // case00
>                  .ttype          = NORMAL,
> -                .expect_revents = POLLOUT,
> +                .expect_revents = POLLOUT | POLLIN,
>                  .ret            = 0,
>                  .err            = 0,
>          },
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
