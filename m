From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Apr 2018 18:56:44 +0800
Subject: [LTP] [RFC PATCH] include: add two exponential backoff macros
Message-ID: <1523444204-12870-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_common.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/tst_common.h b/include/tst_common.h
index e4466d5..4c96e6b 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -35,4 +35,51 @@
 #define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
 
+/*
+ * Exponential backoff usleep for function repeat
+ * @FUNC: the function() which will be retried
+ * @ERET: an expected return value from the FUNC
+ */
+#define TST_RETRY_FUNC(FUNC, ERET) \
+	TST_RETRY_FUNC_WITH_EXPONENTIAL_BACKOFF(FUNC, ERET, 1)
+
+#define TST_RETRY_FUNC_WITH_EXPONENTIAL_BACKOFF(FUNC, ERET, MAX_DELAY) \
+do {	int delay = 1;						\
+	for (;;) {						\
+		typeof(FUNC) ret = FUNC;			\
+		if (ret == (typeof(FUNC))ERET)			\
+			break;					\
+		if (delay < MAX_DELAY * 1000000) {		\
+			usleep(delay);				\
+			delay *= 2;				\
+		} else {					\
+			tst_brk_(__FILE__, __LINE__,		\
+			TBROK | TERRNO, #FUNC " failed");	\
+		}						\
+	}							\
+} while(0)
+
+/*
+ * Exponential backoff usleep for wating a varible change
+ * @VAR: the variable will be changed in other place
+ * @EXP: an expected value which VAR should be equal to
+ */
+#define TST_WAIT_ON_VAR(VAR, EXP)	\
+	TST_WAIT_WITH_EXPONENTIAL_BACKOFF(VAR, EXP, 1)
+
+#define TST_WAIT_WITH_EXPONENTIAL_BACKOFF(VAR, EXP, MAX_DELAY)	\
+do {	int delay = 1; 						\
+	for (;;) {						\
+		if (VAR == (typeof(VAR)) EXP)			\
+			break;					\
+		if (delay < MAX_DELAY * 1000000) {		\
+			usleep(delay);				\
+			delay *= 2;				\
+		} else {					\
+			tst_brk_(__FILE__, __LINE__,		\
+			TBROK | TERRNO, #VAR " is not expected");	\
+		}						\
+	}							\
+} while(0)
+
 #endif /* TST_COMMON_H__ */
-- 
1.9.3

