From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 May 2019 13:30:23 +0200
Subject: [LTP] [PATCH v1 2/4] syscalls/pidfd_send_signal01
In-Reply-To: <20190515120116.11589-2-camann@suse.com>
References: <20190515120116.11589-1-camann@suse.com>
 <20190515120116.11589-2-camann@suse.com>
Message-ID: <20190528113022.GA14548@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> new file mode 100644
> index 000000000..3553c5464
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + */
> +
> +#ifndef __PIDFD_SEND_SIGNAL_H__
> +#define __PIDFD_SEND_SIGNAL_H__
           ^

	   Plese don't use undescores at the beginning of identifiers.

Identifiers starting with _ and __ are reserved for the system, i.e.
libc and compiler.

> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +static int tst_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> +				 unsigned int flags)

We probably should not use the tst_ prefix here as this is not a test
library code.

I guess that we can make this future proof with a configure check for
pidfd_send_signal() that will get included in glibc later on.

> +{
> +	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> +}
> +
> +
> +#endif /* __PIDFD_SEND_SIGNAL_H__ */
> diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
> new file mode 100644
> index 000000000..9ab1971bf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + */
> +/*
> + * Tests if the pidfd_send_signal systemcall behaves
                                       ^
				       Should either be one of:
				       * syscall
				       * system call

> + * like rt_sigqueueinfo when a pointer to a siginfo_t
> + * struct is passed.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <signal.h>
> +#include <stdlib.h>
> +#include "tst_safe_pthread.h"
> +#include "pidfd_send_signal.h"
> +
> +#define SIGNAL  SIGUSR1
> +#define DATA	777
> +
> +static struct sigaction *sig_action;
> +static int sig_rec;
> +static siginfo_t *uinfo;
> +static int pidfd;
> +
> +static void received_signal(int sig, siginfo_t *info, void *ucontext)
> +{
> +	if (info && ucontext) {
> +		if (sig == SIGNAL && uinfo->si_value.sival_int == DATA) {
> +			tst_res(TPASS, "Received correct signal and data!");
> +			sig_rec = 1;
> +		} else
> +			tst_res(TFAIL, "Received wrong signal and/or data!");
> +	} else
> +		tst_res(TFAIL, "Signal handling went wrong!");

This is a very minor however LKML coding style prefers to have curly
braces around both blocks if they have to be over one of them.

> +}
> +
> +static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
                                          ^
			You do return arg at the end of this function,
			there is no point in the ATTRIBUTE_UNUSED
> +{
> +	int ret;
> +
> +	ret = sigaction(SIGNAL, sig_action, NULL);
> +	if (ret)
> +		tst_brk(TBROK | TTERRNO, "Failed to set sigaction");

Why not SAFE_SIGACTION() ?

> +	TST_CHECKPOINT_WAKE(0);
> +	TST_CHECKPOINT_WAIT(1);

We do have TST_CHECKPOINT_WAKE_AND_WAIT().

> +	return arg;
> +}
> +
> +static void verify_pidfd_send_signal(void)
> +{
> +	pthread_t thr;
> +
> +	SAFE_PTHREAD_CREATE(&thr, NULL, handle_thread, NULL);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	TEST(tst_pidfd_send_signal(pidfd, SIGNAL, uinfo, 0));
> +	if (TST_RET != 0) {
> +		tst_res(TFAIL | TTERRNO, "pidfd_send_signal() failed");
> +		return;
> +	}
> +
> +	TST_CHECKPOINT_WAKE(1);
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +
> +	if (sig_rec)
> +		tst_res(TPASS,
> +			"pidfd_send_signal() behaved like rt_sigqueueinfo()");

Very minor as well, LKML coding style prefers curly braces around
multiline statements like this one.

> +}
> +
> +static void setup(void)
> +{
> +	pidfd = SAFE_OPEN("/proc/self", O_DIRECTORY | O_CLOEXEC);
> +
> +	sig_action = SAFE_MALLOC(sizeof(struct sigaction));
> +
> +	memset(sig_action, 0, sizeof(*sig_action));
> +	sig_action->sa_sigaction = received_signal;
> +	sig_action->sa_flags = SA_SIGINFO;
> +
> +	uinfo = SAFE_MALLOC(sizeof(siginfo_t));
> +
> +	memset(uinfo, 0, sizeof(*uinfo));
> +	uinfo->si_signo = SIGNAL;
> +	uinfo->si_code = SI_QUEUE;
> +	uinfo->si_pid = getpid();
> +	uinfo->si_uid = getuid();
> +	uinfo->si_value.sival_int = DATA;
> +
> +	sig_rec = 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	free(uinfo);
> +	free(sig_action);
> +	if (pidfd > 0)
> +		SAFE_CLOSE(pidfd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_pidfd_send_signal,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_checkpoints = 1,
> +	.timeout = 20,

Please do not change the default timeout unless it's needed.

There are actually only two situations where this makese sense:

* The test is expected to run for a long time
   => timeout needs to be increased

* The test goes into an infinit loop on a buggy kernel
   => timeout has to be set low, so that we do not waste time

> +};
> -- 
> 2.16.4

Other than the minor comments, the test looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
