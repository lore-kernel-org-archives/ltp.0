From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 15:58:28 +0100
Subject: [LTP] [PATCH 2/3] tst_test: add macro helper to invoke
 pthread_once()
In-Reply-To: <1482154595-4641-2-git-send-email-alexey.kodanev@oracle.com>
References: <1482154595-4641-1-git-send-email-alexey.kodanev@oracle.com>
 <1482154595-4641-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170123145828.GD25788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  include/tst_test.h |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 3c77a98..a4ba167 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -71,6 +71,20 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
>  	({int ret = expr;                                           \
>  	  ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret; }) \
>  
> +/*
> + * Macro to use for making functions called only once in
> + * multi-threaded tests such as init or cleanup function.
> + * The first call to @name_fn function by any thread shall
> + * call the @exec_fn. Subsequent calls shall not call @exec_fn.
> + * *_fn functions must not take any arguments.
> + */
> +#define TST_DECLARE_ONCE_FN(name_fn, exec_fn)				\
> +	void name_fn(void)						\
> +	{								\
> +		static pthread_once_t ltp_once = PTHREAD_ONCE_INIT;	\
> +		pthread_once(&ltp_once, exec_fn);			\
> +	}

This should rather be in tst_safe_pthread.h, otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
