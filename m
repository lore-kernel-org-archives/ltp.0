Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWV03-0006v8-RL
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 12:44:47 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWUzn-0003sl-Ef
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 12:44:42 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UCi9XA030350
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 08:44:10 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UCiPoj172418
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 08:44:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UCiPrT021463
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 08:44:25 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40907182138w484cc898gac9fe00dbde75afd@mail.gmail.com>
References: <364299f40907182138w484cc898gac9fe00dbde75afd@mail.gmail.com>
Date: Thu, 30 Jul 2009 18:14:22 +0530
Message-Id: <1248957862.5788.17.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix bad strerror calls
	in	testcases/kernel/syscalls/waitid01.c
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

On Sat, 2009-07-18 at 21:38 -0700, Garrett Cooper wrote: 
> For whatever reason the original author was using int casts to the
> strerror strings. That's just plain wrong...
> 
> This corrects the issue by feeding back the proper strerror output,
> which reduces noise at compile time and results in the same desired
> behavior (because we shouldn't be negative testing strerror(3) in
> waitid01.c:
> 
> gcooper@orangebox /scratch/ltp-nova2/ltp-nova $
> /scratch/ltp-nova2/ltp-nova/testcases/kernel/syscalls/waitid/waitid01
> waitid01    0  INFO  :  Process 29085 terminated:
> waitid01    0  INFO  :  code = 1
> waitid01    0  INFO  :  exit value = 123
> waitid01    0  INFO  :  Process 29086 terminated:
> waitid01    0  INFO  :  code = 2
> waitid01    0  INFO  :  signal = 8
> waitid01    0  INFO  :  Process 29087 terminated:
> waitid01    0  INFO  :  code = 2
> waitid01    0  INFO  :  signal = 1
> waitid01    0  INFO  :  Process 29088 terminated:
> waitid01    0  INFO  :  code = 1
> waitid01    0  INFO  :  exit value = 123
> waitid01    0  INFO  :  Process 29089 terminated:
> waitid01    0  INFO  :  code = 2
> waitid01    0  INFO  :  signal = 8
> waitid01    0  INFO  :  Process 29090 terminated:
> waitid01    0  INFO  :  code = 2
> waitid01    0  INFO  :  signal = 1
> waitid01    0  INFO  :  Process 29091 terminated:
> waitid01    0  INFO  :  code = 1
> waitid01    0  INFO  :  exit value = 123
> waitid01    0  INFO  :  Process 29092 terminated:
> waitid01    0  INFO  :  code = 2
> waitid01    0  INFO  :  signal = 8
> waitid01    0  INFO  :  Process 29093 terminated:
> waitid01    0  INFO  :  code = 2
> waitid01    0  INFO  :  signal = 1
> waitid01    1  PASS  :  waitid(): system call passed
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

I checked in this too. Thanks.

Regards--
Subrata

> 
> Index: testcases/kernel/syscalls/waitid/waitid01.c
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/waitid/waitid01.c,v
> retrieving revision 1.1
> diff -u -r1.1 waitid01.c
> --- testcases/kernel/syscalls/waitid/waitid01.c	15 Jun 2009 18:39:45 -0000	1.1
> +++ testcases/kernel/syscalls/waitid/waitid01.c	19 Jul 2009 04:34:39 -0000
> @@ -116,14 +116,9 @@
>  int errnochoose(void){   //choose the relative errno
> 
>      switch (TEST_ERRNO){
> -        case    0:      tst_exit();
> -        case    ECHILD: strerror((int)"ECHILD");
> -        	        break;
> -        case    EINTR:  strerror((int)"EINTR");
> -                	break;
> -        case    EINVAL: strerror((int)"EINVAL");
> -                	break;
> -        default:     strerror((int)"Other Error");
> +        case  0:     tst_exit();
> +		     break;
> +        default:     strerror(TEST_ERRNO);
>                       break;
>     }
>          TEST_RETURN = 0;
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
