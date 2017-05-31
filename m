From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 31 May 2017 18:35:52 +0800
Subject: [LTP] [PATCH] ltp/numa: Fix compilation without MAP_HUGETLB
Message-ID: <1496226952-15147-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on some older distributions due to undefined
MAP_HUGETLB, so we include lapi/mmap.h to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/numa/support_numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index b6aa8bd..4904cc5 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -39,6 +39,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "lapi/mmap.h"
 
 /* Global Variables */
 #define MB (1<<20)
-- 
1.8.3.1



