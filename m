From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Jan 2020 16:39:28 +0100
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open
In-Reply-To: <4dd4dabd2cd574dc2657c5926e8e3d1a0c8a8ae6.1579259595.git.viresh.kumar@linaro.org>
References: <b4f5242fdca1659b2f71e1b3290fd32194e7340a.1579259595.git.viresh.kumar@linaro.org>
 <4dd4dabd2cd574dc2657c5926e8e3d1a0c8a8ae6.1579259595.git.viresh.kumar@linaro.org>
Message-ID: <20200121153928.GA12370@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> new file mode 100644
> index 000000000000..b67393bcafa2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> @@ -0,0 +1,68 @@
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
> +#include <unistd.h>
> +
> +#include "tst_test.h"
> +#include "lapi/pidfd_open.h"
> +#include "lapi/syscalls.h"
> +
> +static void run(void)
> +{
> +	struct pollfd pollfd;
> +	int p_id, fd, ready;
> +
> +	TEST(fork());
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL, "fork() Failed");
> +		tst_res(TBROK, "unable to continue");
> +	}

We do have SAFE_FORK() make use of that one instead.


> +	if (TST_RET == 0) {
> +		/* child */
> +		usleep(1000);

This is inherently racy, the process should not exit until the parent
has called pidfd_open().

We do have a checkpoints in the test library that can synchronize
between processes, generally it should look like:

child:
	checkpoint_wait()
	exit()

parent:
	pidfd_open()
	checkpoint_wake()

> +		exit(EXIT_SUCCESS);
> +	} else {
> +		/* parent */
> +		p_id = TST_RET;
> +
> +		TEST(pidfd_open(p_id, 0));
> +
> +		fd = TST_RET;
> +		if (fd == -1) {
> +			tst_res(TFAIL, "Cannot retrieve file descriptor to the child process");
                                  ^
			tst_res(TFAIL | TTERRNO, "pidfd_open() failed");
> +			return;
> +		}
> +
> +		pollfd.fd = fd;
> +		pollfd.events = POLLIN;
> +
> +		ready = poll(&pollfd, 1, -1);
> +		if (ready == -1) {
> +			tst_res(TFAIL, "poll() Failed");
> +			tst_res(TBROK, "unable to continue");

There is absolutely no need to print two messages on a failure, so this
should just be tst_brk(TBROK | TERRNO, "poll() failed");

Also note that tst_brk() _EXITS_ the test, which is what you want here.

> +		}
> +
> +		printf("Events (0x%x): POLLIN is %sset\n", pollfd.revents,
> +				(pollfd.revents & POLLIN) ? "" : "not ");

No printf in tests, use tst_res(TINFO, ...) instead.

Also we should check here that we got the event and that the child is
dead at this point, or something along these lines.

There does not seem to be single TPASS in this tests, which itself will
report that the test is broken when it's executed.

> +		SAFE_CLOSE(fd);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "5.3",
> +	.test_all = run,
> +};

And we are also missing third test here, that checks various error
condigitions such as flags != 0, invalid pid, etc.

-- 
Cyril Hrubis
chrubis@suse.cz
