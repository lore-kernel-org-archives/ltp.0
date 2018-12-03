From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 03 Dec 2018 16:05:17 +0100
Subject: [LTP] [PATCH v3] fzsync: limit sampling time
In-Reply-To: <d66dd64f84d9e34ed19f5a0f6643ad4cdc94b4dc.1543844172.git.jstancek@redhat.com>
References: <d66dd64f84d9e34ed19f5a0f6643ad4cdc94b4dc.1543844172.git.jstancek@redhat.com>
Message-ID: <87va4amz0y.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Jan Stancek <jstancek@redhat.com> writes:

> Fixes: #429
>
> Sampling can take considerably longer time on single CPU
> and very slow systems. This patch limits sampling time to
> 1/2 of fuzzing runtime. If we don't have enough samples by
> that time, stop sampling and use stats we gathered so far.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_fuzzy_sync.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> Changes in v3:
> - base sampling time directly on exec time
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index 03f69b78bc82..18b9d265bbb4 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -70,6 +70,9 @@
>  #ifndef TST_FUZZY_SYNC_H__
>  #define TST_FUZZY_SYNC_H__
>
> +/* how much of exec time is sampling allowed to take */
> +#define SAMPLING_SLICE 0.5f
> +
>  /** Some statistics for a variable */
>  struct tst_fzsync_stat {
>  	float avg;
> @@ -582,17 +585,21 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
>  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
>  {
>  	int exit = 0;
> +	float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> +
> +	/* Limit amount of time spent on sampling */

I think this comment is redundant as you have documented the variable
and there is also the tst_res message. You could maybe add more info in
the message though. Like "Stopped sampling at %d (out of %d) samples
because sampling time reached 50% of the total time limit".

> +	if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
> +		&& (pair->sampling > 0)) {
> +		tst_res(TINFO, "stopping sampling at %d samples",
> +			pair->exec_loop);
> +		pair->sampling = 0;
> +		tst_fzsync_pair_info(pair);
> +	}
>
> -	if (pair->exec_time_p
> -	    < 1 - tst_timeout_remaining() / pair->exec_time_start) {
> +	if (pair->exec_time_p < rem_p) {
>  		tst_res(TINFO,
>  			"Exceeded execution time, requesting exit");
>  		exit = 1;
> -
> -		if (pair->sampling > 0) {
> -			tst_res(TWARN,
> -				"Still sampling, consider increasing LTP_TIMEOUT_MUL");
> -		}
>  	}
>
>  	if (++pair->exec_loop > pair->exec_loops) {


--
Thank you,
Richard.
