Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mkca7-0000ep-LZ
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:40:23 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mkca1-000804-12
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:40:23 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n87BXPKV029926
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:33:25 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n87BeBMu241542
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:40:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n87Bb6GQ017297
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:37:06 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA06ECF.4040508@jp.fujitsu.com>
References: <4AA06ECF.4040508@jp.fujitsu.com>
Date: Mon, 07 Sep 2009 17:09:52 +0530
Message-Id: <1252323604.4922.26.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fix UNRESOLVED failures of pthread tests
	in	open_posix_testsuite
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
To: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-09-04 at 10:35 +0900, Seiichi Ikarashi wrote: 
> Hi,
> 
> I report a couple of "UNRESOLVED" failures of open_posix_testsuite in ltp
> and send a patch for them.
> 
> I got following failures while executing open_posix_testsuite.
> 
> > conformance/interfaces/pthread_setschedparam/5-1: execution: UNRESOLVED: Output: 
> > [07:16:29]Test conformance/interfaces/pthread_setschedparam/5-1.c unresolved: got 22 (Invalid argument) on line 152 (Sem_post in signal handler 1)
> 
> > conformance/interfaces/pthread_detach/4-3: execution: UNRESOLVED: Output:
> > *snip*
> > [12:05:38]Test conformance/interfaces/pthread_detach/4-3.c unresolved: got 22 (Invalid argument) on line 157 (Sem_post in signal handler 1)
> 
> Both of them have wrong steps of its test preparation:
>   1. register signal handlers (just do sem_post()) for SIGUSR1/SIGUSR2.
>   2. block those signals
>   3. prepare something (sem_init()) for these signal handlers
>   4. send signals to itself from sub-threads.
> 
> They have a window of not-yet-prepared-for-signals
> between step 1 and 2. I think above "UNRESOLVED" failures
> (sem_post() before sem_init()) are the result of getting a
> signal during this window.
> I don't know who sent a signal to them but I guess
> neighboring tests are suspects, because number of tests run
> concurrently in open_posix_testsuite.
> 
> The fix shall be just delaying step 1 to between step 2 and 4,
> so I wrote such a patch for both pthread_setschedparam and
> pthread_detach. I have confirmed that this UNRESOLVED failure
> disappeared with this patch applied.
> 
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>

Ok Thanks.

Regards--
Subrata

> 
> Regards,
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
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
