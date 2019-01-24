From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Jan 2019 17:11:59 +0100
Subject: [LTP] [PATCH v3 5/6] syscalls/clock_settime: create syscall
 clock_settime tests
In-Reply-To: <20181212203723.18810-5-rafael.tinoco@linaro.org>
References: <20181211142750.GA27159@rei>
 <20181212203723.18810-1-rafael.tinoco@linaro.org>
 <20181212203723.18810-5-rafael.tinoco@linaro.org>
Message-ID: <20190124161159.GC16804@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "config.h"
> +#include "tst_timer.h"
> +#include "tst_safe_clocks.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#define DELTA_SEC 10
> +#define DELTA_SEC_US (long long) (DELTA_SEC * 1000000)
             ^
	     Maybe just DELTA_US having both SEC and US in the name is
	     confusing.

> +#define DELTA_SEC_VAR_POS (long long) (DELTA_SEC_US * 1.10)
> +#define DELTA_SEC_VAR_NEG (long long) (DELTA_SEC_US * 0.90)

It would be probably more clear to just define epsilon here as

#define DELTA_EPS (DELTA_US * 0.1)

Then use it as DELTA_US + DELTA_EPS and DELTA_US - DELTA_EPS

> +static void verify_clock_settime(void)
> +{
> +	long long elapsed;
> +	struct timespec begin, change, end;
> +
> +	/* test 01: move forward */
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &begin);
> +
> +	change = tst_timespec_add_us(begin, DELTA_SEC_US);
> +
> +	if (clock_settime(CLOCK_REALTIME, &change) != 0)
> +		tst_brk(TBROK | TTERRNO, "could not set realtime change");
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &end);
> +
> +	elapsed = tst_timespec_diff_us(end, begin);
> +
> +	if (elapsed > DELTA_SEC_US && elapsed < DELTA_SEC_VAR_POS) {
> +		tst_res(TPASS, "clock_settime(2): was able to advance time");
> +	} else {
> +		tst_res(TFAIL, "clock_settime(2): could not advance time");
> +	}

The curly braces around these one line statements are useless here.

> +	/* test 02: move backward */
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &begin);
> +
> +	change = tst_timespec_rem_us(begin, DELTA_SEC_US);
> +
> +	if (clock_settime(CLOCK_REALTIME, &change) != 0)
> +		tst_brk(TBROK | TTERRNO, "could not set realtime change");
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &end);
> +
> +	elapsed = tst_timespec_diff_us(end, begin);
> +
> +	if (~(elapsed) > DELTA_SEC_VAR_NEG) {

We still does not check that the time wasn't set too much into history
so this should be adjusted just like the previous condition to:

	if (~(elapsed) < DELTA_US && ~(elapsed) > DELTA_US - DELTA_EPS)

> +		tst_res(TPASS, "clock_settime(2): was able to recede time");
> +	} else {
> +		tst_res(TFAIL, "clock_settime(2): could not recede time");
> +	}

