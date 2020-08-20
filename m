From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 20 Aug 2020 11:19:18 -0700
Subject: [LTP] [LTP PATCH 2/2] crypto/af_alg02: send message with control
 data before reading
In-Reply-To: <20200820181918.404758-1-ebiggers@kernel.org>
References: <20200820181918.404758-1-ebiggers@kernel.org>
Message-ID: <20200820181918.404758-3-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

It isn't clearly defined what happens if you read from an AF_ALG request
socket without previously sending the control data to begin an
encryption or decryption operation.  On some kernels the read will
return 0, while on others it will block.

Testing this corner case isn't the purpose of af_alg02; it just wants to
try to encrypt a zero-length message.  So, change it to explicitly send
a zero-length message with control data.

This fixes the test failure reported at
https://lkml.kernel.org/r/CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com

Fixing the test in this way was also previously suggested at
https://lkml.kernel.org/r/20200702033221.GA19367@gondor.apana.org.au

Note, this patch doesn't change the fact that the read() still blocks on
pre-4.14 kernels (which is a kernel bug), and thus the timeout logic in
the test is still needed.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 testcases/kernel/crypto/af_alg02.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index fab0010c9..31d30777c 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -21,14 +21,29 @@
 #include <pthread.h>
 #include <errno.h>
 
+#define SALSA20_IV_SIZE       8
+#define SALSA20_MIN_KEY_SIZE  16
+
 static void *verify_encrypt(void *arg)
 {
+	const uint8_t iv[SALSA20_IV_SIZE] = { 0 };
+	const struct tst_alg_sendmsg_params params = {
+		.encrypt = true,
+		.iv = iv,
+		.ivlen = SALSA20_IV_SIZE,
+	};
 	char buf[16];
-	int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20", NULL, 16);
+	int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20", NULL,
+					SALSA20_MIN_KEY_SIZE);
 
-	TST_CHECKPOINT_WAKE(0);
+	/* Send a zero-length message to encrypt */
+	tst_alg_sendmsg(reqfd, NULL, 0, &params);
 
-	/* With the bug the kernel crashed here */
+	/*
+	 * Read the zero-length encrypted data.
+	 * With the bug, the kernel crashed here.
+	 */
+	TST_CHECKPOINT_WAKE(0);
 	if (read(reqfd, buf, 16) == 0)
 		tst_res(TPASS, "Successfully \"encrypted\" an empty message");
 	else
-- 
2.28.0

