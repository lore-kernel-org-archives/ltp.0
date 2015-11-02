From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Nov 2015 18:28:09 +0100
Subject: [LTP] [PATCH v3] sched_getattr/sched_getattr02: Add new
 testcase for sched_getattr
In-Reply-To: <563463CC.3090703@huawei.com>
References: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
 <20151026154705.GB6772@rei> <56302781.30701@huawei.com>
 <20151029160913.GE23990@rei> <563463CC.3090703@huawei.com>
Message-ID: <20151102172809.GD28478@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static pid_t pid;
> +static pid_t unused_pid;
> +struct sched_attr attr_copy;
> +static unsigned int flags;
> +static unsigned int inval_flags = 10000;
> +
> +static struct test_case {
> +	pid_t *pid;
> +	struct sched_attr *a;
> +	unsigned int size;
> +	unsigned int *flags;
> +	int exp_errno;
> +} test_cases[] = {
> +	{&unused_pid, &attr_copy, sizeof(struct sched_attr), &flags, ESRCH},
> +	{&pid, NULL, sizeof(struct sched_attr), &flags, EINVAL},
> +	{&pid, &attr_copy, sizeof(struct sched_attr) - 1, &flags, EINVAL},
> +	{&pid, &attr_copy, sizeof(struct sched_attr), &inval_flags, EINVAL}

The flags are also compile time constant, so we can just initialize it
here with 0 and 10000 for invalid flags the same way as the size.

> +};
> +
> +static void setup(void);
> +static void sched_getattr_verify(const struct test_case *test);
> +
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)
> +{
> +	int i;
> +
> +	for (i = 0; i < TST_TOTAL; i++)
> +		sched_getattr_verify(&test_cases[i]);
> +
> +	return NULL;
> +}
> +
> +static void sched_getattr_verify(const struct test_case *test)
> +{
> +	TEST(sched_getattr(*(test->pid), test->a, test->size,
> +			*(test->flags)));
> +
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "sched_getattr() succeeded unexpectedly.");
> +		return;
> +	}
> +
> +	if (TEST_ERRNO == test->exp_errno) {
> +		tst_resm(TPASS | TTERRNO,
> +			"sched_getattr() failed expectedly");
> +		return;
> +	}
> +
> +	tst_resm(TFAIL | TTERRNO, "sched_getattr() failed unexpectedly "
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

And since we do not call the sched_setattr() anymore, there is no reason
to run the test in separate thread, or is it?

I would just do the for loop over the testcase here inside the
TEST_LOOPING() loop.

> +	}
> +
> +	tst_exit();
> +}

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
