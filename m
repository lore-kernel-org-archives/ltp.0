From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 11 Dec 2018 14:05:27 -0200
Subject: [LTP] [PATCH v2 1/2] syscalls/clock_settime01.c: create syscall
 clock_settime
In-Reply-To: <20181211142750.GA27159@rei>
References: <20181206130309.GA22250@rei>
 <20181206190710.22471-1-rafael.tinoco@linaro.org>
 <20181211142750.GA27159@rei>
Message-ID: <f4a194b4-7672-39ef-7898-e8d510f8edfb@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/11/18 12:27 PM, Cyril Hrubis wrote:
> Hi!
>> new file mode 100644
>> index 000000000..97d720fa2
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2018 Linaro Limited. All rights reserved.
>> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
>> + */
>> +
>> +/*
>> + * Basic test for clock_settime(2) on REALTIME clock:
>> + *
>> + *      1) advance DELTA_SEC seconds
>> + *      2) go backwards DELTA_SEC seconds
>> + *
>> + * Accept DELTA_PER deviation on both (specially going backwards).
>> + */
>> +
>> +#include "config.h"
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +
>> +#define DELTA_SEC 10	/* 10 seconds delta    */
>> +#define DELTA_PER 0.1	/* 1 percent deviation */
>> +
>> +static struct timespec real_begin, mono_begin, mono_end;
>> +
>> +static void clock_elapsed(struct timespec *begin, struct timespec *end,
>> +		struct timespec *elapsed)
>> +{
>> +	elapsed->tv_sec = end->tv_sec - begin->tv_sec;
>> +	elapsed->tv_nsec = end->tv_nsec - begin->tv_nsec;
> 
> If you do this the elapsed may end up in non-normalized state, i.e.
> elapsed->tv_nsec may end up negative.

#)... definitely, will stick to what tst_timer.h has.

> 
> We do have all kinds of inline functions for conversion and arimetic in
> tst_timer.h so there is no point of rolling your own here.
> 
>> +}
>> +
>> +static void clock_return(void)
>                       ^
> 		      I would have named this restore, but that is very
> 		      minor.
> 
>> +{
>> +	static struct timespec elapsed, adjust;
>> +
>> +	clock_elapsed(&mono_begin, &mono_end, &elapsed);
>> +
>> +	adjust.tv_sec = real_begin.tv_sec + elapsed.tv_sec;
>> +	adjust.tv_nsec = real_begin.tv_nsec + elapsed.tv_nsec;
> 
> We should normalize the addition here as well, i.e. carry over to
> seconds if the number of nanoseconds gets greater than 1s.

definitely, stupid mistake on my side, will fix.

> 
> Ideally we should add a function to add two timespec structures into the
> tst_timer.h header (in a separate patch).

Alright.

> 
>> +	if (clock_settime(CLOCK_REALTIME, &adjust) != 0)
>> +		tst_res(TBROK | TTERRNO, "could restore realtime clock");
>> +}
>> +
>> +static void clock_fixnow(void)
>> +{
>> +	if (clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not get elapsed time");
> 
> We should make sure here that both real_begin and mono_begin were set
> before we attempt to restore the system time. A restore_time flag se to
> 1 after we successfully read both will do.

Alright.

> 
>> +	clock_return();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	/* save initial monotonic time to restore it when needed */
>> +
>> +	if (clock_gettime(CLOCK_REALTIME, &real_begin) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not get initial real time");
>> +
>> +	if (clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin) != 0)
>> +		tst_res(TBROK | TTERRNO, "couldn't get initial monotonic time");
>                   ^
> 		  This should have been tst_brk() doing tst_res() with
> 		  TBROK does not make much sense.
> 
> Also we do have tst_safe_clocks.h, if you include that you can use
> SAFE_CLOCK_GETTIME() instead.
> 
> Overall the idea of restoring wall clock using monotonic timer is a good
> one, maybe we should even move this code to a library so that all tests
> that change wall clock would need just set restore_wallclock flag in the
> tst_test structure...

Will look into that.

> 
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	clock_fixnow();
>> +}
>> +
>> +static void verify_clock_settime(void)
>> +{
>> +	static struct timespec begin, change, end, elapsed;
>> +
>> +	/* test 01: move forward */
>> +
>> +	if (clock_gettime(CLOCK_REALTIME, &begin) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not get realtime at the begin");
>> +
>> +	change.tv_sec = begin.tv_sec + DELTA_SEC;
>> +
>> +	if (clock_settime(CLOCK_REALTIME, &change) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not set realtime change");
>> +
>> +	if (clock_gettime(CLOCK_REALTIME, &end) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not get realtime after change");
> 
> Here as well.
> 
>> +	clock_elapsed(&begin, &end, &elapsed);
>> +
>> +	if (elapsed.tv_sec < (float) (DELTA_SEC - (DELTA_SEC * DELTA_PER)))
> 
> It would be much easier to just use tst_timespec_diff_ms() and check
> that the result is in reasonable range. I.e. check lower bound as well.

Yep, I missed tst_timer.h entirely it seems =o), won't reinvent the wheel.

> 
>> +		tst_res(TFAIL, "clock_settime(2): could not advance time");
>> +	else
>> +		tst_res(TPASS, "clock_settime(2): was able to advance time");
>> +
>> +	/* test 02: move backward */
>> +
>> +	if (clock_gettime(CLOCK_REALTIME, &begin) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not get realtime at the begin");
>> +
>> +	change.tv_sec = begin.tv_sec - DELTA_SEC;
>> +
>> +	if (clock_settime(CLOCK_REALTIME, &change) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not set realtime change");
>> +
>> +	if (clock_gettime(CLOCK_REALTIME, &end) != 0)
>> +		tst_res(TBROK | TTERRNO, "could not get realtime after change");
>> +
>> +	clock_elapsed(&begin, &end, &elapsed);
>> +
>> +	elapsed.tv_sec = ~elapsed.tv_sec;
>> +	elapsed.tv_nsec = ~elapsed.tv_nsec;
>> +
>> +	if (elapsed.tv_sec < (float) (DELTA_SEC - (DELTA_SEC * DELTA_PER)))
>> +		tst_res(TFAIL, "clock_settime(2): could not recede time");
>> +	else
>> +		tst_res(TPASS, "clock_settime(2): was able to recede time");
> 
> Here as well.
> 
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test_all = verify_clock_settime,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +};
>>
>> diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
>> new file mode 100644
>> index 000000000..710f37219
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
>> @@ -0,0 +1,171 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2018 Linaro Limited. All rights reserved.
>> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
>> + */
>> +
>> +/*
>> + * Basic tests for errors of clock_settime(2) on different clock types.
>> + */
>> +
>> +#include "config.h"
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +
>> +#define DELTA_SEC 10
>> +#define NSEC_PER_SEC (1000000000L)
>> +#define MAX_CLOCKS 16
>> +
>> +static struct timespec clock_realtime_saved;
>> +
>> +struct test_case {
>> +	clockid_t type;
>> +	struct timespec newtime;
>> +	int exp_err;
>> +	int replace;
>> +};
>> +
>> +struct test_case tc[] = {
>> +	{				/* case 01: REALTIME: timespec NULL   */
>> +	 .type = CLOCK_REALTIME,
>> +	 .newtime.tv_sec = -2,
>> +	 .exp_err = EFAULT,
>> +	 .replace = 1,
>> +	 },
>> +	{				/* case 02: REALTIME: tv_sec = -1     */
>> +	 .type = CLOCK_REALTIME,
>> +	 .newtime.tv_sec = -1,
>> +	 .exp_err = EINVAL,
>> +	 .replace = 1,
>> +	 },
>> +	{				/* case 03: REALTIME: tv_nsec = -1    */
>> +	 .type = CLOCK_REALTIME,
>> +	 .newtime.tv_nsec = -1,
>> +	 .exp_err = EINVAL,
>> +	 .replace = 1,
>> +	 },
>> +	{				/* case 04: REALTIME: tv_nsec = 1s+1  */
>> +	 .type = CLOCK_REALTIME,
>> +	 .newtime.tv_nsec = NSEC_PER_SEC + 1,
>> +	 .exp_err = EINVAL,
>> +	 .replace = 1,
>> +	 },
>> +	{				/* case 05: MONOTONIC		      */
>> +	 .type = CLOCK_MONOTONIC,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +	{				/* case 06: MAXCLOCK		      */
>> +	 .type = MAX_CLOCKS,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +	{				/* case 07: MAXCLOCK+1		      */
>> +	 .type = MAX_CLOCKS + 1,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +	/* Linux specific */
>> +	{				/* case 08: CLOCK_MONOTONIC_COARSE    */
>> +	 .type = CLOCK_MONOTONIC_COARSE,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +	{				/* case 09: CLOCK_MONOTONIC_RAW       */
>> +	 .type = CLOCK_MONOTONIC_RAW,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +	{				/* case 10: CLOCK_BOOTTIME	      */
>> +	 .type = CLOCK_BOOTTIME,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +	{				/* case 11: CLOCK_PROCESS_CPUTIME_ID  */
>> +	 .type = CLOCK_PROCESS_CPUTIME_ID,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +	{				/* case 12: CLOCK_THREAD_CPUTIME_ID   */
>> +	 .type = CLOCK_THREAD_CPUTIME_ID,
>> +	 .exp_err = EINVAL,
>> +	 },
>> +};
>> +
>> +/*
>> + * Some tests may cause libc to segfault when passing bad arguments.
>> + */
>> +static int sys_clock_settime(clockid_t clk_id, struct timespec *tp)
>> +{
>> +	return tst_syscall(__NR_clock_settime, clk_id, tp);
>> +}
>> +
>> +static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
>> +{
>> +	return tst_syscall(__NR_clock_gettime, clk_id, tp);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	/* restore realtime clock */
>> +
>> +	if (sys_clock_settime(CLOCK_REALTIME, &clock_realtime_saved) < 0)
>> +		tst_res(TBROK | TTERRNO, "clock_settime(2): could not set "
>> +				"current time back");
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	if (sys_clock_gettime(CLOCK_REALTIME, &clock_realtime_saved) < 0)
>> +		tst_res(TBROK | TTERRNO, "clock_gettime(2): could not get "
>> +				"current time");
>> +}
>> +
>> +static void verify_clock_settime(unsigned int i)
>> +{
>> +	struct timespec spec, *specptr;
>> +
>> +	if (tc[i].replace == 0) {
>> +
>> +		/* add 1 sec to test clock */
>> +
>> +		specptr = &spec;
>> +		specptr->tv_sec = clock_realtime_saved.tv_sec + 1;
>> +		specptr->tv_nsec = clock_realtime_saved.tv_nsec;
>> +
>> +	} else {
>> +
>> +		/* bad pointer case */
>> +
>> +		if (tc[i].newtime.tv_sec == -2)
>> +			specptr = tst_get_bad_addr(cleanup);
>> +
>> +		/* use given values */
>> +
>> +		else {
> 
> Still curly braces missing here, but that is minor.
> 
> And maybe we just need to turn the newtime into a pointer in the tcases
> structure. Then you can initialize global variable to current time +
> epsion and use pointer to it or even initialize it inline as:
> 
> static struct timespec valid_time;
> 
> struct test_case tc[] = {
> 	{
> 	 .type = CLOCK_REALTIME,
> 	 .exp_err = EFAULT,
> 	},
> 	{
> 	 .type = CLOCK_REALTIME;
> 	 .newtime = &valid_time;
> 	 .exp_err = EINVAL,
> 	{
> 	 .type = CLOCK_REALTIME,
> 	 .newtime = &(struct timespec){},
> 	 .exp_err = EINVAL,
> 	 .replace = 1,
> 	},
> 	...
> };
> 
> And we can loop in the test setup and set NULL address to the result of
> tst_get_bad_addr() as well.

Good idea.

> 
>> +			specptr = &spec;
>> +			specptr->tv_sec = tc[i].newtime.tv_sec;
>> +			specptr->tv_nsec = tc[i].newtime.tv_nsec;
>> +		}
>> +	}
>> +
>> +	TEST(sys_clock_settime(tc[i].type, specptr));
>> +
>> +	if (TST_RET == -1) {
>> +
>> +		if (tc[i].exp_err == TST_ERR) {
>> +
>> +			tst_res(TPASS, "clock_settime(2): failed as expected");
>> +
>> +		} else {
>> +			tst_res(TFAIL | TTERRNO, "clock_settime(2): "
>> +					"failed with different error");
>> +		}
>> +
>> +		return;
>> +	}
>> +
>> +	tst_res(TFAIL | TTERRNO, "clock_settime(2): clock type %d failed",
>> +			tc[i].type);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test = verify_clock_settime,
>> +	.cleanup = cleanup,
>> +	.tcnt = ARRAY_SIZE(tc),
>> +	.needs_root = 1,
>> +};
>> -- 
>> 2.20.0.rc1
>>
> 

Thanks for reviewing... will re-work it.

-- 
Rafael D. Tinoco
Linaro - Kernel Validation
