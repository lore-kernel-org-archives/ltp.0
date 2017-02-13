From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 15:43:02 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/3] linkat01: Get rid of rmobj() call +
	small cleanup
Message-ID: <20170213144304.3806-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/linkat/linkat01.c | 56 ++++++++++-------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index 0e82f7f..6772a6b 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -57,7 +57,6 @@
 #include <limits.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
-#include "rmobj.h"
 #include "safe_macros.h"
 
 #ifndef AT_FDCWD
@@ -190,14 +189,6 @@ struct test_struct {
 char *TCID = "linkat01";
 int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
 
-#define SUCCEED_OR_DIE(syscall, message, ...)		\
-	(errno = 0,					\
-	 ({int ret=syscall(__VA_ARGS__);		\
-	 if (ret==-1)					\
-		tst_brkm(TBROK | TERRNO, cleanup,	\
-			message, __VA_ARGS__);		\
-	 ret; }))
-
 static int mylinkat(int olddirfd, const char *oldfilename, int newdirfd,
 		    const char *newfilename, int flags)
 {
@@ -238,11 +229,11 @@ int main(int ac, char **av)
 static void setup_every_copy(void)
 {
 	close(newdirfd);
-	rmobj(TEST_DIR2, NULL);
+	unlink(dpathname);
+	rmdir(TEST_DIR2);
 
-	SUCCEED_OR_DIE(mkdir, "mkdir(%s, %o) failed", TEST_DIR2, 0700);
-	newdirfd = SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed",
-				  TEST_DIR2, O_DIRECTORY);
+	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
+	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
 }
 
 static void mylinkat_test(struct test_struct *desc)
@@ -297,42 +288,31 @@ static void mylinkat_test(struct test_struct *desc)
 void setup(void)
 {
 	char *cwd;
+	int fd;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
 
 	cwd = get_current_dir_name();
-	if (cwd == NULL)
+	if (cwd == NULL) {
 		tst_brkm(TFAIL | TERRNO, cleanup,
 			 "Failed to get current working directory");
-	else {
-
-		SUCCEED_OR_DIE(mkdir, "mkdir(%s, %o) failed", TEST_DIR1, 0700);
-		SUCCEED_OR_DIE(mkdir, "mkdir(%s, %o) failed", TEST_DIR3, 0700);
-		olddirfd = SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed",
-					  TEST_DIR1, O_DIRECTORY);
-		deldirfd = SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed",
-					  TEST_DIR3, O_DIRECTORY);
-		SUCCEED_OR_DIE(rmdir, "rmdir(%s) failed", TEST_DIR3);
-		SUCCEED_OR_DIE(close, "close(%d) failed",
-			       SUCCEED_OR_DIE(open, "open(%s, 0x%x, %o) "
-					      "failed",
-					      TEST_DIR1 "/" TEST_FILE1,
-					      O_CREAT | O_EXCL, 0600));
-
-		SUCCEED_OR_DIE(mkfifo, "mkfifo(%s, %o) failed",
-			       TEST_DIR1 "/" TEST_FIFO, 0600);
-
-		snprintf(dpathname, sizeof(dpathname), DPATHNAME_FMT, cwd);
-		snprintf(spathname, sizeof(spathname), SPATHNAME_FMT, cwd);
-
-		free(cwd);
+	}
 
-		TEST_PAUSE;
+	SAFE_MKDIR(cleanup, TEST_DIR1, 0700);
+	SAFE_MKDIR(cleanup, TEST_DIR3, 0700);
+	olddirfd = SAFE_OPEN(cleanup, TEST_DIR1, O_DIRECTORY);
+	deldirfd = SAFE_OPEN(cleanup, TEST_DIR3, O_DIRECTORY);
+	SAFE_RMDIR(cleanup, TEST_DIR3);
+	fd = SAFE_OPEN(cleanup, TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
+	SAFE_CLOSE(cleanup, fd);
+	SAFE_MKFIFO(cleanup, TEST_DIR1 "/" TEST_FIFO, 0600);
 
-	}
+	snprintf(dpathname, sizeof(dpathname), DPATHNAME_FMT, cwd);
+	snprintf(spathname, sizeof(spathname), SPATHNAME_FMT, cwd);
 
+	free(cwd);
 }
 
 static void cleanup(void)
-- 
2.10.2

