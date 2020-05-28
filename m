From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 28 May 2020 12:47:15 +0200
Subject: [LTP] [PATCH V2] syscalls: clock_settime: Add test around y2038
 vulnerability
In-Reply-To: <20200528103506.rlchdwf2yppl7fhz@vireshk-i7>
References: <70417fdc55c750e8b13d7124e66a7e8a59182e75.1590494889.git.viresh.kumar@linaro.org>
 <86a36c7d5919a966e077cb76f0d8710f31bcc60a.1590649002.git.viresh.kumar@linaro.org>
 <CAK8P3a11aWYdBtgV=T91_BOVR_hX-OZTAVhr806nbTFtCE+3MQ@mail.gmail.com>
 <20200528091148.3afrkdjqzjer4vqh@vireshk-i7>
 <CAK8P3a3Y4P-aLCEYmYiLGqNcccyXCcGfHJkoPAEzxFz8p2yocw@mail.gmail.com>
 <20200528103506.rlchdwf2yppl7fhz@vireshk-i7>
Message-ID: <CAK8P3a3MVuNa32ATv+b8pnOAHBPd8+zfukm0bzy6bB3O21BT6A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 28, 2020 at 12:35 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-05-20, 11:31, Arnd Bergmann wrote:
> > On Thu, May 28, 2020 at 11:11 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 28-05-20, 10:27, Arnd Bergmann wrote:
> > > > On Thu, May 28, 2020 at 8:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > > +       ret = tv->clock_settime(CLOCK_REALTIME, tst_ts_get(&ts));
> > > > > +       if (ret == -1)
> > > > > +               tst_brk(TBROK | TERRNO, "clock_settime() failed");
> > >
> > > But I noticed that even this version may not be good enough, as I am
> > > still doing the same thing in setup(), i.e. setting time to just
> > > before y2038 to test if it is y2038 safe or not. I believe even that
> > > isn't fine ?
> >
> > Good point. I see you have this check above that:
> >
> > +       /* Check if the kernel is y2038 safe */
> > +       if (tv->type != TST_KERN_OLD_TIMESPEC)
> > +               return;
> > +
> >
> > So that part should prevent it from doing something bad,
>
> Not really. That code is part of the setup() routine and with "return"
> we will go and run the actual test run(). That code is there to avoid
> running the code on time64 implementation unnecessarily.

Ok, I see.

> > but I now
> > see it's still not great because it also prevents the test case from running
> > on 64-bit architectures. If you change the condition to also check for
> > sizeof(__kernel_old_timespec) it should be ok.
>
> What about this instead of the whole setup() changes:
>
>        /* Check if the kernel is y2038 safe */
>        if (tv->type == TST_KERN_OLD_TIMESPEC &&
>            sizeof(__kernel_old_timespec) == 8)
>                tst_brk("Invalid configuration");

Sounds good, as long as this only stops the clock_settime() run
and not all variants including the clock_settim64() one.

         Arnd
