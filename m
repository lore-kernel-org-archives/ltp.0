From: Eric Biggers <ebiggers@kernel.org>
Date: Tue,  9 Jul 2019 11:42:02 -0700
Subject: [LTP] [PATCH] crypto/crypto_user02.c: new test that tries to delete
 larval algorithm
Message-ID: <20190709184202.25112-1-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Test for a bug in the crypto user configuration API (NETLINK_CRYPTO)
where it incorrectly allowed operating on "larval" algorithms.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/crypto                          |   1 +
 testcases/kernel/crypto/.gitignore      |   1 +
 testcases/kernel/crypto/Makefile        |   2 +
 testcases/kernel/crypto/crypto_user02.c | 108 ++++++++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 testcases/kernel/crypto/crypto_user02.c

diff --git a/runtest/crypto b/runtest/crypto
index ad713c5edf..be8bc81d2f 100644
--- a/runtest/crypto
+++ b/runtest/crypto
@@ -6,3 +6,4 @@ af_alg05 af_alg05
 af_alg06 af_alg06
 pcrypt_aead01 pcrypt_aead01
 crypto_user01 crypto_user01
+crypto_user02 crypto_user02
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index 7340bde293..c5be01180c 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -6,3 +6,4 @@ af_alg05
 af_alg06
 pcrypt_aead01
 crypto_user01
+crypto_user02
diff --git a/testcases/kernel/crypto/Makefile b/testcases/kernel/crypto/Makefile
index 6547e1cb63..7cbdb72d19 100644
--- a/testcases/kernel/crypto/Makefile
+++ b/testcases/kernel/crypto/Makefile
@@ -22,3 +22,5 @@ CFLAGS			+= -D_GNU_SOURCE
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 af_alg02: CFLAGS += -pthread
+
+crypto_user02: LDLIBS += -lrt
diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
new file mode 100644
index 0000000000..6090b5a4ea
--- /dev/null
+++ b/testcases/kernel/crypto/crypto_user02.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Regression test for kernel commit 21d4120ec6f5 ("crypto: user - prevent
+ * operating on larval algorithms").  See the commit message for a detailed
+ * explanation of the problem.  Basically, this test tries to cause a NULL
+ * pointer dereference in the kernel by abusing the CRYPTO_MSG_DELALG message in
+ * the NETLINK_CRYPTO interface to try to delete a "larval" algorithm, which is
+ * a kernel-internal marker for an algorithm which has been registered but isn't
+ * ready yet (e.g., hasn't completed the in-kernel crypto self-tests yet).
+ *
+ * CRYPTO_MSG_NEWALG will create such a larval algorithm.  However, it waits
+ * (killably) for the larval to mature before returning, and it holds a lock
+ * that prevents CRYPTO_MSG_DELALG from running.  To get around this, this test
+ * sends a fatal signal to the process executing CRYPTO_MSG_NEWALG.
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_crypto.h"
+#include "tst_timer.h"
+
+static struct tst_crypto_session ses = TST_CRYPTO_SESSION_INIT;
+
+static void setup(void)
+{
+	tst_crypto_open(&ses);
+}
+
+static void run(void)
+{
+	struct crypto_user_alg alg = {
+		/*
+		 * Any algorithm instantiated from a template can do here, but
+		 * choose something that's commonly available.
+		 */
+		.cru_driver_name = "hmac(sha256-generic)",
+	};
+	pid_t pid;
+	int status;
+
+	/* Check whether the algorithm is supported before continuing. */
+	TEST(tst_crypto_add_alg(&ses, &alg));
+	if (TST_RET != 0 && TST_RET != -EEXIST) {
+		if (TST_RET == -ENOENT)
+			tst_brk(TCONF, "%s not supported", alg.cru_driver_name);
+
+		tst_brk(TBROK | TRERRNO,
+			"unexpected error checking for algorithm support");
+	}
+
+	tst_res(TINFO,
+		"Starting crypto_user larval deletion test.  May crash buggy kernels.");
+
+	tst_timer_start(CLOCK_MONOTONIC);
+
+	while (!tst_timer_expired_ms(1000)) {
+		pid = SAFE_FORK();
+
+		if (pid == 0) {
+			/* Child process: execute CRYPTO_MSG_NEWALG. */
+			tst_crypto_open(&ses);
+			for (;;) {
+				TEST(tst_crypto_add_alg(&ses, &alg));
+				if (TST_RET && TST_RET != -EEXIST)
+					tst_brk(TBROK | TRERRNO,
+						"unexpected error from tst_crypto_add_alg()");
+			}
+		}
+
+		/*
+		 * Parent process: kill the child process (hopefully while it's
+		 * executing CRYPTO_MSG_NEWALG) and execute CRYPTO_MSG_DELALG.
+		 * Buggy kernels sometimes dereferenced a NULL pointer during
+		 * CRYPTO_MSG_DELALG here.
+		 */
+		usleep(rand() % 5000);
+		kill(pid, SIGKILL);
+		SAFE_WAIT(&status);
+		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+			tst_brk(TBROK, "child %s", tst_strstatus(status));
+		TEST(tst_crypto_del_alg(&ses, &alg));
+		if (TST_RET && TST_RET != -ENOENT)
+			tst_brk(TBROK | TRERRNO,
+				"unexpected error from tst_crypto_del_alg()");
+	}
+
+	tst_res(TPASS, "didn't crash");
+}
+
+static void cleanup(void)
+{
+	tst_crypto_close(&ses);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.22.0

