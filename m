From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Jan 2019 11:57:03 +0100
Subject: [LTP] [PATCH v5 ltp] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20190116171645.13055-1-pengfei.xu@intel.com>
References: <20190116171645.13055-1-pengfei.xu@intel.com>
Message-ID: <20190117105703.GB23942@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void verify_umip_instruction(unsigned int n)
> +{
> +	int status;
> +	struct tcase *tc = &tcases[n];
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		switch (tc->option) {
> +		case 0:
> +			asm_sgdt();
> +			break;
> +		case 1:
> +			asm_sidt();
> +			break;
> +		case 2:
> +			asm_sldt();
> +			break;
> +		case 3:
> +			asm_smsw();
> +			break;
> +		case 4:
> +			asm_str();
> +			break;
> +		default:
> +			tst_brk(TCONF, "Invalid tcase parameter:%d",
> +				tc->option);
> +		}
> +	} else {
> +		// let child process execute first
> +		sleep(1);
> +		SAFE_KILL(pid, SIGINT);

Is this still needed? As far as I can tell the child either gets killed
by kernel or calls exit(0) right after it has been started.

I do frown upon every use of sleep() in tests and let me just explain
the reason why.

We do have about 3000 of tests in LTP, if each of the tests was calling
sleep() carelessly that would add up to an hour of useless waiting and
we do care about the testsuite to finish as fast as possible for several
reasons. Mainly because no sane developer would use tests that take so
long to run. Minimizing the time needed to test a code change is hence
the only way how the ensure that the tests are actually used in
production and tests that are not used are completely pointless to begin
with.

The second reason why sleep(1) is wrong is that, while it works fine in
99% of the cases, there is no guarantee that the child would actually
finish under 1 second. In this case this would probably never be a
problem, but if you did anything more compled in the child than
executing a single instruction it will became a real problem as well.

> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TPASS, "Got SIGSEGV");
> +		return;
> +	}
> +	tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s",
> +		tst_strstatus(status));
> +}
> +
> +static void setup(void)
> +{
> +	FILE *fp;
> +	int max = 2048;
> +	char buf[max];
> +
> +	// cpuinfo should contain umip
> +	fp = SAFE_FOPEN(CPUINFO_FILE, "r");
> +	while (!feof(fp)) {
> +		if (fgets(buf, sizeof(buf), fp) == NULL) {

You should close the file here.

> +			tst_brk(TCONF, "cpuinfo show: cpu does not support umip");
> +		}
> +
> +		if (!strstr(buf, "flags"))
> +			continue;
> +
> +		if (strstr(buf, "umip")) {
> +			tst_res(TINFO, "cpuinfo contain umip, cpu support umip");
> +			break;
> +		} else
> +			continue;
> +	}
> +
> +	SAFE_FCLOSE(fp);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +}

This is now completely unused, let's get rid of it.

> +static struct tst_test test = {
> +	.min_kver = "4.1",
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.forks_child = 1,
> +	.test = verify_umip_instruction,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +};
> -- 
> 2.14.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
