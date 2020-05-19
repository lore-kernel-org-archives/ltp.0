From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 May 2020 14:56:18 +0200
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall()
 unnecessarily
In-Reply-To: <CAK8P3a2PgjYyijH=VoNGhs_xk1VvFN6ZNvNM-W4TopWY6jJNbA@mail.gmail.com>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
 <20200519122347.GC16008@yuki.lan>
 <CAK8P3a2PgjYyijH=VoNGhs_xk1VvFN6ZNvNM-W4TopWY6jJNbA@mail.gmail.com>
Message-ID: <20200519125618.GA29373@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > -     tst_clock_gettime(CLOCK_MONOTONIC, &ts);
> > > +     clock_gettime(CLOCK_MONOTONIC, &ts);

> > I guess that this will reintroduce LTP compilation failures on older
> > glibc, which was the primary reason we used the tst_clock_gettime()
> > instead of clock_gettime().

> I see that clock_gettime was first added in glibc-2.1.3 back in 1999.
> Can that actually run LTP any more? If it can and this is considered
> important, I fear the tst_clock_gettime() call needs to be extended
> to call the clock_gettime()/clock_gettime64()/gettimeofday() syscalls,
> whichever is the first to work, and convert the formats from the
> native kernel format to the glibc format.
IMHO the older system we still test in Travis (but going to remove it soon) is
CentOS 6 (kernel 3.10, glibc 2.12, gcc 4.4.7). I suspect that it was needed this
system (e.g. system with old glibc and gcc; gcc required some fixes which
bothered me, but old glibc actually caught some bugs in fallback which we
wouldn't otherwise find). Or am I wrong?

We agreed (few LTP maintainers), that, at least for SUSE and Red Hat is ok to
drop support for distros 10+ years, because these systems are tested with some
older LTP release anyway.

>          Arnd

Kind regards,
Petr
