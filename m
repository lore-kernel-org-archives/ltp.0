From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Aug 2018 17:27:29 +0800
Subject: [LTP] [PATCH v2 4/4] fzsync: Limit execution time to prevent
	test timeouts
In-Reply-To: <87in4c3spd.fsf@rpws.prws.suse.cz>
References: <20180813135908.30752-1-rpalethorpe@suse.com>
 <20180813135908.30752-4-rpalethorpe@suse.com>
 <87in4c3spd.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2f_Wg+MgdNoqXPotmq4gJaBZOJKX_kMtY=0ubZ6LkT5vg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:

Hello,
>
> Richard Palethorpe <rpalethorpe@suse.com> writes:
>
> >  /**
> >   * tst_fzsync_pair_wait_update_{a,b} - Wait and then recalculate
> >   *
> > @@ -301,10 +311,26 @@ static inline int tst_fzsync_wait_b(struct
> tst_fzsync_pair *pair)
> >  static inline int tst_fzsync_wait_update_a(struct tst_fzsync_pair
> *pair)
> >  {
> >       static int loop_index;
> > +     int timer_state = tst_timer_state_ms(60000);
> > +     int exit = 0;
> > +
> > +     if (!(timer_state & TST_TIMER_STARTED)) {
> > +             tst_timer_start(CLOCK_MONOTONIC_RAW);
> > +     } else if (timer_state & TST_TIMER_EXPIRED) {
> > +             tst_res(TINFO,
> > +                     "Exceeded fuzzy sync time limit, requesting exit");
> > +             exit = 1;
>
> This is not going to work with the -i argument or if the test author
> also wants to use tst_timer. I'm going to have to do something
> different.


Yes, good catch. I didn't realized that when reviewing the patch.

Maybe we can try to leave the expired time judgement in fzync library and
without using any LTP timer API. But for the -i parameter, it seems hard to
set pair->exit to 0 at a proper time :(.

Now I'm thinking that why not to redesign/improve the fzync first and then
solve the timeout issue. It will be easier than current situation I guess.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180816/eac4d793/attachment.html>
