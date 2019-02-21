From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 20 Feb 2019 21:30:23 -0800
Subject: [LTP] [PATCH 3/6] crypto/af_alg02: new regression test for salsa20
	empty message bug
In-Reply-To: <20190221053026.18489-1-ebiggers@kernel.org>
References: <20190221053026.18489-1-ebiggers@kernel.org>
Message-ID: <20190221053026.18489-4-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/cve                        |  1 +
 testcases/kernel/crypto/.gitignore |  1 +
 testcases/kernel/crypto/af_alg02.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 testcases/kernel/crypto/af_alg02.c

diff --git a/runtest/cve b/runtest/cve
index f46c400cc4..031bcdc2a7 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -27,6 +27,7 @@ cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
 cve-2017-15649 fanout01
 cve-2017-15951 request_key03 -b cve-2017-15951
+cve-2017-17805 af_alg02
 cve-2017-17806 af_alg01
 cve-2017-17807 request_key04
 cve-2017-1000364 stack_clash
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index 998af17284..dc79f3275b 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -1,3 +1,4 @@
 af_alg01
+af_alg02
 pcrypt_aead01
 crypto_user01
diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
new file mode 100644
index 0000000000..a9e8204230
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Regression test for commit ecaaab564978 ("crypto: salsa20 - fix
+ * blkcipher_walk API usage"), or CVE-2017-17805.  This test verifies that an
+ * empty message can be encrypted with Salsa20 without crashing the kernel.
+ */
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+
+static void run(void)
+{
+	char buf[16];
+	int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20", NULL, 16);
+
+	/* With the bug the kernel crashed here */
+	if (read(reqfd, buf, 16) == 0)
+		tst_res(TPASS, "Successfully \"encrypted\" an empty message");
+	else
+		tst_res(TBROK, "read() didn't return 0");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.20.1

