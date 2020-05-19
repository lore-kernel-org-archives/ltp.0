From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 May 2020 15:45:11 +0200
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall()
 unnecessarily
In-Reply-To: <CAK8P3a2PgjYyijH=VoNGhs_xk1VvFN6ZNvNM-W4TopWY6jJNbA@mail.gmail.com>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
 <20200519122347.GC16008@yuki.lan>
 <CAK8P3a2PgjYyijH=VoNGhs_xk1VvFN6ZNvNM-W4TopWY6jJNbA@mail.gmail.com>
Message-ID: <20200519134511.GD16008@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > -     tst_clock_gettime(CLOCK_MONOTONIC, &ts);
> > > +     clock_gettime(CLOCK_MONOTONIC, &ts);
> >
> > I guess that this will reintroduce LTP compilation failures on older
> > glibc, which was the primary reason we used the tst_clock_gettime()
> > instead of clock_gettime().
> 
> I see that clock_gettime was first added in glibc-2.1.3 back in 1999.
> Can that actually run LTP any more? If it can and this is considered
> important, I fear the tst_clock_gettime() call needs to be extended
> to call the clock_gettime()/clock_gettime64()/gettimeofday() syscalls,
> whichever is the first to work, and convert the formats from the
> native kernel format to the glibc format.

I guess that at the current time we do support distros that are at max
10 years old, mostly because enterprise support cycles are about 10
years in lenght.

The issue here is that glibc needed -lrt passed to linker couple of
years ago and we wanted to avoid the need of linking everything with
-lrt, as calling the raw syscall was just easier fix.

-- 
Cyril Hrubis
chrubis@suse.cz
