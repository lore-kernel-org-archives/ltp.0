From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 24 Jun 2021 13:33:46 +0800
Subject: [LTP] [PATCH v3 2/3] include/tst_test_macro.h: Add TST_EXP_FAIL2
 macros
In-Reply-To: <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YNM4rlDJLzb4xk6v@yuki>
 <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1624512827-3256-2-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/c-test-api.txt        | 11 +++++++++++
 include/tst_test_macros.h |  8 ++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 4cccbdc10..e3ca27696 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -281,6 +281,17 @@ The 'TST_EXP_FAIL()' is similar to 'TST_EXP_PASS()' but it fails the test if
 the call haven't failed with -1 and 'errno' wasn't set to the expected one
 passed as the second argument.
 
+[source,c]
+-------------------------------------------------------------------------------
+static void test(void)
+{
+	...
+	TST_EXP_FAIL2(msgget(key, flags), EINVAL, "msgget(%i, %i)", key, flags);
+	...
+}
+The 'TST_EXP_FAIL2()' is the same as 'TST_EXP_FAIL' the only difference is that
+the return value is a non-negative integer if call passes.
+
 [source,c]
 -------------------------------------------------------------------------------
 const char *tst_strsig(int sig);
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 89dfe5a31..78cee47de 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -120,13 +120,13 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \
 
-#define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
+#define TST_EXP_FAIL_(PASS_COND, SCALL, ERRNO, ...)                            \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
 		TST_PASS = 0;                                                  \
 		                                                               \
-		if (TST_RET == 0) {                                            \
+		if (PASS_COND) {                                               \
 			TST_MSG_(TFAIL, " succeeded", #SCALL, ##__VA_ARGS__);  \
 		        break;                                                 \
 		}                                                              \
@@ -150,4 +150,8 @@ extern void *TST_RET_PTR;
 		}                                                              \
 	} while (0)
 
+#define TST_EXP_FAIL(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET == 0, SCALL, ERRNO, __VA_ARGS__)
+
+#define TST_EXP_FAIL2(SCALL, ERRNO, ...) TST_EXP_FAIL_(TST_RET >= 0, SCALL, ERRNO, __VA_ARGS__)
+
 #endif	/* TST_TEST_MACROS_H__ */
-- 
2.23.0

