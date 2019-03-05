From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Mar 2019 16:30:26 +0100
Subject: [LTP] [PATCH v2] syscalls: add rt_tgsigqueueinfo() test-case
In-Reply-To: <1551795743-30614-1-git-send-email-sumit.garg@linaro.org>
References: <1551795743-30614-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190305153025.GF13703@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> new file mode 100644
> index 0000000..132b31c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> + * Author: Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +/*
> + * Test rt_tgsigqueueinfo
> + *
> + * This tests the rt_tgsigqueueinfo() syscall. It sends the signal and data
> + * to the single thread specified by the combination of tgid, a thread group
> + * ID, and tid, a thread in that thread group.
> + *
> + * Also this implement 3 tests differing on the basis of signal sender:
> + * - Sender and receiver is the same thread.
> + * - Sender is parent of the thread.
> + * - Sender is different thread.
> + */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <string.h>
> +#include <pthread.h>
> +#include "tst_safe_pthread.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +static char sigval_send[] = "rt_tgsigqueueinfo data";
> +static int signum_rcv;

This has to be volatile, otherwise compiler has no idea that the value
could be changed asynchronically from within the signal handler and may
miscompile the loop (when optimalizations are enabled) that waits for
the signal arrival.

> +static char sigval_rcv[128];
> +
> +static pthread_cond_t sigusr1_cond = PTHREAD_COND_INITIALIZER;
> +static pthread_mutex_t sigusr1_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> +static pthread_cond_t tid_cond = PTHREAD_COND_INITIALIZER;
> +static pthread_mutex_t tid_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> +static void sigusr1_handler(int signum, siginfo_t *uinfo,
> +			    void *p LTP_ATTRIBUTE_UNUSED)
> +{
> +	char *rcv = uinfo->_sifields._rt.si_sigval.sival_ptr;
> +
> +	if (rcv)
> +		strcpy(sigval_rcv, rcv);

I do wonder if we need to really copy the data here. If we send a
pointer shouldn't be enough to store the pointer and check it against
sigval_send later on?

> +	signum_rcv = signum;
> +
> +	pthread_cond_broadcast(&sigusr1_cond);

It's not safe to call anything but a couple of signal-async-safe
functions in the signal handler, see:

http://www.man7.org/linux/man-pages/man7/signal-safety.7.html

I guess that the easiest solution here would be doing something as:

	while (!signum_rcv)
		usleep(1000);

Instead of the pthread_cond_wait().

> +}
> +
> +void *tfunc_self(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	siginfo_t uinfo;
> +
> +	signum_rcv = 0;
> +	memset(sigval_rcv, 0, sizeof(sigval_rcv));
> +
> +	uinfo.si_errno = 0;
> +	uinfo.si_code = SI_QUEUE;
> +	uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
> +
> +	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
> +			 syscall(__NR_gettid), SIGUSR1, &uinfo));
> +	if (TST_RET)
> +		tst_brk(TFAIL | TTERRNO, "rt_tgsigqueueinfo failed");
> +
> +	pthread_mutex_lock(&sigusr1_mutex);
> +	while (!signum_rcv)
> +		pthread_cond_wait(&sigusr1_cond, &sigusr1_mutex);
> +	pthread_mutex_unlock(&sigusr1_mutex);
> +
> +	if ((signum_rcv == SIGUSR1) && !strcmp(sigval_send, sigval_rcv))
> +		tst_res(TPASS, "Test signal to self succeeded");
> +	else
> +		tst_res(TFAIL, "Test failed");

It wouldn't harm to be a bit more verbose here. I.e. tell the user what
exactly was wrong.

> +	return NULL;

There is a nice trick we use in LTP, if you do return arg; here you can
drop the ATTRIBUTE_UNUSED.

