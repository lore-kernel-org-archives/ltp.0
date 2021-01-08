From: Cixi Geng <gengcixi@gmail.com>
Date: Fri, 8 Jan 2021 17:19:38 +0800
Subject: [LTP] [PATCH 2/3] lib: implement rtctime_save and
 rtctime_restore function
In-Reply-To: <X/cTWFNvtJ5NCyOh@yuki.lan>
References: <20201223033517.1464263-1-gengcixi@gmail.com>
 <20201223033517.1464263-3-gengcixi@gmail.com>
 <X/cTWFNvtJ5NCyOh@yuki.lan>
Message-ID: <CAF12kFvhp0sVfrX9Rhe2XumZPVCA_em51UVr2QkiHOpECC4mDg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> ?2021?1?7??? ??9:56???
>
> >  static struct timespec real_begin, mono_begin;
> >
> > +static struct rtc_time rtc_begin;
> > +
> >  static int clock_saved;
> >
> >  void tst_wallclock_save(void)
> > @@ -58,3 +61,42 @@ void tst_wallclock_restore(void)
> >       if (tst_clock_settime(CLOCK_REALTIME, &adjust))
> >               tst_brk(TBROK | TERRNO, "tst_clock_settime() realtime failed");
> >  }
> > +
> > +void tst_rtctime_save(void)
> > +{
> > +     /* save initial monotonic time to restore it when needed */
> > +     if (tst_rtc_gettime(&rtc_begin))
> > +             tst_brk(TBROK | TERRNO, "tst_rtc_gettime() realtime failed");
> > +
> > +     if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin))
> > +             tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
> > +
> > +     clock_saved = 1;
>
> It would be better if we defined rtc_clock_saved for the rtc* functions
> instead.
>
> > +}
> > +
> > +void tst_rtctime_restore(void)
> > +{
> > +     static struct timespec mono_end, elapsed;
> > +     static struct timespec rtc_begin_tm, rtc_adjust;
> > +     static struct rtc_time rtc_restore;
> > +
> > +     if (!clock_saved)
> > +             return;
> > +
> > +     clock_saved = 0;
> > +
> > +     if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end))
> > +             tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
> > +
> > +     elapsed = tst_timespec_diff(mono_end, mono_begin);
> > +
> > +     rtc_begin_tm.tv_sec = tst_rtc_tm_to_time(&rtc_begin);
>
> We should clear the tv_nsec here otherwise it will contain garbage.
The rtc_begin_tm is defined in this function? and tv_nsec never assigned?
so I think it will not produce any garbage.
>
> > +     rtc_adjust = tst_timespec_add(rtc_begin_tm, elapsed);
> > +
> > +     tst_rtc_time_to_tm(rtc_adjust.tv_sec, &rtc_restore);
> > +
> > +     /* restore realtime clock based on monotonic delta */
> > +     if (tst_rtc_settime(&rtc_restore))
> > +             tst_brk(TBROK | TERRNO, "tst_rtc_settime() realtime failed");
> > +}
>
> Other than this, it looks good.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
