From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Dec 2018 08:40:24 -0500 (EST)
Subject: [LTP] [PATCH v4] fzsync: limit sampling time
In-Reply-To: <8361c9b264ceb4c212319fcb366d85a854495ffe.1543912963.git.jstancek@redhat.com>
References: <8361c9b264ceb4c212319fcb366d85a854495ffe.1543912963.git.jstancek@redhat.com>
Message-ID: <1713839002.84458666.1544449224828.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Fixes: #429
> 
> Sampling can take considerably longer time on single CPU
> and very slow systems. This patch limits sampling time to
> 1/2 of fuzzing runtime. If we don't have enough samples by
> that time, stop sampling and use stats we gathered so far.

@Richard: Are you OK with v4 (with %% typo fixed)?

> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_fuzzy_sync.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> Changes in v4:
>  - drop comment
>  - tweak info message when timeout is reached
> 
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index 03f69b78bc82..0e534bb041f8 100644
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
> @@ -582,17 +585,21 @@ static inline void tst_fzsync_wait_b(struct
> tst_fzsync_pair *pair)
>  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
>  {
>  	int exit = 0;
> +	float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> +
> +	if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
> +		&& (pair->sampling > 0)) {
> +		tst_res(TINFO, "Stopped sampling at %d (out of %d) samples, "
> +			"sampling time reached 50% of the total time limit",
> +			pair->exec_loop, pair->min_samples);
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
> --
> 1.8.3.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
