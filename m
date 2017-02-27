From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 14:51:03 +0800
Subject: [LTP] [PATCH] doio/growfiles.c: show line number when test failed
Message-ID: <20170227065103.GA30910@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Please review this patch. Thanks.

The original code always shows "growfiles.c:132: Test failed". With this
patch, it will show the right line number where exit() be called.
---
 testcases/kernel/fs/doio/growfiles.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index bbad230..6f25a54 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -125,11 +125,11 @@ char *TCID = "growfiles";	/* Default test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 
 /* To avoid extensive modifications to the code, use this bodge */
-#define exit(x) myexit(x)
-void myexit(int x)
+#define exit(x) myexit(__FILE__, __LINE__, x)
+void myexit(const char *file, const int lineno, int x)
 {
 	if (x)
-		tst_resm(TFAIL, "Test failed");
+		tst_resm_(file, lineno, TFAIL, "Test failed");
 	else
 		tst_resm(TPASS, "Test passed");
 	tst_exit();
-- 
2.7.4

