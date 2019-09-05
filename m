From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 05 Sep 2019 09:23:00 +0200
Subject: [LTP] [PATCH] fzsync: don't compare spins_avg (float) against 1
 (int)
In-Reply-To: <2ded10ab8d989ba7ee0cc1e9f1ac28acdf14c947.1567606698.git.jstancek@redhat.com>
References: <2ded10ab8d989ba7ee0cc1e9f1ac28acdf14c947.1567606698.git.jstancek@redhat.com>
Message-ID: <87woenky0b.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Jan Stancek <jstancek@redhat.com> writes:

> tst_fzsync_pair.spins is increased at least by one on every iteration.
> If during all calibration loops, both A and B manage to complete at
> nearly same time, then spins is increased only by one.
>
> spins_avg starts as 0, and tst_exp_moving_avg() will move it closer
> and closer to 1, but it will never be 1:
>         float f = 0; int i;
>         for (i = 0; i < 4096; i++)
>                 f = tst_exp_moving_avg(0.25f, 1, f);
>         printf("%.15f %d\n", f, f >= 1);
> 	$ 0.999999880790710 0
>
> which on rare occasion can cause: "Can't calculate random delay".

I'm surprised that you have seen this. Out of interest, does this happen
on a particular setup, or just randomly?

>
> Compare against float slightly smaller than 1.
> Also print stats one more time when we hit the warning.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_fuzzy_sync.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index de0402c9bbe9..2c0389c5d63e 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -73,6 +73,8 @@
>  /* how much of exec time is sampling allowed to take */
>  #define SAMPLING_SLICE 0.5f
>
> +#define EPSILON 0.999f
> +
>  /** Some statistics for a variable */
>  struct tst_fzsync_stat {
>  	float avg;
> @@ -477,7 +479,7 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
>  			tst_res(TINFO, "Minimum sampling period ended");
>  			tst_fzsync_pair_info(pair);
>  		}
> -	} else if (fabsf(pair->diff_ab.avg) >= 1 && pair->spins_avg.avg >= 1) {
> +	} else if (fabsf(pair->diff_ab.avg) > EPSILON && pair->spins_avg.avg > EPSILON) {
>  		per_spin_time = fabsf(pair->diff_ab.avg) / pair->spins_avg.avg;

I suppose you could also use MAX(pair->spins_avg.avg, 1f) and drop the
check. It might even be OK to only check that it is greater than
zero. I'm not sure if the number of delay spins will be sane either way,
but it probably can't do any harm.

>  		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
>  			- pair->diff_sb.avg;
> @@ -495,6 +497,7 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
>  		}
>  	} else if (!pair->sampling) {
>  		tst_res(TWARN, "Can't calculate random delay");
> +		tst_fzsync_pair_info(pair);
>  		pair->sampling = -1;
>  	}


--
Thank you,
Richard.
