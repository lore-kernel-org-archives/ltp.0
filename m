From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 07 Jul 2021 08:52:03 +0100
Subject: [LTP] [PATCH] wait403: Reproduce undefined INT_MIN negation
In-Reply-To: <20210706142325.11347-1-rpalethorpe@suse.com>
References: <20210706142325.11347-1-rpalethorpe@suse.com>
Message-ID: <87im1m7e8s.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Richard Palethorpe <rpalethorpe@suse.com> writes:

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Fixes: https://github.com/linux-test-project/ltp/issues/322

> ---
>  runtest/syscalls                           |  1 +
>  testcases/kernel/syscalls/wait4/.gitignore |  1 +
>  testcases/kernel/syscalls/wait4/wait403.c  | 40 ++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/wait4/wait403.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 98fe3c02e..128eaadd2 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1663,6 +1663,7 @@ wait02 wait02
>  
>  wait401 wait401
>  wait402 wait402
> +wait403 wait403
>  
>  waitpid01 waitpid01
>  waitpid02 waitpid02
> diff --git a/testcases/kernel/syscalls/wait4/.gitignore b/testcases/kernel/syscalls/wait4/.gitignore
> index 9313eb72c..577f73479 100644
> --- a/testcases/kernel/syscalls/wait4/.gitignore
> +++ b/testcases/kernel/syscalls/wait4/.gitignore
> @@ -1,2 +1,3 @@
>  /wait401
>  /wait402
> +/wait403
> diff --git a/testcases/kernel/syscalls/wait4/wait403.c b/testcases/kernel/syscalls/wait4/wait403.c
> new file mode 100644
> index 000000000..262351b7c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/wait4/wait403.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
> + */
> +
> +/*
> + * [Description]
> + *
> + * Check wait4(INT_MIN, ...) is not allowed. The pid is negated before
> + * searching for a group with that pid. Negating INT_MIN is not
> + * defined so UBSAN will be triggered if enabled.
> + *
> + * If the bug is present, but UBSAN is not enabled, then it should
> + * result in ECHILD.
> + */
> +
> +#include <stdlib.h>
> +#include <errno.h>
> +#define _USE_BSD
> +#include <sys/types.h>
> +#include <sys/resource.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	int status = 1;
> +	struct rusage rusage;
> +
> +	TST_EXP_FAIL2(wait4(-2147483648, &status, 0, &rusage), ESRCH,
> +		      "wait4 fails with ESRCH");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "dd83c161fbcc"},

Possibly needs {}

> +	}
> +};


-- 
Thank you,
Richard.
