Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCeg-0006H4-Ki
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:26 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCec-0000kT-Uw
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:26 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n67FZXfm003356
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:35:33 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n67FWJtM135844
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n67FWI3H004856
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:18 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40907061533j49edc5d4x4532b6a3d53f97f0@mail.gmail.com>
References: <364299f40907061322x726c3dcbh7ec674fc3851593f@mail.gmail.com>
	<200907061813.57806.vapier@gentoo.org>
	<364299f40907061533j49edc5d4x4532b6a3d53f97f0@mail.gmail.com>
Date: Tue, 07 Jul 2009 21:02:12 +0530
Message-Id: <1246980732.5539.44.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] Make IDcheck.sh DESTDIR aware and less strict
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Mon, 2009-07-06 at 15:33 -0700, Garrett Cooper wrote: 
> On Mon, Jul 6, 2009 at 3:13 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> > On Monday 06 July 2009 16:22:17 Garrett Cooper wrote:
> >> The end goal of this patch is to make IDcheck.sh more rootfs- / cross-
> >> compilation friendly, such that it can be run from the primary compile
> >> instance, and instead of attempting to manipulate the target system
> >> data, manipulate the sys-root / rootfs data through the use of DESTDIR
> >> and by relaxing certain checks. Most of the checks were unnecessary
> >> anyhow (am i root?), etc and can be easily remedied by just relying on
> >> the other checks made by touch(1)'ing files and the post-process
> >> operation, as ENOPERM will be returned if one cannot access the
> >> configuration file of interest.
> >>
> >> Also, use awk for all operations instead of grep because it will
> >> reduces the potential for random failures when dealing with /etc/group
> >> and /etc/passwd files, and we can switch over to one subroutine
> >> instead of multiple subroutines for checks.
> >
> > please use unified diffs only
> 
>     Ugh, sorry (cvs diff in context mode as default sucks... yay for
> aliases). Let's try that again...

Thanks.

Regards--
Subrata

> Thanks,
> -Garrett
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
