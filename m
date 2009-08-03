Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MXvbP-0007gr-B8
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:21:15 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXvbK-0001Db-3n
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:21:15 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73BHLiQ019061
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:17:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73BL4q6198814
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:21:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73BL3Zj027866
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:21:04 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A736253.90209@us.ibm.com>
References: <200907031601.52650.vapier@gentoo.org> <4A736253.90209@us.ibm.com>
Date: Mon, 03 Aug 2009 16:50:59 +0530
Message-Id: <1249298459.7460.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] futex syscall tests
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
To: Darren Hart <dvhltc@us.ibm.com>, Mike Frysinger <vapier@gentoo.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi Darren,

On Fri, 2009-07-31 at 14:29 -0700, Darren Hart wrote: 
> Mike Frysinger wrote:
> > are there any futex syscall tests already in ltp that i cant seem to locate ?  
> > if not, i can adapt the few that already exist in the libfutex code ...
> > -mike
> 
> Mike,
> 
> I recently done a lot of cleanup and a couple feature additions to the
> kernel futex code.  In doing so I was noticing the lack of a good futex
> system call test suite.  I had started a writeup of what such a test
> suite should accomplish.  I hadn't decided if I wanted to push it to LTP

I would request you to eventually push it to LTP. I think Mike might be
interested in reviewing the initial test code and then suggest his
additions/deletions. That way it would work fine, until Mike has already
written something for this.

And thanks for sharing the below design information.

Regards--
Subrata

> eventually or not.  As it sounds like you may have similar interests in
> this test, please find my very early, very incomplete, initial thoughts
> on such a testsuite.
> 
> I'd welcome your thoughts on approach, direction, etc.
> 
> -------------------------------------------------------------------------------
> 
> The following is a start at what I hope to be a design document for a new
> exhaustive futex functional/performance/stress benchmark. Before I flesh it
> out any further, I'd really appreciate some feedback on what I have so far.
> 
> Given the number of permutations each test seems to require, I think some kind
> of "test generator" is needed. We will have to describe the permutations and
> pass them to the test generator so it can create the various versions of the
> tests.
> 
> HAVOC FUTEX
> ===========
> 
> Havoc Futex is intended to thoroughly test the Linux kernel futex system call
> API. To the extent possible, each test is implemented using raw system calls
> as well as the glibc pthread library.
> 
> Futex Op Codes
> --------------
> FUTEX_WAIT
> FUTEX_WAKE
> FUTEX_FD
> FUTEX_REQUEUE
> FUTEX_CMP_REQUEUE
> FUTEX_WAKE_OP
> FUTEX_LOCK_PI
> FUTEX_UNLOCK_PI
> FUTEX_TRYLOCK_PI
> FUTEX_WAIT_BITSET
> FUTEX_WAKE_BITSET
> FUTEX_WAIT_REQUEUE_PI
> FUTEX_CMP_REQUEUE_PI
> 
> Syscalls to Test
> ----------------
> futex_wake
> futex_wake_op
> futex_requeue
> futex_wait
> futex_lock_pi
> futex_unlock_pi
> futex_wait_requeue_pi
> 
> Functional Tests
> ----------------
> requeue_pi/*
> 	Exercise the FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI op codes,
> 	under every possible combination of the following scenarios:
> 
> 	o shared and private futexes
> 	o CLOCK_MONOTONIC and CLOCK_REALTIME timeouts (and none)
> 	o Signal handling prior to and post requeue
> 	o correct and incorrect settings for val
> 	o target futex owned by waker, owned by third party, unowned
> 	o OWNERDIED reclaim of mutex
> 	o ensure priority ordered wakeup of waiters
> 
> 	Error and Misuse Cases
> 	----------------------
> 	o mixed shared and private futexes (should fail)
> 	o pi source futex
> 	o non-pi target futex
> 	o unmapped shared futex fault handling
> 	o bogus uaddrs
> 	o invalid nr_wake and nr_requeue values
> 	o mismatched wait_requeue and futex_requeue target futexes
> 	o incorrect pairing of futex_wait_requeue_pi with futex_wake
> 
> 	Syscalls Exercised
> 	------------------
> 	futex_wait_requeue_pi
> 	futex_requeue
> 	futex_lock_pi
> 	futex_unlock_pi
> 
> pi_lock/*
> 	Exercise the FUTEX_LOCK_PI and FUTEX_UNLOCK_PI op codes, under every
> 	possible combination of the following scenarious:
> 
> 	o shared and private futexes
> 	o CLOCK_MONOTONIC and CLOCK_REALTIME timeouts (and none)
> 	o Signal handling
> 	o correct and incorrect settings for val
> 	o bogus uaddrs
> 	o contended and uncontended cases
> 	o OWNERDIED reclaim of mutex
> 
> 	Error and Misuse Cases
> 	----------------------
> 	o pi_unlock of a non-pi-locked futex
> 	o pi_lock of an owned non-pi futex
> 	o unmapped shared futex fault handling
> 	o mismatched futex_lock_pi and futex_wake(_op)? calls
> 	o mismatched futex_wait and futex_unlock_pi calls
> 
> 	Syscalls Exercised
> 	------------------
> 	futex_lock_pi
> 	futex_unlock_pi
> 	futex_wait
> 	futex_wake
> 	futex_wake_op
> 
> requeue/*
> 	Exercise the FUTEX_WAIT and the FUTEX_CMP_REQUEUE op codes.  Perform
> 	basic testing for FUTEX_REQUEUE, purposefully avoiding its known
> 	flaws.
> 
> 	Error and Misuse Cases
> 	----------------------
> 
> 	Syscalls Exercised
> 	------------------
> 	futex_wait
> 	futex_requeue
> 
> wait/*
> 	Exercise the FUTEX_WAIT and FUTEX_WAKE op codes.
> 
> 	Error and Misuse Cases
> 	----------------------
> 
> 	Syscalls Exercised
> 	------------------
> 	futex_wait
> 	futex_wake
> 	futex_wake_op
> 
> 
> 
> Performance Tests
> -----------------
> 	o attempt to expose lock contention issues, such as those exposed by
> 	  calling futex_wait on an unowned futex
> 	o rapid lock and unlock of an uncontended futex
> 	o rapid lock and unlock of a heavily conteded futex
> 	o attempt to expose bottlenecks imposed by the shared hash-bucket
> 	  implementation
> 	o attempt to expose real-time scheduling overhead
> 
> Stress Tests
> ------------
> 	o thousands of threads/processes contending on a single futex
> 	o thousands of threads/processes on thousands of futexes
> 
> Other Thoughts
> --------------
> kernel-side futex fault injection
> 	There are a lot of places in futex.c that have to handle faults.  I
> 	think some kind of a fault injection system is needed.  This could be
> 	enabled via a sysctl or perhaps just configured in to a debug kernel.
> 	Running this test suite in a loop would allow us to achieve some
> 	statistical confidence in these numerous fault paths.
> 
> FUTEX_REQUEUE
> 	This op code is deprecated in favor of FUTEX_CMP_REQUEUE.  Do to the
> 	unreliable nature of the op code, only very limited testing can be
> 	performed.
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
