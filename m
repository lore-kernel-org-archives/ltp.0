From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2015 18:33:50 +0200
Subject: [LTP] [PATCH v2] sched_getattr/sched_getattr01: Add new
 testcase to test sched_getattr
Message-ID: <20150929163350.GB32435@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[CCing the new LTP mailing list, please reply to this email only]

Hi!
> +/*
> + * Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#ifndef __SCHED_H__
> +#define __SCHED_H__
> +
> +#include "linux_syscall_numbers.h"

You should include stdint.h here to get the int32_t and uint64_t types
defined.

> diff --git a/runtest/sched b/runtest/sched
> index 16877a3..10a1648 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -9,6 +9,8 @@ trace_sched01		trace_sched -c 1
>  hackbench01 hackbench 50 process 1000
>  hackbench02 hackbench 20 thread 1000
> 
> +sched_getattr01 sched_getattr01

Given that this is simple sched_getattr syscall test we may as well
include the test in runtest/syscalls.

> diff --git a/testcases/kernel/syscalls/sched_getattr/Makefile b/testcases/kernel/syscalls/sched_getattr/Makefile
> new file mode 100644
> index 0000000..30d6cf3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_getattr/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2008
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CFLAGS			+= -lpthread
                                    ^
				    This should be -pthread see for
				    example 'man pthread_create'

> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> new file mode 100644
> index 0000000..6570e86
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> @@ -0,0 +1,92 @@
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <linux/unistd.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <sys/syscall.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "linux_syscall_numbers.h"
> +#include "lapi/sched.h"
> +
> +char *TCID = "edf_test01";
> +int TST_TOTAL = 1;
> +
> +#define SCHED_DEADLINE	6
> +#define RUNTIME_VAL 10000000
> +#define PERIOD_VAL 30000000
> +#define DEADLINE_VAL 30000000
> +
> +void *run_deadline(void *data)
> +{
> +	struct sched_attr attr, attr_copy;
> +	int ret;
> +	unsigned int flags = 0;
> +	unsigned int size;
> +
> +	attr.size = sizeof(attr);
> +	attr.sched_flags = 0;
> +	attr.sched_nice = 0;
> +	attr.sched_priority = 0;
> +
> +	/* This creates a 10ms/30ms reservation */
> +	attr.sched_policy = SCHED_DEADLINE;
> +	attr.sched_runtime = 10 * 1000 * 1000;
> +	attr.sched_period = 30 * 1000 * 1000;
> +	attr.sched_deadline = 30 * 1000 * 1000;
> +
> +	ret = sched_setattr(0, &attr, flags);
> +	if (ret < 0)
> +		tst_brkm(TFAIL | TERRNO, NULL, "sched_setattr error\n");
> +
> +	size = sizeof(attr_copy);
> +	ret = sched_getattr(0, &attr_copy, size, flags);
> +	if (ret < 0)
> +		tst_brkm(TFAIL | TERRNO, NULL, "sched_getattr error\n");
> +
> +	int fail = 0;
> +
> +	if (attr_copy.sched_runtime != RUNTIME_VAL) {
> +		tst_resm(TINFO, "sched_runtime is incorrect (%llu),expected"
> +				" %u", attr.sched_runtime, RUNTIME_VAL);
> +		fail++;
> +	}
> +	if (attr_copy.sched_period != PERIOD_VAL) {
> +		tst_resm(TINFO, "sched_period is incorrect (%llu),expected"
> +				" %u", attr.sched_period, PERIOD_VAL);
                                          ^
				Technically this is uint64_t so the
				clean way to print it is to use PRIu64
				or to cast the attribute to long long
				unsigned int.
> +		fail++;
> +	}
> +	if (attr_copy.sched_deadline != DEADLINE_VAL) {
> +		tst_resm(TINFO, "sched_deadline is incorrect (%llu),expected"
> +				" %u", attr.sched_deadline, DEADLINE_VAL);
> +		fail++;
> +	}
> +
> +	if (fail)
> +		tst_resm(TFAIL, "attributes were read back incorrectly");
> +	else
> +		tst_resm(TPASS, "attributes were read back correctly");
> +
> +	return NULL;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	pthread_t thread;
> +
> +	if ((tst_kvercmp(3, 14, 0)) < 0)
> +		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher\n");
> +
> +	pthread_create(&thread, NULL, run_deadline, NULL);
> +
> +	pthread_join(thread, NULL);
> +
> +	tst_exit();
> +}

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
