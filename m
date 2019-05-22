From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 May 2019 18:16:57 +0800
Subject: [LTP] [PATCH] syscalls/prctl05.c: New test for prctl() with
	PR_{SET, GET}_NAME
In-Reply-To: <1557404414-3797-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1557404414-3797-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5CE52199.9080508@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
Ping. :-)
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  include/lapi/prctl.h                       |  5 +++
>  runtest/syscalls                           |  1 +
>  testcases/kernel/syscalls/prctl/.gitignore |  1 +
>  testcases/kernel/syscalls/prctl/prctl05.c  | 51 ++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/prctl/prctl05.c
>
> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
> index c3612e643..91da9c2d6 100644
> --- a/include/lapi/prctl.h
> +++ b/include/lapi/prctl.h
> @@ -9,6 +9,11 @@
>  
>  #include <sys/prctl.h>
>  
> +#ifndef PR_SET_NAME
> +# define PR_SET_NAME 15
> +# define PR_GET_NAME 16
> +#endif
> +
>  #ifndef PR_SET_CHILD_SUBREAPER
>  # define PR_SET_CHILD_SUBREAPER	36
>  # define PR_GET_CHILD_SUBREAPER	37
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 51bff2990..950615bef 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -864,6 +864,7 @@ prctl01 prctl01
>  prctl02 prctl02
>  prctl03 prctl03
>  prctl04 prctl04
> +prctl05 prctl05
>  
>  pread01 pread01
>  pread01_64 pread01_64
> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
> index 1c3da3052..9ecaf9854 100644
> --- a/testcases/kernel/syscalls/prctl/.gitignore
> +++ b/testcases/kernel/syscalls/prctl/.gitignore
> @@ -2,3 +2,4 @@
>  /prctl02
>  /prctl03
>  /prctl04
> +/prctl05
> diff --git a/testcases/kernel/syscalls/prctl/prctl05.c b/testcases/kernel/syscalls/prctl/prctl05.c
> new file mode 100644
> index 000000000..8a0ea2eb3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/prctl/prctl05.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * Test PR_GET_NAME and PR_SET_NAME of prctl(2).
> + * 1)Set the name of the calling thread, the name can be up to 16 bytes
> + *   long, including the terminating null byte. If exceeds 16 bytes, the
> + *   string is silently truncated.
> + * 2)Return the name of the calling thread, the buffer should allow space
> + *   for up to 16 bytes, the returned string will be null-terminated.
> + */
> +
> +#include <errno.h>
> +#include <sys/prctl.h>
> +#include <string.h>
> +#include <lapi/prctl.h>
> +#include "tst_test.h"
> +
> +#define thread_name "prctl05_test_xxxxx"
> +
> +static void verify_prctl(void)
> +{
> +	char buf[20];
> +
> +	TEST(prctl(PR_SET_NAME, &thread_name));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_NAME) failed");
> +		return;
> +	}
> +	tst_res(TPASS, "prctl(PR_SET_NAME) succeeded, set thread name as "
> +			"prctl05_test_xxxxx");
> +
> +	TEST(prctl(PR_GET_NAME, &buf));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_NAME) failed");
> +		return;
> +	}
> +
> +	if (!strncmp(thread_name, buf, 15) && strlen(buf) == 15)
> +		tst_res(TPASS, "prctl(PR_GET_NAME) succeeded, "
> +				"thread name is %s", buf);
> +	else
> +		tst_res(TFAIL,
> +			"prctl(PR_GET_NAME) failed to truncate the name into "
> +			"16 byte long");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_prctl,
> +};



