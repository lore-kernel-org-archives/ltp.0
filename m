Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWUzl-00020O-Lb
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 12:44:29 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWUzh-0003r0-Pa
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 12:44:29 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UCckHC003298
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 08:38:46 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UCiJdu247634
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 08:44:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UCiIt7029852
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 08:44:19 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40907112103h3b0864a0l1e1c203a77c5476e@mail.gmail.com>
References: <364299f40907112103h3b0864a0l1e1c203a77c5476e@mail.gmail.com>
Date: Thu, 30 Jul 2009 18:14:16 +0530
Message-Id: <1248957856.5788.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix shadowed declaration of basename(3)
	in	testcases/kernel/fs/fsx-linux/fsx-linux.c
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sat, 2009-07-11 at 21:03 -0700, Garrett Cooper wrote: 
> This is the 21st century, and yes we have a basename(3) libcall in
> string.h. This attached patch fixes that so -Wshadow passes:
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

It seems you have not applied this. So, applying.

Regards--
Subrata

> 
> Index: testcases/kernel/fs/fsx-linux/fsx-linux.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/fsx-linux/fsx-linux.c,v
> retrieving revision 1.12
> diff -r1.12 fsx-linux.c
> 449,455d448
> < static const char *basename(const char *path)
> < {
> <       char *c = strrchr(path, '/');
> <
> <       return c ? c++ : path;
> < }
> <
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have
> the opportunity to enter the BlackBerry Developer Challenge. See full prize  
> details at: http://p.sf.net/sfu/Challenge
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
