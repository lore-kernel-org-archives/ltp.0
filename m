From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 20 Feb 2019 21:30:24 -0800
Subject: [LTP] [PATCH 4/6] crypto/af_alg03: new regression test for rfc7539
	hash alg validation
In-Reply-To: <20190221053026.18489-1-ebiggers@kernel.org>
References: <20190221053026.18489-1-ebiggers@kernel.org>
Message-ID: <20190221053026.18489-5-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 testcases/kernel/crypto/.gitignore |  1 +
 testcases/kernel/crypto/af_alg03.c | 31 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 testcases/kernel/crypto/af_alg03.c

diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index dc79f3275b..3e7936fc94 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -1,4 +1,5 @@
 af_alg01
 af_alg02
+af_alg03
 pcrypt_aead01
 crypto_user01
diff --git a/testcases/kernel/crypto/af_alg03.c b/testcases/kernel/crypto/af_alg03.c
new file mode 100644
index 0000000000..240c52835f
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg03.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Regression test for commit e57121d08c38 ("crypto: chacha20poly1305 - validate
+ * the digest size").  This test verifies that the rfc7539 template can't be
+ * instantiated with a hash algorithm whose digest size is not 16 bytes.
+ */
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+
+static void run(void)
+{
+	tst_require_alg("aead", "rfc7539(chacha20,poly1305)");
+	tst_require_alg("hash", "sha256");
+
+	if (tst_have_alg("aead", "rfc7539(chacha20,sha256)")) {
+		tst_res(TFAIL,
+			"instantiated rfc7539 template with wrong digest size");
+	} else {
+		tst_res(TPASS,
+			"couldn't instantiate rfc7539 template with wrong digest size");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.20.1

