From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Sep 2017 14:48:14 +0200
Subject: [LTP] [PATCH v3 3/7] fzsync: Add long running thread support
 and deviation stats
In-Reply-To: <87poasz5r5.fsf@our.domain.is.not.set>
References: <20170901130121.22821-1-rpalethorpe@suse.com>
 <20170901130121.22821-3-rpalethorpe@suse.com>
 <20170912144137.GD29720@rei> <87poasz5r5.fsf@our.domain.is.not.set>
Message-ID: <20170915124813.GC1168@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>  /**
> >>   * tst_fzsync_pair_update - Recalculate the delay
> >> @@ -169,8 +194,16 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
> >>  	double target = pair->avg_diff_trgt;
> >>  	double avg = pair->avg_diff;
> >>  
> >> +	if (pair->a.tv_sec > pair->b.tv_sec)
> >> +		pair->a.tv_nsec += 1000000000;
> >> +	else if (pair->a.tv_sec < pair->b.tv_sec)
> >> +		pair->b.tv_nsec += 1000000000;
> >
> > Why the else here? These two cases are mutually exclusive.
> 
> Because if (pair->a.tv_sec == pair->b.tv_sec) then we want to do
> nothing.

Ah right, missed that. I wonder if can compute the diff directly as:

	 pair->a.tv_nsec - pair->b.tv_nsec + 1000000000 *
	 (pair->a.tv_sec - pair->b.tv_sec)

instead.

Or do we care not to overflow here?

-- 
Cyril Hrubis
chrubis@suse.cz
