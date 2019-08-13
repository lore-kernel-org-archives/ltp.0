From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Aug 2019 14:13:40 +0200
Subject: [LTP] [PATCH v2 2/2] clock_getres01: add test variants
In-Reply-To: <e4c5428276c9a85efc6bddaa2d82e2aed5806108.1565361031.git.jstancek@redhat.com>
References: <ee463189a82212a10c1ac06229dc0a418e18305b.1565361031.git.jstancek@redhat.com>
 <e4c5428276c9a85efc6bddaa2d82e2aed5806108.1565361031.git.jstancek@redhat.com>
Message-ID: <20190813121340.GC16005@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 0 - default, could be either VDSO or syscall
> 1 - syscall with valid res parameter
> 2 - syscall with NULL res parameter
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/clock_getres/clock_getres01.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> index df3e84271ad9..a4134bc1d3c2 100644
> --- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> +++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> @@ -13,6 +13,7 @@
>  #include <errno.h>
>  
>  #include "tst_test.h"
> +#include "lapi/syscalls.h"
>  #include "lapi/posix_clocks.h"
>  
>  static struct timespec res;
> @@ -39,7 +40,18 @@ static struct test_case {
>  
>  static void do_test(unsigned int i)
>  {
> -	TEST(clock_getres(tcase[i].clk_id, tcase[i].res));
> +	switch (tst_variant) {
> +	case 0:
> +		TEST(clock_getres(tcase[i].clk_id, tcase[i].res));
> +		break;
> +	case 1:
> +		TEST(tst_syscall(__NR_clock_getres, tcase[i].clk_id,
> +			tcase[i].res));
> +		break;
> +	case 2:
> +		TEST(tst_syscall(__NR_clock_getres, tcase[i].clk_id, NULL));
> +		break;
> +	}
>  
>  	if (TST_RET != tcase[i].ret) {
>  		if (TST_ERR == EINVAL) {
> @@ -64,4 +76,5 @@ static void do_test(unsigned int i)
>  static struct tst_test test = {
>  	.test = do_test,
>  	.tcnt = ARRAY_SIZE(tcase),
> +	.test_variants = 3,
>  };

Can we please print which variant we are about to test from the test
setup() as well?

-- 
Cyril Hrubis
chrubis@suse.cz
