From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 20 Nov 2019 14:54:11 +0800
Subject: [LTP] [PATCH v6 1/2] lib/tst_timer_test: move test setup
 function before PR_GET_TIMERSLACK
In-Reply-To: <1574044495-2813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191115163517.GB25964@rei.lan>
 <1574044495-2813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <71e855bf-62c8-5ee1-e8d2-6753459571f7@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

 ?I think this patch can be merged if it is ok.

Thanks
Yang Xu

> Move test setup function before PR_GET_TIMERSLACK in timer setup function so
> that the library includes the newly set timerslack in the calculation.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   lib/tst_timer_test.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
> index f6459e5c0..13e9deff2 100644
> --- a/lib/tst_timer_test.c
> +++ b/lib/tst_timer_test.c
> @@ -340,6 +340,9 @@ static void timer_setup(void)
>   	struct timespec t;
>   	int ret;
>   
> +	if (setup)
> +		setup();
> +
>   	tst_clock_getres(CLOCK_MONOTONIC, &t);
>   
>   	tst_res(TINFO, "CLOCK_MONOTONIC resolution %lins", (long)t.tv_nsec);
> @@ -360,16 +363,11 @@ static void timer_setup(void)
>   	tst_res(TINFO, "PR_GET_TIMERSLACK not defined, using %uus",
>   		timerslack);
>   #endif /* PR_GET_TIMERSLACK */
> -
>   	parse_timer_opts();
>   
>   	samples = SAFE_MALLOC(sizeof(long long) * MAX(MAX_SAMPLES, sample_cnt));
> -
>   	if (set_latency() < 0)
>   		tst_res(TINFO, "Failed to set zero latency constraint: %m");
> -
> -	if (setup)
> -		setup();
>   }
>   
>   static void timer_cleanup(void)


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191120/b98d0025/attachment.htm>
