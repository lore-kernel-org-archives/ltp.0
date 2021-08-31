From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 31 Aug 2021 09:43:58 +0800
Subject: [LTP] [PATCH v3] tst_test_macros.h: Add TST_EXP_VAL macro
Message-ID: <20210831014358.28459-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add TST_EXP_VAL to determine whether the return value
is equal to the given value.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 50598aa15..f8e08e134 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -132,6 +132,34 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \

+
+#define TST_EXP_VAL_SILENT_(SCALL, VAL, SSCALL, ...)                           \
+	do {                                                                   \
+		TEST(SCALL);                                                   \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET != VAL) {                                          \
+			TST_MSGP_(TFAIL | TTERRNO, " retval not %ld",          \
+			          (long )VAL, SSCALL, ##__VA_ARGS__);          \
+			break;                                                 \
+		}                                                              \
+		                                                               \
+		TST_PASS = 1;                                                  \
+		                                                               \
+	} while (0)
+
+#define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__)
+
+#define TST_EXP_VAL(SCALL, VAL, ...)                                           \
+	do {                                                                   \
+		TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__);        \
+		                                                               \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
+			                                                       \
+	} while(0)
+
 #define TST_EXP_FAIL_(PASS_COND, SCALL, SSCALL, ERRNO, ...)                    \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
--
2.20.1



