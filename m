From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 16 Jun 2016 15:52:04 +0800
Subject: [LTP] [PATCH] lib/tst_test.c: fix Segmentation fault in tst_vbrk_
Message-ID: <1466063524-13140-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We can't allocate resources to results pointer before checking
kernel version, so do_exit() will fail if we print results pointer.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index c560727..68791cb 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -237,7 +237,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
 		do_test_cleanup();
 
 	if (getpid() == lib_pid)
-		do_exit(TTYPE_RESULT(ttype));
+		do_cleanup();
 
 	exit(TTYPE_RESULT(ttype));
 }
-- 
1.8.3.1



