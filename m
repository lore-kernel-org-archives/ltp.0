From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 12 Jan 2021 10:02:25 +0800
Subject: [LTP] [PATCH v3 1/3] include/tst_test_macros.h: Add TST_EXP_{PASS,
 FD}_SILENT macros
Message-ID: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) TST_EXP_{PASS,FD}_SILENT don't report TPASS when SCALL succeeds.
2) TST_EXP_{PASS,FD} calls TST_EXP_{PASS,FD}_SILENT and reports
   TPASS when SCALL succeeds.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_test_macros.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 3016d95c2..92cb5c66b 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -46,7 +46,7 @@ extern void *TST_RET_PTR;
 	tst_res_(__FILE__, __LINE__, RES, \
 		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR)
 
-#define TST_EXP_FD(SCALL, ...)                                                 \
+#define TST_EXP_FD_SILENT(SCALL, ...)                                          \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -64,14 +64,20 @@ extern void *TST_RET_PTR;
 			break;                                                 \
 		}                                                              \
                                                                                \
-		TST_MSGP_(TPASS, " returned fd %ld", TST_RET,                  \
-		         #SCALL, ##__VA_ARGS__);                               \
-                                                                               \
 		TST_PASS = 1;                                                  \
                                                                                \
 	} while (0)
 
-#define TST_EXP_PASS(SCALL, ...)                                               \
+#define TST_EXP_FD(SCALL, ...)                                                 \
+	do {                                                                   \
+		TST_EXP_FD_SILENT(SCALL, __VA_ARGS__);                         \
+		                                                               \
+		if (TST_PASS)                                                  \
+			TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
+				#SCALL, ##__VA_ARGS__);                        \
+	} while (0)
+
+#define TST_EXP_PASS_SILENT(SCALL, ...)                                        \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -89,12 +95,17 @@ extern void *TST_RET_PTR;
 			break;                                                 \
 		}                                                              \
                                                                                \
-		TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);             \
-                                                                               \
 		TST_PASS = 1;                                                  \
                                                                                \
 	} while (0)
 
+#define TST_EXP_PASS(SCALL, ...)                                               \
+	do {                                                                   \
+		TST_EXP_PASS_SILENT(SCALL, __VA_ARGS__);                       \
+		                                                               \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
+	} while (0)                                                            \
 
 #define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
 	do {                                                                   \
-- 
2.21.0



