From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 13:12:49 +0300
Subject: [LTP] [PATCH v2] crypto/af_alg02: thread termination fixes
Message-ID: <20210720101249.10118-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On musl, pthread_kill() doesn't return ESRCH if thread id is not found
(POSIX only recommends to return ESRCH). Use tst_atomic_store/load()
instead, when waiting for the thread.

Also, the thread's resources wasn't properly freed after the run(),
so adding pthread_join() should fix that.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
v2: convert pthread_tryjoin_np() into atomic_load/store() + pthread_join()

 testcases/kernel/crypto/af_alg02.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index 31d30777c..5863fd26b 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -18,11 +18,13 @@
 #include "tst_test.h"
 #include "tst_af_alg.h"
 #include "tst_safe_pthread.h"
+#include "tst_atomic.h"
 #include <pthread.h>
 #include <errno.h>
 
 #define SALSA20_IV_SIZE       8
 #define SALSA20_MIN_KEY_SIZE  16
+static int completed;
 
 static void *verify_encrypt(void *arg)
 {
@@ -48,19 +50,21 @@ static void *verify_encrypt(void *arg)
 		tst_res(TPASS, "Successfully \"encrypted\" an empty message");
 	else
 		tst_res(TFAIL, "read() didn't return 0");
+
+	tst_atomic_store(1, &completed);
 	return arg;
 }
 
 static void run(void)
 {
 	pthread_t thr;
-
+	tst_atomic_store(0, &completed);
 	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
 	SAFE_PTHREAD_CREATE(&thr, NULL, verify_encrypt, NULL);
 
 	TST_CHECKPOINT_WAIT(0);
 
-	while (pthread_kill(thr, 0) != ESRCH) {
+	while (!tst_atomic_load(&completed)) {
 		if (tst_timeout_remaining() <= 10) {
 			pthread_cancel(thr);
 			tst_brk(TBROK,
@@ -68,6 +72,7 @@ static void run(void)
 		}
 		usleep(1000);
 	}
+	pthread_join(thr, NULL);
 }
 
 static struct tst_test test = {
-- 
2.25.1

