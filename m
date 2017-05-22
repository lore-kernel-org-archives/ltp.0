From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 May 2017 00:47:07 +0200
Subject: [LTP] tst_atomic_add_return() implementation for sparc
In-Reply-To: <20170510192510.GA29900@rei.suse.de>
References: <20170510162157.rqanvu46hfkvffpa@dell5510>
 <20170510192510.GA29900@rei.suse.de>
Message-ID: <20170522224707.jisupuud7jhexjaz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> And the smp_bm_*() macros are translated just to barrier() in case of sparc in
> arch/sparc/include/asm/barrier_64.h which is defined in
The implementation is for 32 bit sparc (sparc v8), but __smp_mb__*() in asm-generic/barrier.h also define it as barrier().
> include/linux/compiler-gcc.h:

> 	#define barrier() __asm__ __volatile__("": : :"memory")

> Then the atomic_add_return_relaxed() translates to atomic_add_return() which is defined in include/asm-generic/atomic.h and translates to:


>         raw_local_irq_save(flags);                                      \
>         ret = (v->counter = v->counter + i);                            \
>         raw_local_irq_restore(flags);                                   \
>                                                                         \


> So something as:

> 	int ret;
> 	__asm__ __volatile__("": : :"memory");
> 	ret = (counter = counter + 1);
>         __asm__ __volatile__("": : :"memory");
> 	return ret;

> Should work, but I do not have any sparc hardware for testing...

I tried this, but lib/newlib_tests/test09 (tested with 32 bit uClibc on sparc 64) fails
:-(. Do you see any obvious error? I hope the problem isn't 64 bit architecture.

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 35a3b3411..8f4903bf6 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -152,6 +152,17 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return result;
 }
 
+#elif defined(__sparc__) && !defined(__arch64__)
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	/* taken from include/asm-generic/atomic.h */
+	int ret;
+	__asm__ __volatile__("": : :"memory");
+	ret = ((*v) = (*v) + i);
+	__asm__ __volatile__("": : :"memory");
+	return ret;
+}
+
 #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
 # error Your compiler does not provide __sync_add_and_fetch and LTP\
 	implementation is missing for your architecture.
------

Kind regards,
Petr
