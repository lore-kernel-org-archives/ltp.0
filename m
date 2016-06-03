From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  3 Jun 2016 15:29:56 +0300
Subject: [LTP] [PATCH] tst_test.h: include tst_kvercmp.h
Message-ID: <1464956996-26578-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_kvercmp.h is included in test.h, but is not included in tst_test.h.
Fixed it.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/tst_test.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 88b46d6..871b273 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -31,6 +31,7 @@
 #include "tst_cpu.h"
 #include "tst_process_state.h"
 #include "tst_atomic.h"
+#include "tst_kvercmp.h"
 
 /*
  * Reports testcase result.
-- 
1.7.1

