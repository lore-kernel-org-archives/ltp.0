From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 24 Aug 2017 13:07:58 +0200
Subject: [LTP] [PATCH 1/6] tst_atomic: Add load, store,
	cmpxchg and use __atomic builtins
In-Reply-To: <20170824110803.9994-1-rpalethorpe@suse.com>
References: <20170824110803.9994-1-rpalethorpe@suse.com>
Message-ID: <20170824110803.9994-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add more fallback inline assembly for the existing architectures and add
SPARC64. Use the __atomic_* compiler intrinsics when available and provide the
option to use the C++11 memory model.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 configure.ac             |   1 +
 include/tst_atomic.h     | 381 +++++++++++++++++++++++++++++++++++++++++++----
 include/tst_fuzzy_sync.h |   1 +
 m4/ltp-atomic.m4         |  34 +++++
 4 files changed, 389 insertions(+), 28 deletions(-)
 create mode 100644 m4/ltp-atomic.m4

diff --git a/configure.ac b/configure.ac
index 23e583dd8..e4f26fe88 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,5 +194,6 @@ LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
 LTP_CHECK_X_TABLES
+LTP_CHECK_ATOMIC_MEMORY_MODEL
 
 AC_OUTPUT
diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 35a3b3411..e7ee72853 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -20,12 +20,91 @@
 
 #include "config.h"
 
-#if HAVE_SYNC_ADD_AND_FETCH == 1
+#if HAVE_ATOMIC_MEMORY_MODEL != 1
+#define LTP_RELAXED 0
+#define LTP_CONSUME 1
+#define LTP_ACQUIRE 2
+#define LTP_RELEASE 3
+#define LTP_ACQ_REL 4
+#define LTP_SEQ_CST 5
+#else
+#define LTP_RELAXED __ATOMIC_RELAXED
+#define LTP_CONSUME __ATOMIC_CONSUME
+#define LTP_ACQUIRE __ATOMIC_ACQUIRE
+#define LTP_RELEASE __ATOMIC_RELEASE
+#define LTP_ACQ_REL __ATOMIC_ACQ_REL
+#define LTP_SEQ_CST __ATOMIC_SEQ_CST
+#endif
+
+#if HAVE_ATOMIC_MEMORY_MODEL == 1
+static inline int tst_atomic_add_return_(int i, int *v, int memorder)
+{
+	return __atomic_add_fetch(v, i, memorder);
+}
+
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	return tst_atomic_add_return_(i, v, LTP_SEQ_CST);
+}
+
+static inline int tst_atomic_cmpxchg_(int *current, int *expected, int desired,
+				      int success_memorder, int failure_memorder)
+{
+	return  __atomic_compare_exchange_n(current, expected, desired, 0,
+					    success_memorder, failure_memorder);
+}
+
+static inline int tst_atomic_load_(int *v, int memorder)
+{
+	return __atomic_load_n(v, memorder);
+}
+
+static inline void tst_atomic_store_(int i, int *v, int memorder)
+{
+	__atomic_store_n(v, i, memorder);
+}
+
+#elif HAVE_SYNC_ADD_AND_FETCH == 1
 static inline int tst_atomic_add_return(int i, int *v)
 {
 	return __sync_add_and_fetch(v, i);
 }
 
+static inline int tst_atomic_add_return_(int i, int *v,
+					 int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	return tst_atomic_add_return(i, v);
+}
+
+static inline int tst_atomic_cmpxchg_(int *current, int *expected, int desired,
+				      int success_memorder LTP_ATTRIBUTE_UNUSED,
+				      int failure_memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int v = __sync_val_compare_and_swap(current, *expected, desired);
+
+	if (v != *expected) {
+		*expected = v;
+		return 0;
+	}
+
+	return 1;
+}
+
+static inline int tst_atomic_load_(int *v, int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int ret;
+
+	ret = *v;
+	__sync_synchronize();
+	return ret;
+}
+
+static inline void tst_atomic_store_(int i, int *v, int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	__sync_synchronize();
+	*v = i;
+}
+
 #elif defined(__i386__) || defined(__x86_64__)
 static inline int tst_atomic_add_return(int i, int *v)
 {
@@ -33,36 +112,49 @@ static inline int tst_atomic_add_return(int i, int *v)
 
 	/*
 	 * taken from arch/x86/include/asm/cmpxchg.h
-	 * Since we always pass int sized parameter, we can simplify it
-	 * and cherry-pick only that specific case.
-	 *
-	switch (sizeof(*v)) {
-	case 1:
-		asm volatile ("lock; xaddb %b0, %1\n"
-			: "+q" (__ret), "+m" (*v) : : "memory", "cc");
-		break;
-	case 2:
-		asm volatile ("lock; xaddw %w0, %1\n"
-			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
-		break;
-	case 4:
-		asm volatile ("lock; xaddl %0, %1\n"
-			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
-		break;
-	case 8:
-		asm volatile ("lock; xaddq %q0, %1\n"
-			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
-		break;
-	default:
-		__xadd_wrong_size();
-	}
-	*/
+	 */
 	asm volatile ("lock; xaddl %0, %1\n"
 		: "+r" (__ret), "+m" (*v) : : "memory", "cc");
 
 	return i + __ret;
 }
 
