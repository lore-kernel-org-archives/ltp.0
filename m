From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jun 2016 13:47:59 +0200
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <alpine.DEB.2.11.1606231024220.5839@nanos>
References: <20160617121134.417319325@linutronix.de>
 <1466581044.3188.34.camel@gmail.com>
 <alpine.DEB.2.11.1606221037310.5839@nanos>
 <20160622102858.GA13962@rei.lan>
 <alpine.DEB.2.11.1606231024220.5839@nanos>
Message-ID: <20160623114759.GA19250@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > While this is true, checking with reasonable error margin works just
> > fine 99% of the time. You cannot really test that timer expires, without
> > setting arbitrary margin.
> 
> Err. You know that the timer expired because sigtimedwait() returns
> EAGAIN. And the only thing you can reliably check for is that the timer did
> not expired to early. Anything else is guesswork and voodoo programming.

There is quite a lot of things that can happen on mutitasking OS and
there are even NMIs in hardware, etc. But seriously is there a reason
why OS that is not under heavy load cannot expire timers with reasonable
overruns? I.e. if I ask for a second of sleep and expect it to be woken
up not much more than half of a second later?

If we stick only to guarantees that are defined in POSIX playing music
with mplayer would not be possible since it sleeps in futex() and if it
wakes too late it will fail to fill buffers. In practice this worked
fine for me for years.

-- 
Cyril Hrubis
chrubis@suse.cz
