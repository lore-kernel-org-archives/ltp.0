From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Sep 2020 10:10:32 +0200
Subject: [LTP] [PATCH] clock_gettime04: relax the time diff in VM
In-Reply-To: <20200915031402.26519-1-liwang@redhat.com>
References: <20200915031402.26519-1-liwang@redhat.com>
Message-ID: <20200915081032.GA8111@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> To balance that the test inside a VM can NOT get enough CPU time, which
> result in sporadically fails with the time comparing.
> 
> clock_gettime04.c:155: PASS: CLOCK_REALTIME: Difference between successive readings is reasonable
> clock_gettime04.c:155: PASS: CLOCK_REALTIME_COARSE: Difference between successive readings is reasonable
> clock_gettime04.c:148: FAIL: CLOCK_MONOTONIC: Difference between successive readings greater than 5 ms (2): 22
> clock_gettime04.c:155: PASS: CLOCK_MONOTONIC_COARSE: Difference between successive readings is reasonable
> clock_gettime04.c:148: FAIL: CLOCK_MONOTONIC_RAW: Difference between successive readings greater than 5 ms (1): 22
> clock_gettime04.c:148: FAIL: CLOCK_BOOTTIME: Difference between successive readings greater than 5 ms (1): 29
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

The idea is good, but I think that the implementation could be better.

Why can't we just call the tst_is_virt() in test setup and if we detect
that we are running on virtual machine print a TINFO message that
maximal expected difference has been multiplied by 10?

> ---
>  .../kernel/syscalls/clock_gettime/clock_gettime04.c      | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> index 2f484c43f..5c4a5d751 100644
> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> @@ -92,6 +92,7 @@ static void run(unsigned int i)
>  	struct test_variants *tv;
>  	int count = 10000, ret;
>  	unsigned int j;
> +	int virt_env = tst_is_virt(VIRT_ANY);
>  
>  	do {
>  		for (j = 0; j < ARRAY_SIZE(variants); j++) {
> @@ -143,11 +144,17 @@ static void run(unsigned int i)
>  
>  			diff /= 1000000;
>  
> -			if (diff >= 5) {
> +			if (!virt_env && diff >= 5) {
>  				tst_res(TFAIL, "%s: Difference between successive readings greater than 5 ms (%d): %lld",
>  					tst_clock_name(clks[i]), j, diff);
>  				return;
>  			}
> +
> +			if (virt_env && diff >= 50) {
> +				tst_res(TFAIL, "%s: Difference between successive readings(in VM) greater than 50 ms (%d): %lld",
> +					tst_clock_name(clks[i]), j, diff);
> +				return;
> +			}
>  		}
>  	} while (--count);
>  
> -- 
> 2.21.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
