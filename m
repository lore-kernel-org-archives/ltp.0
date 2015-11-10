From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2015 14:19:40 +0100
Subject: [LTP] [PATCH] [PATCH] sched_setattr/sched_setattr01: Add new
 testcase for sched_setattr
In-Reply-To: <1446801572-215993-1-git-send-email-cuibixuan@huawei.com>
References: <1446801572-215993-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <20151110131940.GF23947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "test.h"
> +#include "linux_syscall_numbers.h"

This header is included from lapi/sched.h, isn't it?

So there is no need to include it here as well.

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
> +struct sched_attr attr;
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
> +void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)

The function should rather be named "do_test()" or similar.

> +{
> +	int i;
> +
> +	attr.size = sizeof(attr);
> +	attr.sched_flags = 0;
> +	attr.sched_nice = 0;
> +	attr.sched_priority = 0;
> +
> +	attr.sched_policy = SCHED_DEADLINE;
> +	attr.sched_runtime = RUNTIME_VAL;
> +	attr.sched_period = PERIOD_VAL;
> +	attr.sched_deadline = DEADLINE_VAL;

Well, we can initialize this structure statically as well just by:

static struct sched_attr attr = {
	.size = sizeof(attr),
	.sched_flags = 0,
	...
};


> +	for (i = 0; i < TST_TOTAL; i++)
> +		sched_setattr_verify(&test_cases[i]);
> +
> +	return NULL;
> +}
> +
> +static void sched_setattr_verify(const struct test_case *test)
> +{
> +	errno = 0;

No need to zero errno, the TEST() macro does that for you.

> +	TEST(sched_setattr(*(test->pid), test->a, test->flags));
> +
> +	if (TEST_RETURN != test->exp_return) {
> +		tst_resm(TFAIL, "sched_getattr() return unexpectedly.");

Please print the actual return value and expected return value here.

It may be good to actually distinguish between expected failure and
expected success. Then we wouldn't have to print the expected return
value and just print TFAIL, "succeded unexpectedly" or TFAIL | TTERRNO,
"failed with %li unexpectedly", TEST_RETURN.

> +		return;
> +	}
> +
> +	if (TEST_ERRNO == test->exp_errno) {
> +		tst_resm(TPASS | TTERRNO,
> +			"sched_setattr() return expectedly");
                                           ^
					   maybe "works as expected" is
					   a bit better

> +		return;
> +	}
> +
> +	tst_resm(TFAIL | TTERRNO, "sched_getattr() return unexpectedly "
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
> +		pthread_create(&thread, NULL, run_deadline, NULL);
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

-- 
Cyril Hrubis
chrubis@suse.cz
