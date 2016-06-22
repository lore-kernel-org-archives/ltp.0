From: Mike Galbraith <umgwanakikbuti@gmail.com>
Date: Wed, 22 Jun 2016 15:37:47 +0200
Subject: [LTP] [patch V2 00/20] timer: Refactor the timer wheel
In-Reply-To: <1466586367.3188.45.camel@gmail.com>
References: <20160617121134.417319325@linutronix.de>
 <1466581044.3188.34.camel@gmail.com>
 <alpine.DEB.2.11.1606221037310.5839@nanos>
 <1466586367.3188.45.camel@gmail.com>
Message-ID: <1466602667.3188.63.camel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2016-06-22 at 11:06 +0200, Mike Galbraith wrote:
> On Wed, 2016-06-22 at 10:44 +0200, Thomas Gleixner wrote:
> > B1;2802;0cOn Wed, 22 Jun 2016, Mike Galbraith wrote:
> > > FWIW, testing with ltp, I noticed a new failure in logs.  It turns
> > out
> > > to be intermittent, but the testcase mostly fails.
> > 
> > You forgot to cc the LTP folks ...
> 
> This ain't the only one, it's just new.  I'll mention it.
>  
> File under FYI/FWIW: I also plugged the set into RT, and nothing fell
> out of local boxen.  The below is falling out of my 8 socket box
> though.. maybe a portage booboo.
> 
> [ 1503.988863] clocksource: timekeeping watchdog on CPU42: Marking clocksource 'tsc' as unstable because the skew is too large:
> [ 1504.203800] clocksource:                       'hpet' wd_now: 38b55bb wd_last: 8303f269 mask: ffffffff
> [ 1504.296111] clocksource:                       'tsc' cs_now: 3a3aa717794 cs_last: 354624eea7b mask: ffffffffffffffff
> [ 1504.402329] clocksource: Switched to clocksource hpet

Nope, not RT portage booboo.  Virgin x86-tip/WIP.timers..

vogelweide:~/:[130]# dmesg|grep clocksource:
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    5.608205] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    9.151208] clocksource: Switched to clocksource hpet
[    9.485907] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   11.947226] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x20974986637, max_idle_ns: 440795286310 ns
[   13.012145] clocksource: Switched to clocksource tsc
[  434.868215] clocksource: timekeeping watchdog on CPU59: Marking clocksource 'tsc' as unstable because the skew is too large:
[  434.982251] clocksource:                       'hpet' wd_now: 732cdf37 wd_last: df3d99d8 mask: ffffffff
[  435.085875] clocksource:                       'tsc' cs_now: 16e6780d1eb cs_last: 11326fa576e mask: ffffffffffffffff
[  435.211249] clocksource: Switched to clocksource hpet
vogelweide:~/:[0]#
