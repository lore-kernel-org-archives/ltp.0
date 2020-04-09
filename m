From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 11:12:22 +0800
Subject: [LTP] [PATCH v2 1/2] Add SAFE_PIPE2.
In-Reply-To: <20200408211700.7958-2-laniel_francis@privacyrequired.com>
References: <208a947b-a64a-0962-b3de-0756f1cc1c92@cn.fujitsu.com>
 <20200408211700.7958-2-laniel_francis@privacyrequired.com>
Message-ID: <0a337c22-c05d-3f9a-d918-6d96762ce0db@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Laniel

Usually, we should add safe macro for new and old api.
We have old/safe_macros.h.

But ltp only has three places to use pipe2(pipe2_01,02,03), and
pipe2_01,02 use ltp_syscall to call pipe2, so I think it is ok.

only a small nit:
move safe_pipe2() declaration to tst_safe_macros.h. We don't need to add 
it into safe_macros_fn.h. ie commit f59fa0de ("Add SAFE_PTRACE() to LTP 
library").

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Best Regards
Yang Xu
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> This macro is the equivalent of SAFE_PIPE for pipe2 system call.
> ---
>   include/safe_macros_fn.h  |  3 +++
>   include/tst_safe_macros.h |  3 +++
>   lib/safe_macros.c         | 15 +++++++++++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
> index 3df952811..ec2d34ae3 100644
> --- a/include/safe_macros_fn.h
> +++ b/include/safe_macros_fn.h
> @@ -67,6 +67,9 @@ int safe_open(const char *file, const int lineno,
>   int safe_pipe(const char *file, const int lineno,
>                 void (*cleanup_fn)(void), int fildes[2]);
>   
> +int safe_pipe2(const char *file, const int lineno, void (*cleanup_fn) (void),
> +               int fildes[2], int flags);
> +
>   ssize_t safe_read(const char *file, const int lineno,
>                     void (*cleanup_fn)(void), char len_strict, int fildes,
>                     void *buf, size_t nbyte);
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index d95d26219..1738d3cc6 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -87,6 +87,9 @@ static inline int safe_dup(const char *file, const int lineno,
>   #define SAFE_PIPE(fildes) \
>   	safe_pipe(__FILE__, __LINE__, NULL, (fildes))
>   
> +#define SAFE_PIPE2(fildes, flags) \
> +	safe_pipe2(__FILE__, __LINE__, NULL, (fildes), (flags))
> +
>   #define SAFE_READ(len_strict, fildes, buf, nbyte) \
>   	safe_read(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
>   
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index dde9b7b5e..780245821 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -248,6 +248,21 @@ int safe_pipe(const char *file, const int lineno, void (*cleanup_fn) (void),
>   	return rval;
>   }
>   
> +int safe_pipe2(const char *file, const int lineno, void (*cleanup_fn) (void),
> +               int fildes[2], int flags)
> +{
> +	int rval;
> +
> +	rval = pipe2(fildes, flags);
> +	if (rval == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: pipe2({%d,%d}) failed",
> +			 file, lineno, fildes[0], fildes[1]);
> +	}
> +
> +	return rval;
> +}
> +
>   ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
>                     char len_strict, int fildes, void *buf, size_t nbyte)
>   {
> 


