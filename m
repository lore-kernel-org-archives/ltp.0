From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Jul 2019 15:04:28 +0200
Subject: [LTP] [PATCH v3] timers/timer_create0{2, 3,
 4}: Ported to new library
In-Reply-To: <20190718062546.7843-1-camann@suse.com>
References: <20190718062546.7843-1-camann@suse.com>
Message-ID: <20190718130428.GA21682@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -#define CLEANUP cleanup

Removing this line breaks the compilation for the timer_delete() tests,
it should be removed once these are rewritten, (yes there is a CLEANUP()
function defined in the old library headers which, after this define
becomes cleanup(), it's a mess we have to get rid off but let's do that
step by a step).

HINT: Do make clean && make in the timers directory after applying this
      patch.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
> + *
> + * Author: Aniruddha Marathe <aniruddha.marathe@wipro.com>
> + *
> + * Ported to new library:
> + * 07/2019      Christian Amann <camann@suse.com>
> + */
> +/*
> + * Basic error handling test for timer_create(2):
> + *
> + *	Passes invalid parameters when calling the syscall and checks
> + *	if it fails with EFAULT:
> + *	1) Pass an invalid pointer for the sigevent structure parameter
> + *	2) Pass an invalid pointer for the timer ID parameter
> + */
> +
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <time.h>
> +#include <signal.h>
> +#include "tst_test.h"
> +#include "common_timers.h"
> +
> +static struct sigevent sig_ev;
> +static kernel_timer_t  timer_id;
> +
> +static struct testcase {
> +	struct sigevent	*ev_ptr;
> +	kernel_timer_t	*kt_ptr;
> +	int		error;
> +	char		*description;
> +} tcases[] = {
> +	{NULL, &timer_id, EFAULT, "invalid sigevent struct"},
> +	{&sig_ev, NULL, EFAULT, "invalid timer ID"},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	unsigned int i;
> +	struct testcase *tc = &tcases[n];
> +
> +	tst_res(TINFO, "Testing for %s.", tc->description);
> +
> +	for (i = 0; i < CLOCKS_DEFINED; ++i) {
> +		clock_t clock = clock_list[i];
> +
> +		/* PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
> +		 * kernel versions lower than 2.6.12
> +		 */
> +		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
> +			clock == CLOCK_THREAD_CPUTIME_ID) {
> +			if (!have_cputime_timers())
> +				tc->error = EINVAL;
> +		}
> +
> +		TEST(tst_syscall(__NR_timer_create, clock_list[n], tc->ev_ptr,
> +			     tc->kt_ptr));
> +
> +		if (TST_RET != -1 || TST_ERR != tc->error) {
> +			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
> +				tst_res(TPASS | TTERRNO,
> +					"%s unsupported, failed as expected",
> +					get_clock_str(clock));
> +			} else {
> +				tst_res(TFAIL | TTERRNO,
> +					"%s didn't fail as expected (%s) - Got",
> +					get_clock_str(clock),
> +					tst_strerrno(tc->error));
> +			}
> +			continue;
> +		}
> +		tst_res(TPASS, "Timer creation for %s failed as expected: %s",
> +				get_clock_str(clock), tst_strerrno(tc->error));
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	tcases[0].ev_ptr = tst_get_bad_addr(NULL);
> +	tcases[1].kt_ptr = tst_get_bad_addr(NULL);

Can we rather do:

	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
		if (!tcases[i].ev_ptr)
			tcases[i].ev_ptr = tst_get_bad_addr();

		if (!tcases[i].kt_ptr)
			tcases[i].kt_ptr = tst_get_bad_addr();
	}

That way we do not depend on the order of the structure.

Also we should probably move these tests to the syscalls/timer_create/
directory and add them to the syscalls runtest file. But let's do that
in a separate patch. We may also rename them to 01 and 02 in that patch.

And this test misses EINVAL tests for:

* wrong timer id
  (we do have MAX_CLOCKS constant in lapi/posix_clocks.h for that)

* wrong content of the sigevent structure

But given that the original test was missing these we may as well do
that in a follow up patch as well.

-- 
Cyril Hrubis
chrubis@suse.cz
