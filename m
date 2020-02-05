From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Feb 2020 15:25:16 +0100
Subject: [LTP] [PATCH 1/2] Add TST_SPIN_TEST() macro
In-Reply-To: <20200203113956.13176-1-mdoucha@suse.cz>
References: <20200203113956.13176-1-mdoucha@suse.cz>
Message-ID: <20200205142515.GB30186@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_common.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/tst_common.h b/include/tst_common.h
> index a0c06a3f7..72e00ca81 100644
> --- a/include/tst_common.h
> +++ b/include/tst_common.h
> @@ -55,6 +55,34 @@
>  	ERET;								\
>  })
>  
> +/**
> + * TST_SPIN_TEST() - Repeatedly retry a function with an increasing delay.
> + * @FUNC - The function which will be retried
> + *
> + * Same as TST_RETRY_FUNC() but any non-negative return value is accepted
> + * as success and tst_brk() will not be called on timeout.
> + */
> +#define TST_SPIN_TEST(FUNC) \
> +	TST_SPIN_TEST_EXP_BACKOFF(FUNC, 1, -1)
> +
> +#define TST_SPIN_TEST_EXP_BACKOFF(FUNC, MAX_DELAY, GOOD_ERRNO)	\
> +({	unsigned int tst_delay_, tst_max_delay_;			\
> +	tst_delay_ = 1;							\
> +	tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);	\
> +	for (;;) {							\
> +		TEST(FUNC);						\
> +		if (TST_RET >= 0 || (GOOD_ERRNO >= 0 && TST_ERR == GOOD_ERRNO))	\
> +			break;						\
> +		if (tst_delay_ < tst_max_delay_) {			\
> +			usleep(tst_delay_);				\
> +			tst_delay_ *= 2;				\
> +		} else {						\
> +			break;						\
> +		}							\
> +	}								\
> +	TST_RET;							\
> +})

This looks like we will end up adding more specialized variants over
time, I do wonder if we can make one generic implementation. It would
probably make more sense to pass a function that converts the FUNC
output into boolean instead.

Something as:

diff --git a/include/tst_common.h b/include/tst_common.h
index a0c06a3f7..b7c644d0d 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -34,25 +34,26 @@
  * (the total time sleeping will be approximately one second as well). When the
  * delay exceeds one second tst_brk() is called.
  */
-#define TST_RETRY_FUNC(FUNC, ERET) \
-	TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, 1)
+#define TST_RETRY_FUNC(FUNC, ECHCK) \
+	TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, 1)
 
-#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)	\
+#define TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, MAX_DELAY)		\
 ({	unsigned int tst_delay_, tst_max_delay_;			\
 	tst_delay_ = 1;							\
 	tst_max_delay_ = tst_multiply_timeout(MAX_DELAY * 1000000);	\
+	typeof(FUNC) tst_ret_;                                          \
 	for (;;) {							\
-		typeof(FUNC) tst_ret_ = FUNC;				\
-		if (tst_ret_ == ERET)					\
+		tst_ret_ = FUNC;					\
+		if (ECHCK(tst_ret_))					\
 			break;						\
 		if (tst_delay_ < tst_max_delay_) {			\
 			usleep(tst_delay_);				\
 			tst_delay_ *= 2;				\
 		} else {						\
-			tst_brk(TBROK, #FUNC" timed out");		\
+			break;                                          \
 		}							\
 	}								\
-	ERET;								\
+	tst_ret_;							\
 })
 
 #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
diff --git a/testcases/kernel/syscalls/tgkill/tgkill03.c b/testcases/kernel/syscalls/tgkill/tgkill03.c
index 593a21726..a303d0c9c 100644
--- a/testcases/kernel/syscalls/tgkill/tgkill03.c
+++ b/testcases/kernel/syscalls/tgkill/tgkill03.c
@@ -39,11 +39,14 @@ static void *defunct_thread_func(void *arg)
 	return arg;
 }
 
+#define HAS_FAILED(x) ((x) == -1)
+
 static void setup(void)
 {
 	sigset_t sigusr1;
 	pthread_t defunct_thread;
 	char defunct_tid_path[PATH_MAX];
+	int ret;
 
 	sigemptyset(&sigusr1);
 	sigaddset(&sigusr1, SIGUSR1);
@@ -59,7 +62,9 @@ static void setup(void)
 	SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func, NULL);
 	SAFE_PTHREAD_JOIN(defunct_thread, NULL);
 	sprintf(defunct_tid_path, "/proc/%d/task/%d", getpid(), defunct_tid);
-	TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK), -1, 15);
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK), HAS_FAILED, 1);
+	if (!HAS_FAILED(ret))
+		tst_brk(TBROK, "Timeout %s still exists", defunct_tid_path);
 }
 
 static void cleanup(void)

Also I do not like that we are using the TEST() macro inside of an
macro, that may lead to unexpected consequencies. The TST_RET and
TST_ERR should not change unless user used TEST() macro explicitely.

-- 
Cyril Hrubis
chrubis@suse.cz
