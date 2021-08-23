From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Aug 2021 17:05:19 +0200
Subject: [LTP] [PATCH 2/3] tst_test_macros: Stringify early
In-Reply-To: <20210823150520.25614-1-chrubis@suse.cz>
References: <20210823150520.25614-1-chrubis@suse.cz>
Message-ID: <20210823150520.25614-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have to stringify the SCALL argument early, otherwise it will be
replaced in a case that it's a macro.

This is not fixing any hypotetical problem for instance the
tst_syscall() is a macro. If we pass it to a TST_EXP_*() macro and keep
it as a default message it will produce messy output.

Take for an example:

TST_EXP_FAIL(tst_sycall(__NR_foo, 1), EINVAL);

Before this patch it produces:

foo.c:12: TPASS: ({ int tst_ret; if (277 == -1) { (*__errno_location ()) = 38; tst_ret = -1; } else { tst_ret = syscall(277, 1); } if (tst_ret == -1 && (*__errno_location ()) == 38) { ({ do { ((void)sizeof(char[1 - 2 * !!(!((32) & (2 | 32 | 1)))])); } while (0); tst_brk_("foo.c", 12, (32), ("syscall(-1496763488) " "__NR_foo" " not supported"),277); }); } tst_ret; }) : EINVAL (22)

After this patch it will produce:

foo.c:12: TPASS: tst_syscall(__NR_foo, 1) : EINVAL (22)

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test_macros.h | 40 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index ecc612b0d..50598aa15 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -46,7 +46,7 @@ extern void *TST_RET_PTR;
 	tst_res_(__FILE__, __LINE__, RES, \
 		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR)
 
-#define TST_EXP_POSITIVE_(SCALL, ...)                                          \
+#define TST_EXP_POSITIVE_(SCALL, SSCALL, ...)                                  \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -54,13 +54,13 @@ extern void *TST_RET_PTR;
 		                                                               \
 		if (TST_RET == -1) {                                           \
 			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
-			         #SCALL, ##__VA_ARGS__);                       \
+			         SSCALL, ##__VA_ARGS__);                       \
 			break;                                                 \
 		}                                                              \
 		                                                               \
 		if (TST_RET < 0) {                                             \
 			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
-			          TST_RET, #SCALL, ##__VA_ARGS__);             \
+			          TST_RET, SSCALL, ##__VA_ARGS__);             \
 			break;                                                 \
 		}                                                              \
                                                                                \
@@ -70,7 +70,7 @@ extern void *TST_RET_PTR;
 
 #define TST_EXP_POSITIVE(SCALL, ...)                               \
 	do {                                                       \
-		TST_EXP_POSITIVE_(SCALL, ##__VA_ARGS__);           \
+		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);   \
 		                                                   \
 		if (TST_PASS) {                                    \
 			TST_MSGP_(TPASS, " returned %ld",          \
@@ -78,29 +78,29 @@ extern void *TST_RET_PTR;
 		}                                                  \
 	} while (0)
 
-#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, ##__VA_ARGS__)
+#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_FD(SCALL, ...)                                                 \
 	do {                                                                   \
-		TST_EXP_FD_SILENT(SCALL, ##__VA_ARGS__);                       \
+		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
 				#SCALL, ##__VA_ARGS__);                        \
 	} while (0)
 
-#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, ##__VA_ARGS__)
+#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_PID(SCALL, ...)                                                \
 	do {                                                                   \
-		TST_EXP_PID_SILENT(SCALL, ##__VA_ARGS__);                      \
+		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
 									       \
 		if (TST_PASS)                                                  \
 			TST_MSGP_(TPASS, " returned pid %ld", TST_RET,         \
 				#SCALL, ##__VA_ARGS__);                        \
 	} while (0)
 
-#define TST_EXP_PASS_SILENT(SCALL, ...)                                        \
+#define TST_EXP_PASS_SILENT_(SCALL, SSCALL, ...)                               \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -108,13 +108,13 @@ extern void *TST_RET_PTR;
 		                                                               \
 		if (TST_RET == -1) {                                           \
 			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
-			         #SCALL, ##__VA_ARGS__);                       \
+			         SSCALL, ##__VA_ARGS__);                       \
 		        break;                                                 \
 		}                                                              \
 		                                                               \
 		if (TST_RET != 0) {                                            \
 			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
-			          TST_RET, #SCALL, ##__VA_ARGS__);             \
+			          TST_RET, SSCALL, ##__VA_ARGS__);             \
 			break;                                                 \
 		}                                                              \
                                                                                \
@@ -122,44 +122,46 @@ extern void *TST_RET_PTR;
                                                                                \
 	} while (0)
 
+#define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
+
 #define TST_EXP_PASS(SCALL, ...)                                               \
 	do {                                                                   \
-		TST_EXP_PASS_SILENT(SCALL, ##__VA_ARGS__);                     \
+		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \
 
-#define TST_EXP_FAIL_(PASS_COND, SCALL, ERRNO, ...)                            \
+#define TST_EXP_FAIL_(PASS_COND, SCALL, SSCALL, ERRNO, ...)                    \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
 		TST_PASS = 0;                                                  \
 		                                                               \
 		if (PASS_COND) {                                               \
-			TST_MSG_(TFAIL, " succeeded", #SCALL, ##__VA_ARGS__);  \
+			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
 		        break;                                                 \
 		}                                                              \
 		                                                               \
 		if (TST_RET != -1) {                                           \
 			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
-			          TST_RET, #SCALL, ##__VA_ARGS__);             \
+			          TST_RET, SSCALL, ##__VA_ARGS__);             \
 			break;                                                 \
 		}                                                              \
 		                                                               \
 		if (TST_ERR == ERRNO) {					\
 			TST_MSG_(TPASS | TTERRNO, " ",			\
-				 #SCALL, ##__VA_ARGS__);		\
+				 SSCALL, ##__VA_ARGS__);		\
 			TST_PASS = 1;					\
 		} else {						\
 			TST_MSGP_(TFAIL | TTERRNO, " expected %s",	\
 				  tst_strerrno(ERRNO),			\
-				  #SCALL, ##__VA_ARGS__);		\
+				  SSCALL, ##__VA_ARGS__);		\
 		}							\
 	} while (0)
 
-#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
 
-#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET >= 0, SCALL, ERRNO, ##__VA_ARGS__)
+#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET >= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
 
 #endif	/* TST_TEST_MACROS_H__ */
-- 
2.31.1

