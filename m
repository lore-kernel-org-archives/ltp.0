From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Oct 2015 16:47:05 +0100
Subject: [LTP] [PATCH] sched_getattr/sched_getattr02: Add new testcase
 for sched_getattr
In-Reply-To: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
References: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <20151026154705.GB6772@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
> @@ -0,0 +1,152 @@

Please add a GPL header here.

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
> +#include "linux_syscall_numbers.h"
> +#include "lapi/sched.h"
> +
> +char *TCID = "sched_getattr01";
> +int TST_TOTAL = 1;
> +
> +#define SCHED_DEADLINE	6
> +#define RUNTIME_VAL 10000000
> +#define PERIOD_VAL 30000000
> +#define DEADLINE_VAL 30000000
> +
> +void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)
> +{
> +	struct sched_attr attr, attr_copy;
> +	int ret;
> +	unsigned int flags = 0;
> +	unsigned int size;
> +
> +	attr.size = sizeof(attr);
> +	attr.sched_flags = 0;
> +	attr.sched_nice = 0;
> +	attr.sched_priority = 0;
> +
> +	/* This creates a 10ms/30ms reservation */
> +	attr.sched_policy = SCHED_DEADLINE;
> +	attr.sched_runtime = RUNTIME_VAL;
> +	attr.sched_period = PERIOD_VAL;
> +	attr.sched_deadline = DEADLINE_VAL;
> +
> +	ret = sched_setattr(0, &attr, flags);
> +	if (ret < 0)
> +		tst_brkm(TFAIL | TERRNO, NULL, "sched_setattr() failed");
> +
> +	size = sizeof(attr_copy);

So this test test invalid parameters passed to sched_getattr(), then it
would be far better to define array of structures that describe what
parameters should be passed to the call and what is the expected
outcome. See for instance:

testcases/kernel/syscalls/kcmp/kcmp02.c

> +	/*
> +	 * TEST CASE 1
> +	 * set invalid address (NULL) of attr
> +	 */
> +	TEST(sched_getattr(0, NULL, size, flags));
> +
> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EINVAL) {
> +			tst_resm(TPASS, "sched_getattr() - set invalid address of attr failed as expected with errno %d : %s",
> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO));
> +		} else {
> +			tst_resm(TFAIL, "sched_getattr() - set invalid address of attr failed with errno %d : %s but expected %d (EINVAL)",

These messages are far too long. Be more punctual and to the point. Also
you should really use TTERRNO flag that will print TEST_ERRNO in
standard format rather than doing it manually. I would do something as:

tst_resm(TFAIL | TTERRNO, "sched_getattr() attr = NULL, expected EINVAL");

Which would yield:

foo         1  TFAIL  :  sched_getattr02.c:21: sched_getattr() attr = NULL, expected EINVAL: errno=EFAULT(14): Bad address

Which contains all information that is needed.

> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO), EINVAL);
> +		}
> +	} else {
> +		tst_resm(TFAIL, "sched_getattr() - set invalid address of attr succeeded unexpectedly.");
> +	}
> +
> +	/*
> +	 * TEST CASE 2
> +	 * set error value (999999) of pid
> +	 */
> +	TEST(sched_getattr(999999, &attr_copy, size, flags));

We have tst_get_unused_pid() that returns pid that is guaranteed not to
be used. Please us it instead.

> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == ESRCH) {
> +			tst_resm(TPASS, "sched_getattr() - set error value of pid failed as expected with errno %d : %s",
> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO));
> +		} else {
> +			tst_resm(TFAIL, "sched_getattr() - set error value of pid failed with errno %d : %s but expected %d (ESRCH)",
> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO), ESRCH);
> +		}
> +	} else {
> +		tst_resm(TFAIL, "sched_getattr() - set error value of pid succeeded unexpectedly.");
> +	}
> +
> +	/*
> +	 * TEST CASE 3
> +	 * set error value of size
> +	 */
> +	TEST(sched_getattr(0, &attr_copy, size - 1, flags));
> +
> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EINVAL) {
> +			tst_resm(TPASS, "sched_getattr() - set error value of size failed as expected with errno %d : %s",
> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO));
> +		} else {
> +			tst_resm(TFAIL, "sched_getattr() - set error value of size failed with errno %d : %s but expected %d (EINVAL)",
> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO), EINVAL);
> +		}
> +	} else {
> +		tst_resm(TFAIL, "sched_getattr() - set error value of size succeeded unexpectedly.");
> +	}
> +
> +	/*
> +	 * TEST CASE 4
> +	 * set error value (10000) of flags
> +	 */
> +	TEST(sched_getattr(0, &attr_copy, size, 10000));
> +
> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EINVAL) {
> +			tst_resm(TPASS, "sched_getattr() - set error value of flags failed as expected with errno %d : %s",
> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO));
> +		} else {
> +			tst_resm(TFAIL, "sched_getattr() - set error value of flags failed with errno %d : %s but expected %d (EINVAL)",
> +			TEST_ERRNO,
> +			strerror(TEST_ERRNO), EINVAL);
> +		}
> +	} else {
> +		tst_resm(TFAIL, "sched_getattr() - set error value of pid succeeded unexpectedly.");
> +	}
> +
> +	return NULL;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	pthread_t thread;
> +	int lc;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +
> +	tst_require_root();
> +
> +	if ((tst_kvercmp(3, 14, 0)) < 0)
> +		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		pthread_create(&thread, NULL, run_deadline, NULL);
> +		pthread_join(thread, NULL);
> +	}
> +
> +	tst_exit();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
