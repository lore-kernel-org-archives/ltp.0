From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 9 Jun 2020 10:51:49 +0200
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <20200609083219.5473zf2tq4tmjxac@vireshk-i7>
References: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
 <CAK8P3a0b2BbZq_yYBKJHUfZgzCYUtdidpzJEj-HzuBKf1Q_nnQ@mail.gmail.com>
 <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
 <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
 <20200608112000.sjrbvmqjciifgyub@vireshk-i7>
 <CAK8P3a0PqtFWTZr9hvSy5Y0ZZOSNgfzw0x1DTTyuzfsfROpAvw@mail.gmail.com>
 <20200609070535.iym6m5n2v5urykbc@vireshk-i7>
 <CAK8P3a0giS2A=4Hc4SO7cVn_nOU4rz-KzbSkQJcddM2Hc=KRxg@mail.gmail.com>
 <20200609083219.5473zf2tq4tmjxac@vireshk-i7>
Message-ID: <CAK8P3a2BaLtcyyfNQUJq-gvO6C_53hvLaNhajcpREwqHCEBYqg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 9, 2020 at 10:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 09-06-20, 09:43, Arnd Bergmann wrote:
> > On Tue, Jun 9, 2020 at 9:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 08-06-20, 16:51, Arnd Bergmann wrote:
> > > > You already have a special case for gettimeofday(), so just round down
> > > > the 'start' value to the previous microsecond when you are in that
> > > > case.
> > >
> > > Since this will also affect the next reading as well (as we will loose
> > > values < 1 us), I tried to do it a bit differently.
> > >
> > > @@ -78,6 +78,13 @@ static void run(unsigned int i)
> > >                         tv->gettime(clks[i], tst_ts_get(&ts));
> > >                         end = tst_ts_to_ns(ts);
> > >
> > > +                       /*
> > > +                        * gettimeofday() doesn't value less than 1 us, copy
> > > +                        * that from start.
> > > +                        */
> > > +                       if (tv->gettime == my_gettimeofday && end < start)
> > > +                               end += start % 1000;
> >
> > This looks like it should work correctly, but it feels a bit more fragile than
> >
> >                        if (tv->gettime == my_gettimeofday)
> >                                start -= start % 1000;
> >
> > which would bring the start and end values to the same resolution
> > rather than making up values that were never read.
>
> This sounds better, will pick it up.
>
> > Your approach however has the advantage of adding less overhead
> > as the % operator on a 64-bit integer is going to turn into a very
> > expensive calculation on most 32-bit processors that itself can
> > skew the timing.
>
> I am not sure of what you meant here, both the approaches are using
> the % operation.

Yours only needs it when the nanoseconds are actually lower, which
is only the case if no the actual time has not crossed into the next
microsecond. If the gettimeofday() call itself takes over a microsecond
to complete, then it usually will have wrapped, but this is highly
hardware specific as the amount of time it takes to read the current
clock registers can be anywhere from 'almost free' to 'several
microseconds'.

Doing a division would be the same as the modulo operator.

Using a 32-bit modulo or division on the tv_nsec portion instead
of doing it on the 64-bit nanoseconds is much faster but also
a little more complex.

Another option would be to allow up to 999 nanoseconds of
time going backwards before printing an error for the case
of gettimeofday() after clock_gettime(), like

if ((tv->gettime == my_gettimeofday)
    slack = 999;
else
    slack = 0;

if (start + slack < end)
      failure();

This is much faster as it avoids the division but does not catch
the corner case of gettimeofday() returning a value that is
slightly before the previous clock_gettime() but that is actually
in the previous microsecond interval.

     Arnd
