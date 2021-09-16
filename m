From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 16 Sep 2021 11:20:33 +0100
Subject: [LTP] [PATCH 1/2] lib: tst_kconfig: Fix typo Constrain ->
 Constraint
In-Reply-To: <20210915143725.13170-2-chrubis@suse.cz>
References: <20210915143725.13170-1-chrubis@suse.cz>
 <20210915143725.13170-2-chrubis@suse.cz>
Message-ID: <87tuiklt3i.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Cyril Hrubis <chrubis@suse.cz> writes:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/tst_kconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index c2b85821b..c9de3017b 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -497,7 +497,7 @@ void tst_kconfig_check(const char *const kconfigs[])
>  
>  		if (val != 1) {
>  			abort_test = 1;
> -			tst_res(TINFO, "Constrain '%s' not satisfied!", kconfigs[i]);
> +			tst_res(TINFO, "Constraint '%s' not satisfied!", kconfigs[i]);
>  			dump_vars(exprs[i]);
>  		}
>  
> -- 
> 2.32.0


-- 
Thank you,
Richard.
