From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 28 Aug 2017 13:02:35 +0200
Subject: [LTP] [PATCH v2 1/7] tst_atomic: Add load,
	store and use __atomic builtins
Message-ID: <20170828110241.30453-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add more fallback inline assembly for the existing architectures and add
SPARC64. Use the __atomic_* compiler intrinsics when available.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 configure.ac             |   1 +
 include/tst_atomic.h     | 213 ++++++++++++++++++++++++++++++++++++++++-------
 include/tst_fuzzy_sync.h |   1 +
 m4/ltp-atomic.m4         |  34 ++++++++
 4 files changed, 220 insertions(+), 29 deletions(-)
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
index 35a3b3411..bd4205153 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -20,12 +20,45 @@
 
 #include "config.h"
 
-#if HAVE_SYNC_ADD_AND_FETCH == 1
+#if HAVE_ATOMIC_MEMORY_MODEL == 1
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	return __atomic_add_fetch(v, i, __ATOMIC_SEQ_CST);
+}
+
+static inline int tst_atomic_load(int *v)
+{
+	return __atomic_load_n(v, __ATOMIC_SEQ_CST);
+}
+
+static inline void tst_atomic_store(int i, int *v)
+{
+	__atomic_store_n(v, i, __ATOMIC_SEQ_CST);
+}
+
+#elif HAVE_SYNC_ADD_AND_FETCH == 1
 static inline int tst_atomic_add_return(int i, int *v)
 {
 	return __sync_add_and_fetch(v, i);
 }
 
+static inline int tst_atomic_load(int *v)
+{
+	int ret;
+
+	__sync_synchronize();
+	ret = *v;
+	__sync_synchronize();
+	return ret;
+}
+
+static inline void tst_atomic_store(int i, int *v)
+{
+	__sync_synchronize();
+	*v = i;
+	__sync_synchronize();
+}
+
 #elif defined(__i386__) || defined(__x86_64__)
 static inline int tst_atomic_add_return(int i, int *v)
 {
@@ -33,36 +66,31 @@ static inline int tst_atomic_add_return(int i, int *v)
 
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
 
+static inline int tst_atomic_load(int *v)
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
+static inline void tst_atomic_store(int i, int *v)
+{
+	asm volatile("" : : : "memory");
+	*v = i;
+	asm volatile("" : : : "memory");
+}
+
 #elif defined(__powerpc__) || defined(__powerpc64__)
 static inline int tst_atomic_add_return(int i, int *v)
 {
@@ -83,7 +111,26 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return t;
 }
 
+static inline int tst_atomic_load(int *v)
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
+static inline void tst_atomic_store(int i, int *v)
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
@@ -102,11 +149,29 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return old_val + i;
 }
 
+static inline int tst_atomic_load(int *v)
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
+static inline void tst_atomic_store(int i, int *v)
+{
+	asm volatile("" : : : "memory");
+	*v = i;
+	asm volatile("" : : : "memory");
+}
+
 #elif defined(__arc__)
 
 /*ARCv2 defines the smp barriers */
 #ifdef __ARC700__
-#define smp_mb()
+#define smp_mb()	asm volatile("" : : : "memory")
 #else
 #define smp_mb()	asm volatile("dmb 3\n" : : : "memory")
 #endif
@@ -132,6 +197,24 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return val;
 }
 
+static inline int tst_atomic_load(int *v)
+{
+	int ret;
+
+	smp_mb();
+	ret = *v;
+	smp_mb();
+
+	return ret;
+}
+
+static inline void tst_atomic_store(int i, int *v)
+{
+	smp_mb();
+	*v = i;
+	smp_mb();
+}
+
 #elif defined (__aarch64__)
 static inline int tst_atomic_add_return(int i, int *v)
 {
@@ -140,7 +223,7 @@ static inline int tst_atomic_add_return(int i, int *v)
 
 	__asm__ __volatile__(
 "       prfm    pstl1strm, %2	\n"
-"1:     ldxr 	%w0, %2		\n"
+"1:     ldaxr	%w0, %2		\n"
 "       add	%w0, %w0, %w3	\n"
 "       stlxr	%w1, %w0, %2	\n"
 "       cbnz	%w1, 1b		\n"
@@ -152,9 +235,81 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return result;
 }
 
+static inline int tst_atomic_load(int *v)
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
+static inline void tst_atomic_store(int i, int *v)
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
+static inline int tst_atomic_add_return(int i, int *v)
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
+static inline int tst_atomic_load(int *v)
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
+static inline void tst_atomic_store(int i, int *v)
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
index 000000000..836f0a4fd
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
+}])],[has_atomic_mm="yes"])
+
+if test "x$has_atomic_mm" = xyes; then
+	AC_DEFINE(HAVE_ATOMIC_MEMORY_MODEL,1,
+	          [Define to 1 if you have the __atomic_* compiler builtins])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+])
-- 
2.14.1

