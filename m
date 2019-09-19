From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Sep 2019 12:02:05 +0200
Subject: [LTP] [RFC PATCH] tst_taint: TCONF when kernel is alreay tainted
In-Reply-To: <20190918053519.26244-1-liwang@redhat.com>
References: <20190918053519.26244-1-liwang@redhat.com>
Message-ID: <20190919100205.GA26642@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As the tst_taint_init comments described, If the tainted-flags are already set
> by the kernel, there is no reason to continue and TCONF is generated. But in
> the function achieve, it uses TBROK.
> 
>   cmdline="cve-2017-17053"
>   tst_test.c:1096: INFO: Timeout per run is 0h 10m 00s
>   tst_taint.c:88: BROK: Kernel is already tainted: 536871424

There is a reason for generating TBROK, we do not want the test to be
skipped silently in this case. If kernel is tainted something went wrong
anyways and we are looking only for a specific flags.

> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Chang Yin <cyin@redhat.com>
> Cc: Michael Moese <mmoese@suse.de>
> ---
> 
> Notes:
>     Hi Cyril & Michael,
>     
>     I'm not sure if that's a good choice to skip whole test if the kernel already
>     tainted, so maybe we could also perform it but not do a strict tainted-flags
>     check after testing? The reason I think is it probably have chance to find
>     new issue even with a tainted kernel.
>     
>     Any suggestion?
> 
>  lib/tst_taint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> index a5dbf77d2..f7cafb96f 100644
> --- a/lib/tst_taint.c
> +++ b/lib/tst_taint.c
> @@ -85,7 +85,7 @@ void tst_taint_init(unsigned int mask)
>  
>  	taint = tst_taint_read();
>  	if ((taint & mask) != 0)
> -		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
> +		tst_brk(TCONF, "Kernel is already tainted: %u", taint);
>  }
>  
>  
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
