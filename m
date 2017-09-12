From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Sep 2017 14:40:09 +0200
Subject: [LTP] [PATCH v3 1/7] tst_atomic: Add load,
 store and use __atomic builtins
In-Reply-To: <20170901130121.22821-1-rpalethorpe@suse.com>
References: <20170901130121.22821-1-rpalethorpe@suse.com>
Message-ID: <20170912124009.GA29720@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static inline int tst_atomic_load(int *v)
> +{
> +	int ret;
> +
> +	asm volatile("" : : : "memory");
> +	ret = *v;
> +	asm volatile("" : : : "memory");
> +
> +	return ret;
> +}
> +
> +static inline void tst_atomic_store(int i, int *v)
> +{
> +	asm volatile("" : : : "memory");
> +	*v = i;
> +	asm volatile("" : : : "memory");
> +}

These two functions are defined several times here, maybe we should just
define something as NEEDS_GENERIC_ASM_LOAD_STORE and do

#ifdef NEEDS_GENERIC_ASM_LOAD_STORE
...
#endif

Where these are defined at the end of the file.

>  #elif defined(__powerpc__) || defined(__powerpc64__)
>  static inline int tst_atomic_add_return(int i, int *v)
>  {
> @@ -83,7 +154,26 @@ static inline int tst_atomic_add_return(int i, int *v)
>  	return t;
>  }
>  
> +static inline int tst_atomic_load(int *v)
> +{
> +	int ret;
> +
> +	asm volatile("sync\n" : : : "memory");
> +	ret = *v;
> +	asm volatile("sync\n" : : : "memory");
> +
> +	return ret;
> +}
> +
> +static inline void tst_atomic_store(int i, int *v)
> +{
> +	asm volatile("sync\n" : : : "memory");
> +	*v = i;
> +	asm volatile("sync\n" : : : "memory");
> +}
> +
>  #elif defined(__s390__) || defined(__s390x__)
> +
>  static inline int tst_atomic_add_return(int i, int *v)
>  {
>  	int old_val, new_val;
> @@ -102,11 +192,29 @@ static inline int tst_atomic_add_return(int i, int *v)
>  	return old_val + i;
>  }
>  
> +static inline int tst_atomic_load(int *v)
> +{
> +	int ret;
> +
> +	asm volatile("" : : : "memory");
> +	ret = *v;
> +	asm volatile("" : : : "memory");
> +
> +	return ret;
> +}
> +
> +static inline void tst_atomic_store(int i, int *v)
> +{
> +	asm volatile("" : : : "memory");
> +	*v = i;
> +	asm volatile("" : : : "memory");
> +}
> +
>  #elif defined(__arc__)
>  
>  /*ARCv2 defines the smp barriers */
>  #ifdef __ARC700__
> -#define smp_mb()
> +#define smp_mb()	asm volatile("" : : : "memory")
>  #else
>  #define smp_mb()	asm volatile("dmb 3\n" : : : "memory")
>  #endif
> @@ -132,6 +240,24 @@ static inline int tst_atomic_add_return(int i, int *v)
>  	return val;
>  }
>  
> +static inline int tst_atomic_load(int *v)
> +{
> +	int ret;
> +
> +	smp_mb();
> +	ret = *v;
> +	smp_mb();
> +
> +	return ret;
> +}
> +
> +static inline void tst_atomic_store(int i, int *v)
> +{
> +	smp_mb();
> +	*v = i;
> +	smp_mb();
> +}
> +
>  #elif defined (__aarch64__)
>  static inline int tst_atomic_add_return(int i, int *v)
>  {
> @@ -140,7 +266,7 @@ static inline int tst_atomic_add_return(int i, int *v)
>  
>  	__asm__ __volatile__(
>  "       prfm    pstl1strm, %2	\n"
> -"1:     ldxr 	%w0, %2		\n"
> +"1:     ldaxr	%w0, %2		\n"
>  "       add	%w0, %w0, %w3	\n"
>  "       stlxr	%w1, %w0, %2	\n"
>  "       cbnz	%w1, 1b		\n"
> @@ -152,9 +278,90 @@ static inline int tst_atomic_add_return(int i, int *v)
>  	return result;
>  }
>  
> +/* We are using load and store exclusive (ldaxr & stlxr) instructions to try
> + * and help prevent the tst_atomic_load and, more likely, tst_atomic_store
> + * functions from interfering with tst_atomic_add_return which takes advantage
> + * of exclusivity. It is not clear if this is a good idea or not, but does
> + * mean that all three functions are very similar.
> + */
> +static inline int tst_atomic_load(int *v)
> +{
> +	int ret;
> +	unsigned long tmp;
> +
> +	asm volatile("//atomic_load			\n"
> +		"	prfm	pstl1strm,  %[v]	\n"
> +		"1:	ldaxr	%w[ret], %[v]		\n"
> +		"	stlxr   %w[tmp], %w[ret], %[v]  \n"
> +		"	cbnz    %w[tmp], 1b		\n"
> +		"	dmb ish				\n"
> +		: [tmp] "=&r" (tmp), [ret] "=&r" (ret), [v] "+Q" (*v)
> +		: : "memory");
> +
> +	return ret;
> +}
> +
> +static inline void tst_atomic_store(int i, int *v)
> +{
> +	unsigned long tmp;
> +
> +	asm volatile("//atomic_store			\n"
> +		"	prfm	pstl1strm, %[v]		\n"
> +		"1:	ldaxr	%w[tmp], %[v]		\n"
> +		"	stlxr   %w[tmp], %w[i], %[v]	\n"
> +		"	cbnz    %w[tmp], 1b		\n"
> +		"	dmb ish				\n"
> +		: [tmp] "=&r" (tmp), [v] "+Q" (*v)
> +		: [i] "r" (i)
> +		: "memory");
> +}
> +
> +#elif defined(__sparc__) && defined(__arch64__)
> +static inline int tst_atomic_add_return(int i, int *v)
> +{
> +	int ret, tmp;
> +
> +	/* Based on arch/sparc/lib/atomic_64.S with the exponential backoff
> +	 * function removed because we are unlikely to have a large (>= 16?)
> +	 * number of cores continuously trying to update one variable.
> +	 */
> +	asm volatile("/*atomic_add_return*/		\n"
> +		"1:	ldsw	[%[v]], %[ret];		\n"
> +		"	add	%[ret], %[i], %[tmp];	\n"
> +		"	cas	[%[v]], %[ret], %[tmp];	\n"
> +		"	cmp	%[ret], %[tmp];		\n"
> +		"	bne,pn	%%icc, 1b;		\n"
> +		"	nop;				\n"
> +		"	add	%[ret], %[i], %[ret];	\n"
> +		: [ret] "=r&" (ret), [tmp] "=r&" (tmp)
> +		: [i] "r" (i), [v] "r" (v)
> +		: "memory", "cc");
> +
> +	return ret;
> +}
> +
> +static inline int tst_atomic_load(int *v)
> +{
> +	int ret;
> +
> +	/* See arch/sparc/include/asm/barrier_64.h */
> +	asm volatile("" : : : "memory");
> +	ret = *v;
> +	asm volatile("" : : : "memory");
> +
> +	return ret;
> +}
> +
> +static inline void tst_atomic_store(int i, int *v)
> +{
> +	asm volatile("" : : : "memory");
> +	*v = i;
> +	asm volatile("" : : : "memory");
> +}
> +
>  #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
> -# error Your compiler does not provide __sync_add_and_fetch and LTP\
> -	implementation is missing for your architecture.
> +# error Your compiler does not provide __atomic_add_fetch, __sync_add_and_fetch \
> +        and an LTP implementation is missing for your architecture.
>  #endif
>  
>  static inline int tst_atomic_inc(int *v)
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index 229217495..f97137c35 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -32,6 +32,7 @@
>  
>  #include <sys/time.h>
>  #include <time.h>
> +#include "tst_atomic.h"

Hmm, isn't this added out-of-order here?

>  #ifndef CLOCK_MONOTONIC_RAW
>  # define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
> diff --git a/m4/ltp-atomic.m4 b/m4/ltp-atomic.m4
> new file mode 100644
> index 000000000..836f0a4fd
> --- /dev/null
> +++ b/m4/ltp-atomic.m4
> @@ -0,0 +1,34 @@
> +dnl
> +dnl Copyright (c) Linux Test Project, 2016
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +
> +AC_DEFUN([LTP_CHECK_ATOMIC_MEMORY_MODEL],[dnl
> +	AC_MSG_CHECKING([for __atomic_* compiler builtins])
> +	AC_LINK_IFELSE([AC_LANG_SOURCE([
> +int main(void) {
> +	int i = 0, j = 0;
> +	__atomic_add_fetch(&i, 1, __ATOMIC_ACQ_REL);
> +	__atomic_load_n(&i, __ATOMIC_SEQ_CST);
> +	__atomic_compare_exchange_n(&i, &j, 0, 0, __ATOMIC_RELEASE, __ATOMIC_ACQUIRE);

We can drop the exchange function here now.

> +	__atomic_store_n(&i, 0, __ATOMIC_RELAXED);
> +	return i;
> +}])],[has_atomic_mm="yes"])
> +
> +if test "x$has_atomic_mm" = xyes; then
> +	AC_DEFINE(HAVE_ATOMIC_MEMORY_MODEL,1,
> +	          [Define to 1 if you have the __atomic_* compiler builtins])
> +	AC_MSG_RESULT(yes)
> +else
> +	AC_MSG_RESULT(no)
> +fi
> +])
> -- 
> 2.14.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
