From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Nov 2015 04:05:24 -0500 (EST)
Subject: [LTP] [PATCH v2] signal: add new testcase signal06.c
In-Reply-To: <1447151557-27539-1-git-send-email-liwang@redhat.com>
References: <1447151557-27539-1-git-send-email-liwang@redhat.com>
Message-ID: <748520497.6794885.1447232724888.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: jstancek@redhat.com
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 10 November, 2015 11:32:37 AM
> Subject: [PATCH v2] signal: add new testcase signal06.c
> 
> v1 --> v2
> 	1. define LOOPS as 10000
> 	2. use -pthread in Makefile
> 	3. add volatile to FLAGE
> 	4. include linux_syscall_numbers.h
> 	5. use __NR_tkill and SIGHUP
> 	6. use tst_exit() and TEST()

Hi,

just some minor comments below, I missed some in last email.

Other than that it looked ok to me and I could reproduce the bug
on older kernels.

Regards,
Jan

> 
> the comments from Oleg's patch:
> 
> save_xstate_sig()->drop_init_fpu() doesn't look right. setup_rt_frame()
> can fail after that, in this case the next setup_rt_frame() triggered
> by SIGSEGV won't save fpu simply because the old state was lost. This
> obviously mean that fpu won't be restored after sys_rt_sigreturn() from
> SIGSEGV handler.
> 
> this issue was fixed on kernel v3.17-rc3-3:
> 
>   	commit df24fb859a4e200d9324e2974229fbb7adf00aef
>   		Author: Oleg Nesterov <oleg@redhat.com>
>   		Date:   Tue Sep 2 19:57:17 2014 +0200
> 
>         commit 66463db4fc5605d51c7bb81d009d5bf30a783a2c
>                 Author: Oleg Nesterov <oleg@redhat.com>
>                 Date:   Tue Sep 2 19:57:13 2014 +0200

one of these is using spaces, the other one tabs

> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/ltplite                             |   1 +
>  runtest/stress.part3                        |   1 +
>  runtest/syscalls                            |   1 +
>  testcases/kernel/syscalls/signal/Makefile   |   2 +
>  testcases/kernel/syscalls/signal/signal06.c | 156

We should add it to .gitignore too.

