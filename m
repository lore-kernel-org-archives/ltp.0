Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaNR-0006Ig-RQ
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:17 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaNN-00074a-6D
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:17 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIKd4a027761
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:20:39 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UIT7Lo211068
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UIT6Il002937
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:06 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A658302.60307@in.ibm.com>
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
	<4A64541C.9090408@in.ibm.com>
	<364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
	<4A658302.60307@in.ibm.com>
Date: Thu, 30 Jul 2009 23:58:55 +0530
Message-Id: <1248978536.5788.57.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: Sharyathi Nagesh <sharyath@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com

On Tue, 2009-07-21 at 14:27 +0530, Sharyathi Nagesh wrote: 
> Garret
> 
> > 
> > Hi Yeehaw,
> >     1. You didn't provide sign-off, as noted in the DCO:
> > http://ltp.sourceforge.net/DCO.txt
> Excuse me for missing that out, if this patch format is okie I will resend it with the 
> sign-off included in it

Sharyathi, please resend this clean.

Regards--
Subrata

> >     2. This appears to be a legitimate documentation bug (at least as
> > far as the manpages for 2.6.29-r5 are concerned), because I can't find
> > a single reference to nobody in the manpage, as far as special
> > importance is concerned. Furthermore, looking at the OpenGroup's
> > documentation, I don't see anything there either:
> > http://www.opengroup.org/onlinepubs/000095399/functions/getgroups.html
> 
>   I am not very clear with what you are pointing at, but let me take a shot. bin and nobody 
> are 2 users used in the test case. I am not sure who or where it is getting created, but 
> what I did observe is that they don't have the same privileges. GID of bin is in the list of 
> supplementary group ids of root while nobody is not. If this is the case chmod/fchmod won't 
> clear S_IGSID bit of the file, as you can read from man page of chmod/fchmod.
>   Nobody won't be in any man page as this User was created by LTP, I suppose, to use in this 
> test case.
> Thanks
> Sharyathi N
> 
> 
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have
> the opportunity to enter the BlackBerry Developer Challenge. See full prize  
> details at: http://p.sf.net/sfu/Challenge
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
