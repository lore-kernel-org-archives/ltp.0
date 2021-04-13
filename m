From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Apr 2021 11:37:06 +0200
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B47B3@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B47B3@dggeml531-mbx.china.huawei.com>
Message-ID: <YHVmQvK6TnFod/tu@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> According to your review, is there any problems in the patch as follows:
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 45753d1ca..0a096d666 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1156,7 +1156,16 @@ static void heartbeat(void)
>         if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
>                 tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> 
> -       kill(getppid(), SIGUSR1);
> +       if (getppid() == 1) {
> +               tst_res(TFAIL, "Main test process might have exit!");
> +               /*
> +                * We need kill the task group immediately since the
> +                * main process has exit.
> +                */
> +               kill(0, SIGKILL);
> +               exit(-1);

Not that it matters that much, but I would do exit(TBROK);

> +       } else
> +               kill(getppid(), SIGUSR1);

No need for the else branch here now that we do exit() a the end of the
if () block.

Other than that it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
