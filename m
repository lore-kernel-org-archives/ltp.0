From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  7 Sep 2017 15:23:59 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/mbind01: Fix warnings without
	libnuma2
Message-ID: <20170907132359.30247-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The #else branch should have to use TST_TEST_TCONF() which is the
standard way how to cope with compiled out testcases.

The hacky code that implements main() in a case that libnuma2 is not
preset produces "no retrun in non-void function" that is treated as an
error by modern build systems. Moreover it also breaks the option
parsing which will break the new runltp-ng testrunner in the future.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/mbind/mbind01.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 648cdab97..be5470691 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -24,10 +24,10 @@
 #include <errno.h>
 
 #include "numa_helper.h"
+#include "tst_test.h"
 
 #if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
 	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
-#include "tst_test.h"
 
 #define MEM_LENGTH (4 * 1024 * 1024)
 
@@ -234,10 +234,5 @@ static struct tst_test test = {
 };
 
 #else /* libnuma >= 2 */
-#define TST_NO_DEFAULT_MAIN
-#include "tst_test.h"
-int main(void)
-{
-	tst_brk(TCONF, "test requires libnuma >= 2.");
-}
+TST_TEST_TCONF("test requires libnuma >= 2.");
 #endif
-- 
2.13.0

