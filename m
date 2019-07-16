From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jul 2019 17:53:11 +0200
Subject: [LTP] [PATCH v2] timers/timer_create0{2, 3,
 4}: Ported to new library
In-Reply-To: <20190715125426.30568-1-camann@suse.com>
References: <20190715125426.30568-1-camann@suse.com>
Message-ID: <20190716155311.GA4641@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
> + *
> + * Author:	Aniruddha Marathe <aniruddha.marathe@wipro.com>
> + *
> + * Ported to new library:
> + * 07/2019	Christian Amann <camann@suse.com>
> + */
> +/*
> + *
> + * Basic test for timer_create(2):
> + *
> + *	Creates a timer for each available clock using the
> + *	following notification types:
> + *	1) SIGEV_NONE
> + *	2) SIGEV_SIGNAL
> + *	3) SIGEV_THREAD
> + *	4) SIGEV_THREAD_ID
> + *	5) NULL
> + */
> +
> +#include <signal.h>
> +#include <time.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "common_timers.h"
> +
> +static struct sigevent evp;

I guess that there is no reason for evp to be global variable now.

> +static struct notif_type {
> +	int		sigev_signo;
> +	int		sigev_notify;
> +	char		*message;
> +	struct sigevent *sevp;
> +} types[] = {
> +	{SIGALRM, SIGEV_NONE, "SIGEV_NONE", &evp},
> +	{SIGALRM, SIGEV_SIGNAL, "SIGEV_SIGNAL", &evp},
> +	{SIGALRM, SIGEV_THREAD, "SIGEV_THREAD", &evp},
> +	{SIGALRM, SIGEV_THREAD_ID, "SIGEV_THREAD_ID", &evp},
> +	{0, 0, "NULL", NULL},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	unsigned int i;
> +	struct notif_type *nt = &types[n];
> +	kernel_timer_t created_timer_id;
> +
> +	tst_res(TINFO, "Testing notification type: %s", nt->message);
> +
> +	memset(&evp, 0, sizeof(evp));
> +
> +	for (i = 0; i < CLOCKS_DEFINED; ++i) {
> +		clock_t clock = clock_list[i];
> +
> +		evp.sigev_value  = (union sigval) 0;
> +		evp.sigev_signo  = nt->sigev_signo;
> +		evp.sigev_notify = nt->sigev_notify;
> +
> +		if (strstr(get_clock_str(clock), "CPUTIME_ID")) {

Maybe even here we can go for explicit:

	clock == CLOCK_PROCESS_CPUTIME_ID ||
	clock == CLOCK_THREAD_CPUTIME_ID

> +			/* (PROCESS_CPUTIME_ID &
> +			 *  THREAD_CPUTIME_ID)
> +			 * is not supported on kernel versions
> +			 * lower than 2.6.12
> +			 */
> +			if ((tst_kvercmp(2, 6, 12)) < 0)
> +				continue;
> +		}
> +		if (!strcmp(get_clock_str(clock), "MONOTONIC_RAW"))
> +			continue;

Why not just clock == CLOCK_MONOTONIC_RAW ?

> +		if (!strcmp(nt->message, "SIGEV_THREAD_ID"))
> +			evp._sigev_un._tid = getpid();

Here as well, why not just nt->sigev_notify == SIGEV_THREAD_ID ?

> +		TEST(tst_syscall(__NR_timer_create,
> +			clock, nt->sevp,
> +			&created_timer_id));
> +
> +		if (TST_RET != 0) {
> +			if (allowed_to_fail(clock) && TST_ERR == EINVAL) {
> +				tst_res(TPASS,
> +					"%s unsupported, failed as expected: %s",
> +					get_clock_str(clock),
> +					tst_strerrno(TST_ERR));
                                           ^
                                          You can use TTERRNO flag here instead.
> +			} else {
> +				tst_res(TFAIL | TTERRNO,
> +					"Failed to create timer for %s",
> +					get_clock_str(clock));
> +			}
> +			continue;
> +		}
> +
> +		tst_res(TPASS, "Timer successfully created for %s",
> +					get_clock_str(clock));
> +
> +		TEST(tst_syscall(__NR_timer_delete, created_timer_id));
> +		if (TST_RET != 0) {
> +			tst_res(TINFO, "Failed to delete timer %s",
                                  ^
				  Really TINFO I would go for TFAIL|TTERRNO here
> +				get_clock_str(clock));
> +		}
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(types),
> +	.needs_root = 1,
> +};

...

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
> +static int have_recent_kernel(void)
> +{
> +	return tst_kvercmp(2, 6, 12) >= 0;
> +}
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
> +		if (strstr(get_clock_str(clock), "CPUTIME_ID") &&
> +		    !have_recent_kernel())
                           ^
			   Well recent is kind of relative word, I
			   wouldn't call 2.6.12 recent yet it works fine
			   here.

What about we called the function have_cputime_timers() or something
similar?

I guess that we can also put it in the common header and use it in the
previous test as well.


> +			tc->error = EINVAL;
> +
> +		TEST(tst_syscall(__NR_timer_create, clock_list[n], tc->ev_ptr,
> +			     tc->kt_ptr));
> +
> +		if (TST_RET != -1 || TST_ERR != tc->error) {
> +			if (allowed_to_fail(clock) && TST_ERR == EINVAL) {
                            ^
			    Maybe this should be called
			    "possibly_unsupported()" or something
			    similar.
> +				tst_res(TPASS,
> +					"%s unsupported, failes as expected: %s",
> +					get_clock_str(clock),
> +					tst_strerrno(TST_ERR));

                                        TTERRNO here as well

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
> +
> +	sig_ev.sigev_value  = (union sigval) 0;
> +	sig_ev.sigev_signo  = SIGALRM;
> +	sig_ev.sigev_notify = SIGEV_NONE;
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +};
> -- 
> 2.16.4
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
