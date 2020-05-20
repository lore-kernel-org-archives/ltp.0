From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 20 May 2020 10:10:56 +0530
Subject: [LTP] [PATCH 1/1] C API: Turn .test_variants into array of
 description
In-Reply-To: <20200519140704.GE16008@yuki.lan>
References: <20200519120725.25750-1-pvorel@suse.cz>
 <20200519140704.GE16008@yuki.lan>
Message-ID: <20200520044056.z67p66mubpok23gi@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19-05-20, 16:07, Cyril Hrubis wrote:
> Hi!
> > diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
> > index 061b2bb22..40dae4b24 100644
> > --- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
> > +++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
> > @@ -107,14 +107,12 @@ struct test_case tc[] = {
> >  static struct test_variants {
> >  	int (*clock_adjtime)(clockid_t clk_id, void *timex);
> >  	enum tst_timex_type type;
> > -	char *desc;
> >  } variants[] = {
> >  #if (__NR_clock_adjtime != __LTP__NR_INVALID_SYSCALL)
> > -	{.clock_adjtime = sys_clock_adjtime, .type = TST_KERN_OLD_TIMEX, .desc = "syscall with old kernel spec"},
> > +	{.clock_adjtime = sys_clock_adjtime, .type = TST_KERN_OLD_TIMEX},
> >  #endif
> > -
> >  #if (__NR_clock_adjtime64 != __LTP__NR_INVALID_SYSCALL)
> > -	{.clock_adjtime = sys_clock_adjtime64, .type = TST_KERN_TIMEX, .desc = "syscall time64 with kernel spec"},
> > +	{.clock_adjtime = sys_clock_adjtime64, .type = TST_KERN_TIMEX},
> >  #endif
> >  };
> >  
> > @@ -188,8 +186,6 @@ static void setup(void)
> >  	size_t i;
> >  	int rval;
> >  
> > -	tst_res(TINFO, "Testing variant: %s", tv->desc);
> > -
> >  	saved.type = tv->type;
> >  	rval = tv->clock_adjtime(CLOCK_REALTIME, tst_timex_get(&saved));
> >  	if (rval < 0) {
> > @@ -257,7 +253,15 @@ static struct tst_test test = {
> >  	.setup = setup,
> >  	.cleanup = cleanup,
> >  	.tcnt = ARRAY_SIZE(tc),
> > -	.test_variants = ARRAY_SIZE(variants),
> > +	.test_variants = (const char *[]) {
> > +#if (__NR_clock_adjtime != __LTP__NR_INVALID_SYSCALL)
> > +		"syscall with old kernel spec",
> > +#endif
> > +#if (__NR_clock_adjtime64 != __LTP__NR_INVALID_SYSCALL)
> > +		"syscall time64 with kernel spec",
> > +#endif
> > +		NULL
> > +	},
> 
> I do not think that having more ifdefs and splitting the test variant
> structure helps to make things simple in the case of timer testcases.
> 
> What exact problem are you trying to solve?

This is exactly what I thought about this when I saw the patch, and then also
the problem of syncing two different arrays with their names (specially in my
tests).

-- 
viresh
