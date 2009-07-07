Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCg3-0006VG-Up
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:33:51 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCfy-0001Dk-Lc
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:33:51 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n67FSEZI010086
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:28:14 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n67FWNRT1364056
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:24 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n67FWN5U024279
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:32:23 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40907061535s19bbe0b8o3c716b5320f2f9f8@mail.gmail.com>
References: <364299f40907061455n2f95c877sb40d6a97e856fd03@mail.gmail.com>
	<200907061810.04510.vapier@gentoo.org>
	<364299f40907061535s19bbe0b8o3c716b5320f2f9f8@mail.gmail.com>
Date: Tue, 07 Jul 2009 21:02:15 +0530
Message-Id: <1246980735.5539.45.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Missing limits.h include and test.h style
	in	system_specific_process_info.c
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

On Mon, 2009-07-06 at 15:35 -0700, Garrett Cooper wrote: 
> On Mon, Jul 6, 2009 at 3:10 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> > On Monday 06 July 2009 17:55:43 Garrett Cooper wrote:
> >> 1. test.h is in .../include/. Thus #include should be #include
> >> "test.h", not #include <test.h>.
> >> 2. limits.h should be explicitly stated because certain constants are
> >> used in system_specific_process_info.c (SHRT_MAX for instance).
> >>
> >> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >
> > unified diffs only please.  context diffs are awful.
> 
> And again.
> -Garrett

Thanks.

Regards--
Subrata

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
