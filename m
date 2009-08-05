Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1MYYsA-0007u1-MC
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 05:17:10 +0000
Received: from e28smtp08.in.ibm.com ([59.145.155.8])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYYs3-0008Th-F7
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 05:17:10 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7555ZT9027752
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 10:35:35 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n755A8cA1093836
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 10:40:08 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n755A8pV018337
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 15:10:08 +1000
Message-ID: <4A791430.2000407@linux.vnet.ibm.com>
Date: Wed, 05 Aug 2009 10:40:08 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <5D25ED72-13B4-4ED7-959C-4974F4DF2FCA@kernel.crashing.org>
In-Reply-To: <5D25ED72-13B4-4ED7-959C-4974F4DF2FCA@kernel.crashing.org>
Subject: Re: [LTP] building LTP on fedora 10 or 11
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

Kumar Gala wrote:
> Has anyone been able to build LTP on fedora 10 or 11.
>
> When I try on a x86_64 fedora 10 box:
>
> [galak@komodo ltp]$ make autotools
> aclocal -I m4
> autoconf
> configure.ac:9: error: possibly undefined macro: AC_PROG_AR
>        If this token and others are legitimate, please use  
> m4_pattern_allow.
>        See the Autoconf documentation.
> make: *** [configure] Error 1
>
> than if I run it again I get:
>
> [galak@komodo ltp]$ make autotools
> make: *** No rule to make target `m4/Makefile.am', needed by `m4/ 
> Makefile.in'.  Stop.
>
> I pretty much see the same behavior on fedora 11.  Tried both x86_64  
> and PPC.
>
> - k
>
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   
Hi Kumar,

Which version of LTP is producing this error ? Have you tried latest LTP 
that is July'09  version ?
-Rishi

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
