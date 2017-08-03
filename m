From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Aug 2017 15:52:26 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/9] syscalls/splice02: Convert to the new
	library
In-Reply-To: <20170803135233.13676-1-chrubis@suse.cz>
References: <20170803135233.13676-1-chrubis@suse.cz>
Message-ID: <20170803135233.13676-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                            |  2 +-
 testcases/kernel/syscalls/splice/splice02.c | 60 +++++++----------------------
 2 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index e9dd3dec0..be617e337 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1224,7 +1224,7 @@ socketpair02 socketpair02
 sockioctl01 sockioctl01
 
 splice01 splice01
-splice02 seq 1 20000 | splice02 splice02-temp
+splice02 seq 1 20000 | splice02
 splice03 splice03
 splice04 splice04
 splice05 splice05
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index d2f843ae7..a9ca51539 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -19,17 +19,7 @@
 /*                                                                            */
 /******************************************************************************/
 /******************************************************************************/
-/*                                                                            */
-/* File:        splice02.c                                                    */
-/*                                                                            */
 /* Description: This tests the splice() syscall                               */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* echo "Test splice()" > <outfile>; splice02 <outfile>                       */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   splice02                                                      */
 /******************************************************************************/
 #define _GNU_SOURCE
 
@@ -38,54 +28,30 @@
 #include <unistd.h>
 #include <fcntl.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/splice.h"
 
-char *TCID = "splice02";
-int TST_TOTAL = 1;
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	if ((tst_kvercmp(2, 6, 17)) < 0) {
-		tst_brkm(TCONF, cleanup, "This test can only run on kernels "
-			"that are 2.6.17 or higher");
-	}
-
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
 #define SPLICE_SIZE (64*1024)
 
-int main(int ac, char **av)
+static void splice_test(void)
 {
 	int fd;
 
-	setup();
-
-	if (ac < 2) {
-		tst_brkm(TFAIL, NULL, "%s failed - Usage: %s outfile", TCID,
-			 av[0]);
-	}
-
-	fd = SAFE_OPEN(cleanup, av[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	fd = SAFE_OPEN("splice02-temp", O_WRONLY | O_CREAT | O_TRUNC, 0644);
 
 	TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
 	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL, "splice failed - errno = %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
+		tst_res(TFAIL, "splice failed - errno = %d : %s",
+			TEST_ERRNO, strerror(TEST_ERRNO));
 	} else {
-		tst_resm(TPASS, "splice() system call Passed");
+		tst_res(TPASS, "splice() system call Passed");
 	}
 
-	SAFE_CLOSE(cleanup, fd);
-
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = splice_test,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.17",
+};
-- 
2.13.0