> +}
> +
> +static void verify_signal_self(void)
> +{
> +	pthread_t pt;
> +
> +	SAFE_PTHREAD_CREATE(&pt, NULL, tfunc_self, NULL);
> +
> +	SAFE_PTHREAD_JOIN(pt, NULL);
> +}
> +
> +void *t1func(void *arg)
> +{
> +	pid_t *tid = arg;
> +
> +	*tid = syscall(__NR_gettid);
> +
> +	pthread_cond_broadcast(&tid_cond);
> +
> +	signum_rcv = 0;
> +	memset(sigval_rcv, 0, sizeof(sigval_rcv));

This initialization has to be done before we notify the parent thread,
otherwise there is a race.

> +	pthread_mutex_lock(&sigusr1_mutex);
> +	while (!signum_rcv)
> +		pthread_cond_wait(&sigusr1_cond, &sigusr1_mutex);
> +	pthread_mutex_unlock(&sigusr1_mutex);
> +
> +	if ((signum_rcv == SIGUSR1) && !strcmp(sigval_send, sigval_rcv))
> +		tst_res(TPASS, "Test signal to different thread succeeded");
> +	else
> +		tst_res(TFAIL, "Test failed");

Here as well, a bit more verbose, maybe we should put the code into a
common check function, since it's the same as in the self function.

> +	return NULL;
> +}
> +
> +static void verify_signal_parent_thread(void)
> +{
> +	pid_t tid = -1;
> +	pthread_t pt;
> +	siginfo_t uinfo;
> +
> +	SAFE_PTHREAD_CREATE(&pt, NULL, t1func, &tid);
> +
> +	pthread_mutex_lock(&tid_mutex);
> +	while (tid == -1)
> +		pthread_cond_wait(&tid_cond, &tid_mutex);
> +	pthread_mutex_unlock(&tid_mutex);

We do have checkpoint library in LTP that is much easier to use than
this, see:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#229-fork-and-parent-child-synchronization

> +	uinfo.si_errno = 0;
> +	uinfo.si_code = SI_QUEUE;
> +	uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
> +
> +	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
> +			 tid, SIGUSR1, &uinfo));
> +	if (TST_RET)
> +		tst_brk(TFAIL | TTERRNO, "rt_tgsigqueueinfo failed");
> +
> +	SAFE_PTHREAD_JOIN(pt, NULL);
> +}
> +
> +void *t2func(void *arg)
> +{
> +	pid_t *tid = arg;
> +	siginfo_t uinfo;
> +
> +	uinfo.si_errno = 0;
> +	uinfo.si_code = SI_QUEUE;
> +	uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
> +
> +	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
> +			 *tid, SIGUSR1, &uinfo));
> +	if (TST_RET)
> +		tst_brk(TFAIL | TTERRNO, "rt_tgsigqueueinfo failed");
> +
> +	return NULL;
> +}
> +
> +static void verify_signal_inter_thread(void)
> +{
> +	pid_t tid = -1;
> +	pthread_t pt1, pt2;
> +
> +	SAFE_PTHREAD_CREATE(&pt1, NULL, t1func, &tid);
> +
> +	pthread_mutex_lock(&tid_mutex);
> +	while (tid == -1)
> +		pthread_cond_wait(&tid_cond, &tid_mutex);
> +	pthread_mutex_unlock(&tid_mutex);
> +
> +	SAFE_PTHREAD_CREATE(&pt2, NULL, t2func, &tid);

That's very minor but maybe it would be a bit more readable if we named
the t1func and t2func sender_func and receiver_func or anything that
hints the function purpose.

> +	SAFE_PTHREAD_JOIN(pt2, NULL);
> +
> +	SAFE_PTHREAD_JOIN(pt1, NULL);
> +}
> +
> +static struct tcase {
> +	void (*tfunc)(void);
> +} tcases[] = {
> +	{&verify_signal_self},
> +	{&verify_signal_parent_thread},
> +	{&verify_signal_inter_thread},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	tcases[i].tfunc();
> +}
> +
> +static void setup(void)
> +{
> +	struct sigaction sigusr1 = {
> +		.sa_flags = SA_SIGINFO,
> +		.sa_sigaction = sigusr1_handler,
> +	};
> +
> +	SAFE_SIGACTION(SIGUSR1, &sigusr1, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.test = run,
> +};

Otherwise it looks good.
-- 
Cyril Hrubis
chrubis@suse.cz
