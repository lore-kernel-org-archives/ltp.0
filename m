From: Christian Amann <camann@suse.com>
Date: Wed,  8 May 2019 09:16:36 +0200
Subject: [LTP] [PATCH v3] crypto/af_alg02: fixed read() being stuck
Message-ID: <20190508071636.13804-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On kernels < 4.14 (missing commit 2d97591ef43d) reading from
the request socket does not return and the testcase does not
finish.

This fix moves the logic to a child thread in order for the
parent to handle the timeout and report a message to the user.

Signed-off-by: Christian Amann <camann@suse.com>
---

Notes:
    Hi Li,
    
    > We could set LTP_ATTRIBUTE_UNUSED at the behind of unused parameter to get
    > rid of compiling warning
    
    Thats very useful but I couldn't find it anywhere in the documentation.
    IMHO it should be put in there, because I stumbled upon this problem
    a couple of times.
    
    Anyway, I implemented your suggestions. I hope it's an alright patch now.
    Thanks for your feedback!
    
    Regards,
    Christian

 testcases/kernel/crypto/Makefile   |  2 ++
 testcases/kernel/crypto/af_alg02.c | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/crypto/Makefile b/testcases/kernel/crypto/Makefile
index 76f9308c2..6547e1cb6 100644
--- a/testcases/kernel/crypto/Makefile
+++ b/testcases/kernel/crypto/Makefile
@@ -20,3 +20,5 @@ include $(top_srcdir)/include/mk/testcases.mk
 CFLAGS			+= -D_GNU_SOURCE
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+af_alg02: CFLAGS += -pthread
diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index a9e820423..1c725212a 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -7,23 +7,56 @@
  * Regression test for commit ecaaab564978 ("crypto: salsa20 - fix
  * blkcipher_walk API usage"), or CVE-2017-17805.  This test verifies that an
  * empty message can be encrypted with Salsa20 without crashing the kernel.
+ *
+ * Fix for kernels < 4.14:
+ * With kernels missing commit 2d97591ef43d ("crypto: af_alg - consolidation
+ * of duplicate code") read() does not return in this situation. The call is
+ * now moved to a child thread in order to cancel it in case read() takes an
+ * unusual long amount of time.
  */
 
 #include "tst_test.h"
 #include "tst_af_alg.h"
+#include "tst_safe_pthread.h"
+#include <pthread.h>
+#include <errno.h>
 
-static void run(void)
+void *verify_encrypt(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	char buf[16];
 	int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20", NULL, 16);
 
+	TST_CHECKPOINT_WAKE(0);
+
 	/* With the bug the kernel crashed here */
 	if (read(reqfd, buf, 16) == 0)
 		tst_res(TPASS, "Successfully \"encrypted\" an empty message");
 	else
-		tst_res(TBROK, "read() didn't return 0");
+		tst_res(TFAIL, "read() didn't return 0");
+	return arg;
+}
+
+static void run(void)
+{
+	pthread_t thr;
+
+	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+	SAFE_PTHREAD_CREATE(&thr, NULL, verify_encrypt, NULL);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	while (pthread_kill(thr, 0) != ESRCH) {
+		if (tst_timeout_remaining() <= 10) {
+			pthread_cancel(thr);
+			tst_brk(TBROK,
+				"Timed out while reading from request socket.");
+		}
+		usleep(1000);
+	}
 }
 
 static struct tst_test test = {
 	.test_all = run,
+	.timeout = 20,
+	.needs_checkpoints = 1,
 };
-- 
2.16.4

