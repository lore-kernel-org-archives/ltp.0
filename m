From: Steve Muckle <smuckle@google.com>
Date: Mon, 4 Mar 2019 11:35:59 -0800
Subject: [LTP] [PATCH] syscalls: add rt_tgsigqueueinfo() test-case
In-Reply-To: <1551097931-18320-1-git-send-email-sumit.garg@linaro.org>
References: <1551097931-18320-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1fc28a33-6ed8-9be1-caf5-dde3606f1b6f@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sumit,

On 02/25/2019 04:32 AM, Sumit Garg wrote:
> This tests the rt_tgsigqueueinfo() syscall used to queue a signal and
> data to the single thread specified by the combination of tgid, a thread
> group ID, and tid, a thread in that thread group.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   runtest/syscalls                                   |  1 +
>   .../kernel/syscalls/rt_tgsigqueueinfo/.gitignore   |  1 +
>   .../kernel/syscalls/rt_tgsigqueueinfo/Makefile     | 10 ++++
>   .../rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c        | 53 ++++++++++++++++++++++
>   4 files changed, 65 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore
>   create mode 100644 testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile
>   create mode 100644 testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 70d3561..861c0a6 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -996,6 +996,7 @@ rt_sigprocmask01 rt_sigprocmask01
>   rt_sigprocmask02 rt_sigprocmask02
>   rt_sigqueueinfo01 rt_sigqueueinfo01
>   rt_sigsuspend01 rt_sigsuspend01
> +rt_tgsigqueueinfo01 rt_tgsigqueueinfo01
>   
>   sbrk01 sbrk01
>   sbrk02 sbrk02
> diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore b/testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore
> new file mode 100644
> index 0000000..f9ffa58
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore
> @@ -0,0 +1 @@
> +rt_tgsigqueueinfo01
> diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile b/testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile
> new file mode 100644
> index 0000000..035ca64
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile
> @@ -0,0 +1,10 @@
> +# Copyright (c) 2019 - Linaro Limited. All rights reserved.
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir             ?= ../../../..
> +
> +rt_tgsigqueueinfo01: CFLAGS+=-pthread
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> new file mode 100644
> index 0000000..336b968
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> + * Author: Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +/*
> + * Test rt_tgsigqueueinfo
> + *
> + * This tests the rt_tgsigqueueinfo() syscall. It sends the signal and data
> + * to the single thread specified by the combination of tgid, a thread group
> + * ID, and tid, a thread in that thread group.
> + */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <pthread.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +void *tfunc(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	siginfo_t uinfo;
> +
> +	uinfo.si_errno = 0;
> +	uinfo.si_code = SI_QUEUE;
> +
> +	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
> +			 syscall(__NR_gettid), SIGCHLD, &uinfo));

It looks like the pthread here is sending the signal to itself which 
seems like a special case. Not that it isn't worth testing but I'd think 
there should be a test which sends the signal to a different thread. 
This (the self-send case) could be an additional test.

> +	if (TST_RET)
> +		tst_res(TFAIL, "Test Failed");
> +	else
> +		tst_res(TPASS, "Test Succeeded");

I recommend verifying the signal and its data (si_value) are delivered 
successfully prior to test completion.

> +
> +	return NULL;
> +}
> +
> +static void verify_rt_tgsigqueueinfo(void)
> +{
> +	pthread_t pt;
> +
> +	TEST(pthread_create(&pt, NULL, tfunc, NULL));
> +	if (TST_RET)
> +		tst_brk(TFAIL | TTERRNO, "pthread_create failed");
> +
> +	TEST(pthread_join(pt, NULL));
> +	if (TST_RET)
> +		tst_brk(TFAIL | TTERRNO, "pthread_join failed");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_rt_tgsigqueueinfo,
> +};
> 

thanks,
steve

