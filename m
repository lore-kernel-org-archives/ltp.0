From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 12 Dec 2018 18:46:54 -0200
Subject: [LTP] [PATCH v3 5/6] syscalls/clock_settime: create syscall
 clock_settime tests
In-Reply-To: <20181212203723.18810-5-rafael.tinoco@linaro.org>
References: <20181211142750.GA27159@rei>
 <20181212203723.18810-1-rafael.tinoco@linaro.org>
 <20181212203723.18810-5-rafael.tinoco@linaro.org>
Message-ID: <bd26bf86-a679-09cf-60f6-c61049a475e2@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/12/18 6:37 PM, Rafael David Tinoco wrote:
> Fixes: 343
> 
> clock_settime01 creates a new test, using new API, based on existing
> and older kernel/timers/clock_settime02 test. clock_settime02 creates
> another test based on older kernel/timers/clock_settime03 test. Both
> will be deleted in the next commits.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>  runtest/syscalls                              |   3 +
>  .../kernel/syscalls/clock_settime/.gitignore  |   2 +
>  .../kernel/syscalls/clock_settime/Makefile    |   8 +
>  .../syscalls/clock_settime/clock_settime01.c  |  75 +++++++++
>  .../syscalls/clock_settime/clock_settime02.c  | 150 ++++++++++++++++++
>  5 files changed, 238 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/clock_settime/.gitignore
>  create mode 100644 testcases/kernel/syscalls/clock_settime/Makefile
>  create mode 100644 testcases/kernel/syscalls/clock_settime/clock_settime01.c
>  create mode 100644 testcases/kernel/syscalls/clock_settime/clock_settime02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 34b47f36b..dd03ad31a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -79,6 +79,9 @@ clock_nanosleep01 clock_nanosleep01
>  clock_nanosleep02 clock_nanosleep02
>  clock_nanosleep2_01 clock_nanosleep2_01
>  
> +clock_settime01 clock_settime01
> +clock_settime02 clock_settime02
> +
>  clone01 clone01
>  clone02 clone02
>  clone03 clone03
> diff --git a/testcases/kernel/syscalls/clock_settime/.gitignore b/testcases/kernel/syscalls/clock_settime/.gitignore
> new file mode 100644
> index 000000000..281217550
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/.gitignore
> @@ -0,0 +1,2 @@
> +clock_settime01
> +clock_settime02
> diff --git a/testcases/kernel/syscalls/clock_settime/Makefile b/testcases/kernel/syscalls/clock_settime/Makefile
> new file mode 100644
> index 000000000..e6674a6b2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/Makefile
> @@ -0,0 +1,8 @@
> +# Copyright (c) 2018 - Linaro Limited. All rights reserved.
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime01.c b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
> new file mode 100644
> index 000000000..6e0ee47c4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Linaro Limited. All rights reserved.
> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
> + */
> +
> +/*
> + * Basic test for clock_settime(2) on REALTIME clock:
> + *
> + *      1) advance DELTA_SEC seconds
> + *      2) go backwards DELTA_SEC seconds
> + *
> + * Restore wall clock at the end of test.
> + */
> +
> +#include "config.h"
> +#include "tst_timer.h"
> +#include "tst_safe_clocks.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#define DELTA_SEC 10
> +#define DELTA_SEC_US (long long) (DELTA_SEC * 1000000)
> +#define DELTA_SEC_VAR_POS (long long) (DELTA_SEC_US * 1.10)
> +#define DELTA_SEC_VAR_NEG (long long) (DELTA_SEC_US * 0.90)
> +
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
> +
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
> +		tst_res(TPASS, "clock_settime(2): was able to recede time");
> +	} else {
> +		tst_res(TFAIL, "clock_settime(2): could not recede time");
> +	}
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

Cyril, I haven't done a global timespec, having a pointer inside the
test_case structure, just because there are a few other tests, like when
having sec to -1, nsec to -1, etc.. and I wouldn't be able to set those
during compilation time.. I hope you don't mind, test is functional and
working good.

-- 
Rafael D. Tinoco
Linaro - Kernel Validation
