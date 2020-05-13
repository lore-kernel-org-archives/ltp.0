From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2020 13:33:18 +0200
Subject: [LTP] [PATCH] syscalls: Fix issues around calling syscalls with
 old timespec
In-Reply-To: <437d6fd3926de4c801ae0edb2379c6afafcb34d4.1589190284.git.viresh.kumar@linaro.org>
References: <437d6fd3926de4c801ae0edb2379c6afafcb34d4.1589190284.git.viresh.kumar@linaro.org>
Message-ID: <20200513113318.GA25472@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

checking for __kernel_timespec, which defined in include/tst_timer.h should fix
it, but we might need some more elegant solution (have that depende

diff --git testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
index 42e4c699c..c246f84bb 100644
--- testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
+++ testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
@@ -17,7 +17,7 @@
 #include <asm/posix_types.h>
 #include "lapi/timex.h"
 
-#ifndef __kernel_timex
+#ifndef __kernel_timespec
 #if defined(__x86_64__) && defined(__ILP32__)
 typedef long long __kernel_long_t;
 #else

> +++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
> @@ -14,9 +14,54 @@
>  #include <pwd.h>
>  #include <sys/timex.h>
>  #include <sys/types.h>
> +#include <asm/posix_types.h>
>  #include "lapi/timex.h"

Thanks! On a first look LGTM.
Unfortunately, there is failure on Centos 6 (gcc 4):

https://travis-ci.org/github/pevik/ltp/jobs/686519604

/usr/src/ltp/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h:24: error: redefinition of typedef '__kernel_long_t'
/usr/src/ltp/include/tst_timer.h:99: note: previous declaration of '__kernel_long_t' was here
/usr/src/ltp/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h:27: error: redefinition of typedef '__kernel_old_time_t'
/usr/src/ltp/include/tst_timer.h:102: note: previous declaration of '__kernel_old_time_t' was here
make[4]: *** [clock_adjtime01] Error 1
make[4]: *** Waiting for unfinished jobs....
In file included from /usr/src/ltp/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c:58:
/usr/src/ltp/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h: At top level:
/usr/src/ltp/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h:24: error: redefinition of typedef '__kernel_long_t'
/usr/src/ltp/include/tst_timer.h:99: note: previous declaration of '__kernel_long_t' was here
/usr/src/ltp/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h:27: error: redefinition of typedef '__kernel_old_time_t'
/usr/src/ltp/include/tst_timer.h:102: note: previous declaration of '__kernel_old_time_t' was here
make[4]: *** [clock_adjtime02] Error 1
make[4]: Leaving directory `/usr/src/ltp-build/testcases/kernel/syscalls/clock_adjtime'

>  #ifndef __kernel_timex
> +#if defined(__x86_64__) && defined(__ILP32__)
> +typedef long long __kernel_long_t;
> +#else
> +typedef long __kernel_long_t;
> +#endif
> +
> +typedef __kernel_long_t	__kernel_old_time_t;

It's caused by this fallback definition ^, which is already in
include/tst_timer.h. Simple deleting it should fix the problem

Kind regards,
Petr

diff --git testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
index 42e4c699c..9849d83e3 100644
--- testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
+++ testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
@@ -18,13 +18,6 @@
 #include "lapi/timex.h"
 
 #ifndef __kernel_timex
-#if defined(__x86_64__) && defined(__ILP32__)
-typedef long long __kernel_long_t;
-#else
-typedef long __kernel_long_t;
-#endif
-
-typedef __kernel_long_t	__kernel_old_time_t;
 
 struct __kernel_old_timeval {
 	__kernel_old_time_t	tv_sec;		/* seconds */
