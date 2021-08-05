From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Aug 2021 14:04:54 +0200
Subject: [LTP] [PATCH] [3/6] syscalls/sysfs: Convert sysfs03 to the new
 API
In-Reply-To: <20210805110349.16615-1-sujiaxun@uniontech.com>
References: <20210805110349.16615-1-sujiaxun@uniontech.com>
Message-ID: <YQvT5slxDpsJtSDc@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * [DESCRIPTION]

Here as well [Description]

> + * This test is run for option 3 for sysfs(2)
> + */
> 
>  #include <errno.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> -#include "test.h"
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
> 
> -static void setup();
> -static void cleanup();
> -
> -char *TCID = "sysfs03";
> -int TST_TOTAL = 1;
> -
> -int main(int ac, char **av)
> +static void verify_sysfs03(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> 
> -	setup();
> 
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(ltp_syscall(__NR_sysfs, 3));
> +		TEST(tst_syscall(__NR_sysfs, 3));
> 
>  		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "sysfs(2) Failed for"
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL, "sysfs(2) Failed for"
>  				 " option 3 and returned"
> -				 " %d as error number", TEST_ERRNO);
> +				 " %d as error number", TST_ERR);
>  		} else {
> -			tst_resm(TPASS, "sysfs(2) Passed for option 3");
> +			tst_res(TPASS, "sysfs(2) Passed for option 3");
>  		}
> -	}			/*End of TEST_LOOPING */

And here as well this could be replaced with TST_EXP_POSSITIVE()


-- 
Cyril Hrubis
chrubis@suse.cz
