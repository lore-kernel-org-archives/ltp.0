From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Aug 2016 13:31:57 +0200
Subject: [LTP] [PATCH] syscalls/mprotect04: Use
 __builtin___clear_cache() to sync caches
In-Reply-To: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
References: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <20160801113157.GD6899@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "config.h"
>  #include <signal.h>
>  #include <setjmp.h>
>  #include <sys/types.h>
> @@ -178,6 +179,16 @@ static int page_present(void *p)
>  	return 0;
>  }
>  
> +static void clear_cache(void *start, int len)
> +{
> +#if HAVE_BUILTIN_CLEAR_CACHE == 1
> +	__builtin___clear_cache(start, start + len);
> +#else
> +	tst_brkm(TCONF, cleanup,
> +		"compiler doesn't have __builtin___clear_cache()");
> +#endif
> +}
> +
>  /*
>   * Copy page where &exec_func resides. Also try to copy subsequent page
>   * in case exec_func is close to page boundary.
> @@ -189,10 +200,7 @@ static void *get_func(void *mem)
>  	uintptr_t func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
>  	void *func_copy_start = mem + func_page_offset;
>  	void *page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
> -#ifdef __powerpc__
>  	void *mem_start = mem;
> -	uintptr_t i;
> -#endif
>  
>  	/* copy 1st page, if it's not present something is wrong */
>  	if (!page_present(page_to_copy)) {
> @@ -210,11 +218,7 @@ static void *get_func(void *mem)
>  	else
>  		memset(mem, 0, page_sz);
>  
> -#ifdef __powerpc__
> -	for (i = 0; i < copy_sz; i += 4)
> -		__asm__ __volatile__("dcbst 0,%0; sync; icbi 0,%0; sync; isync"
> -			:: "r"(mem_start + i));
> -#endif
> +	clear_cache(mem_start, copy_sz);

As far as I can tell this is not needed on x86 machines so maybe we
should do something as:

...

#else
# if !defined(__x86_64__) && !defined(__i386__)
	tst_brkm(TCONF, cleanup,
		"compiler doesn't have __builtin___clear_cache()");
# endif
#endif


So that the test is not disabled on older x86 machines.


Otherwise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
