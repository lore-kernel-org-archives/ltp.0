From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 14 May 2020 11:08:36 +0530
Subject: [LTP] [PATCH] syscalls: Fix issues around calling syscalls with
 old timespec
In-Reply-To: <20200513125428.GA15868@dell5510>
References: <437d6fd3926de4c801ae0edb2379c6afafcb34d4.1589190284.git.viresh.kumar@linaro.org>
 <20200513113318.GA25472@dell5510>
 <20200513114239.roy5hqu26lm2of4l@vireshk-i7>
 <20200513125428.GA15868@dell5510>
Message-ID: <20200514053836.c45c4jhp4hwgiik4@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13-05-20, 14:54, Petr Vorel wrote:
> Hi Viresh,
> 
> > > >  #ifndef __kernel_timex
> > > > +#if defined(__x86_64__) && defined(__ILP32__)
> > > > +typedef long long __kernel_long_t;
> > > > +#else
> > > > +typedef long __kernel_long_t;
> > > > +#endif
> > > > +
> > > > +typedef __kernel_long_t	__kernel_old_time_t;
> 
> > > It's caused by this fallback definition ^, which is already in
> > > include/tst_timer.h. Simple deleting it should fix the problem
> 
> > But tst_timer.h isn't included here in clock_adjtime at all. What's
> tst_timer.h has been included in clock_adjtime.h since 5085e14c7e

And I missed that completely :(

-- 
viresh
