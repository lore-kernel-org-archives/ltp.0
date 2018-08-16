From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 16 Aug 2018 14:58:27 +0200
Subject: [LTP] [PATCH v3 3/4] tst_timer: Create interface for using
	multiple timers
In-Reply-To: <20180816122247.GD6547@rei>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
 <20180816120020.11042-3-rpalethorpe@suse.com> <20180816122247.GD6547@rei>
Message-ID: <87bma24gek.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +/**
>> + * Encapsulates a stopwatch timer.
>> + *
>> + * Useful when you need to use multiple timers in a single test.
>> + */
>> +struct tst_timer {
>> +	/** The POSIX clock type  */
>> +	clockid_t clock_id;
>> +	/** How much time can pass before tst_timer_expired_st() returns true */
>> +	struct timespec limit;
>> +	/** Where to start measuring time from */
>> +	struct timespec start_time;
>> +};
>> +
>>  /*
>>   * Converts timespec to microseconds.
>>   */
>> @@ -251,6 +265,14 @@ void tst_timer_check(clockid_t clk_id);
>>   */
>>  void tst_timer_start(clockid_t clk_id);
>>
>> +/**
>> + * Sets the start time for timer tim.
>> + *
>> + * @relates tst_timer
>> + * @param tim The timer to start
>> + */
>> +void tst_timer_start_st(struct tst_timer *tim);
>
> So user is expected to fill in the tst_timer structure before this call
> is called, right?
>
> Maybe it would be easier to pass the timeout and CLOCK_ID to this
> function and keep the initialization in the test library, that way we
> can also check if the timer is supported first before we return from the
> start function.

Well if the clock is not supported and the call fails, then the user
will have to deal with that at the call site of tst_timer_start which is
not very convenient for tst_fuzzy_sync. I would rather have a seperate
initialisation function for the tst_timer struct which can be called in
the setup function. e.g. tst_timer_init[_st](clock_id, timeout, ...).

>
> And lastly but not least, we were also discussion special timer id,
> something as TST_TIMER_DEFAULT that would select appropriate timer,
> althoug I guess that CLOCK_MONOTONIC is supporoted on anything that we
> care for these days.

Yeah, fuzzy_sync just defines CLOCK_MONOTIC to CLOCK_MONOTONIC_RAW if
possible and uses that. Not had any reports of CLOCK_MONOTONIC being
unavailabe.

>
>>  /*
>>   * Returns true if timer started by tst_timer_start() has been running for
>>   * longer than ms seconds.
>> @@ -259,6 +281,14 @@ void tst_timer_start(clockid_t clk_id);
>>   */
>>  int tst_timer_expired_ms(long long ms);
>>
>> +/**
>> + * Returns true if timer tim has been running for longer than tst_timer::limit
>> + *
>> + * @relates tst_timer
>> + * @param tim The timer to check
>> + */
>> +int tst_timer_expired_st(struct tst_timer *tim);
>> +
>>  /*
>>   * Marks timer end time.
>>   */
>> diff --git a/lib/tst_timer.c b/lib/tst_timer.c
>> index d5e4c49d2..baec18280 100644
>> --- a/lib/tst_timer.c
>> +++ b/lib/tst_timer.c
>> @@ -79,6 +79,12 @@ void tst_timer_start(clockid_t clk_id)
>>  		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
>>  }
>>
>> +void tst_timer_start_st(struct tst_timer *tim)
>> +{
>> +	if (tst_clock_gettime(tim->clock_id, &tim->start_time))
>> +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
>> +}
>> +
>>  int tst_timer_expired_ms(long long ms)
>>  {
>>  	struct timespec cur_time;
>> @@ -89,6 +95,17 @@ int tst_timer_expired_ms(long long ms)
>>  	return tst_timespec_diff_ms(cur_time, start_time) >= ms;
>>  }
>>
>> +int tst_timer_expired_st(struct tst_timer *tim)
>> +{
>> +	struct timespec cur_time;
>> +
>> +	if (tst_clock_gettime(tim->clock_id, &cur_time))
>> +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
>> +
>> +	return tst_timespec_lt(tim->limit,
>> +			       tst_timespec_diff(cur_time, tim->start_time));
>> +}
>> +
>>  void tst_timer_stop(void)
>>  {
>>  	if (tst_clock_gettime(clock_id, &stop_time))
>> --
>> 2.18.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp


--
Thank you,
Richard.
