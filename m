Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MPLmW-0008Ls-Dl
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 19:29:16 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPLmR-0002sw-MH
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 19:29:16 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6AJODPH003577
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 15:24:13 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6AJTAnJ257938
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 15:29:10 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6AJQdDE023138
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 15:26:39 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40907101221i1da178c5xc0211627c0872e85@mail.gmail.com>
References: <4A5436D4.6070201@petalogix.com>
	<364299f40907080719q4ab01842v7e47a352b8214b8a@mail.gmail.com>
	<4A54AEFA.3030100@petalogix.com>
	<364299f40907082230m27683f17yd042bd569d0a5165@mail.gmail.com>
	<4A55C646.5060805@petalogix.com>
	<364299f40907091011y2f988746n562e183b5d4276be@mail.gmail.com>
	<4A5782A5.2050301@petalogix.com>
	<364299f40907101221i1da178c5xc0211627c0872e85@mail.gmail.com>
Date: Sat, 11 Jul 2009 00:59:04 +0530
Message-Id: <1247254145.5040.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] IDcheck.sh - awk problem
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
Cc: Mike Frysinger <vapier.adi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>

On Fri, 2009-07-10 at 12:21 -0700, Garrett Cooper wrote:
> On Fri, Jul 10, 2009 at 11:04 AM, Michal
> Simek<michal.simek@petalogix.com> wrote:
> > Garrett Cooper wrote:
> >> On Thu, Jul 9, 2009 at 3:28 AM, Michal Simek<michal.simek@petalogix.com> wrote:
> >>
> >>> Garrett Cooper wrote:
> >>>
> >>>> On Wed, Jul 8, 2009 at 7:36 AM, Michal Simek<michal.simek@petalogix.com> wrote:
> >>>>
> >>>>
> >>>>> Of course not because I cross compile ltp for Microblaze - correct
> >>>>> /etc/passwd - group is on
> >>>>> target system. Maybe worth to remove calling IDcheck.sh from make
> >>>>> install and call it only before
> >>>>> running the test.
> >>>>>
> >>>>>
> >>>>>
> >>>> Michal,
> >>>>     Please give this patch a try, and instead when you run make
> >>>> install, do SKIP_IDCHECK=1.
> >>>> HTH,
> >>>> -Garrett
> >>>>
> >>
> >> Wow. I must have been tired at the time; no idea why I used filter
> >> instead of strip. Please try this instead.
> >>
> >> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >>
> > Sorry for delay.
> >
> > Tested-by: Michal Simek <monstr@monstr.eu>
> 
> Subrata,
>     The fix for IDcheck.sh / the top-level Makefile is ready to be
> committed to HEAD. Are we ok for commit?

Garrett,

Please go ahead. I am making for some final preparations for OLS
2009 ;-). Would you all be interested to see my paper:

http://www.linuxsymposium.org/2009/view_abstract.php?content_key=24,
http://www.linuxsymposium.org/2009/view_abstract.php?content_key=25,

Regards--
Subrata

> Thanks,
> -Garrett


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
