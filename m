From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 20 Feb 2019 21:30:25 -0800
Subject: [LTP] [PATCH 5/6] crypto/af_alg04: new regression test for vmac
	race conditions
In-Reply-To: <20190221053026.18489-1-ebiggers@kernel.org>
References: <20190221053026.18489-1-ebiggers@kernel.org>
Message-ID: <20190221053026.18489-6-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 testcases/kernel/crypto/.gitignore |  1 +
 testcases/kernel/crypto/af_alg04.c | 56 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 testcases/kernel/crypto/af_alg04.c

diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index 3e7936fc94..df6b7e73cb 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -1,5 +1,6 @@
 af_alg01
 af_alg02
 af_alg03
+af_alg04
 pcrypt_aead01
 crypto_user01
diff --git a/testcases/kernel/crypto/af_alg04.c b/testcases/kernel/crypto/af_alg04.c
new file mode 100644
index 0000000000..b8e494b870
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg04.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Google LLC
+ */
+
+/*
+ * Regression test for commit bb2964810233 ("crypto: vmac - separate tfm and
+ * request context").  This test verifies that a VMAC transform can be used by
+ * multiple concurrent hash requests without crashing the kernel.  Based on the
+ * reproducer from the commit message.
+ */
+
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+
+static void run(void)
+{
+	int algfd, reqfd;
+	char buf[256] = { 0 };
+	pid_t pid;
+	int status;
+	int i;
+
+	if (tst_have_alg("hash", "vmac64(aes)"))
+		algfd = tst_alg_setup("hash", "vmac64(aes)", NULL, 16);
+	else
+		algfd = tst_alg_setup("hash", "vmac(aes)", NULL, 16);
+
+	pid = SAFE_FORK();
+
+	reqfd = tst_alg_accept(algfd);
+
+	for (i = 0; i < 500000; i++)
+		SAFE_WRITE(1, reqfd, buf, sizeof(buf));
+
+	close(reqfd);
+
+	if (pid != 0) {
+		SAFE_WAIT(&status);
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+			tst_res(TPASS, "didn't crash");
+		else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
+			tst_res(TFAIL, "crashed");
+		else
+			tst_brk(TBROK, "child %s", tst_strstatus(status));
+
+		close(algfd);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
-- 
2.20.1

