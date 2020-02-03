From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  3 Feb 2020 12:39:55 +0100
Subject: [LTP] [PATCH 1/2] Add TST_SPIN_TEST() macro
Message-ID: <20200203113956.13176-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The TST_RETRY_FUNC() macro requires a single return value that'll be considered
success. This cannot be used with system calls that e.g. return a new file
descriptor because the success value is somewhat unpredictable.

Add a new macro TST_SPIN_TEST that'll work mostly like TST_RETRY_FUNC(), except:
- Any negative return value means failure, any non-negative return value means
  success.
- The loop will fall through on timeout instead of callid tst_brk(). TST_RET
  and TST_ERR will be set to the values returned by the last FUNC call.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_common.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/tst_common.h b/include/tst_common.h
index a0c06a3f7..72e00ca81 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -55,6 +55,34 @@
 	ERET;								\
 })
 
+/**
+ * TST_SPIN_TEST() - Repeatedly retry a function with an increasing delay.
+ * @FUNC - The function which will be retried
+ *
+ * Same as TST_RETRY_FUNC() but any non-negative return value is accepted
+ * as success and tst_brk() will not be called on timeout.
+ */
+#define TST_SPIN_TEST(FUNC) \
+	TST_SPIN_TEST_EXP_BACKOFF(FUNC, 1, -1)
+
+#define TST_SPIN_TEST_EXP_BACKOFF(FUNC, MAX_DELAY, GOOD_ERRNO)	\
+({	unsigned int tst_delay_, tst_max_delay_;			\
+	tst_delay_ = 1;							\
+	tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);	\
+	for (;;) {							\
+		TEST(FUNC);						\
+		if (TST_RET >= 0 || (GOOD_ERRNO >= 0 && TST_ERR == GOOD_ERRNO))	\
+			break;						\
+		if (tst_delay_ < tst_max_delay_) {			\
+			usleep(tst_delay_);				\
+			tst_delay_ *= 2;				\
+		} else {						\
+			break;						\
+		}							\
+	}								\
+	TST_RET;							\
+})
+
 #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
 	do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
 
-- 
2.24.1

