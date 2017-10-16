From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 16 Oct 2017 11:31:10 +0800
Subject: [LTP] [PATCH] syscalls/ioctl07.c: Fix compilation && Cleanup
Message-ID: <1508124670-11877-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

1) Fix compilation error on older kernels(e.g RHEL5.11GA) due to
   undefined __u32, as below:
   error: expected specifier-qualifier-list before ‘__u32’
   error: expected specifier-qualifier-list before ‘__u32’

2) Remove unused tst_safe_stdio.h header file

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl07.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl07.c b/testcases/kernel/syscalls/ioctl/ioctl07.c
index a159dbc..fb11178 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl07.c
@@ -22,9 +22,9 @@
  *
  */
 
+#include <asm/types.h>
 #include <linux/random.h>
 #include <stdlib.h>
-#include "tst_safe_stdio.h"
 #include "tst_test.h"
 
 static char *s_fuzz;
-- 
1.8.3.1



