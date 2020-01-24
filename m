From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jan 2020 17:49:35 +0100
Subject: [LTP] [PATCH V3 2/2] syscalls/pidfd_open
In-Reply-To: <8dc3dff0390db58b2f472501c30595647a913e34.1579858930.git.viresh.kumar@linaro.org>
References: <1dbcadb1781ba1f0584eb92c83aec5f66abb109c.1579858930.git.viresh.kumar@linaro.org>
 <8dc3dff0390db58b2f472501c30595647a913e34.1579858930.git.viresh.kumar@linaro.org>
Message-ID: <20200124164935.GA3206@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * Basic pidfd_open() test, fetches the PID of the current process and tries to
> + * get its file descriptor.
> + */
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +
> +#include "tst_test.h"
> +#include "lapi/pidfd_open.h"
> +#include "lapi/syscalls.h"

All the sys/ headers and the lapi/syscalls.h are included from the
lapi/pidfd_open.h there is no need to include them again here.

> +static void run(void)
> +{
> +	int fd;
> +
> +	TEST(pidfd_open(getpid(), 0));
> +
> +	fd = TST_RET;
> +	if (fd == -1)
> +		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
> +
> +	SAFE_CLOSE(fd);

Why can't we use the TST_RET directly here? I.e. if (TST_RET == -1) etc.

> +	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "5.3",
> +	.test_all = run,
> +};
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> new file mode 100644
> index 000000000000..5e5431335731
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * Basic pidfd_open() test to test invalid arguments.
> + */
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +
> +#include "tst_test.h"
> +#include "lapi/pidfd_open.h"
> +#include "lapi/syscalls.h"

Here as well.

> +#define INVALID_PID	-1
> +#define MY_PID		0
> +#define EXPIRED_PID	1
> +
> +static struct tcase {
> +	char *name;
> +	int pid;

This is usually handled by setting a pointer to global variable that is
initialized in the test setup, e.g.:

static int expired_pid;

...
{"expired pid", &expired_pid, 0, ESRCH}
...

static void run(void)
{
	...
	TEST(pidfd_open(*tc->pid, tc->flags));
	...
}

static void setup(void)
{
	expired_pid = tst_get_unused_pid();
}

> +	int flags;
> +	int exp_errno;
> +} tcases[] = {
> +	{"test-expired-pid", EXPIRED_PID, 0, ESRCH},
> +	{"test-invalid-pid", INVALID_PID, 0, EINVAL},
> +	{"test-invalid-flags", MY_PID, 1, EINVAL},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	pid_t pid;
> +
> +	if (tc->pid == EXPIRED_PID)
> +		pid = tst_get_unused_pid();
> +	else if (tc->pid == MY_PID)
> +		pid = getpid();
> +	else
> +		pid = tc->pid;
> +
> +	TEST(pidfd_open(pid, tc->flags));
> +
> +	if (TST_RET != -1) {
> +		SAFE_CLOSE(TST_RET);
> +		tst_brk(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
> +			tc->name, n);
> +	}
> +
> +	if (tc->exp_errno != TST_ERR) {
> +		tst_brk(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
> +			tc->name, tst_strerrno(tc->exp_errno));
> +	}
> +
> +	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
> +		tc->name);
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "5.3",
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +};
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> new file mode 100644
> index 000000000000..efa14dc52d7a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * This program opens the PID file descriptor of the child process created with
> + * fork(). It then uses poll to monitor the file descriptor for process exit, as
> + * indicated by an EPOLLIN event.
> + */
> +#include <poll.h>
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +#include "lapi/pidfd_open.h"
> +#include "lapi/syscalls.h"
> +
> +static void run(void)
> +{
> +	struct pollfd pollfd;
> +	int fd, ready;
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		TST_CHECKPOINT_WAIT(0);
> +		exit(EXIT_SUCCESS);
> +	} else {
> +		TEST(pidfd_open(pid, 0));
> +
> +		fd = TST_RET;
> +		if (fd == -1)
> +			tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");
> +
> +		TST_CHECKPOINT_WAKE(0);
> +
> +		pollfd.fd = fd;
> +		pollfd.events = POLLIN;
> +
> +		ready = poll(&pollfd, 1, -1);
> +
> +		SAFE_CLOSE(fd);
> +		SAFE_WAITPID(pid, NULL, 0);
> +
> +		if (ready == -1)
> +			tst_brk(TBROK | TERRNO, "poll() failed");
> +
> +		if (ready != 1)
> +			tst_brk(TBROK, "poll() should return 1");

Shouldn't this rather be TFAIL?

Something like:

	if (ready != 1)
		tst_res(TFAIL, "poll() returned %i", ready);
	else
		tst_res(TPASS, ...);

> +		tst_res(TPASS, "pidfd_open() passed");

Just a minor thing, there is no need for the else branch since the child
calls exit().

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "5.3",
> +	.test_all = run,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +};
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

-- 
Cyril Hrubis
chrubis@suse.cz
