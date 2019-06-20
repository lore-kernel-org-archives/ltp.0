From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jun 2019 15:09:51 +0200
Subject: [LTP] [PATCH 1/2] syscalls/futex_cmp_requeue01.c: Add new test
In-Reply-To: <1559573519-4644-1-git-send-email-ice_yangxiao@163.com>
References: <1559573519-4644-1-git-send-email-ice_yangxiao@163.com>
Message-ID: <20190620130951.GA16394@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 762b15b..fd5f1ec 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1546,6 +1546,7 @@ writev07 writev07
>  perf_event_open01 perf_event_open01
>  perf_event_open02 perf_event_open02
>  
> +futex_cmp_requeue01 futex_cmp_requeue01
>  futex_wait01 futex_wait01
>  futex_wait02 futex_wait02
>  futex_wait03 futex_wait03
> diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
> index dbc2d52..4666a2c 100644
> --- a/testcases/kernel/syscalls/futex/.gitignore
> +++ b/testcases/kernel/syscalls/futex/.gitignore
> @@ -1,3 +1,4 @@
> +/futex_cmp_requeue01
>  /futex_wait01
>  /futex_wait02
>  /futex_wait03
> diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
> index 6e72daf..c4d5033 100644
> --- a/testcases/kernel/syscalls/futex/Makefile
> +++ b/testcases/kernel/syscalls/futex/Makefile
> @@ -18,6 +18,7 @@
>  
>  top_srcdir		?= ../../../..
>  
> +futex_cmp_requeue01: LDLIBS+=-lrt
>  futex_wait02: LDLIBS+=-lrt
>  futex_wake03: LDLIBS+=-lrt
>  futex_wait03: CFLAGS+=-pthread
> diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> new file mode 100644
> index 0000000..88b71cd
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Xiao Yang <ice_yangxiao@163.com>
> + *
> + * Description:
> + * Testcase to check the basic functionality of futex(FUTEX_CMP_REQUEUE).
> + * futex(FUTEX_CMP_REQUEUE) can wake up the number of waiters specified
> + * by val argument and then requeue the number of waiters limited by val2
> + * argument(i.e. move some remaining waiters from uaddr to uaddr2 address).
> + */
> +
> +#include <errno.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +#include <linux/futex.h>
> +#include <sys/time.h>
> +
> +#include "tst_timer_test.h"
> +#include "tst_test.h"
> +#include "futextest.h"
> +#include "futexes_comm.h"
> +
> +#define NUM_WAITERS	3
> +
> +static struct tcase {
> +	int set_wakes;
> +	int set_requeues;
> +	int exp_ret;
> +	int exp_wakes;
> +	int exp_requeues;
> +} tcases[] = {
> +	{1, 2, 3, 1, 2},
> +	{2, 1, 3, 2, 1},
> +	{0, 3, 3, 0, 3},
> +	{1, 1, 2, 1, 1},
> +	{0, 2, 2, 0, 2},
> +	{0, 1, 1, 0, 1},

I wonder if we should add some tests with slightly bigger numbers here,
something as 100 processes should be still small enough even for
embedded hardware...

> +};
> +
> +static void do_child(void)
> +{
> +	struct timespec usec = tst_ms_to_timespec(2000);
> +	int pid = getpid();
> +
> +	if (!futex_wait(&futexes[0], futexes[0], &usec, 0))
> +		tst_res(TINFO, "process %d was woken up", pid);
> +	else
> +		tst_res(TINFO, "process %d wasn't woken up, errno %s",
> +			pid, tst_strerrno(errno));

You can use TINFO | TERRNO instead of the "%s" and tst_strerrno(errno)
here.

> +	exit(0);
> +}
> +
> +static void verify_futex_cmp_requeue(unsigned int n)
> +{
> +	int pid[NUM_WAITERS];
> +	int i;
> +	int manu_wakes1, manu_wakes2;
> +	struct tcase *tc = &tcases[n];
> +
> +	for (i = 0; i < NUM_WAITERS; i++) {
> +		pid[i] = SAFE_FORK();
> +		if (!pid[i])
> +			do_child();
> +	}
> +
> +	for (i = 0; i < NUM_WAITERS; i++)
> +		TST_PROCESS_STATE_WAIT(pid[i], 'S');
> +
> +	TEST(futex_cmp_requeue(&futexes[0], futexes[0], &futexes[1],
> +	     tc->set_wakes, tc->set_requeues, 0));
> +	if (TST_RET != tc->exp_ret) {
> +		tst_res(TFAIL, "futex_cmp_requeue() returned %ld, expected %d",
> +			TST_RET, tc->exp_ret);
> +		goto end;
> +	}
> +
> +	manu_wakes1 = futex_wake(&futexes[1], NUM_WAITERS, 0);
         ^
	num_wakes1 ?

	manu_wakes1 sounds strange

> +	if (manu_wakes1 != tc->exp_requeues) {
> +		tst_res(TFAIL,
> +			"futex_cmp_requeue() requeues %d waiter(s), expected %d",
> +			manu_wakes1, tc->exp_requeues);
> +		goto end;
> +	}
> +
> +	manu_wakes2 = futex_wake(&futexes[0], NUM_WAITERS, 0);
> +	if (NUM_WAITERS - manu_wakes1 - manu_wakes2 != tc->exp_wakes) {
> +		tst_res(TFAIL,
> +			"futex_cmp_requeue() woke %d waiter(s), expected %d",
> +			NUM_WAITERS - manu_wakes1 - manu_wakes2,
> +			tc->exp_wakes);
> +		goto end;
> +	}
> +
> +	tst_res(TPASS,
> +		"futex_cmp_requeue() woke %d waiter(s) and requeued %d waiter(s)",
> +		tc->exp_wakes, tc->exp_requeues);
> +
> +end:

shouldn't we just do futex_wake() with INT_MAX here for both addresses,
otherwise we will just hang here in the waitpid in case we got here from
one of the goto jumps.

> +	for (i = 0; i < NUM_WAITERS; i++)
> +		SAFE_WAITPID(pid[i], NULL, 0);

We may as well be pedantic here and check that the processes has exitted
with 0.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup_futexes,
> +	.cleanup = cleanup_futexes,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_futex_cmp_requeue,
> +	.forks_child = 1,
> +};
> diff --git a/testcases/kernel/syscalls/futex/futexes_comm.h b/testcases/kernel/syscalls/futex/futexes_comm.h
> new file mode 100644
> index 0000000..fe07bc4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futexes_comm.h
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Xiao Yang <ice_yangxiao@163.com>
> + *
> + * Setup futexes in shared memory needed for synchronization
> + * between multiple processes.
> + */
> +
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +static futex_t *futexes;
> +
> +static void setup_futexes(void)
> +{
> +	int fd;
> +
> +	fd = shm_open("/LTP_futexes", O_RDWR | O_CREAT | O_EXCL, 0755);
> +	if (fd < 0) {
> +		tst_brk(TBROK | TERRNO,
> +			"shm_open(/LTP_futexes, O_RDWR|O_CREAT|O_EXCL, 775)");
> +	}
> +
> +	if (shm_unlink("/LTP_futexes"))
> +		tst_brk(TBROK | TERRNO, "shm_unlink(/LTP_futexes)");
> +
> +	SAFE_FTRUNCATE(fd, sizeof(futex_t) * 2);
> +
> +	futexes = SAFE_MMAP(NULL, sizeof(futex_t) * 2, PROT_READ | PROT_WRITE,
> +			    MAP_ANONYMOUS | MAP_SHARED, fd, 0);
> +
> +	SAFE_CLOSE(fd);
> +
> +	futexes[0] = FUTEX_INITIALIZER;
> +	futexes[1] = FUTEX_INITIALIZER + 1;

Sigh, looks like this is new library version of the futex_common.h.
However the futex_common.h is flaved in the very same way this copy is.

There is actually no point in passing a file descriptor to a mmap() with
MAP_ANONYMOUS flag, so you can just get rid for this header and just do:

futexes = SAFE_MMAP(NULL, sizeof(futex_t) * 2, PROT_READ | PROT_WRITE,
                    MAP_ANONYMOUS | MAP_SHARED, -1, 0);

Directly in the test setup, there is no point in having a header just
for one mmap().

And I will fix the old futex tests.

> +}
> +
> +static void cleanup_futexes(void)
> +{
> +	if (futexes)
> +		SAFE_MUNMAP((void *)futexes, sizeof(futex_t) * 2);
                             ^
			     This is useless cast.
> +}

Other than that it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
