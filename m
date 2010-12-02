Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PO7pz-0005gq-7o
	for ltp-list@lists.sourceforge.net; Thu, 02 Dec 2010 12:00:35 +0000
Date: Thu, 2 Dec 2010 13:13:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101202121334.GA20268@saboteur.suse.cz>
References: <4CCA33F8.6020104@cn.fujitsu.com> <4CD777DE.7040302@cn.fujitsu.com>
	<AANLkTikkEAuO5jPXExneKC7OHbOViTErs_Fu_XasYma4@mail.gmail.com>
	<20101118202910.GF19296@saboteur.suse.cz>
	<AANLkTimz2WBPfwCBHajqzA7Uk_72MZeTJdWB0Zbkch8B@mail.gmail.com>
	<AANLkTi=YvMBmUQLSmtq8aM0+s2-X3BmRM13fSUa6a1-1@mail.gmail.com>
	<4CF4CCD7.3060009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CF4CCD7.3060009@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Don't use clock_settime()
 to reset a CPU-time Clock
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
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>>> The tort is the same in POSIX 2008.1. Taking out the chaff...
> >>>>
> >>>> a. If _POSIX_CPUTIME is defined, implementations shall support clock
> >>>> ID values obtained by invoking clock_getcpuclockid(), which represent
> >>>> the CPU-time clock of a given process.
> >>>> b. Implementations shall also support the special clockid_t value
> >>>> CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
> >>>> calling process when invoking one of the clock_*() or timer_*()
> >>>> functions.
> >>>> c. For these clock IDs, the values returned by clock_gettime() and
> >>>> specified by clock_settime() represent the amount of execution time of
> >>>> the process associated with the clock.
> >>>>
> >>>> Nowhere does it say that you can't set that clock. Try running the
> >>>> test as root to see what you can do... if the test fails (even as
> >>>> root), then Linux needs to be fixed to conform to POSIX.
> >>>>
> >>>> Also, try running the other tests I just added to see whether or not
> >>>> the function call fails per POSIX's requirements.
> >>>>
> >>> From clock_settime POSIX documentation:
> >>>
> >>> ...
> >>>
> >>> The effect of setting a clock via clock_settime() on armed per-process timers
> >>> associated with that clock is implementation-dependent.
> >>>
> >>> The appropriate privilege to set a particular clock is implementation-dependent.
> >>>
> >>> ...
> >>>
> >>>
> >>> From man clock_settime:
> >>>
> >>> ...
> >>>
> >>> According to POSIX.1-2001, a process with "appropriate privileges" may set the
> >>> CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID  clocks  using
> >>> clock_settime().  On Linux, these clocks are not settable (i.e., no process has
> >>> "appropriate privileges").
> >>>
> >>> ...
> >>>
> >>>
> >>>
> >>> This is pretty creative understanding of the standart, but I couldn't
> >>> say it's wrong anyway.
> >> I agree that privilege is multitiered and the implications of running
> >> as a particular user, whether or not SELinux is enabled, MAC allows
> >> it, etc are all bits to take into consideration.
> >>
> >> Just running the program as root seems like a simple test to run to
> >> see whether or not the testcase passes.
> > 
> >     FYI, I removed the clock_settime call and simplified the testcase
> > because it wasn't really buying much in the overall scheme of things
> > to make sure that the time matched on the two clock values. If
> > anything that should be tested with the clock_settime conformance
> > testcase.
> 
> Hi Cooper,
> 
> I have a look of the code you modified. Consider the following piece:
> 
>          /* Get the time of clockid_1. */
>          if (clockid_1 != clockid_2) {
>                  printf("clock_getcpuclockid(0, ..) != "
>                    "clock_getcpuclockid(%d, ..): (%d != %d)\n", clockid_1,
>                     clockid_2);
>                 return PTS_FAIL;
>          }
> 
> IMO, you can't do such comparision, it's problematic. In this case, clockid_1 
> and clockid_2 own different values, but they point to the same clock. So you
> can't modify like this.

Yes this assumption seems to be incorrect as I couldn't find in a place
in POSIX documentation which explicitly states that two obtained
clock_id that points to the same clock must be the same. On linux
calling clock_getcpuclockid() with 0 and value from getpid() returns two
different id which both points to the same clock.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
