From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Nov 2019 16:29:45 +0800
Subject: [LTP] [COMMITTED PATCH] mmap1: include lapi/abisize.h header file
Message-ID: <20191128082945.6495-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get rid of this BROK on i686:
 mmap1.c:204: BROK: mmap((nil),2147483648,3,34,-1,0) failed: ENOMEM (12)

Reported-by: Zhijun Wang <zhijwang@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index c5417444f..5c7d3df2f 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include "lapi/abisize.h"
 #include "tst_test.h"
+#include "lapi/abisize.h"
 #include "tst_safe_pthread.h"
 
 #ifdef TST_ABI32
-- 
2.20.1

