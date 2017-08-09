From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Aug 2017 15:29:07 +0200
Subject: [LTP] [PATCH v4 1/3] lib: Add personality fallback and SAFE
	macro
In-Reply-To: <20170808144717.27590-1-rpalethorpe@suse.com>
References: <20170808144717.27590-1-rpalethorpe@suse.com>
Message-ID: <20170809132907.GG32573@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef PERSONALITY_H
> +#define PERSONALITY_H
> +
> +#include <sys/personality.h>
> +
> +#if !(HAVE_DECL_UNAME26 == 1 || defined(UNAME26))
             ^
	 Where is this macro from, I cannot see it anywhere.

Have you forgotten git add on configure.ac or something?

And I doubt that we need anything else than:

#ifndef UNAME26
# define UNAME26 0x0020000
#endif

here...

> +#define UNAME26 0x0020000
> +#endif
> +
> +#endif	/* PERSONALITY_H */
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 8245b68a3..a132d3f86 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -438,4 +438,9 @@ int safe_mknod(const char *file, const int lineno, const char *pathname,
>  #define SAFE_MKNOD(pathname, mode, dev) \
>  	safe_mknod(__FILE__, __LINE__, (pathname), (mode), (dev))
>  
> +int safe_personality(const char *filename, unsigned int lineno,
> +		    unsigned long persona);
> +#define SAFE_PERSONALITY(persona) safe_personality(__FILE__, __LINE__, persona)
> +
> +
>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index e7f5095e5..c928b8357 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -20,6 +20,7 @@
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_safe_macros.h"
> +#include "lapi/personality.h"
                  ^
Do we need this header there for something?

>  int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid)
>  {
> @@ -47,3 +48,16 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid)
>  
>  	return pgid;
>  }
> +
> +int safe_personality(const char *filename, unsigned int lineno,
> +		    unsigned long persona)
> +{
> +	int prev_persona = personality(persona);
> +
> +	if (prev_persona < 0) {
> +		tst_brk_(filename, lineno, TBROK | TERRNO,
> +			 "persona(%ld) failed", persona);
> +	}
> +
> +	return prev_persona;
> +}
> -- 
> 2.13.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
