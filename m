Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoMr-0001kH-R4
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:39:05 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoMn-0002F6-7j
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:39:05 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHarus008907
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:36:53 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHctnO263956
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:38:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHctlJ000412
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:38:55 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200908281044.04663.vapier@gentoo.org>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<200908280514.03971.vapier@gentoo.org>
	<1251454262.9081.16.camel@subratamodak.linux.ibm.com>
	<200908281044.04663.vapier@gentoo.org>
Date: Sun, 30 Aug 2009 23:07:21 +0530
Message-Id: <1251653843.12120.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP]
	=?utf-8?q?=5BPATCH=5D_Annotate_tst=5F*=28=29_helpers_with?=
	=?utf-8?b?CV9fYXR0cmlidXRlX18gKChmb3JtYXQgKHByaW50ZiwgTSwgTikpKQ==?=
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, ltp-list@lists.sourceforge.net

On Fri, 2009-08-28 at 10:44 -0400, Mike Frysinger wrote: 
> On Friday 28 August 2009 06:11:02 Subrata Modak wrote:
> > On Fri, 2009-08-28 at 05:14 -0400, Mike Frysinger wrote:
> > > On Friday 28 August 2009 04:38:17 Subrata Modak wrote:
> > > > Sorry. I need to revert this as it generates a huge set of warning for
> > > > all the tests compiled. It should not only get fixed at test.h, but
> > > > also in all tests that uses the tst_* family of functions, which
> > > > obviously is too big to fix.
> > >
> > > nothing is too big.  the proposed patch is a great idea and anything
> > > preventing it from being merged should be resolved so it can go back in.
> >
> > Great Mike. I am already seeing you doing some changes to the headers in
> > CVS. Can you also push this patch once you are done with all the
> > changes. Please notify me once all are done. I plan to checkout a fresh
> > one for the upcoming release ;-)
> 
> ive fixed a good chunk of the warnings now, but there's still a good number 

Thanks Mike.

> left.  maybe someone else feels like taking a crack at them, but i'm bored 
> now.  i'll leave it up to you to apply said patch now or wait a few days so it

I will do that right away.

Regards--
Subrata

> 
> goes in after the next release.
> -mike


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
