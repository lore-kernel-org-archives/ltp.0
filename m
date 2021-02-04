From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 4 Feb 2021 20:12:39 +0800
Subject: [LTP] [PATCH v2 2/5] syscalls/mallopt01: Use tst_print_mallinfo api
In-Reply-To: <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1612440762-22389-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
index f799aaf9d..271079c12 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -12,10 +12,9 @@
  * Basic mallinfo() and mallopt() testing.
 \*/
 
-#include <malloc.h>
-
 #include "tst_test.h"
 #include "tst_safe_macros.h"
+#include "tst_mallinfo.h"
 
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
+		tst_print_mallinfo("Test uordblks", &info);
 		tst_res(TFAIL, "mallinfo() failed: uordblks < 20K");
 	}
 	if (info.smblks != 0) {
-		print_mallinfo();
+		tst_print_mallinfo("Test smblks", &info);
 		tst_res(TFAIL, "mallinfo() failed: smblks != 0");
 	}
 	if (info.uordblks >= 20480 && info.smblks == 0)
-- 
2.23.0



