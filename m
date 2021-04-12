From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Apr 2021 17:10:11 +0200
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
In-Reply-To: <20210323135604.24504-1-zhaogongyi@huawei.com>
References: <20210323135604.24504-1-zhaogongyi@huawei.com>
Message-ID: <YHRi0457Zo5s7sUx@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When main process has been killed, its son process will be reaped by
> init, and son process will send SIGUSR1 to the init process.
> 
> In busybox, send SIGUSR1 to the init process will trigger shutdown.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  lib/tst_test.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 45753d1ca..91dfc6bf9 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1156,7 +1156,15 @@ static void heartbeat(void)
>  	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
>  		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> 
> -	kill(getppid(), SIGUSR1);
> +	if (getppid() == 1) {
> +		tst_res(TFAIL, "Main test process might have exit!");
                         ^
			 This should be TBROK I guess.
> +		/*
> +		 * We need kill the task group immediately since the
> +		 * main process has exit.
> +		 */
> +		kill(0, SIGKILL);

Shouldn't we call exit here? There is no point in continuing once we
reached this point.

> +	} else
> +		kill(getppid(), SIGUSR1);
>  }
> 
>  static void testrun(void)
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
