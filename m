From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 6 Jul 2020 17:06:42 +0530
Subject: [LTP] [PATCH V7 07/19] syscalls/futex: Add support for time64
 tests
In-Reply-To: <20200706104033.6vk7eqmcdxtqbnjn@vireshk-i7>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <6030fa8c1deda3aab977c7d5745c117fda87708a.1593152309.git.viresh.kumar@linaro.org>
 <20200703124548.GB2308@yuki.lan>
 <20200706104033.6vk7eqmcdxtqbnjn@vireshk-i7>
Message-ID: <20200706113642.kfnxrbqvae4qx4hb@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06-07-20, 16:10, Viresh Kumar wrote:
> On 03-07-20, 14:45, Cyril Hrubis wrote:
> > > diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
> > > index 2573ae177d5b..8fad5d858716 100644
> > > --- a/testcases/kernel/syscalls/futex/futex_wait05.c
> > > +++ b/testcases/kernel/syscalls/futex/futex_wait05.c
> > > @@ -19,7 +19,7 @@ int sample_fn(int clk_id, long long usec)
> > >  	futex_t futex = FUTEX_INITIALIZER;
> > >  
> > >  	tst_timer_start(clk_id);
> > > -	TEST(futex_wait(&futex, futex, &to, 0));
> > > +	TEST(syscall(SYS_futex, &futex, FUTEX_WAIT, futex, &to, NULL, 0));
> > >  	tst_timer_stop();
> > >  	tst_timer_sample();
> > 
> > Why aren't we adding the two functions here as well?
> 
> I am not sure which two functions are you talking about here ..
> 
> > Is the timer library incompatible with test variants?

I kept staring at this code and your comment and may have understood
finally :)

I haven't added futex variants here as this uses the _sample_
callback, which works with the simple timer code in LTP and as I
remember from some earlier discussion, that would be a lot of changes
and may not be worth it.

-- 
viresh
