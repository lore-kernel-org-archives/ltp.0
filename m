From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 9 Jun 2020 09:43:22 +0200
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <20200609070535.iym6m5n2v5urykbc@vireshk-i7>
References: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
 <CAK8P3a0b2BbZq_yYBKJHUfZgzCYUtdidpzJEj-HzuBKf1Q_nnQ@mail.gmail.com>
 <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
 <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
 <20200608112000.sjrbvmqjciifgyub@vireshk-i7>
 <CAK8P3a0PqtFWTZr9hvSy5Y0ZZOSNgfzw0x1DTTyuzfsfROpAvw@mail.gmail.com>
 <20200609070535.iym6m5n2v5urykbc@vireshk-i7>
Message-ID: <CAK8P3a0giS2A=4Hc4SO7cVn_nOU4rz-KzbSkQJcddM2Hc=KRxg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 9, 2020 at 9:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-06-20, 16:51, Arnd Bergmann wrote:
> > You already have a special case for gettimeofday(), so just round down
> > the 'start' value to the previous microsecond when you are in that
> > case.
>
> Since this will also affect the next reading as well (as we will loose
> values < 1 us), I tried to do it a bit differently.
>
> @@ -78,6 +78,13 @@ static void run(unsigned int i)
>                         tv->gettime(clks[i], tst_ts_get(&ts));
>                         end = tst_ts_to_ns(ts);
>
> +                       /*
> +                        * gettimeofday() doesn't value less than 1 us, copy
> +                        * that from start.
> +                        */
> +                       if (tv->gettime == my_gettimeofday && end < start)
> +                               end += start % 1000;

This looks like it should work correctly, but it feels a bit more fragile than

                       if (tv->gettime == my_gettimeofday)
                               start -= start % 1000;

which would bring the start and end values to the same resolution
rather than making up values that were never read.

Your approach however has the advantage of adding less overhead
as the % operator on a 64-bit integer is going to turn into a very
expensive calculation on most 32-bit processors that itself can
skew the timing.

> > > +                       /* Skip comparison on first traversal */
> > > +                       if (count == 10000 && !j)
> > > +                               continue;
>
> I am skipping diff for the first iteration..
>
> > > +
> > > +                       diff = end - start;
> >
> > I think on the first iteration, 'start' is wrong here as well, and needs to
> > be initialized once, as you did in the earlier versions.
>
> And so this won't be a problem.

Ok.

        Arnd
