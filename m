From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 23 Nov 2018 15:55:30 +0100
Subject: [LTP] [PATCH v4 2/4] fzsync: Simplify API with start/end race
	calls and limit exec time
In-Reply-To: <20181122154121.GB907@rei.lan>
References: <20181105154217.18879-1-rpalethorpe@suse.com>
 <20181105154217.18879-3-rpalethorpe@suse.com> <20181122154121.GB907@rei.lan>
Message-ID: <874lc7c07x.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>
> ...
>
>> +/** Wraps clock_gettime */
>>  static inline void tst_fzsync_time(struct timespec *t)
>>  {
>> +#ifdef CLOCK_MONOTONIC_RAW
>>  	clock_gettime(CLOCK_MONOTONIC_RAW, t);
>> +#else
>> +	clock_gettime(CLOCK_MONOTONIC, t);
>> +#endif
>>  }
>
> We should switch to a runtime detection here.
>
>>  /**
>> - * tst_fzsync_time_a - Set A's time to now.
>> + * Exponential moving average
>>   *
>> - * Called at the point you want to synchronise.
>> + * @param alpha The preference for recent samples over old ones.
>> + * @param sample The current sample
>> + * @param prev_avg The average of the all the previous samples
>> + *
>> + * @return The average including the current sample.
>>   */
>> -static inline void tst_fzsync_time_a(struct tst_fzsync_pair *pair)
>> +static inline float tst_exp_moving_avg(float alpha,
>> +					float sample,
>> +					float prev_avg)
>>  {
>> -	tst_fzsync_time(&pair->a);
>> +	return alpha * sample + (1.0 - alpha) * prev_avg;
>>  }
>
> ...
>
>> +static inline void tst_fzsync_pair_wait(int *our_cntr,
>> +					int *other_cntr,
>> +					int *spins)
>>  {
>>  	if (tst_atomic_inc(other_cntr) == INT_MAX) {
>>  		/*
>> @@ -243,84 +532,178 @@ static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
>>  		 * then our counter may already have been set to zero.
>>  		 */
>>  		while (tst_atomic_load(our_cntr) > 0
>> -		       && tst_atomic_load(our_cntr) < INT_MAX
>> -		       && !tst_atomic_load(&pair->exit))
>> -			;
>> +		       && tst_atomic_load(our_cntr) < INT_MAX) {
>> +			if (spins)
>> +				(*spins)++;
>> +		}
>>  
>>  		tst_atomic_store(0, other_cntr);
>>  		/*
>>  		 * Once both counters have been set to zero the invariant
>>  		 * is restored and we can continue.
>>  		 */
>> -		while (tst_atomic_load(our_cntr) > 1
>> -		       && !tst_atomic_load(&pair->exit))
>> +		while (tst_atomic_load(our_cntr) > 1)
>>  			;
>>  	} else {
>>  		/*
>>  		 * If our counter is less than the other thread's we are ahead
>>  		 * of it and need to wait.
>>  		 */
>> -		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
>> -		       && !tst_atomic_load(&pair->exit))
>> -			;
>> +		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
>> +			if (spins)
>> +				(*spins)++;
>
> I do wonder if the if () condition inside of the loop makes actually
> difference in the measurements. If it does we should pass a dummy
> pointer from the functions that pass NULL here.

AFAICT it is optimized out. All that is shown in the disassembler is

../../include/tst_fuzzy_sync.h:
547                                     (*spins)++;
   0x00000000004046f7 <+2023>:  addl   $0x1,0x1813a(%rip)        # 0x41c838 <fzsync_pair+120>

There is no reference to the if statement that I can see. I suppose that
if the function was not inlined then there might be an issue.

>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.
