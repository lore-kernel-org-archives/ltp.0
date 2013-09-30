Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rameshyr@linux.vnet.ibm.com>) id 1VQX1a-0007dq-Uk
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 06:32:06 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VQX1Y-0006xF-HI
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 06:32:06 +0000
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <rameshyr@linux.vnet.ibm.com>;
	Mon, 30 Sep 2013 16:31:56 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3B33E2BB0053
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Sep 2013 16:31:54 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r8U6F8OU19464386
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Sep 2013 16:15:08 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	r8U6VrTd021654
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Sep 2013 16:31:53 +1000
Received: from oc8714216728.ibm.com ([9.124.158.47])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	r8U6VqnO021631
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Sep 2013 16:31:53 +1000
Message-ID: <52491AD8.7080706@linux.vnet.ibm.com>
Date: Mon, 30 Sep 2013 12:01:52 +0530
From: Ramesh <rameshyr@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] clock_settime03 test fails on kernel-2.6.32
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
To: ltp-list@lists.sourceforge.net

Hi All,

I am facing some issues with clock_settim03 test of timers group. 
clock_settime03 evaluates
the error condition of clock_settime systemcall. On my machine, TEST8 & 
TEST9 are failing as
the expeted error is not equal to the actual error.

After analysis, I found that the TEST8 & TEST9 are trying to
set CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID respectively.
But from the man pages, it says that
"According to POSIX.1-2001, the CLOCK_PROCESS_CPUTIME_ID and 
CLOCK_THREAD_CPUTIME_ID
  clocks should be settable using  clock_settime(). How-ever, the clocks 
currently are not settable".

Also, in the below code snippet of 
ltp/testcases/kernel/timers/clock_settime/clock_settime03.c
the if statement looks nothing for my kernel-2.6.32. So, the value of 
testcases[7] and testcases[8]
will get assigned to EFAULT but actually both of them should get set to 
EINVAL as the support is not
available on kernel-2.6.32.

-----------

         /* PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
          * kernel versions lower than 2.6.12 and changed back in 2.6.38
          */
         if ((tst_kvercmp(2, 6, 12)) < 0 || (tst_kvercmp(2, 6, 38)) >= 0) {
                 testcases[7] = EINVAL;
                 testcases[8] = EINVAL;
         } else {
                 testcases[7] = EFAULT;
                 testcases[8] = EFAULT;
         }

------------

I would like to know from which version onwards the 
CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID
clocks can be set using clock_settime() so that I can generate a valid 
patch for this testcase.



Regards,
Ramesh


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
