From: Eric Biggers <ebiggers@kernel.org>
Date: Mon,  1 Jul 2019 14:33:16 -0700
Subject: [LTP] [PATCH] crypto/pcrypt_aead01: add back deleted file comment
Message-ID: <20190701213316.120357-1-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add back some useful text that was accidentally deleted by commit
acc16bcbf12a ("c: Replace GPL verbose text by SPDX license identifier").

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 testcases/kernel/crypto/pcrypt_aead01.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 5d9a123c7..d9c27f69d 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -6,6 +6,14 @@
  *
  * Originally found by syzkaller:
  * https://groups.google.com/forum/#!topic/syzkaller-bugs/NKn_ivoPOpk
+ *
+ * Test for CVE-2017-5754 - pcrypt mishandles freeing instances.
+ *
+ * The test works by adding and then removing pcrypt-AEAD instances.
+ * See commit d76c68109f37 crypto: pcrypt - fix freeing pcrypt instances.
+ *
+ * If the bug is present then this will probably crash the kernel, but also
+ * sometimes the test simply times out.
  */
 
 #include <errno.h>
-- 
2.22.0.410.gd8fdbe21b5-goog

