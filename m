From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 18 Mar 2019 10:13:23 -0700
Subject: [LTP] [PATCH v2 2/6] crypto/af_alg01: new regression test for hmac
	nesting bug
In-Reply-To: <20190318171327.237014-1-ebiggers@kernel.org>
References: <20190318171327.237014-1-ebiggers@kernel.org>
Message-ID: <20190318171327.237014-3-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/crypto                     |  1 +
 runtest/cve                        |  1 +
 testcases/kernel/crypto/.gitignore |  1 +
 testcases/kernel/crypto/af_alg01.c | 78 ++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 testcases/kernel/crypto/af_alg01.c

diff --git a/runtest/crypto b/runtest/crypto
index cdbc44cc8..45c8cdd2d 100644
--- a/runtest/crypto
+++ b/runtest/crypto
@@ -1,2 +1,3 @@
+af_alg01 af_alg01
 pcrypt_aead01 pcrypt_aead01
 crypto_user01 crypto_user01
diff --git a/runtest/cve b/runtest/cve
index 8f38045e9..f46c400cc 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -27,6 +27,7 @@ cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
 cve-2017-15649 fanout01
 cve-2017-15951 request_key03 -b cve-2017-15951
+cve-2017-17806 af_alg01
 cve-2017-17807 request_key04
 cve-2017-1000364 stack_clash
 cve-2017-5754 meltdown
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index 759592fbd..998af1728 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -1,2 +1,3 @@
+af_alg01
 pcrypt_aead01
 crypto_user01
diff --git a/testcases/kernel/crypto/af_alg01.c b/testcases/kernel/crypto/af_alg01.c
new file mode 100644
index 000000000..1ce0e2508
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg01.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Regression test for commit af3ff8045bbf ("crypto: hmac - require that the
+ * underlying hash algorithm is unkeyed"), or CVE-2017-17806.  This test
+ * verifies that the hmac template cannot be nested inside itself.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+
+static void test_with_hash_alg(const char *hash_algname)
+{
+	char hmac_algname[64];
+	char key[4096] = { 0 };
+
+	if (!tst_have_alg("hash", hash_algname)) {
+		tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
+			hash_algname);
+		return;
+	}
+	sprintf(hmac_algname, "hmac(%s)", hash_algname);
+	if (!tst_have_alg("hash", hmac_algname)) {
+		tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
+			hmac_algname);
+		return;
+	}
+
+	sprintf(hmac_algname, "hmac(hmac(%s))", hash_algname);
+	if (tst_have_alg("hash", hmac_algname)) {
+		int algfd;
+
+		tst_res(TFAIL, "instantiated nested hmac algorithm ('%s')!",
+			hmac_algname);
+
+		/*
+		 * Be extra annoying; with the bug, setting a key on
+		 * "hmac(hmac(sha3-256-generic))" crashed the kernel.
+		 */
+		algfd = tst_alg_setup("hash", hmac_algname, NULL, 0);
+		if (setsockopt(algfd, SOL_ALG, ALG_SET_KEY,
+			       key, sizeof(key)) == 0) {
+			tst_res(TFAIL,
+				"set key on nested hmac algorithm ('%s')!",
+				hmac_algname);
+		}
+	} else {
+		tst_res(TPASS,
+			"couldn't instantiate nested hmac algorithm ('%s')",
+			hmac_algname);
+	}
+}
+
+/* try several different unkeyed hash algorithms */
+static const char * const hash_algs[] = {
+	"md5", "md5-generic",
+	"sha1", "sha1-generic",
+	"sha224", "sha224-generic",
+	"sha256", "sha256-generic",
+	"sha3-256", "sha3-256-generic",
+	"sha3-512", "sha3-512-generic",
+};
+
+static void do_test(unsigned int i)
+{
+	test_with_hash_alg(hash_algs[i]);
+}
+
+static struct tst_test test = {
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(hash_algs),
+};
-- 
2.21.0.225.g810b269d1ac-goog

