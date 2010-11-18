Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PJAv2-0002Bf-DW
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 20:17:20 +0000
Date: Thu, 18 Nov 2010 21:29:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101118202910.GF19296@saboteur.suse.cz>
References: <4CCA33F8.6020104@cn.fujitsu.com> <4CD777DE.7040302@cn.fujitsu.com>
	<AANLkTikkEAuO5jPXExneKC7OHbOViTErs_Fu_XasYma4@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikkEAuO5jPXExneKC7OHbOViTErs_Fu_XasYma4@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The tort is the same in POSIX 2008.1. Taking out the chaff...
> 
> a. If _POSIX_CPUTIME is defined, implementations shall support clock
> ID values obtained by invoking clock_getcpuclockid(), which represent
> the CPU-time clock of a given process.
> b. Implementations shall also support the special clockid_t value
> CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
> calling process when invoking one of the clock_*() or timer_*()
> functions.
> c. For these clock IDs, the values returned by clock_gettime() and
> specified by clock_settime() represent the amount of execution time of
> the process associated with the clock.
> 
> Nowhere does it say that you can't set that clock. Try running the
> test as root to see what you can do... if the test fails (even as
> root), then Linux needs to be fixed to conform to POSIX.
> 
> Also, try running the other tests I just added to see whether or not
> the function call fails per POSIX's requirements.
> 

From clock_settime POSIX documentation:

...

The effect of setting a clock via clock_settime() on armed per-process timers
associated with that clock is implementation-dependent.

The appropriate privilege to set a particular clock is implementation-dependent. 

...


From man clock_settime:

...

According to POSIX.1-2001, a process with "appropriate privileges" may set the
CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID  clocks  using
clock_settime().  On Linux, these clocks are not settable (i.e., no process has
"appropriate privileges").

...



This is pretty creative understanding of the standart, but I couldn't
say it's wrong anyway. 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
