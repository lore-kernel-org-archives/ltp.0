From: xieziyao <xieziyao@huawei.com>
Date: Mon, 26 Apr 2021 11:24:08 +0000
Subject: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API
In-Reply-To: <YIaWnt5ksxVyBvxk@pevik>
References: <20210422065732.61222-1-xieziyao@huawei.com>
 <20210422065732.61222-2-xieziyao@huawei.com> <YIaWnt5ksxVyBvxk@pevik>
Message-ID: <ae16017b01474cbb9d4d0e74e473a7c4@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks for your review, Petr.

> +	TEST(tst_syscall(__NR_tkill, tid, SIGUSR1));
> +	if (TST_RET == 0) {
> +		while (!sig_flag);

This while loop is written to check whether the sighandler function captures the SIGUSR1 signal and set sig_flag to 1.

> +		tst_res(TPASS, "tst_syscall(__NR_tkill, %d, SIGUSR1)", tid);
> +	} else {
> +		tst_res(TFAIL | TTERRNO,
> +			"tst_syscall(__NR_tkill, %d, SIGUSR1)", tid);
>  	}
> -	cleanup();
> -	tst_exit();
>  }

Other comments are fine to me.

Best Regards,
Ziyao

-----Original Message-----
From: Petr Vorel [mailto:pvorel@suse.cz] 
Sent: Monday, April 26, 2021 6:32 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API

Hi,

> 1. Convert tkill01 to the new API;
> 2. Capture signals to verify success, while the previous code didn't 
> make it work.

Generally LGTM, with comments below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -48,59 +24,37 @@
>  #include <linux/unistd.h>
>  #include <sys/types.h>
I removed these as not needed. The only one which is still relevant is <signal.h> (I kept it although it's not needed to be included, as it's included in tst_safe_macros.h which are included in tst_test.h).

> -#include "test.h"
>  #include "lapi/syscalls.h"
> +#include "tst_test.h"

> +int sig_flag = 0;

It should be
static int sig_flag;

...
> +static void run(void)
...
> +	SAFE_SIGNAL(SIGUSR1, sighandler);
> +	TEST(tid = tst_syscall(__NR_gettid));
> +	if (TST_RET == -1)
> +		tst_res(TFAIL | TTERRNO, "tst_syscall(__NR_gettid) failed");
gettid() manpage says "ERRORS: This call is alway successful". I suppose this is true also for raw syscall. And it's certainly true for tst_syscall(__NR_gettid).

BTW if it really needed to be checked, tst_brk() or tst_res() with return would need to be used.
> +
> +	TEST(tst_syscall(__NR_tkill, tid, SIGUSR1));
> +	if (TST_RET == 0) {
> +		while (!sig_flag);
Not sure why you required this.
> +		tst_res(TPASS, "tst_syscall(__NR_tkill, %d, SIGUSR1)", tid);
> +	} else {
> +		tst_res(TFAIL | TTERRNO,
> +			"tst_syscall(__NR_tkill, %d, SIGUSR1)", tid);
>  	}
> -	cleanup();
> -	tst_exit();
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +};
In the end going to merge code below.

Kind regards,
Petr

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) Linux Test Project, 2009-2021
 * Copyright (c) Crackerjack Project., 2007
 * Ported from Crackerjack to LTP by Manas Kumar Nayak maknayak@in.ibm.com>  */

/*\
 * [Description]
 *
 * Basic tests for the tkill syscall.
 *
 * [Algorithm]
 *
 * Calls tkill and capture signals to verify success.
 */

#include <signal.h>

#include "lapi/syscalls.h"
#include "tst_test.h"

static int sig_flag;

static void sighandler(int sig)
{
	if (sig == SIGUSR1)
		sig_flag = 1;
}

static void run(void)
{
	int tid;

	SAFE_SIGNAL(SIGUSR1, sighandler);

	tid = tst_syscall(__NR_gettid);

	TST_EXP_PASS(tst_syscall(__NR_tkill, tid, SIGUSR1)); }

static struct tst_test test = {
	.needs_tmpdir = 1,
	.test_all = run,
};
