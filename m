Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MgyQP-0000f1-V5
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:11:17 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyQJ-00061J-TY
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:11:17 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SA9WqC006471
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 06:09:32 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAB6nf245910
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 06:11:06 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAB5em005761
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 06:11:06 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200908280514.03971.vapier@gentoo.org>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<1251439738.9081.9.camel@subratamodak.linux.ibm.com>
	<1251448700.9081.13.camel@subratamodak.linux.ibm.com>
	<200908280514.03971.vapier@gentoo.org>
Date: Fri, 28 Aug 2009 15:41:02 +0530
Message-Id: <1251454262.9081.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP]
	=?iso-8859-1?q?=5BPATCH=5D_Annotate_tst=5F*=28=29_helpers_w?=
	=?iso-8859-1?q?ith=09=5F=5Fattribute=5F=5F_=28=28format_=28printf?=
	=?iso-8859-1?q?=2C_M=2C_N=29=29=29_=28was=3A_Re=3A_=5BPATCH=5D_quo?=
	=?iso-8859-1?q?tactl01=3A_Fix=09tst=5Fresm_=28=29_=09format__causi?=
	=?iso-8859-1?q?ng=09crash_=29?=
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

On Fri, 2009-08-28 at 05:14 -0400, Mike Frysinger wrote:
> On Friday 28 August 2009 04:38:17 Subrata Modak wrote:
> > On Fri, 2009-08-28 at 11:38 +0530, Subrata Modak wrote:
> > > On Thu, 2009-08-27 at 17:29 +0200, Geert Uytterhoeven wrote:
> > > > On Thu, 27 Aug 2009, Geert Uytterhoeven wrote:
> > > > > When the quotactl syscall fails, quotactl01 crashes with a
> > > > > segmentation fault due to an incorrect printf()-style format.
> > > >
> > > > This bug encouraged me to add annotations to the test helpers that take
> > > > printf()-style formats, cfr. the patch below.
> > > >
> > > > It causes a massive amount of compiler warnings, most of them caused by
> > > > TEST_ERRNO being long. According to CVS history, both TEST_RETURN and
> > > > TEST_ERRNO have been changed from int to long to accomodate 64-bit
> > > > platforms, but to me the change of TEST_ERRNO looks bogus.
> > > > As errno is int according to C99, TEST_ERRNO should actually be int
> > > > too, right?
> > > >
> > > > Note that there are also a few other cases where integers are used on
> > > > pointer type format specifiers. These will cause crashes when the code
> > > > path is executed.
> > > >
> > > > >From 601578f79c05779acefe023fd499726d9fe4ce03 Mon Sep 17 00:00:00 2001
> > > >
> > > > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > > > Date: Thu, 27 Aug 2009 17:08:18 +0200
> > > > Subject: [PATCH] Annotate tst_*() helpers with __attribute__ ((format
> > > > (printf, M, N)))
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > >
> > > Ok. Thanks.
> >
> > Sorry. I need to revert this as it generates a huge set of warning for
> > all the tests compiled. It should not only get fixed at test.h, but also
> > in all tests that uses the tst_* family of functions, which obviously is
> > too big to fix.
> 
> nothing is too big.  the proposed patch is a great idea and anything 
> preventing it from being merged should be resolved so it can go back in.

Great Mike. I am already seeing you doing some changes to the headers in
CVS. Can you also push this patch once you are done with all the
changes. Please notify me once all are done. I plan to checkout a fresh
one for the upcoming release ;-)

Regards--
Subrata

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
