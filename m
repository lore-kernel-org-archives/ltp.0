From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 17 Feb 2020 15:16:20 +0100
Subject: [LTP] [PATCH v3 1/3] Redesign TST_RETRY_FUNC()
In-Reply-To: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
References: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
Message-ID: <20200217141622.26912-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The TST_RETRY_FUNC() macro requires a single return value that'll be considered
success. This cannot be used with system calls that e.g. return a new file
descriptor because the success value is somewhat unpredictable.

Redesign TST_RETRY_FUNC() to accept arbitrary macro/function ECHCK as the second
parameter for validating the FUNC return value.
- The loop will end succesfully if ECHCK(ret) evaluates to non-zero.
- The loop will fall through on timeout instead of calling tst_brk().
- errno will be cleared before every FUNC call.
- Add standard check macros for the most common call conventions:
  - TST_RETVAL_EQ0(x) - x == 0
  - TST_RETVAL_NOTNULL(x) - x != 0 or x != NULL
  - TST_RETVAL_GE0(x) - x >= 0

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Everything in this patch. Redesign TST_RETRY_FUNC() instead
of adding a copy with slightly different functionality.

Changes since v2: Added documentation for new TST_RETRY_FUNC() behavior

 doc/test-writing-guidelines.txt             | 61 ++++++++++++++++-----
 include/tst_common.h                        | 45 ++++++++++-----
 testcases/kernel/syscalls/tgkill/tgkill03.c |  8 ++-
 3 files changed, 86 insertions(+), 28 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index bfc3b5554..973b2c0a2 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2317,30 +2317,63 @@ that can sleep for defined amount of seconds, milliseconds or microseconds.
 tst_sleep 100ms
 -------------------------------------------------------------------------------
 
-Retry a function in limited time
-++++++++++++++++++++++++++++++++
-
-Sometimes LTP test needs retrying a function for many times to get success.
-This achievement makes that possible via keeping it retrying if the return
-value of the function is NOT as we expected. After exceeding a limited time,
-test will break from the retries immediately. The time limit is multiplied
-with LTP_TIMEOUT_MUL.
+Retry a function call multiple times
+++++++++++++++++++++++++++++++++++++
+
+Sometimes your LTP test needs to retry a function call multiple times because
+the system is not ready to process it successfully on the first try. The LTP
+library has some useful tools to handle call retrying automatically.
+'TST_RETRY_FUNC()' will keep retrying for up to 1 second. If you want a custom
+time limit, use 'TST_RETRY_FN_EXP_BACKOFF()'. Both methods return the value
+returned by the last 'FUNC' call.
+
+The delay between retries starts at 1 microsecond and doubles after each call.
+The retry loop ends when the function call succeeds or the next delay exceeds
+the specified time (1 second for 'TST_RETRY_FUNC()'). The maximum delay is
+multiplied by TST_TIMEOUT_MUL. The total cumulative delay may be up to twice
+as long as the adjusted maximum delay.
+
+The C version of 'TST_RETRY_FUNC()' is a macro which takes two arguments:
+
+* 'FUNC' is the complete function call with arguments which should be retried
+  multiple times.
+* 'SUCCESS_CHECK' is a macro or function which will validate 'FUNC' return
+  value. 'FUNC' call was successful if 'SUCCESS_CHECK(ret)' evaluates to
+  non-zero.
+
+Both retry methods clear 'errno' before every 'FUNC' call so your
+'SUCCESS_CHECK' can look for specific error codes as well. The LTP library
+also includes predefined 'SUCCESS_CHECK' macros for the most common call
+conventions:
+
+* 'TST_RETVAL_EQ0()' - The call was successful if 'FUNC' returned 0 or NULL
+* 'TST_RETVAL_NOTNULL()' - The call was successful if 'FUNC' returned any
+  value other than 0 or NULL.
+* 'TST_RETVAL_GE0()' - The call was successful if 'FUNC' returned value >= 0.
 
 [source,c]
 -------------------------------------------------------------------------------
-# retry function in 1 second
-TST_RETRY_FUNC(FUNC, EXPECTED_RET)
+/* Keep trying for 1 second */
+TST_RETRY_FUNC(FUNC, SUCCESS_CHECK)
 
-# retry function in N second
-TST_RETRY_FN_EXP_BACKOFF(FUNC, EXPECTED_RET, N)
+/* Keep trying for up to 2*N seconds */
+TST_RETRY_FN_EXP_BACKOFF(FUNC, SUCCESS_CHECK, N)
 -------------------------------------------------------------------------------
 
+The shell version of 'TST_RETRY_FUNC()' is simpler and takes slightly
+different arguments:
+
+* 'FUNC' is a string containing the complete function or program call with
+  arguments.
+* 'EXPECTED_RET' is a single expected return value. 'FUNC' call was successful
+  if the return value is equal to EXPECTED_RET.
+
 [source,sh]
 -------------------------------------------------------------------------------
