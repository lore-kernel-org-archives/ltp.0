From: Yury Norov <ynorov@caviumnetworks.com>
Date: Thu, 26 Jan 2017 02:43:42 +0530
Subject: [LTP] [PATCH] arm64: add tst_atomic_add_return
Message-ID: <1485378822-6059-1-git-send-email-ynorov@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The patch fixes build of LTP, at least with gcc 5.3.
The implementation is taken from kernel v4.9.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/tst_atomic.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 799d735..35a3b34 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -131,6 +131,27 @@ static inline int tst_atomic_add_return(int i, int *v)
 
 	return val;
 }
+
+#elif defined (__aarch64__)
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	unsigned long tmp;
+	int result;
+
+	__asm__ __volatile__(
+"       prfm    pstl1strm, %2	\n"
+"1:     ldxr 	%w0, %2		\n"
+"       add	%w0, %w0, %w3	\n"
+"       stlxr	%w1, %w0, %2	\n"
+"       cbnz	%w1, 1b		\n"
+"       dmb ish			\n"
+	: "=&r" (result), "=&r" (tmp), "+Q" (*v)
+	: "Ir" (i)
+	: "memory");
+
+	return result;
+}
+
 #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
 # error Your compiler does not provide __sync_add_and_fetch and LTP\
 	implementation is missing for your architecture.
-- 
2.7.4

