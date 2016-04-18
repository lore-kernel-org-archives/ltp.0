From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Apr 2016 14:57:18 +0800
Subject: [LTP] [PATCH] mem/hugeshmctl: cleanup for the include file
Message-ID: <1460962638-13828-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 2 +-
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c | 2 +-
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 2c23332..a54077a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -61,7 +61,7 @@
  *	none
  */
 
-#include "hugetlb.h"
+#include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
 #include "hugetlb.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index af98e67..f5ae366 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -53,7 +53,7 @@
  */
 
 #include <pwd.h>
-#include "hugetlb.h"
+#include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
 #include "hugetlb.h"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index a9f6efa..bb2b7e7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -60,7 +60,7 @@
 
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "hugetlb.h"
+#include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
 #include "hugetlb.h"
-- 
1.8.3.1

