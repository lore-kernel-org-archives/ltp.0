Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XCBxd-0003Qp-DW
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 18:17:17 +0000
Date: Tue, 29 Jul 2014 20:16:30 +0200
From: chrubis@suse.cz
Message-ID: <20140729181630.GA28318@rei>
References: <1406585102-31700-1-git-send-email-gary.robertson@linaro.org>
	<20140729104619.GC24424@rei>
	<CAF7YWnxyXT2V=yKmEoSUzTbX8Cn9jVPTOK9-2sn_2jZCBOx_Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF7YWnxyXT2V=yKmEoSUzTbX8Cn9jVPTOK9-2sn_2jZCBOx_Gg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] prio-wake: eliminate deprecated usleep calls
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
To: Gary Robertson <gary.robertson@linaro.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Mike Holmes <mike.holmes@linaro.org>

Hi!
> > > Replaced deprecated usleep calls with calls to rt_nanosleep,
> > > which has no potentially adverse interactions with signals.
> >
> > Deprecated in which sense? In terms of realtime testsuite?
> >
> 
> My apologies for being ambiguous... years of writing pthreads applications
> has made this function 'deprecated' by default in my thinking.
> usleep should generally be avoided when using many other timer functions
> - including nanosleep, which is the basis of rt-nanosleep.
> Generally speaking, usleep and nanosleep should not be used in the same
> program.
> 
> Its interaction with SIGALRM may cause interference
> with other functions using SIGALRM, if any are in use.
> 
> As indicated in the usleep() man page NOTES:
> "       The interaction of this function with  the  SIGALRM  signal,  and
> with
>        other   timer  functions  such  as  alarm(2),  sleep(3),
> nanosleep(2),
>        setitimer(2),  timer_create(2),  timer_delete(2),
> timer_getoverrun(2),
>        timer_gettime(2), timer_settime(2), ualarm(3) is unspecified.
> "

Ok.

> > Has usleep() caused the test to fail? If so, why?
> >
> > usleep() is not causing prio-wake test failures in our environment.
> 
> We are getting race conditions among multiple waiter threads
> on armv7a processors in the futex / mutex locking code
> for the mutex associated with the condition variable in prio-wake.
> This is causing one of the threads to 'hang' waiting for a lock
> after the lock owner releases it and terminates.  Since this
> doesn't happen on x86 it appears to be specific to the armv7a -
> either in the compiler code generation or in some arch-specific
> code somewhere... we are investigating.
> 
> In investigating possible reasons for the 'hangup' I began by
> examining the source in prio-wake.c and saw the potentially
> problematic usleep calls.  Knowing they don't always play
> well with nanosleep I eliminated them on the chance that
> they were contributing to the hangups... which in this case
> they are not.
> 
> However as I said, years of coding pthreads apps
> with various timer functions has led me to use only
> nanosleep-related timer functions and to avoid usleep
> altogether - so I submit this patch as a somewhat
> 'nit-picking' minor cleanup.

Ok.

Can you please sumarize this a bit so that it fits into the commit
message and resend the patch?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
