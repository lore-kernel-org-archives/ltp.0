From: Xinpeng Liu <liuxp11@chinatelecom.cn>
Date: Fri, 26 Mar 2021 10:46:12 +0800
Subject: [LTP] [PATCH] syscalls/mallopt:fix compiling error
Message-ID: <1616726772-29562-1-git-send-email-liuxp11@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mallopt01.c:33:3: warning: implicit declaration of function ?print_mallinfo?
[-Wimplicit-function-declaration]
   print_mallinfo("Test uordblks", &info);
      ^
/tmp/ccOU0s7e.o: In function `test_mallopt':
/root/mywork/ltp_github/testcases/kernel/syscalls/mallopt/mallopt01.c:37:
undefined reference to `print_mallinfo'
/root/mywork/ltp_github/testcases/kernel/syscalls/mallopt/mallopt01.c:33:
undefined reference to `print_mallinfo'

Signed-off-by: Xinpeng Liu <liuxp11@chinatelecom.cn>
---
 testcases/kernel/syscalls/mallopt/mallopt01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index 8ff4649..bb7234f 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -13,6 +13,7 @@
  */
 
 
+#define HAVE_MALLINFO
 #include "../mallinfo/mallinfo_common.h"
 #include "tst_safe_macros.h"
 
-- 
1.8.3.1

