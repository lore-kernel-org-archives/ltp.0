From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Jun 2019 17:16:49 +0200
Subject: [LTP] [PATCH] Fix use of results after being unmapped
In-Reply-To: <1559834477-21724-1-git-send-email-ysionneau@kalray.eu>
References: <1559834477-21724-1-git-send-email-ysionneau@kalray.eu>
Message-ID: <20190612151649.GB3048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
You are missing Signed-off-by: line here, see:

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

> ---
>  lib/tst_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 95f389d..73eca58 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -138,6 +138,7 @@ static void cleanup_ipc(void)
>  	if (results) {
>  		msync((void*)results, size, MS_SYNC);
>  		munmap((void*)results, size);
> +		results = NULL;
>  	}
>  }
>  
> @@ -921,10 +922,11 @@ static void do_cleanup(void)
>  	if (tst_test->save_restore)
>  		tst_sys_conf_restore(0);
>  
> -	cleanup_ipc();
> -
>  	if (tst_test->restore_wallclock)
>  		tst_wallclock_restore();
> +
> +	cleanup_ipc();
> +	/* Do not use 'results' after cleanup_ipc(): it has been unmapped. */

Actually we can remove this comment since after setting results to NULL
we will not crash anymore.

-- 
Cyril Hrubis
chrubis@suse.cz
