From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Aug 2021 17:05:18 +0200
Subject: [LTP] [PATCH 1/3] tst_test_macros: Fix TST_EXP_*() default message
In-Reply-To: <20210823150520.25614-1-chrubis@suse.cz>
References: <20210823150520.25614-1-chrubis@suse.cz>
Message-ID: <20210823150520.25614-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have to erase the last comma because otherwise we pass down one more
empty parameter to the TST_EXP_*_() macros which then causes the FMT
string to be empty and we end up with an empty default message.

Consider for example:

TST_EXP_FD(open(fname, O_RDONLY));

Before the patch it would produce:

foo.c:12: TPASS: returned fd 4

After it would produce:

foo.c:12: TPASS: open(fname, O_RDONLY) returned fd 4

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test_macros.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index d9d7f930f..ecc612b0d 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -70,7 +70,7 @@ extern void *TST_RET_PTR;
 
 #define TST_EXP_POSITIVE(SCALL, ...)                               \
 	do {                                                       \
-		TST_EXP_POSITIVE_(SCALL, __VA_ARGS__);             \
+		TST_EXP_POSITIVE_(SCALL, ##__VA_ARGS__);           \
 		                                                   \
 		if (TST_PASS) {                                    \
 			TST_MSGP_(TPASS, " returned %ld",          \
@@ -78,22 +78,22 @@ extern void *TST_RET_PTR;
 		}                                                  \
 	} while (0)
 
-#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, __VA_ARGS__)
+#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_FD(SCALL, ...)                                                 \
 	do {                                                                   \
-		TST_EXP_FD_SILENT(SCALL, __VA_ARGS__);                         \
+		TST_EXP_FD_SILENT(SCALL, ##__VA_ARGS__);                       \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
 				#SCALL, ##__VA_ARGS__);                        \
 	} while (0)
 
-#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, __VA_ARGS__)
+#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_PID(SCALL, ...)                                                \
 	do {                                                                   \
-		TST_EXP_PID_SILENT(SCALL, __VA_ARGS__);                        \
+		TST_EXP_PID_SILENT(SCALL, ##__VA_ARGS__);                      \
 									       \
 		if (TST_PASS)                                                  \
 			TST_MSGP_(TPASS, " returned pid %ld", TST_RET,         \
@@ -124,7 +124,7 @@ extern void *TST_RET_PTR;
 
 #define TST_EXP_PASS(SCALL, ...)                                               \
 	do {                                                                   \
-		TST_EXP_PASS_SILENT(SCALL, __VA_ARGS__);                       \
+		TST_EXP_PASS_SILENT(SCALL, ##__VA_ARGS__);                     \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
@@ -158,8 +158,8 @@ extern void *TST_RET_PTR;
 		}							\
 	} while (0)
 
-#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, ERRNO, __VA_ARGS__)
+#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, ERRNO, ##__VA_ARGS__)
 
-#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET >= 0, SCALL, ERRNO, __VA_ARGS__)
+#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET >= 0, SCALL, ERRNO, ##__VA_ARGS__)
 
 #endif	/* TST_TEST_MACROS_H__ */
-- 
2.31.1