>  ++++++++++++++++++++++++++++
>  5 files changed, 161 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/signal/signal06.c
> 
> diff --git a/runtest/ltplite b/runtest/ltplite
> index aaa5c73..f2c9dcf 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -840,6 +840,7 @@ signal02 signal02
>  signal03 signal03
>  signal04 signal04
>  signal05 signal05
> +signal06 signal06
>  
>  sigpending02 sigpending02
>  
> diff --git a/runtest/stress.part3 b/runtest/stress.part3
> index 63505ec..36bb16f 100644
> --- a/runtest/stress.part3
> +++ b/runtest/stress.part3
> @@ -744,6 +744,7 @@ signal02 signal02
>  signal03 signal03
>  signal04 signal04
>  signal05 signal05
> +signal06 signal06
>  
>  sigpending02 sigpending02
>  
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 958f66e..cfbcbea 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1143,6 +1143,7 @@ signal02 signal02
>  signal03 signal03
>  signal04 signal04
>  signal05 signal05
> +signal06 signal06
>  
>  signalfd01 signalfd01
>  
> diff --git a/testcases/kernel/syscalls/signal/Makefile
> b/testcases/kernel/syscalls/signal/Makefile
> index bd617d8..dad2a7d 100644
> --- a/testcases/kernel/syscalls/signal/Makefile
> +++ b/testcases/kernel/syscalls/signal/Makefile
> @@ -21,3 +21,5 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +signal06: CFLAGS+=-pthread
> diff --git a/testcases/kernel/syscalls/signal/signal06.c
> b/testcases/kernel/syscalls/signal/signal06.c
> new file mode 100644
> index 0000000..8a33eab
> --- /dev/null
> +++ b/testcases/kernel/syscalls/signal/signal06.c
> @@ -0,0 +1,156 @@
> +/*
> + * Copyright (c) 2015   Author: Oleg Nesterov <oleg@redhat.com>
> + *                      Modify: Li Wang <liwang@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * you should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/*
> + * Description:
> + *
> + *      save_xstate_sig()->drop_init_fpu() doesn't look right.
> setup_rt_frame()
> + *      can fail after that, in this case the next setup_rt_frame()
> triggered
> + *      by SIGSEGV won't save fpu simply because the old state was lost.
> This
> + *      obviously mean that fpu won't be restored after sys_rt_sigreturn()
> from
> + *      SIGSEGV handler.
> + *
> + *      These commits fix the issue on v3.17-rc3-3 stable kernel:
> + *
> + * 	commit df24fb859a4e200d9324e2974229fbb7adf00aef
> + * 		Author: Oleg Nesterov <oleg@redhat.com>
> + * 		Date:   Tue Sep 2 19:57:17 2014 +0200
> + *
> + *      commit 66463db4fc5605d51c7bb81d009d5bf30a783a2c
> + *               Author: Oleg Nesterov <oleg@redhat.com>
> + *               Date:   Tue Sep 2 19:57:13 2014 +0200

one of these is using spaces, the other one tabs.

> + *
> + * Reproduce:
> + *	Test-case (needs -O2).
> + */
> +
> +#include <stdio.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/mman.h>
> +#include <pthread.h>
> +#include <assert.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "linux_syscall_numbers.h"
> +
> +char *TCID = "signal06";
> +int TST_TOTAL = 5;
> +
> +#if __x86_64__
> +
> +#define LOOPS 10000
> +
> +volatile double D;
> +volatile int FLAGE;
> +
> +char altstack[4096 * 10] __attribute__((aligned(4096)));
> +
> +void test(double d)
> +{
> +	int loop = 0;
> +	int pid = getpid();
> +
> +	D = d;
> +	while (D == d && loop < LOOPS) {
> +		/* sys_tkill(pid, SIGHUP); asm to avoid save/reload
> +		 * fp regs around c call */
> +		asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
> +		asm ("syscall" : : : "ax");
> +
> +		loop++;
> +	}
> +
> +	FLAGE = 1;
> +	tst_resm(TINFO, "loop = %d", loop);
> +
> +	if (loop == LOOPS) {
> +		tst_resm(TPASS, "%s call succeeded", TCID);
> +	} else {
> +		tst_resm(TFAIL, "Bug Reproduced!");
> +		tst_exit();
> +	}
> +}
> +
> +void sigh(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +}
> +
> +void *tfunc(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	FLAGE = 0;
> +
> +	for (; ;) {
> +		mprotect(altstack, sizeof(altstack), PROT_READ);
> +		mprotect(altstack, sizeof(altstack), PROT_READ|PROT_WRITE);

We should also check ret code here.

> +
> +		if (FLAGE == 1)
> +			return NULL;
> +	}
> +}
> +
> +int main(int ac, char **av)
> +{
> +	int i, lc;
> +	pthread_t pt;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	stack_t st = {
> +		.ss_sp = altstack,
> +		.ss_size = sizeof(altstack),
> +		.ss_flags = SS_ONSTACK,
> +	};
> +
> +	struct sigaction sa = {
> +		.sa_handler = sigh,
> +	};
> +
> +	sigaction(SIGSEGV, &sa, NULL);
> +	sigaltstack(&st, NULL);
> +	sa.sa_flags = SA_ONSTACK;
> +	sigaction(SIGHUP, &sa, NULL);

We should check return value from sigaction.

> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +
> +			TEST(pthread_create(&pt, NULL, tfunc, NULL));
> +			if (TEST_RETURN)
> +				tst_brkm(TBROK | TTERRNO, NULL,
> +						"pthread_create failed");

TRERRNO

> +
> +			test(123.456);
> +
> +			TEST(pthread_join(pt, NULL));
> +			if (TEST_RETURN)
> +				tst_brkm(TBROK, NULL, "pthread_join failed");

TRERRNO

> +		}
> +	}
> +
> +	tst_exit();
> +}
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "Only test on x86_64.");
> +}
> +#endif
> --
> 1.8.3.1
> 
> 
