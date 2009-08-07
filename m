Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOlZ-000470-Bn
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:41:49 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOlU-0002Eb-Nb
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:41:49 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n77CZtHi018993
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:35:55 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77Cfb0i175856
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:41:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77Cfa7X012601
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:41:36 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A7AC0FC.1080405@in.ibm.com>
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
	<4A64541C.9090408@in.ibm.com>
	<364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
	<4A658302.60307@in.ibm.com>
	<1248978536.5788.57.camel@subratamodak.linux.ibm.com>
	<4A724B32.7070604@in.ibm.com>
	<1249005278.5788.79.camel@subratamodak.linux.ibm.com>
	<4A7AC0FC.1080405@in.ibm.com>
Date: Fri, 07 Aug 2009 18:11:29 +0530
Message-Id: <1249648889.4851.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][RESEND] Issue observed with chmod05,
	fchmod05 test	cases
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

On Thu, 2009-08-06 at 17:09 +0530, Sharyathi Nagesh wrote: 
> Subrata
> 	Resending the patch, after the modification. Let me know if this is acceptable
> Thanks
> Yeehaw

It fails to Apply:

patching file testcases/kernel/syscalls/chmod/chmod05.c
Hunk #1 succeeded at 240 with fuzz 2.
patching file testcases/kernel/syscalls/fchmod/fchmod05.c
Hunk #1 FAILED at 218.
1 out of 1 hunk FAILED -- saving rejects to file
testcases/kernel/syscalls/fchmod/fchmod05.c.rej

Regards--
Subrata

> 
> 
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
