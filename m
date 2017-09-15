From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 15 Sep 2017 11:10:54 +0200
Subject: [LTP] [PATCH v3 3/7] fzsync: Add long running thread support
	and deviation stats
In-Reply-To: <20170912144137.GD29720@rei>
References: <20170901130121.22821-1-rpalethorpe@suse.com>
 <20170901130121.22821-3-rpalethorpe@suse.com> <20170912144137.GD29720@rei>
Message-ID: <87poasz5r5.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

>> - * tst_exp_moving_avg - Exponential moving average
>> + * TST_EXP_MOVING_AVG - Exponential moving average
>>   * @alpha: The preference for recent samples over old ones.
>>   * @sample: The current sample
>>   * @prev_avg: The average of the all the previous samples
>>   *
>>   * Returns average including the current sample.
>>   */
>> -static inline double tst_exp_moving_avg(double alpha, long sample,
>> -					double prev_avg)
>> -{
>> -	return alpha * sample + (1.0 - alpha) * prev_avg;
>> -}
>> +#define TST_EXP_MOVING_AVG(alpha, sample, prev_avg)\
>> +	(alpha * sample + (1.0 - alpha) * prev_avg)
>
> Why do we define this as a macro instead of static inline function? As
> far as I can tell the only difference is that we loose type checks and
> introduce possible side effects.

Ah, I needed to drop type checking at some point, can't remember why,
but it is not necessary now, so I will change it back.

>
>>  /**
>>   * tst_fzsync_pair_update - Recalculate the delay
>> @@ -169,8 +194,16 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
>>  	double target = pair->avg_diff_trgt;
>>  	double avg = pair->avg_diff;
>>  
>> +	if (pair->a.tv_sec > pair->b.tv_sec)
>> +		pair->a.tv_nsec += 1000000000;
>> +	else if (pair->a.tv_sec < pair->b.tv_sec)
>> +		pair->b.tv_nsec += 1000000000;
>
> Why the else here? These two cases are mutually exclusive.

Because if (pair->a.tv_sec == pair->b.tv_sec) then we want to do
nothing.

-- 
Thank you,
Richard.
