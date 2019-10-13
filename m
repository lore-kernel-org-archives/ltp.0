From: Jan Stancek <jstancek@redhat.com>
Date: Sun, 13 Oct 2019 03:54:07 -0400 (EDT)
Subject: [LTP] [PATCH v2] read_all: retry to queue work for any worker
In-Reply-To: <CAEemH2cuxbW55Y_mv9t0u7PEJyQVr9dgtZVFrDYKLi51MSsLmg@mail.gmail.com>
References: <26d555b1d9deddb5a6f0a93a7c7d3b00e8abc1ff.1570616598.git.jstancek@redhat.com>
 <8c5d507fd19bc3110561ed1c666b7ac47442e09e.1570632125.git.jstancek@redhat.com>
 <CAEemH2d82pP2mwHnw42h-17HipGsVeYesfzg7o4axvCiRKU0=Q@mail.gmail.com>
 <CAEemH2eYc1VVtavWKTE-x1gqY6q7qyMVZ-bETXJytPkdvHJriw@mail.gmail.com>
 <1445930938.5951899.1570861051806.JavaMail.zimbra@redhat.com>
 <CAEemH2f2_5wNfNB=a-+=E+KevFOVvjCQ0sjBEG-eS27dwQxarw@mail.gmail.com>
 <23965038.5952515.1570862960195.JavaMail.zimbra@redhat.com>
 <CAEemH2cuxbW55Y_mv9t0u7PEJyQVr9dgtZVFrDYKLi51MSsLmg@mail.gmail.com>
Message-ID: <1498901254.5980601.1570953247355.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Sat, Oct 12, 2019 at 2:49 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > ...
> > > > > Base on your patch, I'm thinking to achieve a new macro
> > TST_INFILOOP_FUNC
> > > > > which can repeat the @FUNC infinitely. Do you feel it satisfies your
> > > > > requirements to some degree or meaningful to LTP?
> > > >
> > > > I'm OK with concept. I'd like more some variation of *RETRY* for name.
> > > > Comments below.
> > > >
> > >
> > > Thanks, what about naming: TST_INFI_RETRY_FUNC?
> >
> > Or just keep TST_RETRY_FUNC and add parameter to it?
> >
> 
> Sounds better, we could add parameter @INFI to control the retry as a knob.
> 
> /* @INFI - 1: retry infinitely, 0: retry in limit times */
> 
> #define TST_RETRY_FUNC(FUNC, ERET, INFI) \
>         TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, 1, INFI)

Other option is we use directly TST_RETRY_FN_EXP_BACKOFF.

> 
> 
> > >
> > > And do you mind use it to replace your function work_push_retry()? I know
> > > it may be not smarter than work_push_retry() but it looks tiny for code.
> >
> > It may need some wrapper, because work_push_retry() may be passing
> > different
> > argument to function on each retry, which was one of reasons for the patch.
> >
> 
> I was not meaning to hack the work_push_retry() function, I mean to change
> your patch as below after we improve the TST_RETRY_FUNC.

Why not? Wouldn't we get better performance if we don't wait on specific worker
to complete?
