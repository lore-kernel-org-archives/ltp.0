From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 4 Aug 2020 18:07:13 +0530
Subject: [LTP] [PATCH V7 19/19] syscalls: clock_settime: Add test around
 y2038 vulnerability
In-Reply-To: <20200728121113.GA2412@yuki.lan>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <5b16889b19e969b79fa7d46c533bb5989ace1e46.1593152309.git.viresh.kumar@linaro.org>
 <20200728121113.GA2412@yuki.lan>
Message-ID: <20200804123713.kbflzyhwhq6cinga@vireshk-mac-ubuntu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28-07-20, 14:11, Cyril Hrubis wrote:
> Hi!
> > +++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
> > +static void setup(void)
> > +{
> > +	struct test_variants *tv = &variants[tst_variant];
> > +
> > +	tst_res(TINFO, "Testing variant: %s", tv->desc);
> > +	start.type = end.type = its.type = tv->type;
> > +
> > +	/* Check if the kernel is y2038 safe */
> > +	if (tv->type != TST_KERN_OLD_TIMESPEC &&

Wow!

> > +	    sizeof(start.ts.kern_old_ts) == 8)
> 
> Huh, what exactly are we trying to assert here? First of all we make
> sure we are not using KERN_OLD_TIMESPEC and then check it's size?
> 
> Shouldn't it be tv->type == TST_KERNL_OLD_TIMESPEC && sizeof(start.ts.kern_old_ts) != 8?
> That way we would abort if the old timespec is not 64bit which would
> make a bit more sense to me.

Yeah, thanks for noticing this. I kept it like that throughout the
discussion with Arnd and finally made the mistake while sending the
patch :(

-- 
viresh
