Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Oe62u-0005Pt-3H
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 12:47:40 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oe62t-0004Vp-02
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 12:47:40 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6SCTJEt026779
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 08:29:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6SClVwM343728
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 08:47:31 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6SClUj5022267
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 08:47:30 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100506065815.23879.4005.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065815.23879.4005.sendpatchset@subratamodak.linux.ibm.com>
Date: Wed, 28 Jul 2010 18:16:58 +0530
Message-Id: <1280321227.9598.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [09/12 FAILURE] LTPE timer create04 fails
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
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>

Fixed now with Latest LTP.

Regards--
Subrata

On Thu, 2010-05-06 at 12:28 +0530, Subrata Modak wrote:
> Subject: LTPE timer_create04 fails
> 
> Issues Description below:
> =======================================
> # ./runltp -s timer_create04
> <<<test_output>>>
> timer_create04    1  TFAIL  :  didn't fail as expected [expected errno = 22
> (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
> timer_create04    2  TFAIL  :  didn't fail as expected [expected errno = 22
> (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
> timer_create04    3  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
> address
> timer_create04    4  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
> address
> timer_create04    5  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
> address
> timer_create04    6  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
> address
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> 
> SUZUKI K. POULOSE said that the same patch for issue #8 will solve the problem :-)
> 
> Regards--
> Subrata
> 


------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
