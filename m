From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jun 2016 18:31:42 +0200
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <alpine.DEB.2.11.1606231720080.5839@nanos>
References: <20160623114759.GA19250@rei.lan>
 <20160623135803.636.qmail@ns.sciencehorizons.net>
 <20160623151127.GA20808@rei.lan>
 <alpine.DEB.2.11.1606231720080.5839@nanos>
Message-ID: <20160623163142.GB20808@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > That is likely POSIX conformance bug, since POSIX explicitly states that
> > sigtimedwait() shall use CLOCK_MONOTONIC to measure the timeout.
> > 
> > "If the Monotonic Clock option is supported, the CLOCK_MONOTONIC clock
> > shall be used to measure the time interval specified by the timeout
> > argument."
> 
> That's fine because jiffies is a less granular form of CLOCK_MONOTONIC.

Looking into POSIX Realtime Clock and Timers it seems to allow that time
service based on CLOCK_* clocks to have different resolution if it's
less or equal than 20ms and if this fact is documented. If we wanted to
be pedantic about this the man page shoud be patched...

Also this gives us reasonably safe upper bound on timer expiration to be
something as:

sleep_time * 1.125 + 20ms

Does this sounds reasonable now?

-- 
Cyril Hrubis
chrubis@suse.cz
