From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 22 Apr 2019 11:01:23 -0700
Subject: [LTP] [PATCH] crypto/af_alg06: new regression test for setting
	malformed authenc key
Message-ID: <20190422180123.107038-1-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Test for a bug where the kernel crashed if a malformed key was set on an
instance of the "authenc" crypto algorithm.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/crypto                     |  1 +
 testcases/kernel/crypto/.gitignore |  1 +
 testcases/kernel/crypto/af_alg06.c | 50 ++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 testcases/kernel/crypto/af_alg06.c

diff --git a/runtest/crypto b/runtest/crypto
index 41ea7b81c..ad713c5ed 100644
--- a/runtest/crypto
+++ b/runtest/crypto
@@ -3,5 +3,6 @@ af_alg02 af_alg02
 af_alg03 af_alg03
 af_alg04 af_alg04
 af_alg05 af_alg05
+af_alg06 af_alg06
 pcrypt_aead01 pcrypt_aead01
 crypto_user01 crypto_user01
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index 17faf3eef..7340bde29 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -3,5 +3,6 @@ af_alg02
 af_alg03
 af_alg04
 af_alg05
+af_alg06
 pcrypt_aead01
 crypto_user01
diff --git a/testcases/kernel/crypto/af_alg06.c b/testcases/kernel/crypto/af_alg06.c
new file mode 100644
index 000000000..fa4daede1
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg06.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Regression test for commit 8f9c46934848 ("crypto: authenc - fix parsing key
+ * with misaligned rta_len").  Based on the reproducer from the commit message.
+ */
+
+#include <errno.h>
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+
+/*
+ * include after <sys/socket.h> (via tst_test.h), to work around dependency bug
+ * in old kernel headers (https://www.spinics.net/lists/netdev/msg171764.html)
+ */
+#include <linux/rtnetlink.h>
+
+static void run(void)
+{
+	struct {
+		struct rtattr attr;
+		uint32_t enckeylen;
+		char keys[1];
+	} __attribute__((packed)) key = {
+		.attr.rta_len = sizeof(key),
+		.attr.rta_type = 1 /* CRYPTO_AUTHENC_KEYA_PARAM */,
+	};
+	int algfd;
+
+	algfd = tst_alg_setup("aead", "authenc(hmac(sha256),cbc(aes))",
+			      NULL, 0);
+	tst_res(TINFO,
+		"Setting malformed authenc key.  May crash buggy kernels.");
+	TEST(setsockopt(algfd, SOL_ALG, ALG_SET_KEY, &key, sizeof(key)));
+	if (TST_RET == 0)
+		tst_res(TFAIL, "setting malformed key unexpectedly succeeded");
+	else if (TST_ERR != EINVAL)
+		tst_res(TFAIL | TTERRNO,
+			"setting malformed key failed with unexpected error");
+	else
+		tst_res(TPASS, "didn't crash, and got EINVAL as expected");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.21.0.593.g511ec345e18-goog