+static inline int tst_atomic_add_return_(int i, int *v,
+					 int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	return tst_atomic_add_return(i, v);
+}
+
+static inline int tst_atomic_cmpxchg_(int *current, int *expected, int desired,
+				      int success_memorder LTP_ATTRIBUTE_UNUSED,
+				      int failure_memorder LTP_ATTRIBUTE_UNUSED)
+{
+	asm volatile("lock; cmpxchgl %2,%1"
+		     : "=a" (*expected), "+m" (*current)
+		     : "r" (desired), "0" (*expected)
+		     : "memory");
+	return *expected == desired;
+}
+
+static inline int tst_atomic_load_(int *v, int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int ret;
+
+	asm volatile("" : : : "memory");
+	ret = *v;
+	asm volatile("" : : : "memory");
+
+	return ret;
+}
+
+static inline void tst_atomic_store_(int i, int *v,
+				     int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	asm volatile("" : : : "memory");
+	*v = i;
+	asm volatile("" : : : "memory");
+}
+
 #elif defined(__powerpc__) || defined(__powerpc64__)
 static inline int tst_atomic_add_return(int i, int *v)
 {
@@ -83,7 +175,54 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return t;
 }
 
+static inline int tst_atomic_add_return_(int i, int *v,
+					 int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	return tst_atomic_add_return(i, v);
+}
+
+static inline int tst_atomic_cmpxchg_(int *current, int *expected, int desired,
+				      int success_memorder LTP_ATTRIBUTE_UNUSED,
+				      int failure_memorder LTP_ATTRIBUTE_UNUSED)
+{
+	/* taken from arch/powerpc/include/asm/cmpxchg.h */
+	asm volatile (
+		"       sync\n"
+		"1:     lwarx	%0,0,%2           # atomic_cmpxchg\n"
+		"       cmpw	0,%0,%3\n"
+		"       bne-	2f\n"
+	        "       stwcx.	%4,0,%2\n"
+		"       bne-	1b\n"
+		"       sync\n"
+		"2:"
+		: "=&r" (*expected), "+m" (*current)
+		: "r" (current), "r" (*expected), "r" (desired)
+		: "cc", "memory");
+
+	return *expected == desired;
+}
+
+static inline int tst_atomic_load_(int *v, int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int ret;
+
+	asm volatile("sync\n" : : : "memory");
+	ret = *v;
+	asm volatile("sync\n" : : : "memory");
+
+	return ret;
+}
+
+static inline void tst_atomic_store_(int i, int *v,
+				     int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	asm volatile("sync\n" : : : "memory");
+	*v = i;
+	asm volatile("sync\n" : : : "memory");
+}
+
 #elif defined(__s390__) || defined(__s390x__)
+
 static inline int tst_atomic_add_return(int i, int *v)
 {
 	int old_val, new_val;
@@ -102,6 +241,44 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return old_val + i;
 }
 
