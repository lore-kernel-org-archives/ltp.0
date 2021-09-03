From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  3 Sep 2021 17:48:43 +0200
Subject: [LTP] [PATCH 2/7] Simplify syscalls/mkdir02
In-Reply-To: <20210903154848.18705-1-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
Message-ID: <20210903154848.18705-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mkdir02 does a lot of unnecessary fork()ing left over from the old version.
The same test can be done with just user "nobody", one unused GID and no
fork()ing at all.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/mkdir/mkdir02.c | 77 +++++++----------------
 1 file changed, 24 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir02.c b/testcases/kernel/syscalls/mkdir/mkdir02.c
index f09e3c33d..2cb199c56 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir02.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir02.c
@@ -9,85 +9,57 @@
  *  bit is set in the parent directory.
  */
 
-#include <errno.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <pwd.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <stdlib.h>
 #include "tst_test.h"
+#include "tst_uid.h"
 
 #define TESTDIR1	"testdir1"
 #define TESTDIR2	"testdir1/testdir2"
 
-static uid_t nobody_uid, bin_uid;
-static gid_t nobody_gid, bin_gid;
+static gid_t free_gid;
 
 static void verify_mkdir(void)
 {
-	struct stat buf1, buf2;
-	pid_t pid;
+	struct stat statbuf;
 	int fail = 0;
 
-	pid = SAFE_FORK();
-	if (pid == 0) {
-		SAFE_SETREGID(bin_gid, bin_gid);
-		SAFE_SETREUID(bin_uid, bin_uid);
-		SAFE_MKDIR(TESTDIR2, 0777);
+	SAFE_MKDIR(TESTDIR2, 0777);
+	SAFE_STAT(TESTDIR2, &statbuf);
 
-		SAFE_STAT(TESTDIR2, &buf2);
-		SAFE_STAT(TESTDIR1, &buf1);
-
-		if (buf2.st_gid != buf1.st_gid) {
-			tst_res(TFAIL,
-				"New dir FAILED to inherit GID have %d expected %d",
-				buf2.st_gid, buf1.st_gid);
-			fail = 1;
-		}
-
-		if (!(buf2.st_mode & S_ISGID)) {
-			tst_res(TFAIL, "New dir FAILED to inherit S_ISGID");
-			fail = 1;
-		}
-
-		if (!fail)
-			tst_res(TPASS, "New dir inherited GID and S_ISGID");
+	if (statbuf.st_gid != free_gid) {
+		tst_res(TFAIL,
+			"New dir FAILED to inherit GID: has %d, expected %d",
+			statbuf.st_gid, free_gid);
+		fail = 1;
+	}
 
-		exit(0);
+	if (!(statbuf.st_mode & S_ISGID)) {
+		tst_res(TFAIL, "New dir FAILED to inherit S_ISGID");
+		fail = 1;
 	}
 
-	tst_reap_children();
+	if (!fail)
+		tst_res(TPASS, "New dir inherited GID and S_ISGID");
+
 	SAFE_RMDIR(TESTDIR2);
 }
 
 
 static void setup(void)
 {
-	struct passwd *pw;
-	struct stat buf;
-	pid_t pid;
+	struct passwd *pw = SAFE_GETPWNAM("nobody");
 
-	pw = SAFE_GETPWNAM("nobody");
-	nobody_uid = pw->pw_uid;
-	nobody_gid = pw->pw_gid;
-	pw = SAFE_GETPWNAM("bin");
-	bin_uid = pw->pw_uid;
-	bin_gid = pw->pw_gid;
+	free_gid = tst_get_free_gid(pw->pw_gid);
 
 	umask(0);
+	SAFE_MKDIR(TESTDIR1, 0777);
+	SAFE_CHMOD(TESTDIR1, 0777 | S_ISGID);
+	SAFE_CHOWN(TESTDIR1, getuid(), free_gid);
 
-	pid = SAFE_FORK();
-	if (pid == 0) {
-		SAFE_SETREGID(nobody_gid, nobody_gid);
-		SAFE_SETREUID(nobody_uid, nobody_uid);
-		SAFE_MKDIR(TESTDIR1, 0777);
-		SAFE_STAT(TESTDIR1, &buf);
-		SAFE_CHMOD(TESTDIR1, buf.st_mode | S_ISGID);
-		exit(0);
-	}
-
-	tst_reap_children();
+	SAFE_SETREGID(pw->pw_gid, pw->pw_gid);
+	SAFE_SETREUID(pw->pw_uid, pw->pw_uid);
 }
 
 static struct tst_test test = {
@@ -95,5 +67,4 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.test_all = verify_mkdir,
-	.forks_child = 1,
 };
-- 
2.33.0

