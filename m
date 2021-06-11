From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 15:41:43 +0200
Subject: [LTP] [PATCH v2 01/10] getitimer02 : Convert getitimer02 to new
 API
In-Reply-To: <20210609173601.29352-1-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
Message-ID: <YMNoFyN89L6/VhP3@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		/* call with a bad address */
>  		TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));
>  

Can we please make use of TST_EXP_FAIL() here instead?

> -		if (TEST_RETURN == 0) {
> -			tst_resm(TFAIL, "call failed to produce "
> -				 "expected error - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			continue;
> +		if (TST_RET == 0) {
> +			tst_res(TFAIL, "call failed to produce "
> +				"expected error - errno = %d - %s",
> +				TST_ERR, strerror(TST_ERR));
>  		}
>  
> -		switch (TEST_ERRNO) {
> +		switch (TST_ERR) {
>  		case EFAULT:
> -			tst_resm(TPASS, "expected failure - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> +			tst_res(TPASS, "expected failure - errno = %d - %s",
> +				 TST_ERR, strerror(TST_ERR));
>  			break;
>  		default:
> -			tst_resm(TFAIL, "call failed to produce "
> -				 "expected error - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> +			tst_res(TFAIL, "call failed to produce "
> +					"expected error - errno = %d - %s",
> +					TST_ERR, strerror(TST_ERR));

And can we please have a proper indentation here from the start instead
of fixing that in subsequent patches?

> -#endif /* if !defined(UCLINUX) */
> +static struct tst_test test = {
> +			.test_all = verify_getitimer,
> +			.needs_root = 1,

And here as well.

-- 
Cyril Hrubis
chrubis@suse.cz
