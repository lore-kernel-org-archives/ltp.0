From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Oct 2015 17:09:13 +0100
Subject: [LTP] [PATCH v2] sched_getattr/sched_getattr02: Add new
 testcase for sched_getattr
In-Reply-To: <56302781.30701@huawei.com>
References: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
 <20151026154705.GB6772@rei> <56302781.30701@huawei.com>
Message-ID: <20151029160913.GE23990@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "test.h"
> +#include "linux_syscall_numbers.h"
> +#include "lapi/sched.h"
> +
> +char *TCID = "sched_getattr02";
> +
> +#define SCHED_DEADLINE  6
> +#define RUNTIME_VAL 10000000
> +#define PERIOD_VAL 30000000
> +#define DEADLINE_VAL 30000000
> +
> +static pid_t pid;
> +static pid_t unused_pid;
> +struct sched_attr attr_copy;
> +static unsigned int size;
> +static unsigned int inval_size;
> +static unsigned int flags;
> +static unsigned int inval_flags = 10000;
> +
> +static struct test_case {
> +	pid_t *pid;
> +	struct sched_attr *a;
> +	unsigned int *size;
> +	unsigned int *flags;
> +	int exp_errno;
> +} test_cases[] = {
> +	{&unused_pid, &attr_copy, &size, &flags, ESRCH},
> +	{&pid, NULL, &size, &flags, EINVAL},
> +	{&pid, &attr_copy, &inval_size, &flags, EINVAL},
> +	{&pid, &attr_copy, &size, &inval_flags, EINVAL}
> +};
> +
> +static void cleanup(void);
> +static void setup(void);
> +static void sched_getattr_verify(const struct test_case *test);
> +
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)
> +{
> +	struct sched_attr attr;
> +	int ret;
> +	unsigned int flags = 0;
> +	int ind;
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

Hmm, do we actually have to call sched_setattr() before we try to do
sched_getattr()?

> +	for (ind = 0; ind < TST_TOTAL; ind++)
> +		sched_getattr_verify(&test_cases[ind]);

Using anything else than i as loop variable is strange.

> +	return NULL;
> +}
> +
> +static void sched_getattr_verify(const struct test_case *test)
> +{
> +	TEST(sched_getattr(*(test->pid), test->a, *(test->size),
> +			*(test->flags)));
> +
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "sched_getattr() succeeded unexpectedly.");
> +		return;
> +	}
> +
> +	if (TEST_ERRNO == test->exp_errno) {
> +		tst_resm(TPASS | TTERRNO,
> +			"sched_getattr() returned the expected value");
                                            ^
					    "failed expectedly" would be
					    a bit better.
> +		return;
> +	}
> +
> +	tst_resm(TFAIL | TTERRNO, "sched_getattr() got unexpected return "
                                                     ^
						  "failed unexpectedly"
> +		"value: expected: %d - %s",
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
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	pid = 0;

Pid is global variable and therefore initialized to 0 allready.

> +	unused_pid = tst_get_unused_pid(cleanup);
> +	size = sizeof(attr_copy);
> +	inval_size = size - 1;

Both sizeof(attr_copy) and sizeof(attr_copy) - 1 are compile time
constants, you can use them directly in the structure initalizer instead
of using it indirectly here.

Also the flags can be initialized directly, no need to use pointers as
they are constant at the compile time as well.

> +	flags = 0;
> +
> +	tst_require_root();
> +
> +	if ((tst_kvercmp(3, 14, 0)) < 0)
> +		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
> +
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
> +{
> +}

Do not add useless empty cleanup() function.

-- 
Cyril Hrubis
chrubis@suse.cz
