From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 25 Jun 2020 16:40:17 +0530
Subject: [LTP] [PATCH V6 01/17] syscalls/timer_gettime: Add support for
 time64 tests
In-Reply-To: <20200625110751.GB23637@yuki.lan>
References: <a4a628a637a6eeeed4249656836bd217f5cbb9ac.1590144577.git.viresh.kumar@linaro.org>
 <9621b4f97b539f2e080b00491eb9ba4973878028.1591760262.git.viresh.kumar@linaro.org>
 <20200624142327.GA5181@yuki.lan>
 <20200625095006.d6ndameqblecadp4@vireshk-i7>
 <20200625110751.GB23637@yuki.lan>
Message-ID: <20200625111017.5yjsqi56u6q3u3s2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25-06-20, 13:07, Cyril Hrubis wrote:
> >         TEST(tv->func(timer, tst_its_get(&spec)));
> >         if (TST_RET == 0) {
> > -               tst_res(TPASS, "timer_gettime() Passed");
> > +               if ((spec.type == TST_KERN_OLD_TIMESPEC &&
> > +                       (spec.ts.kern_old_its.it_interval.tv_sec ||
> > +                        spec.ts.kern_old_its.it_interval.tv_nsec ||
> > +                        spec.ts.kern_old_its.it_value.tv_sec ||
> > +                        spec.ts.kern_old_its.it_value.tv_nsec)) ||
> > +                   (spec.type == TST_KERN_TIMESPEC &&
> > +                       (spec.ts.kern_its.it_interval.tv_sec ||
> > +                        spec.ts.kern_its.it_interval.tv_nsec ||
> > +                        spec.ts.kern_its.it_value.tv_sec ||
> > +                        spec.ts.kern_its.it_value.tv_nsec)))
> > +                       tst_res(TFAIL, "timespec should have been zeroed");
> 
> Indeed that's what I had in mind, can we please abstract this properly
> as well? I guess that we can add helpers such as tst_its_interval_sec()
> tst_its_inverval_nsec, etc.

I preferred it this way as no one else uses it and so maybe we can
live without adding those helpers ?

-- 
viresh
