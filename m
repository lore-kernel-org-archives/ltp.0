From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 17 Sep 2019 19:39:16 +0800
Subject: [LTP] [PATCH] crypto/af_alg05: add comment for a regression
Message-ID: <1568720356-29641-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/crypto/af_alg05.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/crypto/af_alg05.c b/testcases/kernel/crypto/af_alg05.c
index 419c65eab..964adffcc 100644
--- a/testcases/kernel/crypto/af_alg05.c
+++ b/testcases/kernel/crypto/af_alg05.c
@@ -10,6 +10,12 @@
  * block size, and where the destination buffer starts exactly at a page
  * boundary.  Based on the reproducer from the commit message.  Note that this
  * issue only reproduces on certain architectures, such as arm and arm64.
+ *
+ * On some older kernel without commit 160544075f2 ("crypto: scatterwalk - Hide
+ * PageSlab call to optimise away flush_dcache_page") , it doesn't use
+ * ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macro. It can crash on all architectures.
+ * Without skcipher walk interface, it is also a regresstion test for commit
+ * 0868def3e410("crypto: blkcipher - fix crash flushing dcache in error path").
  */
 
 #include <errno.h>
-- 
2.18.1