Again useless curly braces.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_clock_settime,
> +	.needs_root = 1,
> +	.restore_wallclock = 1,
> +};
> diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
> new file mode 100644
> index 000000000..25fcbfe09
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Linaro Limited. All rights reserved.
> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
> + */
> +
> +/*
> + * Basic tests for errors of clock_settime(2) on different clock types.
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "tst_timer.h"
> +#include "tst_safe_clocks.h"
> +
> +#define DELTA_SEC 10
> +#define NSEC_PER_SEC (1000000000L)
> +#define MAX_CLOCKS 16
> +
> +struct test_case {
> +	clockid_t type;
> +	struct timespec newtime;
> +	int exp_err;
> +	int replace;
> +};
> +
> +struct test_case tc[] = {
> +	{				/* case 01: REALTIME: timespec NULL   */
> +	 .type = CLOCK_REALTIME,
> +	 .newtime.tv_sec = -2,
> +	 .exp_err = EFAULT,
> +	 .replace = 1,
> +	 },
> +	{				/* case 02: REALTIME: tv_sec = -1     */
> +	 .type = CLOCK_REALTIME,
> +	 .newtime.tv_sec = -1,
> +	 .exp_err = EINVAL,
> +	 .replace = 1,
> +	 },
> +	{				/* case 03: REALTIME: tv_nsec = -1    */
> +	 .type = CLOCK_REALTIME,
> +	 .newtime.tv_nsec = -1,
> +	 .exp_err = EINVAL,
> +	 .replace = 1,
> +	 },
> +	{				/* case 04: REALTIME: tv_nsec = 1s+1  */
> +	 .type = CLOCK_REALTIME,
> +	 .newtime.tv_nsec = NSEC_PER_SEC + 1,
> +	 .exp_err = EINVAL,
> +	 .replace = 1,
> +	 },
> +	{				/* case 05: MONOTONIC		      */
> +	 .type = CLOCK_MONOTONIC,
> +	 .exp_err = EINVAL,
> +	 },
> +	{				/* case 06: MAXCLOCK		      */
> +	 .type = MAX_CLOCKS,
> +	 .exp_err = EINVAL,
> +	 },
> +	{				/* case 07: MAXCLOCK+1		      */
> +	 .type = MAX_CLOCKS + 1,
> +	 .exp_err = EINVAL,
> +	 },
> +	/* Linux specific */
> +	{				/* case 08: CLOCK_MONOTONIC_COARSE    */
> +	 .type = CLOCK_MONOTONIC_COARSE,
> +	 .exp_err = EINVAL,
> +	 },
> +	{				/* case 09: CLOCK_MONOTONIC_RAW       */
> +	 .type = CLOCK_MONOTONIC_RAW,
> +	 .exp_err = EINVAL,
> +	 },
> +	{				/* case 10: CLOCK_BOOTTIME	      */
> +	 .type = CLOCK_BOOTTIME,
> +	 .exp_err = EINVAL,
> +	 },
> +	{				/* case 11: CLOCK_PROCESS_CPUTIME_ID  */
> +	 .type = CLOCK_PROCESS_CPUTIME_ID,
> +	 .exp_err = EINVAL,
> +	 },
> +	{				/* case 12: CLOCK_THREAD_CPUTIME_ID   */
> +	 .type = CLOCK_THREAD_CPUTIME_ID,
> +	 .exp_err = EINVAL,
> +	 },
> +};
> +
> +/*
> + * Some tests may cause libc to segfault when passing bad arguments.
> + */
> +static int sys_clock_settime(clockid_t clk_id, struct timespec *tp)
> +{
> +	return tst_syscall(__NR_clock_settime, clk_id, tp);
> +}
> +
> +static void verify_clock_settime(unsigned int i)
> +{
> +	struct timespec saved, spec, *specptr;


I would have initialized the specptr = &spec here and only replaced it
down there if we are hitting the EFAULT case.

> +	if (tc[i].replace == 0) {
> +
> +		SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &saved);
> +
> +		/* add 1 sec to test clock */
> +		specptr = &spec;
> +		specptr->tv_sec = saved.tv_sec + 1;
> +		specptr->tv_nsec = saved.tv_nsec;

And we don't need the saved here anymore, so we can really do
clock_gettime() on the specptr here, right?

> +	} else {
> +
> +
> +		if (tc[i].newtime.tv_sec == -2) {
> +
> +			/* bad pointer case */
> +			specptr = tst_get_bad_addr(NULL);

Maybe we can just look for EFAULT errno instead of having magic tv_sec
value.

> +		} else {
> +
> +			/* use given values */
> +			specptr = &spec;
> +			specptr->tv_sec = tc[i].newtime.tv_sec;
> +			specptr->tv_nsec = tc[i].newtime.tv_nsec;

You can do simple spec = tc[i].newtime here.

> +		}
> +	}



> +	TEST(sys_clock_settime(tc[i].type, specptr));
> +
> +	if (TST_RET == -1) {
> +
> +		if (tc[i].exp_err == TST_ERR) {
> +
> +			tst_res(TPASS, "clock_settime(2): failed as expected");
> +
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "clock_settime(2): "
> +					"failed with different error");

I would be better to print the expected errno here as well something as:

	tst_res(TFAIL | TTERRNO, "clock_settime(%s, ...) expected %s",
	        clock_name(tc[i].type), tst_strerrno(tc[i].exp_err));
> +		}
> +
> +		return;
> +	}
> +
> +	tst_res(TFAIL | TTERRNO, "clock_settime(2): clock type %d failed",
> +			tc[i].type);

Shouldn't this say:

	tst_res(TFAIL, "clock_settime(%s, ...) passed unexpectedly, expected %s",
	        clock_name(tc[i].type), tst_strerrno(tc[i].exp_err));

> +}
> +
> +static struct tst_test test = {
> +	.test = verify_clock_settime,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.needs_root = 1,
> +	.restore_wallclock = 1,
> +};
> -- 
> 2.20.0.rc1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
