From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun,  7 Jul 2019 21:00:12 +0200
Subject: [LTP] [PATCH 1/5] lib: include <errno.h> in tst_test.h
In-Reply-To: <20190707190016.27296-1-petr.vorel@gmail.com>
References: <20190707190016.27296-1-petr.vorel@gmail.com>
Message-ID: <20190707190016.27296-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_test.h is using errno variable, thus it should include <errno.h>.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 include/tst_test.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 2e8e36352..2e53e68bf 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -14,6 +14,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include <string.h>
+#include <errno.h>
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
-- 
2.20.1

