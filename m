From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 17:30:50 +0200
Subject: [LTP] [PATCH V3 17/23] initialize recursive mutex in a portable
 way
In-Reply-To: <20160722042656.22346-17-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-17-raj.khem@gmail.com>
Message-ID: <20160727153050.GF11986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> index ea26d4f..eff0eee 100644
> --- a/include/mk/testcases.mk
> +++ b/include/mk/testcases.mk
> @@ -49,7 +49,7 @@ CPPFLAGS	+= -I$(abs_top_builddir)/$(TKI_DIR)
>  
>  INSTALL_DIR	:= testcases/bin
>  
> -LDLIBS		+= -lltp
> +LDLIBS		+= -lltp -lpthread
>  
>  $(APICMDS_DIR) $(LIBLTP_DIR) $(abs_top_builddir)/$(TKI_DIR): %:
>  	mkdir -p "$@"
> diff --git a/lib/ltp.pc.in b/lib/ltp.pc.in
> index 9620129..63cd5f4 100644
> --- a/lib/ltp.pc.in
> +++ b/lib/ltp.pc.in
> @@ -6,5 +6,5 @@ libdir=@libdir@
>  Name: LTP
>  Description: Linux Test Project
>  Version: @VERSION@
> -Libs: -L${libdir} -lltp
> +Libs: -L${libdir} -lltp -lpthread
>  Cflags: -I${includedir}
> diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
> index 0e4eeb8..9dd69fd 100644
> --- a/lib/newlib_tests/Makefile
> +++ b/lib/newlib_tests/Makefile
> @@ -3,7 +3,7 @@ top_srcdir		?= ../..
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
>  CFLAGS			+= -W -Wall
> -LDLIBS			+= -lltp
> +LDLIBS			+= -lltp -lpthread
>  
>  test08: CFLAGS+=-pthread
>  test09: CFLAGS+=-pthread
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index 73a0f16..bc4476d 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -3,7 +3,7 @@ top_srcdir		?= ../..
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
>  CFLAGS			+= -W
> -LDLIBS			+= -lltp
> +LDLIBS			+= -lltp -lpthread
>  
>  tst_cleanup_once: CFLAGS += -pthread

This causes everything to be linked with pthreads which is enough for my
NACK for this patch.

> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index b388d0d..ab995f8 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -79,7 +79,8 @@ int TEST_ERRNO;
>  	assert(strlen(buf) > 0);		\
>  } while (0)
>  
> -static pthread_mutex_t tmutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
> +static pthread_once_t tmutex_once = PTHREAD_ONCE_INIT;
> +static pthread_mutex_t tmutex;
>  
>  static void check_env(void);
>  static void tst_condense(int tnum, int ttype, const char *tmesg);
> @@ -142,9 +143,20 @@ const char *strttype(int ttype)
>  #include "errnos.h"
>  #include "signame.h"
>  
> +static void init_tmutex(void)
> +{
> +	pthread_mutexattr_t attr;
> +
> +	pthread_mutexattr_init(&attr);
> +	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
> +	pthread_mutex_init(&tmutex, &attr);
> +	pthread_mutexattr_destroy(&attr);
> +}
> +
>  static void tst_res__(const char *file, const int lineno, int ttype,
>                        const char *arg_fmt, ...)
>  {
> +	pthread_once(&tmutex_once, init_tmutex);
>  	pthread_mutex_lock(&tmutex);
>  
>  	char tmesg[USERMESG];
> @@ -233,6 +245,7 @@ void tst_flush(void)
>  {
>  	NO_NEWLIB_ASSERT("Unknown", 0);
>  
> +	pthread_once(&tmutex_once, init_tmutex);
>  	pthread_mutex_lock(&tmutex);
>  
>  	/*
> @@ -369,6 +382,7 @@ void tst_exit(void)
>  {
>  	NO_NEWLIB_ASSERT("Unknown", 0);
>  
> +	pthread_once(&tmutex_once, init_tmutex);
>  	pthread_mutex_lock(&tmutex);
>  
>  	tst_flush();
> @@ -441,6 +455,7 @@ static int tst_brk_entered = 0;
>  static void tst_brk__(const char *file, const int lineno, int ttype,
>                        void (*func)(void), const char *arg_fmt, ...)
>  {
> +	pthread_once(&tmutex_once, init_tmutex);
>  	pthread_mutex_lock(&tmutex);
>  
>  	char tmesg[USERMESG];
> @@ -505,6 +520,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
>  {
>  	NO_NEWLIB_ASSERT(file, lineno);
>  
> +	pthread_once(&tmutex_once, init_tmutex);
>  	pthread_mutex_lock(&tmutex);
>  

I do not like this.

I guess the easiest solution would be to eliminate the need for the
mutex to be recursive.

Which may be possible if we turn the T_exitval into counters and use
atomic operations to increment them which should us free from guarding
T_exitval updates called from tst_print() which are called from all over
the place. Or we can get rid of T_mode keeping only the default VERBOSE
behavior, which should have the same efect...

-- 
Cyril Hrubis
chrubis@suse.cz
