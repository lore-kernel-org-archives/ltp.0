From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jun 2018 12:08:11 +0200
Subject: [LTP] [PATCH 2/3] lib: Introduce TESTPTR()
In-Reply-To: <20180620075917.21056-2-pvorel@suse.cz>
References: <20180620075917.21056-1-pvorel@suse.cz>
 <20180620075917.21056-2-pvorel@suse.cz>
Message-ID: <20180620100811.GC21435@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +extern void *TEST_RETURN_PTR;
> +
> +#define TESTPTR(SCALL) \
> +	do { \
> +		errno = 0; \
> +		TEST_RETURN_PTR = (void*)(TEST_RETURN = (intptr_t)SCALL); \

I guess that this expression is safe enough, since TEST_RETURN is long,
so the assigment will not overflow, but that also begs a question why do
we assign it in the first place?

> +		TEST_ERRNO = errno; \
> +	} while (0)
> +
>  /*
>   * Functions to convert ERRNO to its name and SIGNAL to its name.
>   */
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 8ff7ee425..84becbef4 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -55,6 +55,7 @@
>  
>  long TEST_RETURN;
>  int TEST_ERRNO;
> +void *TEST_RETURN_PTR;

Can we please name it a bit better so that we avoid renaming it later
on? What about TST_RET_PTR so that it's consistent with the planned
rename of TEST_RETURN to just TST_RET?

>  #define VERBOSE      1
>  #define NOPASS       3
> -- 
> 2.17.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
