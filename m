From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Wed, 31 Aug 2016 16:39:48 -0700
Subject: [LTP]  tst_atomic: add atomic_add_return for ARC
Message-ID: <1472686788-8992-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/tst_atomic.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index cfe9b4f4b4df..799d7356b97a 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -101,6 +101,36 @@ static inline int tst_atomic_add_return(int i, int *v)
 
 	return old_val + i;
 }
+
+#elif defined(__arc__)
+
+/*ARCv2 defines the smp barriers */
+#ifdef __ARC700__
+#define smp_mb()
+#else
+#define smp_mb()	asm volatile("dmb 3\n" : : : "memory")
+#endif
+
+static inline int tst_atomic_add_return(int i, int *v)
+{
+	unsigned int val;
+
+	smp_mb();
+
+	asm volatile(
+		"1:	llock   %[val], [%[ctr]]	\n"
+		"	add     %[val], %[val], %[i]	\n"
+		"	scond   %[val], [%[ctr]]	\n"
+		"	bnz     1b			\n"
+		: [val]	"=&r"	(val)
+		: [ctr]	"r"	(v),
+		  [i]	"ir"	(i)
+		: "cc", "memory");
+
+	smp_mb();
+
+	return val;
+}
 #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
 # error Your compiler does not provide __sync_add_and_fetch and LTP\
 	implementation is missing for your architecture.
-- 
2.7.4

