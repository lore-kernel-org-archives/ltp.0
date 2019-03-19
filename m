From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Mar 2019 17:44:16 +0100
Subject: [LTP] [PATCH v3 1/2] rt_sigpending02: reuse code from
 sigpending02
In-Reply-To: <20190319113153.13436-2-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <20190319113153.13436-1-maennich@google.com>
 <20190319113153.13436-2-maennich@google.com>
Message-ID: <20190319164416.GA14664@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Matthias,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>  static void run(void)
> @@ -24,20 +28,26 @@ static void run(void)
>  	/* set sigset to point to an invalid location */
>  	sigset_t *sigset = (sigset_t *) - 1;
There is (undocumented) library helper tst_get_bad_addr() which might bring some
arch portability.

> +#if defined(TEST_SIGPENDING)
>  	TEST(tst_syscall(__NR_sigpending, sigset));
BTW: Looking into this, which I merged in 63f8a3f77 ("sigpending: use direct
syscall") removed testing sigpending() glibc wrapper from intel. Now:
sigpending02.c:67: CONF: syscall(-1) __NR_sigpending not supported
@Cyril, is it ok for us?
I guess, we should do something about #506 [1] to solve problems like this.

> +#elif defined(TEST_RT_SIGPENDING)
> +	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE));
> +#else
> +#error Neither TEST_SIGPENDING nor TEST_RT_SIGPENDING is defined!
> +#endif

>  	/* check return code */
>  	if (TST_RET == -1) {
>  		if (TST_ERR != EFAULT) {
>  			tst_res(TFAIL | TTERRNO,
> -				"sigpending() Failed with wrong errno, "
> +				"syscall failed with wrong errno, "
>  				"expected errno=%d, got ", EFAULT);
I'd join this string. + trailing space after got.

>  		} else {
>  			tst_res(TPASS | TTERRNO, "expected failure");
>  		}
>  	} else {
>  		tst_res(TFAIL,
> -			"sigpending() Failed, expected return value=-1, got %ld", TST_RET);
> +			"syscall failed, expected return value=-1, got %ld", TST_RET);
>  	}
>  }

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/506
