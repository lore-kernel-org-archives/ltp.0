From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 22 Apr 2019 10:37:42 -0700
Subject: [LTP] [PATCH] crypto/af_alg04: log INFO message when beginning test
Message-ID: <20190422173742.84066-1-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Make it more obvious that this test will crash buggy kernels.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 testcases/kernel/crypto/af_alg04.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/crypto/af_alg04.c b/testcases/kernel/crypto/af_alg04.c
index b8e494b87..48239e020 100644
--- a/testcases/kernel/crypto/af_alg04.c
+++ b/testcases/kernel/crypto/af_alg04.c
@@ -28,6 +28,8 @@ static void run(void)
 	else
 		algfd = tst_alg_setup("hash", "vmac(aes)", NULL, 16);
 
+	tst_res(TINFO, "Starting vmac hashing test.  May crash buggy kernels.");
+
 	pid = SAFE_FORK();
 
 	reqfd = tst_alg_accept(algfd);
-- 
2.21.0.593.g511ec345e18-goog

