Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOo8a-0008Nd-OX
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 07:33:48 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOo8V-0004tt-Cs
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 07:33:48 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n697Fatd012727
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2009 03:15:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n697L9Bb239792
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2009 03:21:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n697IcPY002700
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2009 03:18:38 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <587a08410907071230x3c4f6edaj71e5ace0a19c96ba@mail.gmail.com>
References: <587a08410907071230x3c4f6edaj71e5ace0a19c96ba@mail.gmail.com>
Date: Thu, 09 Jul 2009 12:51:04 +0530
Message-Id: <1247124065.6174.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Simple test for eventfd
	semaphore	(eventfd-sem:	eventfd2_03.c) for ARM architecture
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
To: Jatin Sharma <sharmaj@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Jatin,

A recent failure on Powerpc has been patched. Please see:

http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/include/powerpc.in?r1=1.6&r2=1.7,

You need to make similar entries by finding out the corresponding
syscall no. on arm and update the following file in ltp. If that solves
your problem, send the patch to LTP:

http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/include/arm.in

Regards--
Subrata

On Tue, 2009-07-07 at 12:30 -0700, Jatin Sharma wrote:
> Cross-compilation of the ltp-full-20090630 for ARM architecture fails
> in the following code. Is there a patch for this code for ARM
> architecture?
> 
> #ifndef __NR_eventfd2
> #if defined(__x86_64__)
> #define __NR_eventfd2 290
> #elif defined(__i386__)
> #define __NR_eventfd2 328
> #else
> #error Cannot detect your architecture!
> #endif
> #endif
> 
> 
> Thanks,
> Jatin
> 
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have 
> the opportunity to enter the BlackBerry Developer Challenge. See full prize 
> details at: http://p.sf.net/sfu/blackberry
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
