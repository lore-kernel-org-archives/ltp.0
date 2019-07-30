From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jul 2019 11:07:54 +0200
Subject: [LTP] [PATCH v2] syscalls/prctl08: New test for prctl() with
 PR_{SET, GET}_TIMERSLACK
In-Reply-To: <1564216031-2973-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1564216031-2973-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190730090754.GA7528@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct tcase {
> +	unsigned long setvalue;
> +	unsigned long cmptime;
> +} tcases[] = {
> +	{1, 50000},
> +	{70000, 120000},
> +	{INT_MAX, 50000},
> +};
> +
> +static int proc_flag = 1;
> +
> +static void check_proc_ns(char *message, unsigned long value)
> +{
> +	unsigned long proc_value;
> +
> +	SAFE_FILE_SCANF(PROC_NS_PATH, "%lu", &proc_value);
> +	if (proc_value == value)
> +		tst_res(TPASS, "%s %s  got %lu expectedly",
> +				message, PROC_NS_PATH, proc_value);
> +	else
> +		tst_res(TFAIL, "%s %s expected %lu got %lu",
> +				message, PROC_NS_PATH, value, proc_value);
> +}
> +
> +static void check_get_timerslack(char *message, unsigned long value)
> +{
> +	TEST(prctl(PR_GET_TIMERSLACK));
> +	if ((unsigned long)TST_RET == value)
> +		tst_res(TPASS, "%s prctl(PR_GET_TIMERSLACK) got %lu expectedly",
> +				message, value);
> +	else
> +		tst_res(TFAIL, "%s prctl(PR_GET_TIMERSLACK) expected %lu got %lu",
> +				message, value, TST_RET);
> +
> +	if (proc_flag)
> +		check_proc_ns(message, value);
> +}
> +
> +static void verify_prctl(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int pid;
> +
> +	struct timespec timereq = { .tv_sec = 0, .tv_nsec = 50000 };
> +	struct timespec timecmp = { .tv_sec = 0, .tv_nsec = tc->cmptime};
> +
> +	TEST(prctl(PR_SET_TIMERSLACK, tc->setvalue));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_TIMERSLACK, %lu) failed",
> +				tc->setvalue);
> +		return;
> +	}
> +	tst_res(TPASS, "prctl(PR_SET_TIMERSLACK, %lu) success", tc->setvalue);
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_get_timerslack("child process", tc->setvalue);
> +		/* A value of 0 means using default */
> +		prctl(PR_SET_TIMERSLACK, 0);

Why do we reset the slack before the measurements?

> +		check_get_timerslack("After set 0, child process", tc->setvalue);
> +
> +		tst_timer_start(CLOCK_MONOTONIC);
> +		TEST(nanosleep(&timereq, NULL));
> +		tst_timer_stop();
> +
> +		if (tst_timespec_lt(tst_timer_elapsed(), timecmp))
> +			tst_brk(TFAIL, "nanosleep() slept less than timecmp");

I do not get what we are trying to assert here.

As far as I understand it the timer slack is a way how to inform kernel
that it's okay if the timers are slightly less precise. However the
timer still can fire somewhere between sleep time and sleep time +
slack, or even maybe later if the system is under load.

BTW we do have a formula that tries to compute maximal time the timers
should sleep based on timer slack in lib/tst_timer_test.c but even with
that we have to take more samples and compute truncated mean because
single short sleep may be delayed unless it's a RT kernel...

> +		tst_res(TPASS, "nanosleep() slept more than timecmp, %llius",
> +				tst_timer_elapsed_us());
> +		exit(0);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	if (access(PROC_NS_PATH, F_OK) == -1) {
> +		tst_res(TCONF, "proc doesn't support timerslack_ns interface");
> +		proc_flag = 0;
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = verify_prctl,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.forks_child = 1,
> +};
> -- 
> 2.18.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
