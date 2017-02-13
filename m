From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 15:43:03 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/3] symlinkat01: Get rid of rmobj() call
	+ small cleanup
In-Reply-To: <20170213144304.3806-1-chrubis@suse.cz>
References: <20170213144304.3806-1-chrubis@suse.cz>
Message-ID: <20170213144304.3806-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/symlinkat/symlinkat01.c | 74 +++++++----------------
 1 file changed, 21 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index e09ca10..14b781e 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -42,7 +42,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "rmobj.h"
+#include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
 #define MYRETCODE -999
@@ -123,13 +123,6 @@ struct test_struct {
 char *TCID = "symlinkat01";
 int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
 
-#define SUCCEED_OR_DIE(syscall, message, ...)														\
-	(errno = 0,																														\
-		({int ret=syscall(__VA_ARGS__);																			\
-			if (ret==-1)																												\
-				tst_brkm(TBROK, cleanup, message, __VA_ARGS__, strerror(errno)); \
-			ret;}))
-
 static int mysymlinkat(const char *oldfilename,
 		       int newdirfd, const char *newfilename)
 {
@@ -171,12 +164,11 @@ int main(int ac, char **av)
 static void setup_every_copy(void)
 {
 	close(newdirfd);
-	rmobj(TEST_DIR2, NULL);
+	unlink(dpathname);
+	rmdir(TEST_DIR2);
 
-	SUCCEED_OR_DIE(mkdir, "mkdir(%s, %o) failed: %s", TEST_DIR2, 0700);
-	newdirfd =
-	    SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed: %s", TEST_DIR2,
-			   O_DIRECTORY);
+	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
+	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
 }
 
 static void mysymlinkat_test(struct test_struct *desc)
@@ -189,33 +181,14 @@ static void mysymlinkat_test(struct test_struct *desc)
 	if (TEST_ERRNO == desc->expected_errno) {
 		if (TEST_RETURN == 0 && desc->referencefn1 != NULL) {
 			int tnum = rand(), vnum = ~tnum;
-			int len;
-			fd = SUCCEED_OR_DIE(open,
-					    "open(%s, 0x%x) failed: %s",
-					    desc->referencefn1, O_RDWR);
-			if ((len =
-			     write(fd, &tnum,
-				   sizeof(tnum))) != sizeof(tnum))
-				tst_brkm(TBROK, cleanup,
-					 "write() failed: expected %zu, returned %d; error: %s",
-					 sizeof(tnum), len,
-					 strerror(errno));
-			SUCCEED_OR_DIE(close, "close(%d) failed: %s",
-				       fd);
-
-			fd = SUCCEED_OR_DIE(open,
-					    "open(%s, 0x%x) failed: %s",
-					    desc->referencefn2,
-					    O_RDONLY);
-			if ((len =
-			     read(fd, &vnum,
-				  sizeof(vnum))) != sizeof(tnum))
-				tst_brkm(TBROK, cleanup,
-					 "read() failed: expected %zu, returned %d; error: %s",
-					 sizeof(vnum), len,
-					 strerror(errno));
-			SUCCEED_OR_DIE(close, "close(%d) failed: %s",
-				       fd);
+
+			fd = SAFE_OPEN(cleanup, desc->referencefn1, O_RDWR);
+			SAFE_WRITE(cleanup, 1, fd, &tnum, sizeof(tnum));
+			SAFE_CLOSE(cleanup, fd);
+
+			fd = SAFE_OPEN(cleanup, desc->referencefn2, O_RDONLY);
+			SAFE_READ(cleanup, 1, fd, &vnum, sizeof(vnum));
+			SAFE_CLOSE(cleanup, fd);
 
 			if (tnum == vnum)
 				tst_resm(TPASS, "Test passed");
@@ -240,24 +213,19 @@ static void mysymlinkat_test(struct test_struct *desc)
 static void setup(void)
 {
 	char *tmp;
+	int fd;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
 
-	SUCCEED_OR_DIE(mkdir, "mkdir(%s, %o) failed: %s", TEST_DIR1, 0700);
-	SUCCEED_OR_DIE(mkdir, "mkdir(%s, %o) failed: %s", TEST_DIR3, 0700);
-	olddirfd =
-	    SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed: %s", TEST_DIR1,
-			   O_DIRECTORY);
-	deldirfd =
-	    SUCCEED_OR_DIE(open, "open(%s, 0x%x) failed: %s", TEST_DIR3,
-			   O_DIRECTORY);
-	SUCCEED_OR_DIE(rmdir, "rmdir(%s) failed: %s", TEST_DIR3);
-	SUCCEED_OR_DIE(close, "close(%d) failed: %s",
-		       SUCCEED_OR_DIE(open, "open(%s, 0x%x, %o) failed: %s",
-				      TEST_DIR1 "/" TEST_FILE1,
-				      O_CREAT | O_EXCL, 0600));
+	SAFE_MKDIR(cleanup, TEST_DIR1, 0700);
+	SAFE_MKDIR(cleanup, TEST_DIR3, 0700);
+	olddirfd = SAFE_OPEN(cleanup, TEST_DIR1, O_DIRECTORY);
+	deldirfd = SAFE_OPEN(cleanup, TEST_DIR3, O_DIRECTORY);
+	SAFE_RMDIR(cleanup, TEST_DIR3);
+	fd = SAFE_OPEN(cleanup, TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
+	SAFE_CLOSE(cleanup, fd);
 
 	/* gratuitous memory leak here */
 	tmp = strdup(dpathname);
-- 
2.10.2

