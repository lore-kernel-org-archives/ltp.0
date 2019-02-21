From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Feb 2019 14:30:10 +0530
Subject: [LTP] [PATCH v4 3/9] lib/tst_test: define TEST_VOID() macro
In-Reply-To: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550739616-24054-4-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Define TEST_VOID() macro for syscalls whose return type is void like
sync() etc.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/tst_test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 12dda2e..03c88e3 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -216,6 +216,13 @@ void tst_reinit(void);
 		TST_ERR = errno; \
 	} while (0)
 
+#define TEST_VOID(SCALL) \
+	do { \
+		errno = 0; \
+		SCALL; \
+		TST_ERR = errno; \
+	} while (0)
+
 extern long TST_RET;
 extern int TST_ERR;
 
-- 
2.7.4

