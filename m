From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jan 2019 14:45:24 +0100
Subject: [LTP] [PATCH v4 ltp] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20190110105856.32422-1-pengfei.xu@intel.com>
References: <20190110105856.32422-1-pengfei.xu@intel.com>
Message-ID: <20190116134523.GE24833@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void sig_handler(int signal)
> +{
> +	int exp_sigsegv = 11;
> +
> +	if (exp_sigsegv == signal) {
> +		sigsegv_cnt++;
> +		tst_res(TPASS, "Received SIGSEGV signal:%d, num:%d",
> +			signal, sigsegv_cnt);
> +		// signal handler by app, kernel will not kill, need exit
> +		exit(EXIT_VALUE);
> +	} else {
> +		tst_res(TWARN, "Received unexpected signal:%d", signal);
> +		SAFE_KILL(pid, SIGINT);
> +	}
> +}

I think I already tried to explain that signal handler runs
asynchronously to the rest of the code and that calling anything else
than a few signal-async-safe functions may cause undefined behavior,
which mostly translates to deadlocks.

Why can't we write the test as:

static void asm_sgdt(void)
{
	unsigned char val[GDT_LEN];

	tst_res(TINFO, "TEST sgdt, sgdt result save at [%p]", val);
	asm volatile("sgdt %0\n" : "=m" (val));
	exit(0);
}

...

static void do_test(unsigned int n)
{
	int pid, status;

	pid = SAFE_FORK();

	if (!pid) {
		switch (n) {
		case 0:
			asm_sgdt();
		break;
		...
		}
	}

	SAFE_WAITPID(pid, &status, 0);

	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
		tst_res(TPASS, "Got SIGSEGV");
		return;
	}

	tst_res(TFAIL, "Child exitted with %s", tst_strstatus(status));
}


-- 
Cyril Hrubis
chrubis@suse.cz
