From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 11:38:24 +0100
Subject: [LTP] [PATCH 1/1] syscalls/clock_getres01: convert to use new
 test library API
In-Reply-To: <20161115095307.27985-1-pvorel@suse.cz>
References: <20161115095307.27985-1-pvorel@suse.cz>
Message-ID: <20161115103824.GB13947@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -#include <sys/syscall.h>
> -#include <sys/types.h>
> -#include <getopt.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include <libgen.h>
>  #include <errno.h>
> -#include <stdio.h>
> -#include <time.h>
> -#include "config.h"
> -#include "include_j_h.h"
>  
> -#include "test.h"
> -#include "lapi/posix_clocks.h"

You shouldn't remove this one, as it provides fallback definitions for
CLOCK_FOO for distros with older glibc.

> +#include "tst_test.h"
>  
>  #define NORMAL		1
>  #define NULL_POINTER	0

I guess that it would be cleaner to include the pointer to the res in
the structure describing the testcase as well instead of this hackery.

> @@ -66,67 +55,46 @@ static struct test_case {
>  	{"-1", -1, NORMAL, -1, EINVAL},
>  };
>  
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "clock_getres01";
>  int TST_TOTAL = ARRAY_SIZE(tcase);
>  
> -int main(int ac, char **av)
> +static void do_test(void)
>  {
>  	int i;
> -	int lc;
>  	struct timespec res;
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; ++i) {
> -			if (tcase[i].ttype == NULL_POINTER)
> -				TEST(clock_getres(tcase[i].clk_id, NULL));
> -			else
> -				TEST(clock_getres(tcase[i].clk_id, &res));
> -
> -			if (TEST_RETURN != tcase[i].ret) {
> -				if (TEST_ERRNO != EINVAL) {
> -					tst_resm(TFAIL | TTERRNO,
> -						 "clock_getres %s failed",
> -						 tcase[i].name);
> -				} else {
> -					tst_resm(TCONF,
> -						 "clock_getres %s NO SUPPORTED",
> -						 tcase[i].name);
> -				}
> +	for (i = 0; i < TST_TOTAL; ++i) {
> +		if (tcase[i].ttype == NULL_POINTER)
> +			TEST(clock_getres(tcase[i].clk_id, NULL));
> +		else
> +			TEST(clock_getres(tcase[i].clk_id, &res));
> +
> +		if (TEST_RETURN != tcase[i].ret) {
> +			if (TEST_ERRNO != EINVAL) {
> +					tst_res(TFAIL | TTERRNO,
> +					 "clock_getres %s failed",
> +					 tcase[i].name);
>  			} else {
> -				if (TEST_ERRNO != tcase[i].err) {
> -					tst_resm(TFAIL,
> -						 "clock_getres %s failed with "
> -						 "unexpect errno: %d",
> -						 tcase[i].name, TEST_ERRNO);
> -				} else {
> -					tst_resm(TPASS,
> -						 "clock_getres %s succeeded",
> -						 tcase[i].name);
> -				}
> +					tst_res(TCONF,
> +					 "clock_getres %s NO SUPPORTED",
> +					 tcase[i].name);
> +			}
> +		} else {
> +			if (TEST_ERRNO != tcase[i].err) {
> +					tst_res(TFAIL,
> +					 "clock_getres %s failed with "
> +					 "unexpect errno: %d",
> +					 tcase[i].name, TEST_ERRNO);
> +			} else {
> +					tst_res(TPASS,
> +					 "clock_getres %s succeeded",
> +					 tcase[i].name);

Can we get rid of the for () loop here as well and rather use the .test
function and .tcnt in tst_test structure instead?

>  			}
> -
>  		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
>  
> -static void setup(void)
> -{
> -	TEST_PAUSE;
> +	}
>  }
>  
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.tid = "clock_getres01",
> +	.test_all = do_test,
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
