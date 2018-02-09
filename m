From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Feb 2018 16:30:01 +0100
Subject: [LTP] [PATCH] Add regression test for CVE-2017-17053
In-Reply-To: <20180126143700.29609-1-mmoese@suse.de>
References: <20180126143700.29609-1-mmoese@suse.de>
Message-ID: <20180209153001.GA28203@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void handler(int sig, siginfo_t *si, void *unused)
> +{
> +	(void)(sig);
> +	(void)(si);
> +	(void)(unused);
> +
> +	*do_exit = -1;
> +}
> +
> +static void setup(void)
> +{
> +	struct sigaction sa;
> +
> +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> +
> +	sa.sa_flags = SA_SIGINFO;
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_sigaction = handler;
> +
> +	if (sigaction(SIGSEGV, &sa, NULL) == -1)
> +		tst_brk(TBROK, "sigaction failed for SIGSEGV");

Why do we use the sa.sa_sigaction here instead of sa_handler if we are
not using the siginfo_t anyways? And why don't we just use
SAFE_SIGNAL(SIGSEGV, handler) as well?

Also it may be better to set the handler after we forked in the run()
function, ignoring SIGSEGV in the main test process does not sound like
a good idea to me.

> +	do_exit = SAFE_MMAP(NULL, sizeof(*do_exit), PROT_READ | PROT_WRITE,
> +			    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	*do_exit = 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP((void *) do_exit, sizeof(*do_exit));
                     ^
		    There is absolutely no reason to cast pointers to
		    (void *) in C the conversion is automatic in this
		    case.

Other than these two minor nits the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
