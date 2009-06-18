Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLSy-0003k5-8F
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:00 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLSv-0006ZU-SQ
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:00 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHRUPU021148
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:27:30 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHVtP3157598
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:31:56 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHVpSV019676
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 11:31:54 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906121408.15925.jpalecek@web.de>
References: <1244635585.9465.14.camel@munipradeep-laptop>
	<200906121408.15925.jpalecek@web.de>
Date: Thu, 18 Jun 2009 23:01:38 +0530
Message-Id: <1245346298.5041.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Some of the testcases which are resulting in FAIL
	even	though they	might not be
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>, iranna.ankad@in.ibm.com

On Fri, 2009-06-12 at 14:08 +0200, Jiri Palecek wrote: 
> On Wednesday 10 June 2009 14:06:25 Munipradeep Beerakam wrote:
> > Hi,
> 
> Hi,
> 
> > Here is the list of testcases in May 2009 LTP, which *may* result in
> > FAIL even though it is a configuration error, not the error due to the
> > functionality we are testing. Those tests should give "CONF" message,
> > not "FAIL". I ran LTP on 2.6.18 kernel, x86 architecture.
> > 
> > 
> >    3. get_mempolicy01
> > Part of code, which is not correct
> > tst_resm(TFAIL, "set_mempolicy() failed - errno = %d : %s",TEST_ERRNO,
> > strerror(TEST_ERRNO));
> > ...
> > ...
> > tst_resm(TFAIL, "malloc failed - errno = %d : %s",TEST_ERRNO,
> > strerror(TEST_ERRNO));
> > 
> >    4. mq_open01
> > Part of code, which is not correct
> > if (TEST_RETURN < 0) {
> >                         tst_resm(TFAIL, "mq_getsetattr failed - errno =
> > %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> 
> Not that I'd say this code is stellar, it may even be incorrect, but changing these to TCONF wouldn't be correct either. These error messages should be TCONF only if errno is ENOSYS, otherwise, they should be reported as TBROK, because it would be an error that prevents the test to run. The best option, however, would probably be to add a tst_kvercmp check for kernel versions that contain the respective functions.
> 

Muni,

Can you work out a patch on this lines. I would help you to do so if
required.

Regards--
Subrata

> Regards
>     Jiri Palecek
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing 
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
