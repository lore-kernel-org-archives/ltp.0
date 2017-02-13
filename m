From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 16:14:15 +0100
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early
In-Reply-To: <1698464367.3738204.1486992602576.JavaMail.zimbra@redhat.com>
References: <20170209144445.22737-1-chrubis@suse.cz>
 <1235532957.2260942.1486655806975.JavaMail.zimbra@redhat.com>
 <20170209161120.GA23109@rei>
 <1865245988.2484651.1486715227566.JavaMail.zimbra@redhat.com>
 <151709822.2486191.1486715702857.JavaMail.zimbra@redhat.com>
 <3c1b0f37-f237-d26a-0d92-c5b37dd5bbc4@redhat.com>
 <20170213080929.GB16567@rei.suse.cz>
 <1698464367.3738204.1486992602576.JavaMail.zimbra@redhat.com>
Message-ID: <20170213151415.GA26504@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This sounds good. The only problem we could hit is some common code
> > outside the lib/ directory used in both newlib and oldlib tests. Which
> > was the original reason I put the redirection directly into the
> > tst_brkm_() code...
> 
> Good point, I guess we'd have to do the same as for ltp/lib, that
> is add -DLTPLIB and deal with warnings.
> 
> ---
> 
> Or we don't make tst_brkm_ so strict, we keep it as it is,
> but we find way to prevent newlib users only direct usage
> of tst_brkm() macro:

Sounds good.

> diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
> index 25001e806c12..96fb0c21876e 100644
> --- a/include/old/safe_macros.h
> +++ b/include/old/safe_macros.h
> @@ -331,10 +331,10 @@ static inline int safe_setrlimit(const char *file, const int lineno,
>  
>  #define SAFE_IOCTL(cleanup_fn, fd, request, ...)             \
>         ({int ret = ioctl(fd, request, __VA_ARGS__);         \
> -         ret < 0 ?                                          \
> -          tst_brkm(TBROK | TERRNO, cleanup_fn,              \
> -                   "ioctl(%i,%s,...) failed", fd, #request) \
> -        : ret;})
> +         if (ret < 0)                                       \
> +             tst_brkm(TBROK | TERRNO, cleanup_fn,           \
> +                   "ioctl(%i,%s,...) failed", fd, #request); \
> +         ret;})
>  
>  #endif /* __SAFE_MACROS_H__ */
>  #endif /* __TEST_H__ */
> diff --git a/include/old/test.h b/include/old/test.h
> index d49256073741..93d0c360dfca 100644
> --- a/include/old/test.h
> +++ b/include/old/test.h
> @@ -34,6 +34,10 @@
>  #ifndef __TEST_H__
>  #define __TEST_H__
>  
> +#ifdef TST_TEST_H__
> +#error newlib already included
> +#endif

I guess that this is worth a separate patch. I would make it more
explicit about what has been included though.

#ifdef TST_TEST_H__
# error tst_test.h already included
#endif

>  #include <stdio.h>
>  #include <signal.h>
>  #include <unistd.h>
> @@ -153,9 +157,19 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
>  void tst_brkm_(const char *file, const int lineno, int ttype,
>         void (*func)(void), const char *arg_fmt, ...)
>         __attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
> -#define tst_brkm(ttype, func, arg_fmt, ...) \
> -       tst_brkm_(__FILE__, __LINE__, (ttype), (func), \
> -                 (arg_fmt), ##__VA_ARGS__)
> +
> +#ifdef LTPLIB
> +#include "ltp_priv.h"
> +# define tst_brkm(flags, cleanup, fmt, ...) do { \
> +               if (tst_test) \
> +                       tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
> +               else \
> +                       tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__); \
> +               } while (0)
> +#else
> +# define tst_brkm(flags, cleanup, fmt, ...) \
> +                       tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt, ##__VA_ARGS__)
> +#endif
>  
>  void tst_require_root(void);
>  void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 7dc371ccf095..463418ab2de2 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -18,6 +18,10 @@
>  #ifndef TST_TEST_H__
>  #define TST_TEST_H__
>  
> +#ifdef __TEST_H__
> +#error oldlib already included
> +#endif

Here as well.

>  #include <unistd.h>
>  
>  #include "tst_common.h"
> diff --git a/lib/Makefile b/lib/Makefile
> index 663455ee31ad..6b3f6e1917fb 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -24,7 +24,7 @@ top_srcdir            ?= ..
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
> -CFLAGS                 += -I.
> +CFLAGS                 += -I. -DLTPLIB
>  
>  ifneq ($(ANDROID),1)
>  FILTER_OUT_DIRS                += android_libpthread android_librt
> 
> 
> > We would also need to sprinkle the library code with returns as a part
> > of the patch if I'm not mistaken.
> 
> Agreed, after removing NORETURN there's no way around that.

Can you please have a look at the loop devices patch first? Second patch
there touches the tst_device.c and I would like to have it included
before we start adding the returns there.

> --
> 
> I keep thinking if we shouldn't do those ~30 trivial changes,
> and have one simple tst_brkm() macro for both library and tests.

I would rather keep the old testcases without such changes. I'm afraid
that removing the noreturn attribute may actually break some messed up
test. But maybe I'm just too paranoid.

-- 
Cyril Hrubis
chrubis@suse.cz
