From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jun 2021 15:49:38 +0200
Subject: [LTP] [PATCH v2 03/10] getrusage02: Convert getrusage02 to new
 API
In-Reply-To: <20210609173601.29352-3-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
 <20210609173601.29352-3-vinay.m.engg@gmail.com>
Message-ID: <YMNp8tAdF1usM1LM@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #ifndef RUSAGE_BOTH		/* Removed from user space on RHEL4 */
>  #define RUSAGE_BOTH (-2)	/* still works on SuSE      */
>  #endif /* so this is a work around */

This is used as invalid value here, so this whole part looks wrong.

Can we just place -2 in the testcases structure instead?

> -static void setup();
> -static void cleanup();
> -
> -char *TCID = "getrusage02";
> -
>  static struct rusage usage;
>  
>  struct test_cases_t {
> @@ -90,56 +33,25 @@ struct test_cases_t {
>  } test_cases[] = {
>  	{
>  	RUSAGE_BOTH, &usage, EINVAL},
> -#ifndef UCLINUX
>  	{
>  	RUSAGE_SELF, (struct rusage *)-1, EFAULT}
> -#endif
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -int main(int ac, char **av)
> +static void verify_getrusage(unsigned int i)
>  {
> -
> -	int lc, i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(getrusage(test_cases[i].who, test_cases[i].usage));
> -
> -			if (TEST_RETURN == -1 &&
> -			    TEST_ERRNO == test_cases[i].exp_errno)
> -				tst_resm(TPASS | TTERRNO,
> -					 "getrusage failed as expected");
> -			else
> -				tst_resm(TFAIL | TTERRNO,
> -					 "getrusage failed unexpectedly");
> -		}
> -	}
> -
> -	cleanup();
> -
> -	tst_exit();
> -
> +		TEST(getrusage(test_cases[i].who, test_cases[i].usage));
> +
> +		if (TST_RET == -1 &&
> +		    TST_ERR == test_cases[i].exp_errno)
> +			tst_res(TPASS | TTERRNO,
> +				"getrusage failed as expected");
> +		else
> +			tst_res(TFAIL | TTERRNO,
> +				"getrusage failed unexpectedly");

Here as well, can we please switch to TST_EXP_FAIL()?

>  }
>  
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -}
> -
> -void cleanup(void)
> -{
> -
> -}
> +static struct tst_test test = {
> +	.test = verify_getrusage,
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.needs_root = 1,

Do we really need root for this test?

The original test works fine when executed as a user.

> +};
> -- 
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
