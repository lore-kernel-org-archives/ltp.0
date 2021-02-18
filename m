From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 18 Feb 2021 13:52:50 +0800
Subject: [LTP] [PATCH v3 2/4] syscalls/mallopt01: Use unified print_mallinfo
 api
In-Reply-To: <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <YCFZB1/VMSsfxyPA@yuki.lan>
 <1613627572-5213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1613627572-5213-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mallopt/mallopt01.c | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index f799aaf9d..e270b0bda 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -12,9 +12,8 @@
  * Basic mallinfo() and mallopt() testing.
 \*/
 
-#include <malloc.h>
 
-#include "tst_test.h"
+#include "../mallinfo/mallinfo_common.h"
 #include "tst_safe_macros.h"
 
 #ifdef HAVE_MALLOPT
@@ -23,21 +22,6 @@
 
 struct mallinfo info;
 
-void print_mallinfo(void)
-{
-	tst_res(TINFO, "mallinfo structure:");
-	tst_res(TINFO, "mallinfo.arena = %d", info.arena);
-	tst_res(TINFO, "mallinfo.ordblks = %d", info.ordblks);
-	tst_res(TINFO, "mallinfo.smblks = %d", info.smblks);
-	tst_res(TINFO, "mallinfo.hblkhd = %d", info.hblkhd);
-	tst_res(TINFO, "mallinfo.hblks = %d", info.hblks);
-	tst_res(TINFO, "mallinfo.usmblks = %d", info.usmblks);
-	tst_res(TINFO, "mallinfo.fsmblks = %d", info.fsmblks);
-	tst_res(TINFO, "mallinfo.uordblks = %d", info.uordblks);
-	tst_res(TINFO, "mallinfo.fordblks = %d", info.fordblks);
-	tst_res(TINFO, "mallinfo.keepcost = %d", info.keepcost);
-}
-
 void test_mallopt(void)
 {
 	char *buf;
@@ -46,11 +30,11 @@ void test_mallopt(void)
 
 	info = mallinfo();
 	if (info.uordblks < 20480) {
-		print_mallinfo();
+		print_mallinfo("Test uordblks", &info);
 		tst_res(TFAIL, "mallinfo() failed: uordblks < 20K");
 	}
 	if (info.smblks != 0) {
-		print_mallinfo();
+		print_mallinfo("Test smblks", &info);
 		tst_res(TFAIL, "mallinfo() failed: smblks != 0");
 	}
 	if (info.uordblks >= 20480 && info.smblks == 0)
-- 
2.23.0



