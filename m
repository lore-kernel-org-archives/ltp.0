From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 17:08:44 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/clock_getres01: convert to use
 new test library API
In-Reply-To: <20161115134929.8471-1-pvorel@suse.cz>
References: <20161115134929.8471-1-pvorel@suse.cz>
Message-ID: <20161115160843.GC24751@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(clock_getres(tcase[i].clk_id, tcase[i].res));
> +
> +	if (TEST_RETURN != tcase[i].ret) {
> +		if (TEST_ERRNO != EINVAL) {
> +				tst_res(TFAIL | TTERRNO,
> +				 "clock_getres %s failed",
> +				 tcase[i].name);
                ^
		Fix the indentation here, (1 tab instead of two).

> +		} else {
> +				tst_res(TCONF,
> +				 "clock_getres %s NO SUPPORTED",
> +				 tcase[i].name);
> +		}

And we can simplify the code flow a bit as:


	if (TEST_RETURN != tcase[i].ret) {
		if (TEST_ERRNO == EINVAL) {
			tst_res(TCONF, ...);
			return;
		}

		tst_res(TFAIL ...);
		return;
	}


	if (TEST_ERRNO != tcase[i].err) {
		tst_res(TFAIL, ...);
		return;
	}

	tst_res(TPASS, ...);


> +	} else {
> +		if (TEST_ERRNO != tcase[i].err) {
> +				tst_res(TFAIL,
> +				 "clock_getres %s failed with "
> +				 "unexpect errno: %d",
> +				 tcase[i].name, TEST_ERRNO);
                                     ^

				 This message should print what errno we
				 got and what was the expected one, it
				 should be something as:


				 tst_res(TFAIL | TTERRNO,
				         "clock_getres(%s, ...) failed unexpectedly, expected %s",
					 tcase[i].name, tst_strerrno(tcase[i].err));

> +		} else {
> +				tst_res(TPASS,
> +				 "clock_getres %s succeeded",
> +				 tcase[i].name);
>  		}
>  	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	TEST_PAUSE;
>  }
>  
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.tid = "clock_getres01",
> +	.test = do_test,
> +	.tcnt = ARRAY_SIZE(tcase),
> +};
> -- 
> 2.10.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
