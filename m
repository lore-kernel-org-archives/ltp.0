From: xieziyao <xieziyao@huawei.com>
Date: Mon, 26 Apr 2021 11:35:55 +0000
Subject: [LTP] [PATCH 2/2] syscalls/tkill: Convert tkill02 to the new API
In-Reply-To: <YIagGNrM6az0oMk6@pevik>
References: <20210422065732.61222-1-xieziyao@huawei.com>
 <20210422065732.61222-3-xieziyao@huawei.com> <YIagGNrM6az0oMk6@pevik>
Message-ID: <eadd5bf5cfc34977b9fc4ccf7cf053fb@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Petr,

LGTM, thanks for your review.

Best Regards,
Ziyao

-----Original Message-----
From: Petr Vorel [mailto:pvorel@suse.cz] 
Sent: Monday, April 26, 2021 7:12 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 2/2] syscalls/tkill: Convert tkill02 to the new API

Hi,

LGTM with very minor changes.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +static pid_t expired_pid;
>  static pid_t inval_tid = -1;
> -static pid_t unused_tid;

IMHO unused_tid is better describe what the variable holds.

> -
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> -
> -void setup(void)
> -{
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -
> -	unused_tid = tst_get_unused_pid(cleanup);
> -}

>  struct test_case_t {
>  	int *tid;
>  	int exp_errno;
> -} test_cases[] = {
> -	{&inval_tid, EINVAL},
> -	{&unused_tid, ESRCH}
> +	const char *desc;
> +} tc[] = {
> +	{&inval_tid, EINVAL, "inval_tid"},
> +	{&expired_pid, ESRCH, "expired_pid"}
Well, there is no point to print variable name.  Better would be "invalid TID"
and "unused TID". But IMHO just writing what we expect is enough.

It could be:
#define ERRNO_DESC(x) .exp_errno = x, .desc = "exp" #x ...

	{&inval_tid, ERRNO_DESC(EINVAL},
	{&expired_pid, ERRNO_DESC(ESRCH}

But we have tst_strerrno(), thus just:

struct test_case_t {
	int *tid;
	int exp_errno;
} tc[] = {
	{&inval_tid, EINVAL},
	{&unused_tid, ESRCH}
};

...
	TST_EXP_FAIL(tst_syscall(__NR_tkill, *(tc[i].tid), SIGUSR1),
		     tc[i].exp_errno, "tst_syscall(__NR_tkill) expecting %s",
			 tst_strerrno(tc[i].exp_errno));

I'll merge code below.

Kind regards,
Petr

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) Crackerjack Project., 2007
 * Ported from Crackerjack to LTP by Manas Kumar Nayak maknayak@in.ibm.com>  */

/*\
 * [Description]
 *
 * Basic tests for the tkill() errors.
 *
 * [Algorithm]
 *
 * - EINVAL on an invalid thread ID
 * - ESRCH when no process with the specified thread ID exists  */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <signal.h>
#include <sys/syscall.h>

#include "lapi/syscalls.h"
#include "tst_test.h"

static pid_t unused_tid;
static pid_t inval_tid = -1;

struct test_case_t {
	int *tid;
	int exp_errno;
} tc[] = {
	{&inval_tid, EINVAL},
	{&unused_tid, ESRCH}
};

static void setup(void)
{
	unused_tid = tst_get_unused_pid();
}

static void run(unsigned int i)
{
	TST_EXP_FAIL(tst_syscall(__NR_tkill, *(tc[i].tid), SIGUSR1),
		     tc[i].exp_errno, "tst_syscall(__NR_tkill) expecting %s",
			 tst_strerrno(tc[i].exp_errno));
}

static struct tst_test test = {
	.tcnt = ARRAY_SIZE(tc),
	.needs_tmpdir = 1,
	.setup = setup,
	.test = run,
};
