From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Aug 2018 11:17:12 +0200
Subject: [LTP] [PATCH 4/5] fzsync: Simplify API with start/end race
 calls and limit exec time
In-Reply-To: <87va7tsgr1.fsf@rpws.prws.suse.cz>
References: <20180828093002.20368-1-rpalethorpe@suse.com>
 <20180828093002.20368-5-rpalethorpe@suse.com>
 <20180828162409.GC26231@rei.lan> <87va7tsgr1.fsf@rpws.prws.suse.cz>
Message-ID: <20180829091712.GA30074@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > If yuo init the pair with TST_FZSYNC_PAIR_INIT these fields are already
> > zeroed...
> 
> Not if the user uses the -i argument.

Hmm, then we should probably drop the static initialization. We would
have to have way to set some parameters to non-default values, but I
guess that we can do that after we called the init function. Something
as:

	tst_fzsync_init(&pair);
	tst_fzsync_set_foo(&par, val);

Where tst_fzsync_set_foo() is an static inline function.

> >> +	pair->sampling = pair->min_samples;
> >> +
> >> +	pair->timer.limit =
> >> +		tst_sec_to_timespec(pair->execution_time * tst_timeout_mul());
> >
> > Hmm, why can't we have the limit in seconds? We do convert it to
> > timespec here, then convert it again in the timer library.
> 
> I'm using the new timer API I invented which just uses timespec
> structs.

Maybe we should keep the timer API as it is and reuse the API Jan is
recently working on, i.e. the tst_timeout_remaining() function.

> > So we do collect the statistic here to be used later, and we end either
> > when deviation is small enough or we reached minimal number of spins?
> 
> The sampling period ends when both the minimum number of spins have been
> reached and the average deviation is small.

Right, my bad.

> > The max_dev_ratio is supposed to be set by the testcase then? I would
> > like to avoid having magic constants if possible...
> 
> Well, it can be, but I think most, if not all, tests can (and should)
> use the default deviation ratio. We may need to change the default,
> maybe on a per platform basis, but we need more data.

That is the reason why I would like to have things auto-tuneable, it's
not like we can test the library on every hardware/distro combinations
out there. But let's see.

> >> +	} else if (pair->diff_ab.avg >= 1 && pair->spins_avg.avg >= 1) {
> >> +		per_spin_time = fabs(pair->diff_ab.avg) / pair->spins_avg.avg;
> >> +		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
> >> +			- pair->diff_sb.avg;
> >
> > Uff, it took me a while to figure this out but it seems correct to me,
> > given that we do
> >
> > race_start_a:
> >
> > 	while (delay < 0)
> > 		delay++;
> >
> > race_start_b:
> >
> > 	while (delay > 0)
> > 		delay--;
> >
> > This means that the range for random delay we need is [-B, A]
> >
> > So maybe you should explain the implementation a little bit in the
> > comment above. It's nice that it explains the general idea but maybe we
> > need hints to understand the implementation as well.
> 
> Yeah sorry, I actually figured it out in mathematical notation on paper
> and should have tried to clean it up and rewrite it in the doc
> comment. Or possibly I should write it inline like I did for the wait
> function.

I would have liked a top level comment about the implementation better.

Maybe we need two paragraphs in the top level comment, one about the
general idea and one with hints about the implementation.

> >> +		pair->delay = (int)(time_delay / per_spin_time);
> >
> > Also we can probably use return here to avoid the excessive else if branches.
> >
> >
> > Generally this looks great, maybe needs a little more explanations, but
> > it surely looks like a step into the right direction to me.
> 
> Thanks!
> 
> --
> Thank you,
> Richard.

-- 
Cyril Hrubis
chrubis@suse.cz
