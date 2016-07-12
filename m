From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jul 2016 15:51:04 +0200
Subject: [LTP] [PATCH] waitpid06: use the new API
In-Reply-To: <1467904136-5136-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1467904136-5136-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160712135104.GC2651@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'd like to update those waitpid* test cases utilizing wait_for_parent()
> to use the checkpoint interface. It requires converting them for the
> new LTP API. This, in turn, drops UCLINUX support. However, since nobody
> has replied to:
> 
> http://lists.linux.it/pipermail/ltp/2016-May/001752.html
> 
> it (dropping UCLINUX) seems to be acceptable. Right?

I've even tried to subscribe to the uClinux-dev mailing list but it
looks like nobody manages it anymore. So I guess that we may start
dropping support for it.

> -static void setup_sigint(void)
> -{
> -	if ((sig_t) signal(SIGINT, inthandlr) == SIG_ERR) {
> -		tst_resm(TFAIL, "signal SIGINT failed. " "errno = %d", errno);
> -		exit(-1);
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		do_child_1();
> +	} else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WEXITSTATUS(status) != 0)
> +			tst_res(TFAIL, "Child returned bad status");
> +		else
> +			tst_res(TPASS, "Child returned good status");

Hmm, I guess that there is no reason for this indirection anymore. We
can just start MAXKIDS processes directly from the test() function.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
