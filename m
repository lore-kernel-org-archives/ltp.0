From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 23 Dec 2020 11:36:36 +0000
Subject: [LTP] [PATCH] af_alg07: Add linux-git reference to more general fix
Message-ID: <20201223113636.9617-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While trying to reintroduce this error on kernel 5.10 I found that a
secondary fix has been applied which fixes many more socket types and
may obsolete the original fix. Ideally we would create a new test
based on Eric's reproducer, but for now I will just include a
reference to the second fix.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/crypto/af_alg07.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index c94bb292f..ef13ad764 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -15,13 +15,22 @@
  *
  * The race window is small and it's hard to trigger a kernel crash but
  * fchownat() will return ENOENT as it should only when the bug is not
- * present. Race fixed in:
+ * present. Race fixed specifically for af_alg in:
  *
  *  commit 9060cb719e61b685ec0102574e10337fa5f445ea
  *  Author: Mao Wenan <maowenan@huawei.com>
  *  Date:   Mon Feb 18 10:44:44 2019 +0800
  *
  *  net: crypto set sk to NULL when af_alg_release.
+ *
+ * It was observed that the same bug is present on many other
+ * protocols. A more general fix is in:
+ *
+ *  commit ff7b11aa481f682e0e9711abfeb7d03f5cd612bf
+ *  Author: Eric Biggers <ebiggers@google.com>
+ *  Date:   Thu Feb 21 14:13:56 2019 -0800
+ *
+ *  net: socket: set sock->sk to NULL after calling proto_ops::release()
  */
 
 #include <sys/types.h>
@@ -118,6 +127,7 @@ static struct tst_test test = {
 	.min_cpus = 2,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
+		{"linux-git", "ff7b11aa481f"},
 		{"linux-git", "9060cb719e61"},
 		{"CVE", "2019-8912"},
 		{}
-- 
2.29.2

