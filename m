From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Apr 2016 14:09:15 +0200
Subject: [LTP] [PATCH v3 3/4] tst_atomic: add atomic_add_return for x86/64,
	ppc/64 and s390/x
In-Reply-To: <9daf43fcf4de400240ca0fea83d0a63d2473a046.1460721164.git.jstancek@redhat.com>
References: <9daf43fcf4de400240ca0fea83d0a63d2473a046.1460721164.git.jstancek@redhat.com>
Message-ID: <06b31639b037b98f6b34a25f518a3d8ba6b3550f.1460721164.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In case __sync_add_and_fetch is not provided by compiler, we
try to supply our own implementation.

It has been taken from kernel 4.5 sources, by compiling a small
piece of code (atomic_add_return()) with "gcc -E" and applying
some formatting to make it more readable/pretty.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_atomic.h | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

Changes in v3:
- eliminated some preprocessor nesting by using #elif
- dropped HAVE_ATOMIC_ADD_RETURN define

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 420c53bdfed5..b2edcadfd4db 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -25,7 +25,83 @@ static inline int tst_atomic_add_return(int i, int *v)
 {
 	return __sync_add_and_fetch(v, i);
 }
-#else
+
+#elif defined(__i386__) || defined(__x86_64__)
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	int __ret = i;
+
+	/*
+	 * taken from arch/x86/include/asm/cmpxchg.h
+	 * Since we always pass int sized parameter, we can simplify it
+	 * and cherry-pick only that specific case.
+	 *
+	switch (sizeof(*v)) {
+	case 1:
+		asm volatile ("lock; xaddb %b0, %1\n"
+			: "+q" (__ret), "+m" (*v) : : "memory", "cc");
+		break;
+	case 2:
+		asm volatile ("lock; xaddw %w0, %1\n"
+			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
+		break;
+	case 4:
+		asm volatile ("lock; xaddl %0, %1\n"
+			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
+		break;
+	case 8:
+		asm volatile ("lock; xaddq %q0, %1\n"
+			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
+		break;
+	default:
+		__xadd_wrong_size();
+	}
+	*/
+	asm volatile ("lock; xaddl %0, %1\n"
+		: "+r" (__ret), "+m" (*v) : : "memory", "cc");
+
+	return i + __ret;
+}
+
+#elif defined(__powerpc__) || defined(__powerpc64__)
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	int t;
+
+	/* taken from arch/powerpc/include/asm/atomic.h */
+	asm volatile(
+		"	sync\n"
+		"1:	lwarx	%0,0,%2		# atomic_add_return\n"
+		"	add %0,%1,%0\n"
+		"	stwcx.	%0,0,%2 \n"
+		"	bne-	1b\n"
+		"	sync\n"
+		: "=&r" (t)
+		: "r" (i), "r" (v)
+		: "cc", "memory");
+
+	return t;
+}
+
+#elif defined(__s390__) || defined(__s390x__)
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	int old_val, new_val;
+
+	/* taken from arch/s390/include/asm/atomic.h */
+	asm volatile(
+		"	l	%0,%2\n"
+		"0:	lr	%1,%0\n"
+		"	ar	%1,%3\n"
+		"	cs	%0,%1,%2\n"
+		"	jl	0b"
+		: "=&d" (old_val), "=&d" (new_val), "+Q" (*v)
+		: "d" (i)
+		: "cc", "memory");
+
+	return old_val + i;
+}
+#else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
 # error Your compiler does not provide __sync_add_and_fetch and LTP\
 	implementation is missing for your architecture.
 #endif
-- 
1.8.3.1

