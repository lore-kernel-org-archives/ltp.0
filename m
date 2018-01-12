From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jan 2018 11:45:40 +0100
Subject: [LTP] [PATCH v2] Add regression test for CVE-2017-17052
In-Reply-To: <20180110155505.28433-1-mmoese@suse.de>
References: <20180110155505.28433-1-mmoese@suse.de>
Message-ID: <20180112104540.GA22350@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void *mmap_thread(void *_arg)
> +{
> +	for (;;) {
> +		SAFE_MMAP(NULL, 0x1000000, PROT_READ,
> +				MAP_POPULATE|MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +	}
> +}
> +
> +static void *fork_thread(void *_arg)
> +{
> +	if (shm->exit) {
> +		SAFE_SHMDT(shm);
> +		exit(0);
> +	}
> +
> +	usleep(rand() % 10000);
> +	SAFE_FORK();
> +}
> +
> +static void do_test_fork(void)
> +{
> +	volatile int i;
> +	int status;
> +
> +	SAFE_FORK();
> +	SAFE_FORK();
> +	SAFE_FORK();
> +
> +	for(;;) {
> +		if (SAFE_FORK() == 0) {
> +			pthread_t t;
> +
> +			SAFE_PTHREAD_CREATE(&t, NULL, mmap_thread, NULL);
> +			SAFE_PTHREAD_CREATE(&t, NULL, fork_thread, NULL);
> +			usleep(rand() % 10000);
> +			syscall(__NR_exit_group, 0);
> +		}
> +		SAFE_WAIT(&status);
> +		if (shm->exit)
> +			exit(0);
> +	}
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid;
> +	int status;
> +	volatile int run = 0;
> +
> +	while (run < RUNS) {
> +		pid = SAFE_FORK();
> +
> +		if (pid == 0) {
> +			do_test_fork();
> +		} else {
> +			usleep(EXEC_USEC);
> +			shm->exit = 1;
> +		}
> +		tst_res(TINFO, "run %d passed\n", run);
> +		run++;
> +	}
> +
> +	if (run == RUNS)
> +		tst_res(TPASS, "kernel survived %d runs", run);
> +	else
> +		tst_res(TBROK, "something strange happened");

Apart from the SHM, that's already been commented here my only question
is what is the outcome of the test on unpatched kernel? I suppose that
we got TPASS when everything is going well, do we print the "something
strange happened" message if the test fails, or does it fail elsewhere?

-- 
Cyril Hrubis
chrubis@suse.cz
