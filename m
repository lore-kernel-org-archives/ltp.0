From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 12 Oct 2019 02:49:20 -0400 (EDT)
Subject: [LTP] [PATCH v2] read_all: retry to queue work for any worker
In-Reply-To: <CAEemH2f2_5wNfNB=a-+=E+KevFOVvjCQ0sjBEG-eS27dwQxarw@mail.gmail.com>
References: <26d555b1d9deddb5a6f0a93a7c7d3b00e8abc1ff.1570616598.git.jstancek@redhat.com>
 <8c5d507fd19bc3110561ed1c666b7ac47442e09e.1570632125.git.jstancek@redhat.com>
 <CAEemH2d82pP2mwHnw42h-17HipGsVeYesfzg7o4axvCiRKU0=Q@mail.gmail.com>
 <CAEemH2eYc1VVtavWKTE-x1gqY6q7qyMVZ-bETXJytPkdvHJriw@mail.gmail.com>
 <1445930938.5951899.1570861051806.JavaMail.zimbra@redhat.com>
 <CAEemH2f2_5wNfNB=a-+=E+KevFOVvjCQ0sjBEG-eS27dwQxarw@mail.gmail.com>
Message-ID: <23965038.5952515.1570862960195.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On Sat, Oct 12, 2019 at 2:17 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> >
> > ----- Original Message -----
> > > Hi Jan,
> > >
> > > On Fri, Oct 11, 2019 at 4:24 PM Li Wang <liwang@redhat.com> wrote:
> > >
> > > >
> > > >
> > > > On Wed, Oct 9, 2019 at 10:43 PM Jan Stancek <jstancek@redhat.com>
> > wrote:
> > > >
> > > >> read_all is currently retrying only for short time period and it's
> > > >> retrying to queue for same worker. If that worker is busy, it easily
> > > >> hits timeout.
> > > >>
> > > >> For example 'kernel_page_tables' on aarch64 can take long time to
> > > >> open/read:
> > > >>   # time dd if=/sys/kernel/debug/kernel_page_tables of=/dev/null
> > count=1
> > > >> bs=1024
> > > >>   1+0 records in
> > > >>   1+0 records out
> > > >>   1024 bytes (1.0 kB, 1.0 KiB) copied, 13.0531 s, 0.1 kB/s
> > > >>
> > > >>   real    0m13.066s
> > > >>   user    0m0.000s
> > > >>   sys     0m13.059s
> > > >>
> > > >> Rather than retrying to queue for specific worker, pick any that can
> > > >> accept
> > > >> the work and keep trying until we succeed or hit test timeout.
> > > >>
> > > >
> > > RFC:
> > >
> > > Base on your patch, I'm thinking to achieve a new macro TST_INFILOOP_FUNC
> > > which can repeat the @FUNC infinitely. Do you feel it satisfies your
> > > requirements to some degree or meaningful to LTP?
> >
> > I'm OK with concept. I'd like more some variation of *RETRY* for name.
> > Comments below.
> >
> 
> Thanks, what about naming: TST_INFI_RETRY_FUNC?

Or just keep TST_RETRY_FUNC and add parameter to it?

> 
> And do you mind use it to replace your function work_push_retry()? I know
> it may be not smarter than work_push_retry() but it looks tiny for code.

It may need some wrapper, because work_push_retry() may be passing different
argument to function on each retry, which was one of reasons for the patch.

> 
> > ...
> > > +#define TST_INFILOOP_FUNC(FUNC, ERET) \
> > > +       TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, -1)
> > > +
> > >  #define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)        \
> > > -({     int tst_delay_ = 1;                                             \
> > > +({     int tst_delay_ = 1, tst_max_delay_ = MAX_DELAY;                 \
> > > +       if (MAX_DELAY < 0)                                              \
> > > +                tst_max_delay_ *= MAX_DELAY;                           \
> >
> > Shouldn't this be just times (-1). For -5 you get 25 as max sleep time.
> >
> 
> Agree.
> 
> >
> > >         for (;;) {                                                      \
> > >                 typeof(FUNC) tst_ret_ = FUNC;                           \
> > >                 if (tst_ret_ == ERET)                                   \
> > >                         break;                                          \
> > > -               if (tst_delay_ < MAX_DELAY * 1000000) {                 \
> > > -                       usleep(tst_delay_);                             \
> > > +               usleep(tst_delay_);                                     \
> > > +               if (tst_delay_ < tst_max_delay_ * 1000000) {            \
> > >                         tst_delay_ *= 2;                                \
> > >                 } else {                                                \
> > > -                       tst_brk(TBROK, #FUNC" timed out");              \
> > > +                        if (MAX_DELAY > 0)                             \
> >
> > pastebin has this condition backwards, but here it looks ok
> 
> Sorry for the typo in pastebin.
> 
> --
> Regards,
> Li Wang
> 
