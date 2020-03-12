From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Mar 2020 14:43:00 +0100
Subject: [LTP] [PATCH] syscalls/clone3: New tests
In-Reply-To: <08f6f9f8af7b8f999136cc2a30744a8d678d2b5f.1584000268.git.viresh.kumar@linaro.org>
References: <08f6f9f8af7b8f999136cc2a30744a8d678d2b5f.1584000268.git.viresh.kumar@linaro.org>
Message-ID: <20200312134300.GB3803@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  configure.ac                                |  1 +
>  include/lapi/clone.h                        | 49 ++++++++++++
>  runtest/syscalls                            |  3 +
>  testcases/kernel/syscalls/clone3/.gitignore |  2 +
>  testcases/kernel/syscalls/clone3/Makefile   |  7 ++
>  testcases/kernel/syscalls/clone3/clone301.c | 67 ++++++++++++++++
>  testcases/kernel/syscalls/clone3/clone302.c | 86 +++++++++++++++++++++
>  7 files changed, 215 insertions(+)
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
> index 7dd109400075..48015fe15525 100644
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
> index 000000000000..7402a637d679
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone301.c
> @@ -0,0 +1,67 @@
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
> +
> +static struct clone_args *args;
> +static int pidfd, child_tid, parent_tid;
> +
> +static struct tcase {
> +	uint64_t flags;
> +	int exit_signal;
> +} tcases[] = {
> +	{0, SIGCHLD},
> +	{CLONE_FS, SIGCHLD},
> +	{CLONE_NEWPID, SIGCHLD},
> +	{CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, SIGCHLD},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	pid_t pid;
> +	int status;
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
> +
> +	if (pid < 0) {
> +		tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
> +		return;
> +	}
> +
> +	if (!pid)
> +		exit(EXIT_SUCCESS);
> +
> +	SAFE_WAIT(&status);
> +
> +	tst_res(TPASS, "clone3() passed with status:%d, pidfd:%d, ctid:%d, ptid:%d (index %d)",
> +		WEXITSTATUS(status), pidfd, child_tid, parent_tid, n);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = clone3_supported_by_kernel,
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{},
> +	}
> +};

We need root for the CLONE_NEWPID, so I guess that we need .needs_root=1
added here. I can add that before applying the rest looks good to me.

Also I guess that we should add test that would check that the pidfd is
valid, i.e. that it could be used to send a signal to the child process,
but that could be added later in a subsequent patch.

And the same for the exit signal, we should add a test that the child
send requested signal to the parent on exit.

> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> new file mode 100644
> index 000000000000..5c3e001d088d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -0,0 +1,86 @@
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
> +
> +static struct tcase {
> +	const char *name;
> +	struct clone_args **args;
> +	size_t size;
> +	uint64_t flags;
> +	int *pidfd;
> +	int *child_tid;
> +	int *parent_tid;
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
> +	{"zero-stack-size", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, (unsigned long)&stack, 0, 0, EINVAL},
> +	{"invalid-stack", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, 0, 4, 0, EINVAL},

What about invalid exit signal? I guess that signal is 32bit so anything
that has non-zero bits in upper 32bits of the exit_signal should yield
EINVAL as well.

Also all pidfd, child_tid, and parent_tid should be tested with invalid
pointers right?

> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct clone_args *args = *tc->args;
> +
> +	if (args) {
> +		args->flags = tc->flags;
> +		args->pidfd = (uint64_t)(tc->pidfd);
> +		args->child_tid = (uint64_t)(tc->child_tid);
> +		args->parent_tid = (uint64_t)(tc->parent_tid);
> +		args->exit_signal = tc->exit_signal;
> +		args->stack = tc->stack;
> +		args->stack_size = tc->stack_size;
> +		args->tls = tc->tls;
> +	}
> +
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
> +	.setup = clone3_supported_by_kernel,
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
