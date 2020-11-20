From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Nov 2020 11:16:22 +0100
Subject: [LTP] [PATCH v4] syscalls/ptrace11: Add test for tracing init
 process
In-Reply-To: <1605842193-10828-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20201119153116.GA18048@yuki.lan>
 <1605842193-10828-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20201120101622.GA4910@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * Before kernel 2.6.26, we can't trace init(1) process and ptrace() will
> + * get EPERM error. This case just check whether we can trace init(1)
> + * process and doesn't trigger error.
> + */

I've reformatted this comment so that it's picked up by documentation
parser.

> +#include <errno.h>
> +#include <signal.h>
> +#include <sys/wait.h>
> +#include <pwd.h>
> +#include <config.h>
> +#include <stdlib.h>
> +#include "ptrace.h"
> +#include "tst_test.h"
> +
> +static void verify_ptrace(void)
> +{
> +	TEST(ptrace(PTRACE_ATTACH, 1, NULL, NULL));
> +	if (TST_RET == 0)
> +		tst_res(TPASS, "ptrace() traces init process successfully");
> +	else
> +		tst_res(TFAIL | TTERRNO,
> +			"ptrace() returns %ld, failed unexpectedly", TST_RET);
> +
> +	/*
> +	 * As ptrace(2) man-page said, when using PTRACE_ATTACH option, the
> +	 * tracee is sent a SIGSTOP, but will not necessarily have stopped
> +	 * by the completion of this call. Use waitpid(2) to wait for the
> +	 * tracee into stop. Otherwise it may get ESRCH error.
> +	 * As waitpid(2) man-pages said, status for traced children which have
> +	 * stopped is provided even if WUNTRACED option is not specified.
> +	 * So using 0 option is enough.
> +	 */

Simplified this comment.


And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
