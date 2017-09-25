From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 25 Sep 2017 11:51:31 +0200
Subject: [LTP] [PATCH v4 1/7] tst_atomic: Add load,
	store and use __atomic builtins
Message-ID: <20170925095137.31491-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add more fallback inline assembly for the existing architectures and add
SPARC64. Use the __atomic_* compiler intrinsics when available.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V4 - Combine generic load-store fallback functions

 configure.ac             |   1 +
 include/tst_atomic.h     | 234 +++++++++++++++++++++++++++++++++++++++++------
 include/tst_fuzzy_sync.h |   1 +
 m4/ltp-atomic.m4         |  33 +++++++
 4 files changed, 240 insertions(+), 29 deletions(-)
 create mode 100644 m4/ltp-atomic.m4

diff --git a/configure.ac b/configure.ac
index 458a5b13f..3b2f23f7f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -192,5 +192,6 @@ LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
 LTP_CHECK_X_TABLES
+LTP_CHECK_ATOMIC_MEMORY_MODEL
 
 AC_OUTPUT
diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 35a3b3411..5736d28bb 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -14,49 +14,104 @@
  * You should have received a copy of the GNU General Public License
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
+/* The LTP library has some of its own atomic synchronisation primitives
+ * contained in this file. Generally speaking these should not be used
+ * directly in tests for synchronisation, instead use tst_checkpoint.h,
+ * tst_fuzzy_sync.h or the POSIX library.
+ *
+ * Notes on compile and runtime memory barriers and atomics.
+ *
+ * Within the LTP library we have three concerns when accessing variables
+ * shared by multiple threads or processes:
+ *
+ * (1) Removal or reordering of accesses by the compiler.
+ * (2) Atomicity of addition.
+ * (3) LOAD-STORE ordering between threads.
+ *
+ * The first (1) is the most likely to cause an error if not properly
+ * handled. We avoid it by using volatile variables and statements which will
+ * not be removed or reordered by the compiler during optimisation. This includes
+ * the __atomic and __sync intrinsics and volatile asm statements marked with
+ * "memory" as well as variables marked with volatile.
+ *
+ * On any platform Linux is likely to run on, a LOAD (fetch) or STORE of a
+ * 32-bit integer will be atomic. However fetching and adding to a variable is
+ * quite likely not; so for (2) we need to ensure we use atomic addition.
+ *
+ * Finally, for tst_fuzzy_sync at least, we need to ensure that LOADs and
+ * STOREs of any shared variables (including non-atomics) that are made
+ * between calls to tst_fzsync_wait are completed (globally visible) before
+ * tst_fzsync_wait completes. For this, runtime memory and instruction
+ * barriers are required in addition to compile time.
+ *
+ * We use full sequential ordering (__ATOMIC_SEQ_CST) for the sake of
+ * simplicity. LTP tests tend to be syscall heavy so any performance gain from
+ * using a weaker memory model is unlikely to result in a relatively large
+ * performance improvement while at the same time being a potent source of
+ * confusion.
+ *
+ * Likewise, for the fallback ASM, the simplest "definitely will work, always"
+ * approach is preferred over anything more performant.
+ *
+ * Also see Documentation/memory-barriers.txt in the kernel tree and
+ * https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
+ * terminology may vary between sources.
+ */
 
 #ifndef TST_ATOMIC_H__
 #define TST_ATOMIC_H__
 
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
+# define LTP_USE_GENERIC_LOAD_STORE_ASM 1
+
 static inline int tst_atomic_add_return(int i, int *v)
 {
 	int __ret = i;
 
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
 
@@ -83,7 +138,27 @@ static inline int tst_atomic_add_return(int i, int *v)
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
+# define LTP_USE_GENERIC_LOAD_STORE_ASM 1
+
 static inline int tst_atomic_add_return(int i, int *v)
 {
 	int old_val, new_val;
@@ -106,7 +181,7 @@ static inline int tst_atomic_add_return(int i, int *v)
 
 /*ARCv2 defines the smp barriers */
 #ifdef __ARC700__
-#define smp_mb()
+#define smp_mb()	asm volatile("" : : : "memory")
 #else
 #define smp_mb()	asm volatile("dmb 3\n" : : : "memory")
 #endif
@@ -132,6 +207,24 @@ static inline int tst_atomic_add_return(int i, int *v)
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
@@ -140,7 +233,7 @@ static inline int tst_atomic_add_return(int i, int *v)
 
 	__asm__ __volatile__(
 "       prfm    pstl1strm, %2	\n"
-"1:     ldxr 	%w0, %2		\n"
+"1:     ldaxr	%w0, %2		\n"
 "       add	%w0, %w0, %w3	\n"
 "       stlxr	%w1, %w0, %2	\n"
 "       cbnz	%w1, 1b		\n"
@@ -152,9 +245,92 @@ static inline int tst_atomic_add_return(int i, int *v)
 	return result;
 }
 
+/* We are using load and store exclusive (ldaxr & stlxr) instructions to try
+ * and help prevent the tst_atomic_load and, more likely, tst_atomic_store
+ * functions from interfering with tst_atomic_add_return which takes advantage
+ * of exclusivity. It is not clear if this is a good idea or not, but does
+ * mean that all three functions are very similar.
+ */
+static inline int tst_atomic_load(int *v)
+{
+	int ret;
+	unsigned long tmp;
+
+	asm volatile("//atomic_load			\n"
+		"	prfm	pstl1strm,  %[v]	\n"
+		"1:	ldaxr	%w[ret], %[v]		\n"
+		"	stlxr   %w[tmp], %w[ret], %[v]  \n"
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
+# define LTP_USE_GENERIC_LOAD_STORE_ASM 1
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	int ret, tmp;
+
+	/* Based on arch/sparc/lib/atomic_64.S with the exponential backoff
+	 * function removed because we are unlikely to have a large (>= 16?)
+	 * number of cores continuously trying to update one variable.
+	 */
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
 #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
-# error Your compiler does not provide __sync_add_and_fetch and LTP\
-	implementation is missing for your architecture.
+# error Your compiler does not provide __atomic_add_fetch, __sync_add_and_fetch \
+        and an LTP implementation is missing for your architecture.
+#endif
+
+#ifdef LTP_USE_GENERIC_LOAD_STORE_ASM
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
index 000000000..59614a1ec
--- /dev/null
+++ b/m4/ltp-atomic.m4
@@ -0,0 +1,33 @@
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

