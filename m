From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 27 Jan 2021 10:37:03 +0000
Subject: [LTP] [PATCH v2 1/1] fzsync: Add sched_yield for single core
 machine
In-Reply-To: <20210127031853.3485-1-ycliang@andestech.com>
References: <20210127031853.3485-1-ycliang@andestech.com>
Message-ID: <87czxq8y40.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Leo,

Leo Yu-Chi Liang <ycliang@andestech.com> writes:

> +	/**

Trailing whitespace

> +	 * Internal; The flag indicates single core machines or not
> +	 *

Same as above

> +	 * If running on single core machines, it would take considerable
> +	 * amount of time to run fuzzy sync library.
> +	 * Thus call sched_yield to give up cpu to decrease the test time.
> +	 */
> +	bool yield_in_wait;

Actually it appears the CHK macro is not compatible with bool, it
produces compiler warnings. You can either just change this to 'int
yield_in_wait:1;' or don't use the CHK macro.


> +
>  };
>  
>  #define CHK(param, low, hi, def) do {					      \
> @@ -206,6 +218,7 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  	CHK(max_dev_ratio, 0, 1, 0.1);
>  	CHK(exec_time_p, 0, 1, 0.5);
>  	CHK(exec_loops, 20, INT_MAX, 3000000);
> +	CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));
>  }
>  #undef CHK
>  
> @@ -550,7 +563,8 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
>   */
>  static inline void tst_fzsync_pair_wait(int *our_cntr,
>  					int *other_cntr,
> -					int *spins)
> +					int *spins,
> +					bool yield_in_wait)
>  {
>  	if (tst_atomic_inc(other_cntr) == INT_MAX) {
>  		/*
> @@ -564,6 +578,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
>  		       && tst_atomic_load(our_cntr) < INT_MAX) {
>  			if (spins)
>  				(*spins)++;
> +			if(yield_in_wait)
> +				sched_yield();
>  		}
>  
>  		tst_atomic_store(0, other_cntr);
> @@ -581,6 +597,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
>  		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
>  			if (spins)
>  				(*spins)++;
> +			if(yield_in_wait)
> +				sched_yield();

After disassembling this, it appears the compiler does not move the
yield branch outside the loop. The spins branch is optimised out because
it is a compile time constant when NULL.

This might not matter, but it will need testing on a lot of
platforms. OTOH we could manually move the branch outside of the loop.

-- 
Thank you,
Richard.
