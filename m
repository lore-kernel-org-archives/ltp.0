From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Apr 2019 11:07:17 +0200
Subject: [LTP] [PATCH v1] syscalls/ioprio: add ioprio_get/ioprio_set
	tests
In-Reply-To: <20190409062926.13584-1-camann@suse.com>
References: <20190409062926.13584-1-camann@suse.com>
Message-ID: <20190411090717.GB1498@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Christian Amann <camann@suse.com>
> ---
>  testcases/kernel/syscalls/ioprio/.gitignore |   2 +
>  testcases/kernel/syscalls/ioprio/Makefile   |  14 ++++
>  testcases/kernel/syscalls/ioprio/ioprio01.c | 106 ++++++++++++++++++++++++++++
>  testcases/kernel/syscalls/ioprio/ioprio02.c |  88 +++++++++++++++++++++++
>  4 files changed, 210 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ioprio/.gitignore
>  create mode 100644 testcases/kernel/syscalls/ioprio/Makefile
>  create mode 100644 testcases/kernel/syscalls/ioprio/ioprio01.c
>  create mode 100644 testcases/kernel/syscalls/ioprio/ioprio02.c
> 
> diff --git a/testcases/kernel/syscalls/ioprio/.gitignore b/testcases/kernel/syscalls/ioprio/.gitignore
> new file mode 100644
> index 000000000..35e759777
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioprio/.gitignore
> @@ -0,0 +1,2 @@
> +/ioprio01
> +/ioprio02
> diff --git a/testcases/kernel/syscalls/ioprio/Makefile b/testcases/kernel/syscalls/ioprio/Makefile
> new file mode 100644
> index 000000000..d89eb7797
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioprio/Makefile
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +#   Copyright (c) 2019 SUSE LLC
> +#
> +#   Author: Christian Amann <camann@suse.com>
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +ioprio01: CFLAGS += -pthread
> diff --git a/testcases/kernel/syscalls/ioprio/ioprio01.c b/testcases/kernel/syscalls/ioprio/ioprio01.c
> new file mode 100644
> index 000000000..b35dcd09e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioprio/ioprio01.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + *
> + */
> +
> +/*
> + * Tests the functionality to set I/O priority using
> + * ioprio_set and then checks if it was set correctly
> + * using ioprio_get
> + *
> + * 1) Set the priority using the process ID to best-effort scheduling
> + * 2) Set the priority using the process ID to idle scheduling
> + * 3) Set the priority using the group ID to best-effort scheduling
> + * 4) Set the priority using the ID of a thread to real-time scheduling
> + * 5) Set the priority using the user ID to best-effort scheduling
> + *
> + */
> +
> +#include <stdlib.h>
> +#include "config.h"
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/syscalls.h"
> +#include "sys/types.h"

This shuld be <sys/types.h> since it's system header.

> +#include "../utils/ioprio.h"

Definitions from this header should be moved to lapi/ioprio.h

> +#define gettid() tst_syscall(__NR_gettid)
> +
> +static int uid;
> +static int pid;
> +static int gid;
> +static int tid;
> +
> +static struct tcase {
> +	int	which;
> +	int	*who;
> +	int	priority;
> +	int	sched_class;
> +} tcases[] = {
> +	{IOPRIO_WHO_PROCESS, &pid, 0, IOPRIO_CLASS_BE},
> +	{IOPRIO_WHO_PROCESS, &pid, 7, IOPRIO_CLASS_IDLE},
> +	{IOPRIO_WHO_PGRP, &gid, 0, IOPRIO_CLASS_BE},
> +	{IOPRIO_WHO_PROCESS, &tid, 7, IOPRIO_CLASS_RT},
> +	{IOPRIO_WHO_USER, &uid, 3, IOPRIO_CLASS_BE},
> +};
> +
> +static int sys_ioprio_get(int which, int who)
> +{
> +	return tst_syscall(__NR_ioprio_get, which, who);
> +}
> +static int sys_ioprio_set(int which, int who, int ioprio)
> +{
> +	return tst_syscall(__NR_ioprio_set, which, who, ioprio);
> +}

And these wrappers should be put into the lapi/ioprio.h header as well.

> +static void verify_ioprio(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int setIOprio, getIOprio;

Mixed case is frowned upon in LKML coding style, set_io_prio and
get_io_prio.

> +	setIOprio = IOPRIO_PRIO_VALUE(tc->sched_class, tc->priority);
> +
> +	TEST(sys_ioprio_set(tc->which, *tc->who, setIOprio));
> +
> +	if (TST_RET != 0) {
> +		tst_res(TFAIL, "ioprio_set failed with error %s",
> +				tst_strerrno(TST_ERR));
> +		return;
> +	}
> +
> +	TEST(getIOprio = sys_ioprio_get(tc->which, *tc->who));

If you use the TEST() macro the return value is stored in TST_RET and
errno in TST_ERR, which is the whole point of the macro, assigning the
return value to a variable inside of that macro defeats its purpose.

> +	if (setIOprio != getIOprio) {
> +		tst_res(TFAIL, "ioprio_get returned wrong IO priority");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "ioprio_set set correct IO priority");
> +}
> +
> +static void io_thread(void)
> +{
> +	tid = gettid();
> +	pause();
> +}
> +
> +static void setup(void)
> +{
> +	uid = getuid();
> +	gid = getgid();
> +	pid = getpid();
> +	pthread_t thread;
> +
> +	SAFE_PTHREAD_CREATE(&thread, NULL,
> +			(void * (*)(void *)) io_thread, NULL);

This cast is ugly, what we generally do in LTP is to match prototype
function and avoid warnings with this trick:


static void *thread_fn(void *unused)
{
	...

	return unused;
}

> +}
> +
> +static struct tst_test test = {
> +	.test = verify_ioprio,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.needs_root = 1,
> +	.min_kver = "2.6.13",
> +};

The same minor comments apply to the second test as well.


Also I do wonder if we can write a functional test for the syscall, I
guess that we can run two threads doing I/O with a different priorities
and check if the one with higher priority did more.

-- 
Cyril Hrubis
chrubis@suse.cz
