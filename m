From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Aug 2021 11:21:49 +0200
Subject: [LTP] [PATCH] tst_test_macros.h: Make TST_EXP_POSSITIVE() print
 TPASS as well
Message-ID: <20210811092149.11287-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So that it could be used in the tests.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: sujiaxun <sujiaxun@uniontech.com>
---
 include/tst_test_macros.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index cd65d8d0d..d9d7f930f 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -46,7 +46,7 @@ extern void *TST_RET_PTR;
 	tst_res_(__FILE__, __LINE__, RES, \
 		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR)
 
-#define TST_EXP_POSITIVE(SCALL, ...)                                           \
+#define TST_EXP_POSITIVE_(SCALL, ...)                                          \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -68,7 +68,17 @@ extern void *TST_RET_PTR;
                                                                                \
 	} while (0)
 
-#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE(SCALL, __VA_ARGS__)
+#define TST_EXP_POSITIVE(SCALL, ...)                               \
+	do {                                                       \
+		TST_EXP_POSITIVE_(SCALL, __VA_ARGS__);             \
+		                                                   \
+		if (TST_PASS) {                                    \
+			TST_MSGP_(TPASS, " returned %ld",          \
+			          TST_RET, #SCALL, ##__VA_ARGS__); \
+		}                                                  \
+	} while (0)
+
+#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, __VA_ARGS__)
 
 #define TST_EXP_FD(SCALL, ...)                                                 \
 	do {                                                                   \
@@ -79,7 +89,7 @@ extern void *TST_RET_PTR;
 				#SCALL, ##__VA_ARGS__);                        \
 	} while (0)
 
-#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE(SCALL, __VA_ARGS__)
+#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, __VA_ARGS__)
 
 #define TST_EXP_PID(SCALL, ...)                                                \
 	do {                                                                   \
-- 
2.31.1