-# retry function in 1 second
+# Keep trying for 1 second
 TST_RETRY_FUNC "FUNC arg1 arg2 ..." "EXPECTED_RET"
 
-# retry function in N second
+# Keep trying for up to 2*N seconds
 TST_RETRY_FN_EXP_BACKOFF "FUNC arg1 arg2 ..." "EXPECTED_RET" "N"
 -------------------------------------------------------------------------------
 
diff --git a/include/tst_common.h b/include/tst_common.h
index a0c06a3f7..5c09fea7f 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -26,35 +26,54 @@
 /**
  * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
  * @FUNC - The function which will be retried
- * @ERET - The value returned from @FUNC on success
+ * @ECHCK - Function/macro for validating @FUNC return value
  *
- * This macro will call @FUNC in a loop with a delay between retries. If @FUNC
- * returns @ERET then the loop exits. The delay between retries starts at one
- * micro second and is then doubled each iteration until it exceeds one second
- * (the total time sleeping will be approximately one second as well). When the
- * delay exceeds one second tst_brk() is called.
+ * This macro will call @FUNC in a loop with a delay between retries.
+ * If ECHCK(ret) evaluates to non-zero, the loop ends. The delay between
+ * retries starts at one microsecond and is then doubled each iteration until
+ * it exceeds one second (the total time sleeping will be approximately one
+ * second as well). When the delay exceeds one second, the loop will end.
+ * The TST_RETRY_FUNC() macro returns the last value returned by @FUNC.
  */
-#define TST_RETRY_FUNC(FUNC, ERET) \
-	TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, 1)
+#define TST_RETRY_FUNC(FUNC, ECHCK) \
+	TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, 1)
 
-#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)	\
+#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, MAX_DELAY)	\
 ({	unsigned int tst_delay_, tst_max_delay_;			\
+	typeof(FUNC) tst_ret_;						\
 	tst_delay_ = 1;							\
 	tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);	\
 	for (;;) {							\
-		typeof(FUNC) tst_ret_ = FUNC;				\
-		if (tst_ret_ == ERET)					\
+		errno = 0;						\
+		tst_ret_ = FUNC;					\
+		if (ECHCK(tst_ret_))					\
 			break;						\
 		if (tst_delay_ < tst_max_delay_) {			\
 			usleep(tst_delay_);				\
 			tst_delay_ *= 2;				\
 		} else {						\
-			tst_brk(TBROK, #FUNC" timed out");		\
+			break;						\
 		}							\
 	}								\
-	ERET;								\
+	tst_ret_;								\
 })
 
+/*
+ * Return value validation macros for TST_RETRY_FUNC():
+ * TST_RETVAL_EQ0() - Check that value is equal to zero
+ */
+#define TST_RETVAL_EQ0(x) (!(x))
+
+/*
+ * TST_RETVAL_NOTNULL() - Check that value is not equal to zero/NULL
+ */
+#define TST_RETVAL_NOTNULL(x) (!!(x))
+
+/*
+ * TST_RETVAL_GE0() - Check that value is greater than or equal to zero
+ */
+#define TST_RETVAL_GE0(x) ((x) >= 0)
+
 #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
 	do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
 
diff --git a/testcases/kernel/syscalls/tgkill/tgkill03.c b/testcases/kernel/syscalls/tgkill/tgkill03.c
index 593a21726..0002f3278 100644
--- a/testcases/kernel/syscalls/tgkill/tgkill03.c
+++ b/testcases/kernel/syscalls/tgkill/tgkill03.c
@@ -14,6 +14,8 @@
 #include "tst_test.h"
 #include "tgkill.h"
 
+#define CHECK_ENOENT(x) ((x) == -1 && errno == ENOENT)
+
 static pthread_t child_thread;
 
 static pid_t parent_tgid;
@@ -44,6 +46,7 @@ static void setup(void)
 	sigset_t sigusr1;
 	pthread_t defunct_thread;
 	char defunct_tid_path[PATH_MAX];
+	int ret;
 
 	sigemptyset(&sigusr1);
 	sigaddset(&sigusr1, SIGUSR1);
@@ -59,7 +62,10 @@ static void setup(void)
 	SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func, NULL);
 	SAFE_PTHREAD_JOIN(defunct_thread, NULL);
 	sprintf(defunct_tid_path, "/proc/%d/task/%d", getpid(), defunct_tid);
-	TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK), -1, 15);
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK),
+		CHECK_ENOENT, 15);
+	if (!CHECK_ENOENT(ret))
+		tst_brk(TBROK, "Timeout, %s still exists", defunct_tid_path);
 }
 
 static void cleanup(void)
-- 
2.25.0

