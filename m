From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jan 2019 14:56:08 +0100
Subject: [LTP] [PATCH v4 7/8] syscalls/clock_settime: create syscall
 clock_settime tests
In-Reply-To: <20190129173659.27901-7-rafael.tinoco@linaro.org>
References: <20190124161159.GC16804@rei.lan>
 <20190129173659.27901-1-rafael.tinoco@linaro.org>
 <20190129173659.27901-7-rafael.tinoco@linaro.org>
Message-ID: <20190130135608.GD4709@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (elapsed > DELTA_US && elapsed < (DELTA_US + DELTA_EPS))
> +		tst_res(TPASS, "clock_settime(2): was able to advance time");
> +	else
> +		tst_res(TFAIL, "clock_settime(2): could not advance time");

I've changed this to elapsed >= DELTA_US just in case.

> +	/* test 02: move backward */
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &begin);
> +
> +	change = tst_timespec_sub_us(begin, DELTA_US);
> +
> +	if (clock_settime(CLOCK_REALTIME, &change) != 0)
> +		tst_brk(TBROK | TTERRNO, "could not set realtime change");
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &end);
> +
> +	elapsed = tst_timespec_diff_us(end, begin);
> +
> +	if (~(elapsed) < DELTA_US && ~(elapsed) > (DELTA_US - DELTA_EPS))
> +		tst_res(TPASS, "clock_settime(2): was able to recede time");
> +	else
> +		tst_res(TFAIL, "clock_settime(2): could not recede time");

And here as well.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_clock_settime,
> +	.needs_root = 1,
> +	.restore_wallclock = 1,
> +};
> diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
> new file mode 100644
> index 000000000..09c9dc4a4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited. All rights reserved.
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
> +	struct timespec spec, *specptr;
> +
> +	specptr = &spec;
> +
> +	if (tc[i].replace == 0) {
> +
> +		SAFE_CLOCK_GETTIME(CLOCK_REALTIME, specptr);
> +
> +		/* add 1 sec to wall clock */
> +		specptr->tv_sec += 1;
> +
> +	} else {
> +
> +		/* use given time spec */
> +		*specptr = tc[i].newtime;
> +	}
> +
> +	/* bad pointer case */
> +	if (tc[i].exp_err == EFAULT)
> +		specptr = tst_get_bad_addr(NULL);
> +
> +	TEST(sys_clock_settime(tc[i].type, specptr));
> +
> +	if (TST_RET == -1) {
> +
> +		if (tc[i].exp_err == TST_ERR) {
> +
> +			tst_res(TPASS, "clock_settime(2): failed as expected");

I've made this message a bit more verbose, we print withc kind of errno
we got and name of the clock.

> +
> +		} else {
> +
> +			tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s "
> +					"expected %s, failed with %s instead.",
> +					clock_name(tc[i].type),
> +					tst_strerrno(tc[i].exp_err));

The format string didn't match the parameters here, fixed that.

> +		}
> +
> +		return;
> +	}
> +
> +	tst_res(TFAIL | TTERRNO, "clock_settime(2): clock %s passed "
> +				 "unexpectedly, expected %s",
> +				 clock_name(tc[i].type),
> +				 tst_strerrno(tc[i].exp_err));
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_clock_settime,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.needs_root = 1,
> +	.restore_wallclock = 1,
> +};
> -- 
> 2.20.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
