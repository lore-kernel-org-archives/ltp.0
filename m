From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 18 Mar 2019 10:13:27 -0700
Subject: [LTP] [PATCH v2 6/6] crypto/af_alg05: new regression test for
	skcipher_walk error bug
In-Reply-To: <20190318171327.237014-1-ebiggers@kernel.org>
References: <20190318171327.237014-1-ebiggers@kernel.org>
Message-ID: <20190318171327.237014-7-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/crypto                     |  1 +
 testcases/kernel/crypto/.gitignore |  1 +
 testcases/kernel/crypto/af_alg05.c | 43 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 testcases/kernel/crypto/af_alg05.c

diff --git a/runtest/crypto b/runtest/crypto
index b6180c417..41ea7b81c 100644
--- a/runtest/crypto
+++ b/runtest/crypto
@@ -2,5 +2,6 @@ af_alg01 af_alg01
 af_alg02 af_alg02
 af_alg03 af_alg03
 af_alg04 af_alg04
+af_alg05 af_alg05
 pcrypt_aead01 pcrypt_aead01
 crypto_user01 crypto_user01
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index df6b7e73c..17faf3eef 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -2,5 +2,6 @@ af_alg01
 af_alg02
 af_alg03
 af_alg04
+af_alg05
 pcrypt_aead01
 crypto_user01
diff --git a/testcases/kernel/crypto/af_alg05.c b/testcases/kernel/crypto/af_alg05.c
new file mode 100644
index 000000000..419c65eab
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg05.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Regression test for commit 8088d3dd4d7c ("crypto: skcipher - fix crash
+ * flushing dcache in error path").  This test verifies the kernel doesn't crash
+ * when trying to encrypt a message with size not aligned to the block cipher's
+ * block size, and where the destination buffer starts exactly at a page
+ * boundary.  Based on the reproducer from the commit message.  Note that this
+ * issue only reproduces on certain architectures, such as arm and arm64.
+ */
+
+#include <errno.h>
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+
+static void run(void)
+{
+	char buffer[4096] __attribute__((aligned(4096))) = { 0 };
+	int reqfd;
+
+	reqfd = tst_alg_setup_reqfd("skcipher", "cbc(aes-generic)", NULL, 16);
+
+	SAFE_WRITE(1, reqfd, buffer, 15);
+	/* with the bug, this crashed the kernel on some architectures */
+	TEST(read(reqfd, buffer, 15));
+
+	if (TST_RET == 0)
+		tst_res(TBROK, "read() unexpectedly succeeded");
+	else if (TST_ERR == EINVAL)
+		tst_res(TPASS, "read() expectedly failed with EINVAL");
+	else
+		tst_res(TBROK | TTERRNO, "read() failed with unexpected error");
+
+	close(reqfd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.21.0.225.g810b269d1ac-goog