+static inline int tst_atomic_add_return_(int i, int *v,
+					 int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	return tst_atomic_add_return(i, v);
+}
+
+static inline int tst_atomic_cmpxchg_(int *current, int *expected, int desired,
+				      int success_memorder LTP_ATTRIBUTE_UNUSED,
+				      int failure_memorder LTP_ATTRIBUTE_UNUSED)
+{
+	asm volatile(
+		"	cs	%[old],%[new],%[ptr]"
+		: [old] "+d" (*expected), [ptr] "+Q" (*current)
+		: [new] "d" (desired)
+		: "memory");
+
+	return *expected == desired;
+}
+
+static inline int tst_atomic_load_(int *v, int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int ret;
+
+	asm volatile("" : : : "memory");
+	ret = *v;
+	asm volatile("" : : : "memory");
+
+	return ret;
+}
+
+static inline void tst_atomic_store_(int i, int *v,
+				     int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	asm volatile("" : : : "memory");
+	*v = i;
+	asm volatile("" : : : "memory");
+}
+
 #elif defined(__arc__)
 
 /*ARCv2 defines the smp barriers */
@@ -140,7 +317,7 @@ static inline int tst_atomic_add_return(int i, int *v)
 
 	__asm__ __volatile__(
 "       prfm    pstl1strm, %2	\n"
-"1:     ldxr 	%w0, %2		\n"
+"1:     ldaxr 	%w0, %2		\n"
 "       add	%w0, %w0, %w3	\n"
 "       stlxr	%w1, %w0, %2	\n"
 "       cbnz	%w1, 1b		\n"
@@ -152,9 +329,141 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return result;
 }
 
+static inline int tst_atomic_add_return_(int i, int *v,
+					 int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	return tst_atomic_add_return(i, v);
+}
+
+static inline int tst_atomic_cmpxchg_(int *current, int *expected, int desired,
+				      int success_memorder LTP_ATTRIBUTE_UNUSED,
+				      int failure_memorder LTP_ATTRIBUTE_UNUSED)
+{
+	unsigned long tmp;
+
+	/* Taken from arch/arm64/include/asm/atomic_ll_sc.h */
+	asm volatile("//atomic_cmpxchg                      \n"
+		"	prfm	pstl1strm,  %[v]            \n"
+		"1:	ldaxr	%w[oldval], %[v]            \n"
+		"	eor	%w[tmp], %w[oldval], %w[old]\n"
+		"	cbnz	%w[tmp], 2f                 \n"
+		"	stlxr   %w[tmp], %w[new], %[v]      \n"
+		"	cbnz	%w[tmp], 1b                 \n"
+		"	dmb ish                             \n"
+		"2:"
+	: [tmp] "=&r" (tmp), [oldval] "=&r" (*expected),
+	  [v] "+Q" (*(unsigned long *)current)
+	: [old] "Kr" (*expected), [new] "r" (desired)
+	: "memory");
+
+	return *expected == desired;
+}
+
+static inline int tst_atomic_load_(int *v, int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int ret;
+	unsigned long tmp;
+
+	asm volatile("//atomic_load			\n"
+		"	prfm	pstl1strm,  %[v]	\n"
+		"1:	ldaxr	%w[ret], %[v]		\n"
+		"	stlxr   %w[tmp], %w[ret], %[v]\n"
+		"	cbnz    %w[tmp], 1b		\n"
+		"	dmb ish				\n"
+		: [tmp] "=&r" (tmp), [ret] "=&r" (ret), [v] "+Q" (*v)
+		: : "memory");
+
+	return ret;
+}
+
+static inline void tst_atomic_store_(int i, int *v,
+				    int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	unsigned long tmp;
+
+	asm volatile("//atomic_store			\n"
+		"	prfm	pstl1strm, %[v]		\n"
+		"1:	ldaxr	%w[tmp], %[v]		\n"
+		"	stlxr   %w[tmp], %w[i], %[v]	\n"
+		"	cbnz    %w[tmp], 1b		\n"
+		"	dmb ish				\n"
+		: [tmp] "=&r" (tmp), [v] "+Q" (*v)
+		: [i] "r" (i)
+		: "memory");
+}
+
+#elif defined(__sparc__) && defined(__arch64__)
+static inline int tst_atomic_add_return_(int i, int *v,
+					 int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int ret, tmp;
+
+	/* Based on arch/sparc/lib/atomic_64.S */
+	asm volatile("/*atomic_add_return*/		\n"
+		"1:	ldsw	[%[v]], %[ret];		\n"
+		"	add	%[ret], %[i], %[tmp];	\n"
+		"	cas	[%[v]], %[ret], %[tmp];	\n"
+		"	cmp	%[ret], %[tmp];		\n"
+		"	bne,pn	%%icc, 1b;		\n"
+		"	nop;				\n"
+		"	add	%[ret], %[i], %[ret];	\n"
+		: [ret] "=r&" (ret), [tmp] "=r&" (tmp)
+		: [i] "r" (i), [v] "r" (v)
+		: "memory", "cc");
+
+	return ret;
+}
+
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	return tst_atomic_add_return_(i, v, LTP_SEQ_CST);
+}
+
+static inline int tst_atomic_cmpxchg_(int *current, int *expected, int desired,
+				      int success_memorder LTP_ATTRIBUTE_UNUSED,
+				      int failure_memorder LTP_ATTRIBUTE_UNUSED)
+{
+	/* Based on arch/sparc/include/asm/cmpxchg_64.h */
+	asm volatile(
+		"cas [%[current]], %[expected], %[desired]"
+		: [desired] "+&r" (desired)
+		: "[desired]" (desired),
+		  [current] "r" (current),
+		  [expected] "r" (*expected)
+		: "memory");
+
+	/* Unlike x86, [desired] is set/swapped with [*current] */
+	if (*expected != desired) {
+		*expected = desired;
+		return 0;
+	}
+
+	return 1;
+}
+
+static inline int tst_atomic_load_(int *v, int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	int ret;
+
+	/* See arch/sparc/include/asm/barrier_64.h */
+	asm volatile("" : : : "memory");
+	ret = *v;
+	asm volatile("" : : : "memory");
+
+	return ret;
+}
+
+static inline void tst_atomic_store_(int i, int *v,
+				     int memorder LTP_ATTRIBUTE_UNUSED)
+{
+	asm volatile("" : : : "memory");
+	*v = i;
+	asm volatile("" : : : "memory");
+}
+
 #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
