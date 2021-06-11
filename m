From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 15:57:11 +0200
Subject: [LTP] [PATCH v2 05/10] setitimer02: Convert setitimer02 to new
 API
In-Reply-To: <20210609173601.29352-5-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
 <20210609173601.29352-5-vinay.m.engg@gmail.com>
Message-ID: <YMNrt8TxrxhNjFPN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void verify_setitimer(void)
>  {
> -	int lc;
>  	struct itimerval *value;
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();		/* global setup */
> -
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/* allocate some space for a timer structure */
> -		if ((value = malloc((size_t)sizeof(struct itimerval))) ==
> -		    NULL) {
> -			tst_brkm(TBROK, cleanup, "value malloc failed");
> -		}
> -
> -		/* set up some reasonable values */
> -
> -		value->it_value.tv_sec = 30;
> -		value->it_value.tv_usec = 0;
> -		value->it_interval.tv_sec = 0;
> -		value->it_interval.tv_usec = 0;
> -		/*
> -		 * issue the system call with the TEST() macro
> -		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
> -		 */
> -
> -		/* call with a bad address */
> -		TEST(setitimer(ITIMER_REAL, value, (struct itimerval *)-1));
> -
> -		if (TEST_RETURN == 0) {
> -			tst_resm(TFAIL, "call failed to produce EFAULT error "
> -				 "- errno = %d - %s", TEST_ERRNO,
> -				 strerror(TEST_ERRNO));
> -			continue;
> -		}
> -
> -		switch (TEST_ERRNO) {
> -		case EFAULT:
> -			tst_resm(TPASS, "expected failure - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			break;
> -		default:
> -			tst_resm(TFAIL, "call failed to produce EFAULT error "
> -				 "- errno = %d - %s", TEST_ERRNO,
> -				 strerror(TEST_ERRNO));
> -		}
> -
> -		/*
> -		 * clean up things in case we are looping
> -		 */
> -		free(value);
> -		value = NULL;
> +	/* allocate some space for a timer structure */
> +	if ((value = malloc((size_t)sizeof(struct itimerval))) ==
> +		NULL) {
> +		tst_brk(TBROK, "value malloc failed");
>  	}

This should be allocated as a guarded buffer and initialized once in the
test setup, see:

https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers

> -	cleanup();
> -	tst_exit();
> -
> -}
> -
> -#else
> -
> -int main(void)
> -{
> -	tst_resm(TINFO, "test is not available on uClinux");
> -	tst_exit();
> -}
> -
> -#endif /* if !defined(UCLINUX) */
> -
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> +	/* set up some reasonable values */
> +	value->it_value.tv_sec = 30;
> +	value->it_value.tv_usec = 0;
> +	value->it_interval.tv_sec = 0;
> +	value->it_interval.tv_usec = 0;
> +	/*
> +	 * issue the system call with the TEST() macro
> +	 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
> +	 */
> +
> +	/* call with a bad address */
> +	TEST(setitimer(ITIMER_REAL, value, (struct itimerval *)-1));
> +
> +	if (TST_RET == 0) {
> +		tst_res(TFAIL, "call failed to produce EFAULT error "
> +			"- errno = %d - %s", TST_ERR,
> +			strerror(TST_ERR));
> +	}
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	switch (TST_ERR) {
> +	case EFAULT:
> +		tst_res(TPASS, "expected failure - errno = %d - %s",
> +			TST_ERR, strerror(TST_ERR));
> +		break;
> +	default:
> +		tst_res(TFAIL, "call failed to produce EFAULT error "
> +			"- errno = %d - %s", TST_ERR,
> +			strerror(TST_ERR));
> +	}
>  
> -	TEST_PAUSE;
> +	/*
> +	 * clean up things in case we are looping
> +	 */
> +	free(value);
> +	value = NULL;

Here as well, we should switch to TST_EXP_FAIL()

>  }
>  
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> -{
> +static struct tst_test test = {
> +	.test_all = verify_setitimer,
> +	.needs_root = 1,

Here as well, no need for the root.

> +};
>  
> -}
> -- 
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
