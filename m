Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MyATF-0002ww-GH
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 20:29:17 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MyAT9-0007pv-EN
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 20:29:17 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9EKPMAe023111
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 16:25:22 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9EKT4ui2420858
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 16:29:04 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9EKT3gH000424
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Oct 2009 14:29:04 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910141211.11379.chandru@in.ibm.com>
References: <200910011340.32046.chandru@in.ibm.com>
	<1255436017.8438.36.camel@subratamodak.linux.ibm.com>
	<200910141211.11379.chandru@in.ibm.com>
Date: Thu, 15 Oct 2009 01:58:54 +0530
Message-Id: <1255552134.4892.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH V2] ppoll01: add signal() syscall to register
	the	signal handler
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

On Wed, 2009-10-14 at 12:11 +0530, Chandru wrote: 
> On Tuesday 13 October 2009 17:43:37 Subrata Modak wrote:
> > On Thu, 2009-10-01 at 13:40 +0530, Chandru wrote: 
> > > The ppoll01 testcase has a signal handler in it but this signal handler is not registered with the kernel through the signal() syscall. The testcase fails when it sends a SIGINT to itself as part of one of the case of the test run.
> > > The following patch
> > > 1. Adds a signal() syscall to register the signal handler
> > > 2. Corrects the expected 'revents' for the case where ppoll() is called on a file which is only opened in read/write mode, i.e case00.
> > > 
> > > Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
> > 
> > Hi Chandru,
> > 
> > Can you please resend this with a diff from the Latest CVS snapshot ?
> > 
> 
> Hi Subrata, 
> 
> Thanks for letting me know. Here is the patch taken from the latest snapshot. 
> 
> The following patch adds a signal() syscall to the ppoll01 testcase. The testcase has a signal handler in it but this signal handler is not registered with the kernel through the signal() syscall.  Without the patch the testcase fails when it sends a SIGINT to itself as part of one of the case of the test run.
> 
> Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> ---
> 
> --- ltp/testcases/kernel/syscalls/ppoll/ppoll01.c.orig	2009-10-14 16:58:45.547235527 +0530
> +++ ltp/testcases/kernel/syscalls/ppoll/ppoll01.c	2009-10-14 16:53:42.828486675 +0530
> @@ -106,6 +106,8 @@ extern void cleanup() {
>          tst_exit();
>  }
> 
> +void sighandler(int sig);       /* signals handler function for the test */
> +
>  /* Local  Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -126,6 +128,8 @@ extern void cleanup() {
>  /******************************************************************************/
>  void setup() {
>          /* Capture signals if any */
> +	signal(SIGINT, &sighandler);
> +
>          /* Create temporary directories */
>          TEST_PAUSE;
>          tst_tmpdir();


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
