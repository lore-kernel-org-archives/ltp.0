From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 28 Jul 2016 17:38:48 +0800
Subject: [LTP] [PATCH 1/2] syscalls/access04: reconstruct and convert to new
	API
Message-ID: <1469698729-5860-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* take use of some SAFE Marcos
* add test as root and nobody respectively

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/access04.c | 126 +++++++++++-----------------
 1 file changed, 47 insertions(+), 79 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index 49e7057..4996e3c 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -20,110 +20,78 @@
 /*
  * Test Description:
  *  Verify that access() succeeds to check the existance of a file if
- *  search access is permitted on the pathname of the specified file.
+ *  search access is permitted on the pathname of the specified file
+ *  as root and nobody respectively.
  *
  *  07/2001 Ported by Wayne Boyer
+ *  07/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
 #include <pwd.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-#define TESTDIR		"testdir"
-#define TESTFILE	"testdir/testfile"
-#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
-#define FILE_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
-
-char *TCID = "access04";
-int TST_TOTAL = 1;
-
-static const char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
+#define FNAME "accessfile"
 
-static void setup(void);
-static void cleanup(void);
+static uid_t uid;
 
-int main(int ac, char **av)
+static void access_test(const char *user)
 {
 	struct stat stat_buf;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	setup();
+	TEST(access(FNAME, F_OK));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(access(TESTFILE, F_OK));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"access(%s, F_OK) as %s failed", FNAME, user);
+		return;
+	}
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "access(%s, F_OK) failed",
-				 TESTFILE);
-			continue;
-		}
+	TEST(stat(FNAME, &stat_buf));
 
-		if (stat(TESTFILE, &stat_buf) < 0) {
-			tst_resm(TFAIL | TERRNO, "stat(%s) failed",
-				 TESTFILE);
-		} else {
-			tst_resm(TPASS, "functionality of "
-				 "access(%s, F_OK) ok", TESTFILE);
-		}
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"stat(%s) as %s failed", FNAME, user);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "access(%s, F_OK) as %s behaviour is correct",
+		FNAME, user);
 }
 
-static void setup(void)
+static void verify_access(void)
 {
-	int fd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	tst_require_root();
-
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
+	pid_t pid;
 
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TINFO | TERRNO, NULL, "setuid failed");
+	access_test("root");
 
-	TEST_PAUSE;
-	tst_tmpdir();
-
-	if (mkdir(TESTDIR, DIR_MODE) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
-			 TESTDIR, DIR_MODE);
+	pid = SAFE_FORK();
+	if (pid) {
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		SAFE_SETUID(uid);
+		access_test("nobody");
+	}
+}
 
-	if (chmod(TESTDIR, DIR_MODE) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, %#o) failed",
-			 TESTDIR, DIR_MODE);
+static void setup(void)
+{
+	struct passwd *pw;
 
-	fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TESTFILE, FILE_MODE);
+	pw = SAFE_GETPWNAM("nobody");
 
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", TESTFILE);
+	uid = pw->pw_uid;
 
-	if (chmod(TESTFILE, 0) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "chmod(%s, 0) failed", TESTFILE);
+	SAFE_TOUCH(FNAME, 0644, NULL);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tid = "access04",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test_all = verify_access
+};
-- 
1.8.4.2



