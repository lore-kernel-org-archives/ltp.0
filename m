From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 Jun 2019 15:41:39 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/pidfd_send_signal01
In-Reply-To: <20190604114702.28255-1-camann@suse.com>
References: <20190604114702.28255-1-camann@suse.com>
Message-ID: <20190612134139.GA12836@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Add testcase to check if pidfd_send_signal() can provide
> the same functionality as rt_sigqueueinfo().

> Signed-off-by: Christian Amann <camann@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Generally LGTM, nice work, just tiny details below.

BTW inspiration for other tests from kernel selftest [1]
...

> diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
> new file mode 100644
> index 000000000..f44fce013
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + */
> +/*
> + * Tests if the pidfd_send_signal syscall behaves
> + * like rt_sigqueueinfo when a pointer to a siginfo_t
> + * struct is passed.
> + */
> +
> +#define _GNU_SOURCE
Why _GNU_SOURCE? I removed it from all 3 tests and the header and it compiles
fine....

...
> +
> +static void check_syscall_support(void)
> +{
> +	/* allow the tests to fail early */
> +	tst_syscall(__NR_pidfd_send_signal);
> +}
> +
> +#ifndef HAVE_PIDFD_SEND_SIGNAL
> +static int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> +				 unsigned int flags)
> +{
> +	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> +}
> +#endif /* HAVE_PIDFD_SEND_SIGNAL */
I wonder if we want to info whether our wrapper or libc wrapper it's used (it
probably takes time when glibc takes it).

> +
> +#endif /* PIDFD_SEND_SIGNAL_H */
> diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
> new file mode 100644
> index 000000000..f44fce013
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + */
> +/*
> + * Tests if the pidfd_send_signal syscall behaves
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
> +		} else {
> +			tst_res(TFAIL, "Received wrong signal and/or data!");
> +		}
> +	} else {
> +		tst_res(TFAIL, "Signal handling went wrong!");
> +	}
> +}
> +
> +static void *handle_thread(void *arg)
> +{
> +	SAFE_SIGACTION(SIGNAL, sig_action, NULL);
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
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
> +	TEST(pidfd_send_signal(pidfd, SIGNAL, uinfo, 0));
> +	if (TST_RET != 0) {
> +		tst_res(TFAIL | TTERRNO, "pidfd_send_signal() failed");
> +		return;
> +	}
> +
> +	TST_CHECKPOINT_WAKE(0);
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +
> +	if (sig_rec) {
> +		tst_res(TPASS,
> +			"pidfd_send_signal() behaved like rt_sigqueueinfo()");
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	check_syscall_support();
> +
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
I guess this is not needed (as sig_rec is static.


Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/pidfd/pidfd_test.c
