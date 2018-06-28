From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jun 2018 11:00:14 +0200
Subject: [LTP] [PATCH] syscalls/shmctl05: new test for IPC file
 use-after-free bug
In-Reply-To: <20180628064612.GA719@sol.localdomain>
References: <20180513012325.877-1-ebiggers3@gmail.com>
 <20180518132536.GB32299@rei> <20180626113547.GG24288@rei>
 <20180627061815.GA9171@sol.localdomain>
 <20180627135903.GB32300@rei> <20180628064612.GA719@sol.localdomain>
Message-ID: <20180628090010.GB8182@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi, this works well for me too -- thanks!  Though, IIUC it relies on scheduling
> nondeterminism to hit the race.  It might help reproducing bugs like this if
> tst_fzsync_wait_*() cycled through different delay deltas between the two
> threads.

We were talking about something like this with Richard recently, but in
the end we agreed to try to apply the library to a few more testcases to
get a better picture of the real world requirements and obstackles.

I guess that synchronizing with spinlocks like this test does then
introducing slowly graduating delay before we call one of the syscalls
up to some reasonable upper bound a few times sounds reasonable. We
would still have to measure how much time do the syscalls spend in the
kernel so that we have a reasonable estimate for the upper bound, but
that should be doable.

> Also with a fixed kernel, to make the test pass rather than timing out, I had to
> change
> 
> 	while (tst_timer_elapsed_ms() < 5000)
> 
> to
> 
> 	while (tst_timer_stop(), tst_timer_elapsed_ms() < 5000)
>
> It would be nice if there was a simpler supported way to implement time-based
> tests like this.  E.g. the test framework could just save the start time
> automatically for all tests, and then a single function call could return the
> time elapsed so far.

Ah, right, let me fix that first.

The original purpose for the timer library is to measure time spend
doing some operation so the action to sample the end time and to convert
it to interval was separated intentionally.

I will add tst_timer_expired_ms() that could be used as:

tst_timer_start(CLOCK_MONOTONIC);

while (!tst_timer_expired_ms(5000)) {
	...
}

> Anyway, should I go ahead and send a formal v2 patch?

Just let me push the change to the timer library first :-).

-- 
Cyril Hrubis
chrubis@suse.cz
