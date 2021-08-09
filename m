From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 13:28:34 +0200
Subject: [LTP] [PATCH v2 06/16] syscalls/sched_setparam03: convert to
 new API
In-Reply-To: <20210806164730.51040-7-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-7-aleksei.kodanev@bell-sw.com>
Message-ID: <YRERYjpToxyA0AZI@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (!child_pid) {
> +		/*
> +		 * Call sched_setparam(2) with pid = getppid() so that
> +		 * it will set the scheduling parameters for parent
> +		 * process
> +		 */

I would have removed this comment as well, as it's stating the obvious.

> +		TST_EXP_PASS_SILENT(tv->sched_setparam(getppid(), &p5));
> +		exit(0);
>  	}
> +	tst_reap_children();
>  
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_PASS_SILENT(tv->sched_getparam(0, &p));
> +
> +	if (p.sched_priority == p5.sched_priority)
> +		tst_res(TPASS, "got expected priority %d", p.sched_priority);
> +	else
> +		tst_res(TFAIL, "got priority %d, expected 5", p.sched_priority);
>  }
>  
> -/* setup() - performs all ONE TIME setup for this test */
>  void setup(void)
>  {
> -	struct sched_param p = { 1 };
> -
> -	tst_require_root();
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Change scheduling policy to SCHED_FIFO */
> -	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1) {
> -		tst_brkm(TBROK, cleanup, "sched_setscheduler() failed");
> -	}
> +	struct sched_variants *tv = &variants[tst_variant];
> +	struct sched_param p = { .sched_priority = 1 };
>  
> +	tst_res(TINFO, "Testing %s variant", tv->desc);
> +	TST_EXP_PASS_SILENT(tv->sched_setscheduler(0, SCHED_FIFO, &p));

We should tst_brk() here if this fails, TST_EXP_PASS_SILENT() is not
really supposed to be used in the test setup().

And given that we handle the TCONF case in the function we call by the
pointer we can just do:

	if (tv->sched_setscheduler(0, SCHED_FIFO, &p))
		tst_brk(TBROK | TERRNO, "sched_setcheduler(0, SCHED_FIFO, ...)");


Other than this the rest looks good. With the setup() part fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz
