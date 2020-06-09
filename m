From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 9 Jun 2020 14:02:19 +0530
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <CAK8P3a0giS2A=4Hc4SO7cVn_nOU4rz-KzbSkQJcddM2Hc=KRxg@mail.gmail.com>
References: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
 <CAK8P3a0b2BbZq_yYBKJHUfZgzCYUtdidpzJEj-HzuBKf1Q_nnQ@mail.gmail.com>
 <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
 <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
 <20200608112000.sjrbvmqjciifgyub@vireshk-i7>
 <CAK8P3a0PqtFWTZr9hvSy5Y0ZZOSNgfzw0x1DTTyuzfsfROpAvw@mail.gmail.com>
 <20200609070535.iym6m5n2v5urykbc@vireshk-i7>
 <CAK8P3a0giS2A=4Hc4SO7cVn_nOU4rz-KzbSkQJcddM2Hc=KRxg@mail.gmail.com>
Message-ID: <20200609083219.5473zf2tq4tmjxac@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09-06-20, 09:43, Arnd Bergmann wrote:
> On Tue, Jun 9, 2020 at 9:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 08-06-20, 16:51, Arnd Bergmann wrote:
> > > You already have a special case for gettimeofday(), so just round down
> > > the 'start' value to the previous microsecond when you are in that
> > > case.
> >
> > Since this will also affect the next reading as well (as we will loose
> > values < 1 us), I tried to do it a bit differently.
> >
> > @@ -78,6 +78,13 @@ static void run(unsigned int i)
> >                         tv->gettime(clks[i], tst_ts_get(&ts));
> >                         end = tst_ts_to_ns(ts);
> >
> > +                       /*
> > +                        * gettimeofday() doesn't value less than 1 us, copy
> > +                        * that from start.
> > +                        */
> > +                       if (tv->gettime == my_gettimeofday && end < start)
> > +                               end += start % 1000;
> 
> This looks like it should work correctly, but it feels a bit more fragile than
> 
>                        if (tv->gettime == my_gettimeofday)
>                                start -= start % 1000;
> 
> which would bring the start and end values to the same resolution
> rather than making up values that were never read.

This sounds better, will pick it up.

> Your approach however has the advantage of adding less overhead
> as the % operator on a 64-bit integer is going to turn into a very
> expensive calculation on most 32-bit processors that itself can
> skew the timing.

I am not sure of what you meant here, both the approaches are using
the % operation.

-- 
viresh
