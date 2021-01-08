From: Cixi Geng <gengcixi@gmail.com>
Date: Fri, 8 Jan 2021 17:45:12 +0800
Subject: [LTP] [PATCH 2/3] lib: implement rtctime_save and
 rtctime_restore function
In-Reply-To: <X/gnOarZhZhOy+mQ@yuki.lan>
References: <20201223033517.1464263-1-gengcixi@gmail.com>
 <20201223033517.1464263-3-gengcixi@gmail.com>
 <X/cTWFNvtJ5NCyOh@yuki.lan>
 <CAF12kFvhp0sVfrX9Rhe2XumZPVCA_em51UVr2QkiHOpECC4mDg@mail.gmail.com>
 <X/gnOarZhZhOy+mQ@yuki.lan>
Message-ID: <CAF12kFtRGVW3z4-xCAJruoHWOSRtVh0wq+1xiQ--hm2pQDj8Wg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> ?2021?1?8??? ??5:33???
>
> Hi!
> > > > +void tst_rtctime_restore(void)
> > > > +{
> > > > +     static struct timespec mono_end, elapsed;
> > > > +     static struct timespec rtc_begin_tm, rtc_adjust;
> > > > +     static struct rtc_time rtc_restore;
> > > > +
> > > > +     if (!clock_saved)
> > > > +             return;
> > > > +
> > > > +     clock_saved = 0;
> > > > +
> > > > +     if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end))
> > > > +             tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
> > > > +
> > > > +     elapsed = tst_timespec_diff(mono_end, mono_begin);
> > > > +
> > > > +     rtc_begin_tm.tv_sec = tst_rtc_tm_to_time(&rtc_begin);
> > >
> > > We should clear the tv_nsec here otherwise it will contain garbage.
> > The rtc_begin_tm is defined in this function??? and tv_nsec never assigned???
> > so I think it will not produce any garbage.
>
> It's never assigned and declared on stack, so it will contain garbage
> which will be eventually added to the rtc_adjust.tv_sec. Technically
> the tv_nsec is long, so on 64 bit platform it may add up to 10^10
> seconds to the result if we are unlucky and upper bits are set. On 32
> bit there is not much room for error btw, up to 2 seconds since long is
> only 4bytes there.
>

ok,I got it, thanks for you explain, I will fixed this issue

> > > > +     rtc_adjust = tst_timespec_add(rtc_begin_tm, elapsed);
> > > > +
> > > > +     tst_rtc_time_to_tm(rtc_adjust.tv_sec, &rtc_restore);
> > > > +
> > > > +     /* restore realtime clock based on monotonic delta */
> > > > +     if (tst_rtc_settime(&rtc_restore))
> > > > +             tst_brk(TBROK | TERRNO, "tst_rtc_settime() realtime failed");
> > > > +}
> > >
> > > Other than this, it looks good.
> > >
> > > --
> > > Cyril Hrubis
> > > chrubis@suse.cz
>
> --
> Cyril Hrubis
> chrubis@suse.cz
