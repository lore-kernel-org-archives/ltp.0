From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Jun 2019 15:14:01 +0800
Subject: [LTP] [PATCH] lib: add include config.h in cloner.c
Message-ID: <20190619071401.18509-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a follow fix for commit f6164ffc2804b2a68218, otherwise clone08
failed with ENOSYS error:

    clone08.c:81: INFO: running CLONE_PARENT
    clone08.c:104: BROK: CLONE_PARENT clone() failed: ENOSYS
    tst_test.c:357: BROK: Reported by child (2785)

That becuase CLONE_SUPPORTS_7_ARGS macro is included in config.h, without
this header file, the ltp_clone7() will fall into ENOSYS branch.

Reported-by: Ping Fang <pifang@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/cloner.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cloner.c b/lib/cloner.c
index 8469745d0..11401f230 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 #include <sched.h>
 #include <stdarg.h>
+#include "config.h"
 #include "tst_clone.h"
 
 #undef clone			/* we want to use clone() */
-- 
2.20.1

