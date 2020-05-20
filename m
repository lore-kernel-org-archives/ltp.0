From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 20 May 2020 12:49:48 +0530
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall()
 unnecessarily
In-Reply-To: <20200519134511.GD16008@yuki.lan>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
 <20200519122347.GC16008@yuki.lan>
 <CAK8P3a2PgjYyijH=VoNGhs_xk1VvFN6ZNvNM-W4TopWY6jJNbA@mail.gmail.com>
 <20200519134511.GD16008@yuki.lan>
Message-ID: <20200520071948.qtuzbfesqvcnsizd@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19-05-20, 15:45, Cyril Hrubis wrote:
> Hi!
> > > > -     tst_clock_gettime(CLOCK_MONOTONIC, &ts);
> > > > +     clock_gettime(CLOCK_MONOTONIC, &ts);
> > >
> > > I guess that this will reintroduce LTP compilation failures on older
> > > glibc, which was the primary reason we used the tst_clock_gettime()
> > > instead of clock_gettime().
> > 
> > I see that clock_gettime was first added in glibc-2.1.3 back in 1999.
> > Can that actually run LTP any more? If it can and this is considered
> > important, I fear the tst_clock_gettime() call needs to be extended
> > to call the clock_gettime()/clock_gettime64()/gettimeofday() syscalls,
> > whichever is the first to work, and convert the formats from the
> > native kernel format to the glibc format.
> 
> I guess that at the current time we do support distros that are at max
> 10 years old, mostly because enterprise support cycles are about 10
> years in lenght.
> 
> The issue here is that glibc needed -lrt passed to linker couple of
> years ago and we wanted to avoid the need of linking everything with
> -lrt, as calling the raw syscall was just easier fix.

To conclude the discussion, is this patch okay or not ? The reason why I am
asking this is because this file still uses the old test framework and so can't
include tst_timer.h, and so doesn't have access to struct __kernel_old_timespec.

What do you suggest I do here ?

-- 
viresh
