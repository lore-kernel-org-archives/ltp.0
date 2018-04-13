From: Li Wang <liwang@redhat.com>
Date: Fri, 13 Apr 2018 19:19:56 +0800
Subject: [LTP] [PATCH v2] include: add an exponential backoff macro for
	function repeat
Message-ID: <20180413111956.15837-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.de>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_common.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/tst_common.h b/include/tst_common.h
index e4466d5..3c01e26 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -35,4 +35,30 @@
 #define LTP_ALIGN(x, a)    __LTP_ALIGN_MASK(x, (typeof(x))(a) - 1)
 #define __LTP_ALIGN_MASK(x, mask)  (((x) + (mask)) & ~(mask))
 
+/*
+ * Exponential backoff usleep for function repeat
+ * @FUNC: the function which will be retried
+ * @ERET: an expected return value from the FUNC
+ */
+#define TST_RETRY_FUNC(FUNC, ERET) \
+	TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, 1)
+
+#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)	\
+do {	int tst_delay = 1;					\
+	for (;;) {						\
+		typeof(FUNC) ret = FUNC;			\
+		if (ret == ERET)				\
+			break;					\
+		if (tst_delay < MAX_DELAY * 1000000) {		\
+			tst_res(TINFO,				\
+				#FUNC" returned %i, retrying"	\
+				" in %ius", ret, tst_delay);	\
+			usleep(tst_delay);			\
+			tst_delay *= 2;				\
+		} else {					\
+			tst_brk(TBROK, #FUNC" failed");		\
+		}						\
+	}							\
+} while(0)
+
 #endif /* TST_COMMON_H__ */
-- 
2.9.3

