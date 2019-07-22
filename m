From: Christian Amann <camann@suse.com>
Date: Mon, 22 Jul 2019 09:04:46 +0000
Subject: [LTP] [PATCH v2] syscalls/ioprio: Add test cases for I/O
 priority
In-Reply-To: <20190718073941.13153-1-linus.walleij@linaro.org>
References: <20190718073941.13153-1-linus.walleij@linaro.org>
Message-ID: <41d6e9d0-2779-0252-c901-b0de500b2b3f@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

generally these tests look fine. I'd just like to add something to the
things the others have already pointed out:

On 18/07/2019 09:39, Linus Walleij wrote:
> diff --git a/testcases/kernel/syscalls/ioprio/ioprio_get01.c b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
> new file mode 100644
> index 000000000000..79807763a5f3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited
> + */
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>

Please double check if all of those includes are really necessary. It
compiled fine for me using only the types.h and syscalls.h (+ the two
below).

> +
> +#include "tst_test.h"
> +#include "ioprio.h"
> +
> +static int ioprio_get(int which, int who)
> +{
> +	return syscall(SYS_ioprio_get, which, who);

In LTP there is a dedicated syscall function which handles the error if
the syscall-number is absent. This line should be replaced with:

"return tst_syscall(__NR_ioprio_get, which, who);"

If done like this, you don't even have to check the kernel version in
the tst_test structure at the end of every test case.

> +}
> +
> +static void run(void)
> +{
> +	int prio, class;
> +
> +	/* Get the I/O priority for the current process */
> +	TEST(ioprio_get(IOPRIO_WHO_PROCESS, 0));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "ioprio_get failed");
> +		return;
> +	}
> +
> +	class = IOPRIO_PRIO_CLASS(TST_RET);
> +	prio = IOPRIO_PRIO_LEVEL(TST_RET);
> +
> +	if (!prio_in_range(prio)) {
> +		tst_res(TFAIL, "ioprio out of range (%d)", prio);
> +		return;
> +	}
> +
> +	tst_res(TPASS, "ioprio_get returned class %s prio %d",
> +		to_class_str[class], prio);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "2.6.13",
line can be removed, see comment above
> +};

There are also checkpatch errors/warnings for ioprio_set02. Please check
that for yourself.

Other than that, the tests look good!


