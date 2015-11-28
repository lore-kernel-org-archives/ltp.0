From: Cui Bixuan <cuibixuan@huawei.com>
Date: Sat, 28 Nov 2015 17:33:05 +0800
Subject: [LTP] [PATCH v2] sched_setattr/sched_setattr01: Add new
 testcase for sched_setattr
In-Reply-To: <5643267B.5020109@huawei.com>
References: <1446801572-215993-1-git-send-email-cuibixuan@huawei.com>
 <20151110131940.GF23947@rei> <5643267B.5020109@huawei.com>
Message-ID: <565974D1.4000701@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ping~~

On 2015/11/11 19:28, Cui Bixuan wrote:
> Add new testcase for sched_setattr
> 
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
> V2:
>     * Delete #include "linux_syscall_numbers.h";
>     * Change run_deadline() to do_test();
>     * Initialize structure attr at the beginning in sched_setattr01.c;
>     * Delete 'errno = 0' in sched_setattr_verify();
>     * Change some print message
> 
>  runtest/sched                                      |    1 +
>  runtest/syscalls                                   |    1 +
>  testcases/kernel/syscalls/.gitignore               |    1 +
>  testcases/kernel/syscalls/sched_setattr/Makefile   |   25 ++++
>  .../syscalls/sched_setattr/sched_setattr01.c       |  136 ++++++++++++++++++++
>  5 files changed, 164 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/sched_setattr/Makefile
>  create mode 100644 testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
> 
> diff --git a/runtest/sched b/runtest/sched
> index 4b8a1df..89398df 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -9,6 +9,7 @@ trace_sched01		trace_sched -c 1
>  hackbench01 hackbench 50 process 1000
>  hackbench02 hackbench 20 thread 1000
> 
> +sched_setattr01 sched_setattr01
>  sched_getattr01 sched_getattr01
>  sched_getattr02 sched_getattr02
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 724ab66..469baee 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -922,6 +922,7 @@ sched_yield01 sched_yield01
>  sched_setaffinity01 sched_setaffinity01
>  sched_getaffinity01 sched_getaffinity01
> 
> +sched_setattr01 sched_setattr01
>  sched_getattr01 sched_getattr01
>  sched_getattr02 sched_getattr02
> 
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index aba112b..c53f0d4 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -752,6 +752,7 @@
>  /sched_rr_get_interval/sched_rr_get_interval02
>  /sched_rr_get_interval/sched_rr_get_interval03
>  /sched_setaffinity/sched_setaffinity01
> +/sched_setattr/sched_setattr01
>  /sched_setparam/sched_setparam01
>  /sched_setparam/sched_setparam02
>  /sched_setparam/sched_setparam03
> diff --git a/testcases/kernel/syscalls/sched_setattr/Makefile b/testcases/kernel/syscalls/sched_setattr/Makefile
> new file mode 100644
> index 0000000..30718a9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_setattr/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#  Copyright (c) Huawei Technologies Co., Ltd., 2015
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CFLAGS			+= -pthread
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
> new file mode 100644
> index 0000000..63cf890
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
> @@ -0,0 +1,136 @@
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd., 2015
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> + * the GNU General Public License for more details.
> + */
> + /* Description:
> + *   Verify that:
> + *              1) sched_setattr succeed with correct parameters
> + *              2) sched_setattr fails with unused pid
> + *              3) sched_setattr fails with invalid address
> + *              4) sched_setattr fails with invalid flag
> + */
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <linux/unistd.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <sys/syscall.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "lapi/sched.h"
> +
> +char *TCID = "sched_setattr01";
> +
> +#define SCHED_DEADLINE	6
> +#define RUNTIME_VAL 10000000
> +#define PERIOD_VAL 30000000
> +#define DEADLINE_VAL 30000000
> +
> +static pid_t pid;
> +static pid_t unused_pid;
> +
> +static struct sched_attr attr = {
> +	.size = sizeof(struct sched_attr),
> +	.sched_flags = 0,
> +	.sched_nice = 0,
> +	.sched_priority = 0,
> +
> +	.sched_policy = SCHED_DEADLINE,
> +	.sched_runtime = RUNTIME_VAL,
> +	.sched_period = PERIOD_VAL,
> +	.sched_deadline = DEADLINE_VAL,
> +};
> +
> +static struct test_case {
> +	pid_t *pid;
> +	struct sched_attr *a;
> +	unsigned int flags;
> +	int exp_return;
> +	int exp_errno;
> +} test_cases[] = {
> +	{&pid, &attr, 0, 0, 0},
> +	{&unused_pid, &attr, 0, -1, ESRCH},
> +	{&pid, NULL, 0, -1, EINVAL},
> +	{&pid, &attr, 1000, -1, EINVAL}
> +};
> +
> +static void setup(void);
> +static void sched_setattr_verify(const struct test_case *test);
> +
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +void *do_test(void *data LTP_ATTRIBUTE_UNUSED)
> +{
> +	int i;
> +
> +	for (i = 0; i < TST_TOTAL; i++)
> +		sched_setattr_verify(&test_cases[i]);
> +
> +	return NULL;
> +}
> +
> +static void sched_setattr_verify(const struct test_case *test)
> +{
> +	TEST(sched_setattr(*(test->pid), test->a, test->flags));
> +
> +	if (TEST_RETURN != test->exp_return) {
> +		tst_resm(TFAIL | TTERRNO, "sched_setattr() return "
> +			"unexpectedly: expected: %d", test->exp_return);
> +		return;
> +	}
> +
> +	if (TEST_ERRNO == test->exp_errno) {
> +		tst_resm(TPASS | TTERRNO,
> +			"sched_setattr() works as expected");
> +		return;
> +	}
> +
> +	tst_resm(TFAIL | TTERRNO, "sched_setattr() return unexpectedly "
> +		": expected: %d - %s",
> +		test->exp_errno, tst_strerrno(test->exp_errno));
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	pthread_t thread;
> +	int lc;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		pthread_create(&thread, NULL, do_test, NULL);
> +		pthread_join(thread, NULL);
> +	}
> +
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	unused_pid = tst_get_unused_pid(setup);
> +
> +	tst_require_root();
> +
> +	if ((tst_kvercmp(3, 14, 0)) < 0)
> +		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
> +
> +	TEST_PAUSE;
> +}
> 