-# error Your compiler does not provide __sync_add_and_fetch and LTP\
-	implementation is missing for your architecture.
+# error Your compiler does not provide __atomic_add_fetch, __sync_add_and_fetch \
+        and an LTP implementation is missing for your architecture.
 #endif
 
 static inline int tst_atomic_inc(int *v)
@@ -167,4 +476,20 @@ static inline int tst_atomic_dec(int *v)
 	return tst_atomic_add_return(-1, v);
 }
 
+static inline int tst_atomic_cmpxchg(int *current, int *expected, int desired)
+{
+	return tst_atomic_cmpxchg_(current, expected, desired,
+				  LTP_SEQ_CST, LTP_SEQ_CST);
+}
+
+static inline int tst_atomic_load(int *v)
+{
+	return tst_atomic_load_(v, LTP_SEQ_CST);
+}
+
+static inline void tst_atomic_store(int i, int *v)
+{
+	tst_atomic_store_(i, v, LTP_SEQ_CST);
+}
+
 #endif	/* TST_ATOMIC_H__ */
diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 229217495..f97137c35 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -32,6 +32,7 @@
 
 #include <sys/time.h>
 #include <time.h>
+#include "tst_atomic.h"
 
 #ifndef CLOCK_MONOTONIC_RAW
 # define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
diff --git a/m4/ltp-atomic.m4 b/m4/ltp-atomic.m4
new file mode 100644
index 000000000..165456de5
--- /dev/null
+++ b/m4/ltp-atomic.m4
@@ -0,0 +1,34 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2016
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+
+AC_DEFUN([LTP_CHECK_ATOMIC_MEMORY_MODEL],[dnl
+	AC_MSG_CHECKING([for __atomic_* compiler builtins])
+	AC_LINK_IFELSE([AC_LANG_SOURCE([
+int main(void) {
+	int i = 0, j = 0;
+	__atomic_add_fetch(&i, 1, __ATOMIC_ACQ_REL);
+	__atomic_load_n(&i, __ATOMIC_SEQ_CST);
+	__atomic_compare_exchange_n(&i, &j, 0, 0, __ATOMIC_RELEASE, __ATOMIC_ACQUIRE);
+	__atomic_store_n(&i, 0, __ATOMIC_RELAXED);
+	return i;
+}])],[has_saac="yes"])
+
+if test "x$has_saac" = xyes; then
+	AC_DEFINE(HAVE_ATOMIC_MEMORY_MODEL,1,
+	          [Define to 1 if you have the __atomic_* compiler builtins])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+])
-- 
2.14.1

