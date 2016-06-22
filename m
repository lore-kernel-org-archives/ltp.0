From: Mike Galbraith <umgwanakikbuti@gmail.com>
Date: Wed, 22 Jun 2016 11:06:07 +0200
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <alpine.DEB.2.11.1606221037310.5839@nanos>
References: <20160617121134.417319325@linutronix.de>
 <1466581044.3188.34.camel@gmail.com>
 <alpine.DEB.2.11.1606221037310.5839@nanos>
Message-ID: <1466586367.3188.45.camel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2016-06-22 at 10:44 +0200, Thomas Gleixner wrote:
> B1;2802;0cOn Wed, 22 Jun 2016, Mike Galbraith wrote:
> > FWIW, testing with ltp, I noticed a new failure in logs.  It turns
> out
> > to be intermittent, but the testcase mostly fails.
> 
> You forgot to cc the LTP folks ...

This ain't the only one, it's just new.  I'll mention it.
 
File under FYI/FWIW: I also plugged the set into RT, and nothing fell
out of local boxen.  The below is falling out of my 8 socket box
though.. maybe a portage booboo.

[ 1503.988863] clocksource: timekeeping watchdog on CPU42: Marking clocksource 'tsc' as unstable because the skew is too large:
[ 1504.203800] clocksource:                       'hpet' wd_now: 38b55bb wd_last: 8303f269 mask: ffffffff
[ 1504.296111] clocksource:                       'tsc' cs_now: 3a3aa717794 cs_last: 354624eea7b mask: ffffffffffffffff
[ 1504.402329] clocksource: Switched to clocksource hpet
