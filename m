From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2020 14:54:28 +0200
Subject: [LTP] [PATCH] syscalls: Fix issues around calling syscalls with
 old timespec
In-Reply-To: <20200513114239.roy5hqu26lm2of4l@vireshk-i7>
References: <437d6fd3926de4c801ae0edb2379c6afafcb34d4.1589190284.git.viresh.kumar@linaro.org>
 <20200513113318.GA25472@dell5510>
 <20200513114239.roy5hqu26lm2of4l@vireshk-i7>
Message-ID: <20200513125428.GA15868@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> > >  #ifndef __kernel_timex
> > > +#if defined(__x86_64__) && defined(__ILP32__)
> > > +typedef long long __kernel_long_t;
> > > +#else
> > > +typedef long __kernel_long_t;
> > > +#endif
> > > +
> > > +typedef __kernel_long_t	__kernel_old_time_t;

> > It's caused by this fallback definition ^, which is already in
> > include/tst_timer.h. Simple deleting it should fix the problem

> But tst_timer.h isn't included here in clock_adjtime at all. What's
tst_timer.h has been included in clock_adjtime.h since 5085e14c7e

> special with Centos that failure is seen there only ?
> Any idea ?

Not sure why it's only for old CentOS 6. Usually there is some bug in the
headers (conflicting headers which has been fixed in newer distros) or something
simply missing.
And we should really drop CentOS 6 from travis CI, we agreed to discontinue gcc
4 support (10 years old). But I wanted to drop it after the release.

BTW typedef long long __kernel_long_t; is in <asm/posix_types_x32.h>
which you include via <asm/posix_types.h>. But redefining typedef is not a
problem.

Kind regards,
Petr
