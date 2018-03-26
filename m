From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Mar 2018 15:22:42 +0200
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Add SAFE_GETGRNAM()
In-Reply-To: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180326132242.GA20143@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---
>  include/old/safe_macros.h |  3 +++
>  include/safe_macros_fn.h  |  3 +++
>  include/tst_safe_macros.h |  9 +++------
>  lib/safe_macros.c         | 15 +++++++++++++++
>  4 files changed, 24 insertions(+), 6 deletions(-)

> diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
> index e778d30..0718060 100644
> --- a/include/old/safe_macros.h
> +++ b/include/old/safe_macros.h
> @@ -44,6 +44,9 @@
>  #define SAFE_GETPWNAM(cleanup_fn, name)	\
>  	safe_getpwnam(__FILE__, __LINE__, cleanup_fn, (name))

> +#define SAFE_GETGRNAM(cleanup_fn, name) \
> +	safe_getgrnam(__FILE__, __LINE__, cleanup_fn, (name))
Can you please sort it alphabetically (i.e. put SAFE_GETGRNAM() before SAFE_GETPWNAM())?

@Cyril: Do we want to change also safe_macros.h ?

> +
>  #define SAFE_GETRUSAGE(cleanup_fn, who, usage) \
>  	safe_getrusage(__FILE__, __LINE__, (cleanup_fn), (who), (usage))

> diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
> index 3df9528..2d3ddae 100644
> --- a/include/safe_macros_fn.h
> +++ b/include/safe_macros_fn.h
> @@ -45,6 +45,9 @@ char* safe_getcwd(const char *file, const int lineno,
>  struct passwd* safe_getpwnam(const char *file, const int lineno,
>                               void (*cleanup_fn)(void), const char *name);

> +struct group *safe_getgrnam(const char *file, const int lineno,
> +			    void (*cleanup_fn)(void), const char *name);
Again, sort it alphabetically please.

> +
>  int safe_getrusage(const char *file, const int lineno,
>                     void (*cleanup_fn)(void), int who, struct rusage *usage);

> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index f115a7b..56ff4c3 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -72,6 +72,9 @@ static inline int safe_dup(const char *file, const int lineno,
>  #define SAFE_GETPWNAM(name) \
>  	safe_getpwnam(__FILE__, __LINE__, NULL, (name))

> +#define SAFE_GETGRNAM(name) \
> +	safe_getgrnam(__FILE__, __LINE__, NULL, (name))
And here.

> +
>  #define SAFE_GETRUSAGE(who, usage) \
>  	safe_getrusage(__FILE__, __LINE__, NULL, (who), (usage))

> @@ -397,12 +400,6 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
>  #define SAFE_SIGNAL(signum, handler) \
>  	safe_signal(__FILE__, __LINE__, (signum), (handler))

> -int safe_sigaction(const char *file, const int lineno,
> -                   int signum, const struct sigaction *act,
> -                   struct sigaction *oldact);
> -#define SAFE_SIGACTION(signum, act, oldact) \
> -	safe_sigaction(__FILE__, __LINE__, (signum), (act), (oldact))
> -
Removing SAFE_SIGACTION() & safe_sigaction() breaks build. I guess you removed it by
accident.

>  #define SAFE_EXECLP(file, arg, ...) do {                   \
>  	execlp((file), (arg), ##__VA_ARGS__);              \
>  	tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,       \
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index abdeca0..061819e 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -15,6 +15,7 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <malloc.h>
> +#include <grp.h>
>  #include "test.h"
>  #include "safe_macros.h"

> @@ -126,6 +127,20 @@ struct passwd *safe_getpwnam(const char *file, const int lineno,
>  	return rval;
>  }

> +struct group *safe_getgrnam(const char *file, const int lineno,
> +			    void (*cleanup_fn) (void), const char *name)
Again, sort it alphabetically please.

> +{
> +	struct group *rval;
> +
> +	rval = getgrnam(name);
> +	if (rval == NULL) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			"%s:%d: getgrnam(%s) failed", file, lineno, name);
> +	}
> +
> +	return rval;
> +}
> +
>  int
>  safe_getrusage(const char *file, const int lineno, void (*cleanup_fn) (void),
>  	       int who, struct rusage *usage)


Kind regards,
Petr
