From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Feb 2019 13:31:38 +0100
Subject: [LTP] [PATCH 1/2] syscalls/clock_gettime: create syscall
 clock_gettime tests
In-Reply-To: <20190206171703.5761-1-rafael.tinoco@linaro.org>
References: <20190206171703.5761-1-rafael.tinoco@linaro.org>
Message-ID: <20190207123137.GA9277@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +struct test_case {
> +	clockid_t clocktype;
> +	int exp_ret;
> +	int exp_err;
> +	int unsupported;
> +};
> +
> +struct test_case tc[] = {
> +	{
> +	 .clocktype = CLOCK_REALTIME,
> +	 },
> +	{
> +	 .clocktype = CLOCK_REALTIME_COARSE,
> +#ifndef CLOCK_REALTIME_COARSE
> +	 .exp_ret = -1,
> +	 .exp_err = EINVAL,
> +#endif

Depending on the constant beind defined is completely wrong here. The
only way how to figure out if the clock is being supported or not is to
call the clock_gettime() with correct paramters and check for EINVAL.

So I guess that in this test we should call clock_gettime() for
paticular clock and:

* For certain clocks that are implemented for long enough, we expect
  success, I would say that at least CLOCK_REALTIME, CLOCK_MONOTONIC and
  CLOCK_*_CPUTIME_ID should be implemented for long enough to be
  supported everywhere

* The rest of the clocks should be allowed either to pass or return EINVAL

* In case that the call passed we should check that the timespec has
  been changed (we should zero it before the call)

* Also many architectures have vDSO for clock_gettime() we should also
  check that the syscall and vDSO are consistent in this case

> +	 },
> +	{
> +	 .clocktype = CLOCK_MONOTONIC,
> +#ifndef CLOCK_MONOTONIC
> +	 .exp_ret = -1,
> +	 .exp_err = EINVAL,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_MONOTONIC_COARSE,
> +#ifndef CLOCK_MONOTONIC_COARSE
> +	 .exp_ret = -1,
> +	 .exp_err = EINVAL,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_MONOTONIC_RAW,
> +#ifndef CLOCK_MONOTONIC_RAW
> +	 .exp_ret = -1,
> +	 .exp_err = EINVAL,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_BOOTTIME,
> +#ifndef CLOCK_BOOTTIME
> +	 .exp_ret = -1,
> +	 .exp_err = EINVAL,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_PROCESS_CPUTIME_ID,
> +#ifndef CLOCK_PROCESS_CPUTIME_ID
> +	 .exp_ret = -1,
> +	 .exp_err = EINVAL,
> +#endif
> +	 },
> +{
> +	 .clocktype = CLOCK_THREAD_CPUTIME_ID,
> +#ifndef CLOCK_THREAD_CPUTIME_ID
> +	 .exp_ret = -1,
> +	 .exp_err = EINVAL,
> +#endif
> +	 },
> +};
> +
> +static void verify_clock_gettime(unsigned int i)
> +{
> +	struct timespec spec;
> +
> +	TEST(clock_gettime(tc[i].clocktype, &spec));
> +
> +	if (TST_RET == -1 && tc[i].exp_ret == -1) {
> +
> +		if (tc[i].exp_err == TST_ERR) {
> +			tst_res(TPASS, "clock_gettime(2): unsupported clock %s "
> +					"failed as expected",
> +					tst_clock_name(tc[i].clocktype));
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "clock_gettime(2): "
> +					"unsupported clock %s failed "
> +					"unexpectedly",
> +					tst_clock_name(tc[i].clocktype));
> +		}
> +		return;
> +	}
> +
> +	if (TST_RET == -1 && tc[i].exp_ret == 0) {
> +
> +		tst_res(TFAIL | TTERRNO, "clock_gettime(2): clock %s "
> +					"failed unexpectedly",
> +					tst_clock_name(tc[i].clocktype));
> +		return;
> +	}
> +
> +	if (TST_RET == 0 && tc[i].exp_ret == -1) {
> +
> +		tst_res(TFAIL, "clock_gettime(2): unsupported clock %s passed "
> +				"unexpectedly",
> +				tst_clock_name(tc[i].clocktype));
> +		return;
> +	}
> +
> +	tst_res(TPASS, "clock_gettime(2): clock %s passed",
> +			tst_clock_name(tc[i].clocktype));
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_clock_gettime,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.needs_root = 1,
> +};
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
> new file mode 100644
> index 000000000..5985cdec0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
> + */
> +/*
> + * Bad argument tests for clock_gettime(2) on multiple clocks:
> + *
> + *  1) MAX_CLOCKS                - bad clock
> + *  2) MAX_CLOCKS + 1            - bad clock
> + *  3) CLOCK_REALTIME            - bad time spec ptr (if supported)
> + *  4) CLOCK_MONOTONIC           - bad time spec ptr (if supported)
> + *  5) CLOCK_REALTIME_COARSE     - bad time spec ptr (if supported)
> + *  6) CLOCK_MONOTONIC_COARSE    - bad time spec ptr (if supported)
> + *  7) CLOCK_MONOTONIC_RAW       - bad time spec ptr (if supported)
> + *  8) CLOCK_BOOTTIME            - bad time spec ptr (if supported)
> + *  9) CLOCK_PROCESS_CPUTIME_ID  - bad time spec ptr (if supported)
> + * 10) CLOCK_THREAD_CPUTIME_ID   - bad time spec ptr (if supported)
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/posix_clocks.h"
> +#include "tst_timer.h"
> +#include "tst_safe_clocks.h"
> +
> +#define DELTA_SEC 10
> +#define NSEC_PER_SEC (1000000000L)
> +#define MAX_CLOCKS 16
> +
> +struct test_case {
> +	clockid_t clocktype;
> +	int exp_err;
> +};
> +
> +struct test_case tc[] = {
> +	{
> +	 .clocktype = MAX_CLOCKS,
> +	 .exp_err = EINVAL,
> +	 },
> +	{
> +	 .clocktype = MAX_CLOCKS + 1,
> +	 .exp_err = EINVAL,
> +	 },
> +	{
> +	 .clocktype = CLOCK_REALTIME,
> +	 .exp_err = EFAULT,
> +	 },
> +	{
> +	 .clocktype = CLOCK_MONOTONIC,
> +	 .exp_err = EFAULT,
> +	 },
> +	/*
> +	 * Different POSIX clocks have different (*clock_get)() handlers.
> +	 * It justifies testing EFAULT for all.
> +	 */
> +	{
> +	 .clocktype = CLOCK_REALTIME_COARSE,
> +#ifndef CLOCK_REALTIME_COARSE
> +	 .exp_err = EINVAL,
> +#else
> +	 .exp_err = EFAULT,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_MONOTONIC_COARSE,
> +#ifndef CLOCK_MONOTONIC_COARSE
> +	 .exp_err = EINVAL,
> +#else
> +	 .exp_err = EFAULT,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_MONOTONIC_RAW,
> +#ifndef CLOCK_MONOTONIC_RAW
> +	 .exp_err = EINVAL,
> +#else
> +	 .exp_err = EFAULT,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_BOOTTIME,
> +#ifndef CLOCK_BOOTTIME
> +	 .exp_err = EINVAL,
> +#else
> +	 .exp_err = EFAULT,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_PROCESS_CPUTIME_ID,
> +#ifndef CLOCK_PROCESS_CPUTIME_ID
> +	 .exp_err = EINVAL,
> +#else
> +	 .exp_err = EFAULT,
> +#endif
> +	 },
> +	{
> +	 .clocktype = CLOCK_THREAD_CPUTIME_ID,
> +#ifndef CLOCK_THREAD_CPUTIME_ID
> +	 .exp_err = EINVAL,
> +#else
> +	 .exp_err = EFAULT,
> +#endif
> +	 },
> +};
> +
> +/*
> + * Some tests may cause libc to segfault when passing bad arguments.
> + */
> +static int sys_clock_gettime(clockid_t clk_id, struct timespec *tp)
> +{
> +	return tst_syscall(__NR_clock_gettime, clk_id, tp);
> +}
> +
> +static void verify_clock_gettime(unsigned int i)
> +{
> +	struct timespec spec, *specptr;
> +
> +	specptr = &spec;
> +
> +	/* bad pointer case */
> +	if (tc[i].exp_err == EFAULT)
> +		specptr = tst_get_bad_addr(NULL);
> +
> +	TEST(sys_clock_gettime(tc[i].clocktype, specptr));
> +
> +	if (TST_RET == -1) {
> +
> +		if (tc[i].exp_err == TST_ERR) {
> +			tst_res(TPASS, "clock_gettime(2): %sclock %s failed as "
> +					"expected", (tc[i].exp_err == EINVAL) ?
> +					"unsupported " : "",
> +					tst_clock_name(tc[i].clocktype));
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "clock_gettime(2): %sclock %s "
> +					"failed unexpectedly",
> +					(tc[i].exp_err == EINVAL) ?
> +					"unsupported " : "",
> +					tst_clock_name(tc[i].clocktype));
> +		}
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "clock_gettime(2): %sclock %s passed unexpectedly",
> +			(tc[i].exp_err == EINVAL) ? "unsupported " : "",
> +			tst_clock_name(tc[i].clocktype));
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_clock_gettime,
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
