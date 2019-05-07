From: Christian Amann <camann@suse.com>
Date: Tue,  7 May 2019 08:55:30 +0200
Subject: [LTP] [PATCH v1] crypto/af_alg02: fixed read() being stuck
Message-ID: <20190507065530.12174-1-camann@suse.com>
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
 testcases/kernel/crypto/Makefile   |  2 ++
 testcases/kernel/crypto/af_alg02.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

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
index a9e820423..056511993 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -7,12 +7,23 @@
  * Regression test for commit ecaaab564978 ("crypto: salsa20 - fix
  * blkcipher_walk API usage"), or CVE-2017-17805.  This test verifies that an
  * empty message can be encrypted with Salsa20 without crashing the kernel.
+ *
+ * read() fix:
+ * Calls read() in child thread in order to manually kill it after timeout.
+ * With kernels missing commit 2d97591ef43d ("crypto: af_alg - consolidation
+ * of duplicate code") read() does not return.
  */
 
 #include "tst_test.h"
 #include "tst_af_alg.h"
+#include "tst_safe_pthread.h"
+#include <pthread.h>
+#include <time.h>
+#include <errno.h>
 
-static void run(void)
+#define VERIFY_TIMEOUT (time(NULL) + 5)
+
+void *verify_encrypt(void *arg)
 {
 	char buf[16];
 	int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20", NULL, 16);
@@ -22,6 +33,29 @@ static void run(void)
 		tst_res(TPASS, "Successfully \"encrypted\" an empty message");
 	else
 		tst_res(TBROK, "read() didn't return 0");
+	return arg;
+}
+
+static void run(void)
+{
+	pthread_t thr;
+	int join_ret;
+	struct timespec read_timeout;
+
+	read_timeout.tv_sec  = VERIFY_TIMEOUT;
+	read_timeout.tv_nsec = 0;
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, verify_encrypt, NULL);
+	join_ret = pthread_timedjoin_np(thr, NULL, &read_timeout);
+
+	if (join_ret != 0) {
+		if (join_ret == ETIMEDOUT)
+			tst_brk(TBROK,
+				"Timed out while reading from request socket.");
+		else
+			tst_brk(TBROK | TTERRNO,
+				"Error while joining child thread");
+	}
 }
 
 static struct tst_test test = {
-- 
2.16.4

