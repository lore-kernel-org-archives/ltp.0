From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Mar 2020 00:01:12 +0100
Subject: [LTP] [PATCH V2 2/2] syscalls/clone3: New tests
In-Reply-To: <c64b9c05053d500a95cc920e332fa229085217b6.1584618969.git.viresh.kumar@linaro.org>
References: <cover.1584618969.git.viresh.kumar@linaro.org>
 <c64b9c05053d500a95cc920e332fa229085217b6.1584618969.git.viresh.kumar@linaro.org>
Message-ID: <20200319230111.GC29386@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add tests to check working of clone3() syscall.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  configure.ac                                |   1 +
>  include/lapi/clone.h                        |  49 +++++++
>  runtest/syscalls                            |   3 +
>  testcases/kernel/syscalls/clone3/.gitignore |   2 +
>  testcases/kernel/syscalls/clone3/Makefile   |   7 +
>  testcases/kernel/syscalls/clone3/clone301.c | 152 ++++++++++++++++++++
>  testcases/kernel/syscalls/clone3/clone302.c | 101 +++++++++++++
>  7 files changed, 315 insertions(+)
>  create mode 100644 include/lapi/clone.h
>  create mode 100644 testcases/kernel/syscalls/clone3/.gitignore
>  create mode 100644 testcases/kernel/syscalls/clone3/Makefile
>  create mode 100644 testcases/kernel/syscalls/clone3/clone301.c
>  create mode 100644 testcases/kernel/syscalls/clone3/clone302.c
> 
> diff --git a/configure.ac b/configure.ac
> index 238d1cde85f2..cf89bd8c351e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -75,6 +75,7 @@ AC_CHECK_HEADERS(fts.h, [have_fts=1])
>  AC_SUBST(HAVE_FTS_H, $have_fts)
>  
>  AC_CHECK_FUNCS([ \
> +    clone3 \
>      copy_file_range \
>      epoll_pwait \
>      execveat \
> diff --git a/include/lapi/clone.h b/include/lapi/clone.h
> new file mode 100644
> index 000000000000..2b8cbdbe08e0
> --- /dev/null
> +++ b/include/lapi/clone.h
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Linaro Limited. All rights reserved.
> + * Author: Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +#ifndef LAPI_CLONE_H__
> +#define LAPI_CLONE_H__
> +
> +#include <sys/syscall.h>
> +#include <linux/types.h>
> +#include <sched.h>
> +
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +#ifndef HAVE_CLONE3
> +struct clone_args {
> +	uint64_t __attribute__((aligned(8))) flags;
> +	uint64_t __attribute__((aligned(8))) pidfd;
> +	uint64_t __attribute__((aligned(8))) child_tid;
> +	uint64_t __attribute__((aligned(8))) parent_tid;
> +	uint64_t __attribute__((aligned(8))) exit_signal;
> +	uint64_t __attribute__((aligned(8))) stack;
> +	uint64_t __attribute__((aligned(8))) stack_size;
> +	uint64_t __attribute__((aligned(8))) tls;
> +};
> +
> +int clone3(struct clone_args *args, size_t size)
> +{
> +	return tst_syscall(__NR_clone3, args, size);
> +}
> +#endif
> +
> +#ifndef CLONE_PIDFD
> +#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
> +#endif
> +
> +void clone3_supported_by_kernel(void)
> +{
> +	if ((tst_kvercmp(5, 3, 0)) < 0) {
> +		/* Check if the syscall is backported on an older kernel */
> +		TEST(syscall(__NR_clone3, NULL, 0));
> +		if (TST_RET == -1 && TST_ERR == ENOSYS)
> +			tst_brk(TCONF, "Test not supported on kernel version < v5.3");
> +	}
> +}
> +
> +#endif /* LAPI_CLONE_H__ */
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6f2dcd82acf6..65ef53f33e0b 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -105,6 +105,9 @@ clone07 clone07
>  clone08 clone08
>  clone09 clone09
>  
> +clone301 clone301
> +clone302 clone302
> +
>  close01 close01
>  close02 close02
>  close08 close08
> diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
> new file mode 100644
> index 000000000000..604cb903e33d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/.gitignore
> @@ -0,0 +1,2 @@
> +clone301
> +clone302
> diff --git a/testcases/kernel/syscalls/clone3/Makefile b/testcases/kernel/syscalls/clone3/Makefile
> new file mode 100644
> index 000000000000..18896b6f28c0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
> new file mode 100644
> index 000000000000..babf8464108c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone301.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Basic clone3() test.
> + */
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +#include "lapi/clone.h"
> +#include "lapi/pidfd_send_signal.h"
> +
> +#define CHILD_SIGNAL	SIGUSR1
> +
> +static int pidfd, child_tid, parent_tid, count, exit_signal;
> +static struct sigaction *psig_action, *csig_action;
> +static struct clone_args *args;
> +static siginfo_t *uinfo;
> +
> +static struct tcase {
> +	uint64_t flags;
> +	int exit_signal;
> +} tcases[] = {
> +	{0, SIGCHLD},
> +	{0, SIGUSR2},
> +	{CLONE_FS, SIGCHLD},
> +	{CLONE_NEWPID, SIGCHLD},
> +	{CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, SIGCHLD},
> +};
> +
> +static void parent_rx_signal(int sig, siginfo_t *info, void *ucontext)
> +{
> +	if (sig == exit_signal)
> +		tst_res(TPASS, "clone3() passed: Parent received correct signal (index %d)", count);
> +	else
> +		tst_res(TFAIL, "clone3() failed: Parent received incorrect signal (index %d)", count);
> +}
> +
> +static void child_rx_signal(int sig, siginfo_t *info, void *ucontext)
> +{
> +	if (info) {
> +		int n = info->si_value.sival_int;
> +
> +		if (sig == CHILD_SIGNAL)
> +			tst_res(TPASS, "clone3() passed: Child received correct signal (index %d)", n);
> +		else
> +			tst_res(TFAIL, "clone3() failed: Child received incorrect signal (index %d)", n);
> +	} else {
> +		tst_res(TFAIL, "clone3() failed: Invalid info");
> +	}
> +}

Calling tst_res() is not safe from a signal handler context.

So what we should do here is store the sig and info->si_value.sival_int
to a global variables and check them the do_child function instead.

And the same applies for the parent handler as well.

> +static void do_child(int clone_pidfd)
> +{
> +	if (clone_pidfd) {
> +		SAFE_SIGACTION(CHILD_SIGNAL, csig_action, NULL);
> +		TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +	}
> +
> +	exit(0);
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int status, clone_pidfd = tc->flags & CLONE_PIDFD;
> +	pid_t pid;
> +
> +	args->flags = tc->flags;
> +	args->pidfd = (uint64_t)(&pidfd);
> +	args->child_tid = (uint64_t)(&child_tid);
> +	args->parent_tid = (uint64_t)(&parent_tid);
> +	args->exit_signal = tc->exit_signal;
> +	args->stack = 0;
> +	args->stack_size = 0;
> +	args->tls = 0;
> +
> +	TEST(pid = clone3(args, sizeof(*args)));
> +	if (pid < 0) {
> +		tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
> +		return;
> +	}
> +
> +	if (!pid)
> +		do_child(clone_pidfd);
> +
> +	count = n;
> +	exit_signal = tc->exit_signal;
> +	SAFE_SIGACTION(exit_signal, psig_action, NULL);
> +
> +	/* Need to send signal to child process */
> +	if (clone_pidfd) {
> +		TST_CHECKPOINT_WAIT(0);
> +
> +		uinfo->si_value.sival_int = n;
> +
> +		TEST(pidfd_send_signal(pidfd, CHILD_SIGNAL, uinfo, 0));
> +		if (TST_RET != 0) {
> +			tst_res(TFAIL | TTERRNO, "pidfd_send_signal() failed");
> +			return;
> +		}
> +
> +		TST_CHECKPOINT_WAKE(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, __WALL);
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +
> +	psig_action = SAFE_MALLOC(sizeof(*psig_action));
> +	memset(psig_action, 0, sizeof(*psig_action));
> +	psig_action->sa_sigaction = parent_rx_signal;
> +	psig_action->sa_flags = SA_SIGINFO;
> +
> +	csig_action = SAFE_MALLOC(sizeof(*csig_action));
> +	memset(csig_action, 0, sizeof(*csig_action));
> +	csig_action->sa_sigaction = child_rx_signal;
> +	csig_action->sa_flags = SA_SIGINFO;

There is no need to allocate these, we can just define them as a static
global variables with:

static struct sigaction psig_action = {
	.sa_sigaction = parent_rx_signal,
	.sa_flags = SA_SIGINFO,
};

> +	uinfo = SAFE_MALLOC(sizeof(*uinfo));
> +	memset(uinfo, 0, sizeof(*uinfo));
> +	uinfo->si_signo = CHILD_SIGNAL;
> +	uinfo->si_code = SI_QUEUE;
> +	uinfo->si_pid = getpid();
> +	uinfo->si_uid = getuid();

Here as well, the only thing that has to be initialized on runtime are
the pid and uid.

> +}
> +
> +static void cleanup(void)
> +{
> +	free(uinfo);
> +	free(csig_action);
> +	free(psig_action);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.needs_checkpoints = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{},
> +	}
> +};
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> new file mode 100644
> index 000000000000..1355a5c4a07f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Basic clone3() test to check various failures.
> + */
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +#include "lapi/clone.h"
> +
> +static struct clone_args *valid_args, *invalid_args;
> +unsigned long stack;
> +static int *invalid_address;
> +
> +static struct tcase {
> +	const char *name;
> +	struct clone_args **args;
> +	size_t size;
> +	uint64_t flags;
> +	int **pidfd;
> +	int **child_tid;
> +	int **parent_tid;
> +	int exit_signal;
> +	unsigned long stack;
> +	unsigned long stack_size;
> +	unsigned long tls;
> +	int exp_errno;
> +} tcases[] = {
> +	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> +	{"zero size", &valid_args, 0, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> +	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"fs-newns", &valid_args, sizeof(*valid_args), CLONE_FS | CLONE_NEWNS, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"invalid pidfd", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, &invalid_address, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> +	{"invalid childtid", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, &invalid_address, NULL, SIGCHLD, 0, 0, 0, EFAULT},
> +	{"invalid parenttid", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, NULL, &invalid_address, SIGCHLD, 0, 0, 0, EFAULT},
> +	{"invalid signal", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, CSIGNAL + 1, 0, 0, 0, EINVAL},
> +	{"zero-stack-size", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, (unsigned long)&stack, 0, 0, EINVAL},
> +	{"invalid-stack", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, 0, 4, 0, EINVAL},
> +};
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +
> +	invalid_address = tst_get_bad_addr(NULL);
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct clone_args *args = *tc->args;
> +
> +	if (args) {
> +		args->flags = tc->flags;
> +		if (tc->pidfd)
> +			args->pidfd = (uint64_t)(*tc->pidfd);
> +		if (tc->child_tid)
> +			args->child_tid = (uint64_t)(*tc->child_tid);
> +		if (tc->parent_tid)
> +			args->parent_tid = (uint64_t)(*tc->parent_tid);
> +		args->exit_signal = tc->exit_signal;
> +		args->stack = tc->stack;
> +		args->stack_size = tc->stack_size;
> +		args->tls = tc->tls;
> +	}

Isn't this wrong now that invalid_args != NULL?

Shouldn't this rather be if (args == valid_args) ?

> +	TEST(clone3(args, tc->size));
> +
> +	if (!TST_RET)
> +		exit(EXIT_SUCCESS);
> +
> +	if (TST_RET >= 0) {
> +		tst_res(TFAIL, "%s: clone3() passed unexpectedly", tc->name);
> +		return;
> +	}
> +
> +	if (tc->exp_errno != TST_ERR) {
> +		tst_res(TFAIL | TTERRNO, "%s: clone3() should fail with %s",
> +			tc->name, tst_strerrno(tc->exp_errno));
> +		return;
> +	}
> +
> +	tst_res(TPASS | TTERRNO, "%s: clone3() failed as expected", tc->name);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&valid_args, .size = sizeof(*valid_args)},
> +		{},
> +	}
> +};
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

-- 
Cyril Hrubis
chrubis@suse.cz
