From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:36 +0200
Subject: [LTP] [COMMITTED] [PATCH 03/40] Make use of SAFE_MKDIR()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/chmod/chmod04.c       |  5 ++---
 testcases/kernel/syscalls/chmod/chmod05.c       |  4 ++--
 testcases/kernel/syscalls/fchmod/fchmod04.c     |  4 +---
 testcases/kernel/syscalls/fchmod/fchmod05.c     |  4 +---
 testcases/kernel/syscalls/inotify/inotify03.c   |  5 +----
 testcases/kernel/syscalls/lchown/lchown02.c     |  3 +--
 testcases/kernel/syscalls/mknod/mknod02.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod03.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod04.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod05.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod08.c       |  4 +---
 testcases/kernel/syscalls/open/open07.c         | 10 ++++------
 testcases/kernel/syscalls/rename/rename01.c     |  5 ++---
 testcases/kernel/syscalls/rename/rename03.c     |  9 +++------
 testcases/kernel/syscalls/rename/rename04.c     |  9 +++------
 testcases/kernel/syscalls/rename/rename05.c     |  5 ++---
 testcases/kernel/syscalls/rename/rename06.c     |  9 +++------
 testcases/kernel/syscalls/rename/rename07.c     |  5 ++---
 testcases/kernel/syscalls/rename/rename12.c     |  4 +---
 testcases/kernel/syscalls/rmdir/rmdir01.c       |  6 ++----
 testcases/kernel/syscalls/rmdir/rmdir03.c       | 20 ++++----------------
 testcases/kernel/syscalls/rmdir/rmdir04.c       |  7 ++-----
 testcases/kernel/syscalls/rmdir/rmdir05.c       |  5 ++---
 testcases/kernel/syscalls/setxattr/setxattr02.c |  5 ++---
 testcases/kernel/syscalls/stat/stat03.c         |  4 +---
 testcases/kernel/syscalls/symlink/symlink03.c   |  4 +---
 testcases/kernel/syscalls/unlink/unlink08.c     | 19 ++++---------------
 27 files changed, 51 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod04.c b/testcases/kernel/syscalls/chmod/chmod04.c
index 0392eac1d..cbc13cf61 100644
--- a/testcases/kernel/syscalls/chmod/chmod04.c
+++ b/testcases/kernel/syscalls/chmod/chmod04.c
@@ -80,6 +80,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define DIR_MODE 	S_IRWXU | S_IRWXG | S_IRWXO
 #define PERMS		01777	/*
@@ -173,9 +174,7 @@ void setup(void)
 	 * Create a test directory under temporary directory with specified
 	 * mode permissios.
 	 */
-	if (mkdir(TESTDIR, DIR_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
-	}
+	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index 4b0126569..028aa5d6d 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -97,6 +97,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define DEBUG 0
 
@@ -195,8 +196,7 @@ void setup(void)
 	 * mode permissions and change the gid of test directory to nobody's
 	 * gid.
 	 */
-	if (mkdir(TESTDIR, MODE_RWX) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s) failed", TESTDIR);
+	SAFE_MKDIR(cleanup, TESTDIR, MODE_RWX);
 
 	if (setgroups(1, &nobody_u->pw_gid) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index dd79b6cb3..27e3bdcd1 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -170,9 +170,7 @@ void setup(void)
 	 * Create a test directory under temporary directory with specified
 	 * mode permissios and open it for reading/writing.
 	 */
-	if (mkdir(TESTDIR, DIR_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
-	}
+	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
 	if ((fd = open(TESTDIR, O_RDONLY)) == -1) {
 		tst_brkm(TBROK, cleanup,
 			 "open(%s, O_RDONLY) failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 4ef62d4cc..290e2560a 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -188,9 +188,7 @@ void setup(void)
 	 * mode permissions and change the gid of test directory to that of
 	 * guest user.
 	 */
-	if (mkdir(TESTDIR, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
-	}
+	SAFE_MKDIR(cleanup, TESTDIR, MODE_RWX);
 
 	if (setgroups(1, &nobody_u->pw_gid) == -1)
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 9393f1dbb..ae0c37e84 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -183,10 +183,7 @@ static void setup(void)
 
 	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
 
-	if (mkdir(mntpoint, DIR_MODE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
-			 mntpoint, DIR_MODE);
-	}
+	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
 
 	/* Call mount(2) */
 	tst_resm(TINFO, "mount %s to %s fs_type=%s", device, mntpoint, fs_type);
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 5031c0b2f..245c86fa1 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -229,8 +229,7 @@ static void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
 	int fd;
 
 	/* create a test directory */
-	if (mkdir(DIR_TEMP, MODE_RWX) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir failed");
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 
 	/* create a file under test directory */
 	if ((fd = open(TEST_FILE2, O_RDWR | O_CREAT, 0666)) == -1)
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index 85ae1409b..a0b0937a0 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -237,9 +237,7 @@ void setup(void)
 	 * specified mode permissions, with uid/gid set to that of guest
 	 * user and the test process.
 	 */
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 3d4e3c37f..3cf0af398 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -234,9 +234,7 @@ void setup(void)
 	 * specified mode permissions, with uid/gid set to that of guest
 	 * user and the test process.
 	 */
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index 67c31fe58..46273bb3f 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -236,9 +236,7 @@ void setup(void)
 	 * specified mode permissions, with uid/gid set to that of guest
 	 * user and the test process.
 	 */
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index 0808971ed..4edcb9394 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -228,9 +228,7 @@ void setup(void)
 	 * specified mode permissions, with uid/gid set to that of guest
 	 * user and the test process.
 	 */
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
index 6937da532..76bb27f17 100644
--- a/testcases/kernel/syscalls/mknod/mknod08.c
+++ b/testcases/kernel/syscalls/mknod/mknod08.c
@@ -232,9 +232,7 @@ void setup(void)
 	 * specified mode permissions, with uid/gid set to that of guest
 	 * user and the test process.
 	 */
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
diff --git a/testcases/kernel/syscalls/open/open07.c b/testcases/kernel/syscalls/open/open07.c
index 8d99ae5c2..934d6f512 100644
--- a/testcases/kernel/syscalls/open/open07.c
+++ b/testcases/kernel/syscalls/open/open07.c
@@ -65,6 +65,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include "test.h"
+#include "safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -178,8 +179,7 @@ static void setupfunc_test2(void)
 
 	sprintf(file1, "open03.3.%d", getpid());
 	sprintf(file2, "open03.4.%d", getpid());
-	if (mkdir(file1, 00700) < 0)
-		tst_brkm(TBROK, cleanup, "mkdir(2) failed: errno: %d", errno);
+	SAFE_MKDIR(cleanup, file1, 00700);
 
 	if (symlink(file1, file2) < 0)
 		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
@@ -214,8 +214,7 @@ static void setupfunc_test4(void)
 	sprintf(file1, "open03.8.%d", getpid());
 	sprintf(file2, "open03.9.%d", getpid());
 	sprintf(file3, "open03.10.%d", getpid());
-	if (mkdir(file1, 00700) < 0)
-		tst_brkm(TBROK, cleanup, "mkdir(2) failed: errno: %d", errno);
+	SAFE_MKDIR(cleanup, file1, 00700);
 
 	if (symlink(file1, file2) < 0)
 		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
@@ -232,8 +231,7 @@ static void setupfunc_test5(void)
 
 	sprintf(file1, "open11.3.%d", getpid());
 	sprintf(file2, "open12.4.%d", getpid());
-	if (mkdir(file1, 00700) < 0)
-		tst_brkm(TBROK, cleanup, "mkdir(2) failed: errno: %d", errno);
+	SAFE_MKDIR(cleanup, file1, 00700);
 
 	if (symlink(file1, file2) < 0)
 		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index f61973212..2474ab95e 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -72,6 +72,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -207,9 +208,7 @@ void setup(void)
 	f_oldino = buf1.st_ino;
 
 	/* create "old" directory */
-	if (mkdir(fdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", fdir);
-	}
+	SAFE_MKDIR(cleanup, fdir, 00770);
 
 	if (stat(fdir, &buf1) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s"
diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
index 1e89fea8c..b15e8fe95 100644
--- a/testcases/kernel/syscalls/rename/rename03.c
+++ b/testcases/kernel/syscalls/rename/rename03.c
@@ -69,6 +69,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void setup2();
@@ -218,9 +219,7 @@ void setup2(void)
 	SAFE_TOUCH(cleanup, mname, 0700, NULL);
 
 	/* create "old" directory */
-	if (mkdir(fdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", fdir);
-	}
+	SAFE_MKDIR(cleanup, fdir, 00770);
 	if (stat(fdir, &buf1) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s"
 			 "in rename()", fdir);
@@ -231,9 +230,7 @@ void setup2(void)
 	d_oldino = buf1.st_ino;
 
 	/* create another directory */
-	if (mkdir(mdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", mdir);
-	}
+	SAFE_MKDIR(cleanup, mdir, 00770);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/rename/rename04.c b/testcases/kernel/syscalls/rename/rename04.c
index d9c373ee3..5c6d4fda8 100644
--- a/testcases/kernel/syscalls/rename/rename04.c
+++ b/testcases/kernel/syscalls/rename/rename04.c
@@ -64,6 +64,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -147,9 +148,7 @@ void setup(void)
 	sprintf(tstfile, "%s/tstfile_%d", mdir, getpid());
 
 	/* create "old" directory */
-	if (mkdir(fdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", fdir);
-	}
+	SAFE_MKDIR(cleanup, fdir, 00770);
 
 	if (stat(fdir, &buf1) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s"
@@ -162,9 +161,7 @@ void setup(void)
 	oldino = buf1.st_ino;
 
 	/* create another directory */
-	if (mkdir(mdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", mdir);
-	}
+	SAFE_MKDIR(cleanup, mdir, 00770);
 
 	SAFE_TOUCH(cleanup, tstfile, 0700, NULL);
 
diff --git a/testcases/kernel/syscalls/rename/rename05.c b/testcases/kernel/syscalls/rename/rename05.c
index 10825733f..b60da57f8 100644
--- a/testcases/kernel/syscalls/rename/rename05.c
+++ b/testcases/kernel/syscalls/rename/rename05.c
@@ -62,6 +62,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -154,9 +155,7 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "tmp directory %s found!", mdir);
 	}
 
-	if (mkdir(mdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", mdir);
-	}
+	SAFE_MKDIR(cleanup, mdir, 00770);
 
 	if (stat(mdir, &buf2) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
index b4bdda648..8ea96fd70 100644
--- a/testcases/kernel/syscalls/rename/rename06.c
+++ b/testcases/kernel/syscalls/rename/rename06.c
@@ -63,6 +63,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -139,9 +140,7 @@ void setup(void)
 	if (stat(fdir, &buf1) != -1) {
 		tst_brkm(TBROK, cleanup, "tmp directory %s found!", fdir);
 	}
-	if (mkdir(fdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", fdir);
-	}
+	SAFE_MKDIR(cleanup, fdir, 00770);
 	if (stat(fdir, &buf1) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
 			 "in rename()", fdir);
@@ -155,9 +154,7 @@ void setup(void)
 	if (stat(mdir, &buf2) != -1) {
 		tst_brkm(TBROK, cleanup, "tmp directory %s found!", mdir);
 	}
-	if (mkdir(mdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", mdir);
-	}
+	SAFE_MKDIR(cleanup, mdir, 00770);
 
 	if (stat(mdir, &buf2) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
diff --git a/testcases/kernel/syscalls/rename/rename07.c b/testcases/kernel/syscalls/rename/rename07.c
index b483a1c62..061d73556 100644
--- a/testcases/kernel/syscalls/rename/rename07.c
+++ b/testcases/kernel/syscalls/rename/rename07.c
@@ -45,6 +45,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -122,9 +123,7 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "tmp directory %s found!", fdir);
 	}
 
-	if (mkdir(fdir, 00770) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", fdir);
-	}
+	SAFE_MKDIR(cleanup, fdir, 00770);
 
 	if (stat(fdir, &buf1) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
index c620a463b..3555b41c3 100644
--- a/testcases/kernel/syscalls/rename/rename12.c
+++ b/testcases/kernel/syscalls/rename/rename12.c
@@ -194,9 +194,7 @@ void setup(void)
 	sprintf(mname, "%s/rnfile_%d", fdir, getpid());
 
 	/* create a directory */
-	if (mkdir(fdir, PERMS) == -1) {
-		tst_brkm(TBROK, cleanup, "Could not create directory %s", fdir);
-	}
+	SAFE_MKDIR(cleanup, fdir, PERMS);
 
 	if (stat(fdir, &buf1) == -1) {
 		tst_brkm(TBROK, cleanup, "failed to stat directory %s", fdir);
diff --git a/testcases/kernel/syscalls/rmdir/rmdir01.c b/testcases/kernel/syscalls/rmdir/rmdir01.c
index f7e176a6e..370e60726 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir01.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir01.c
@@ -63,6 +63,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -103,10 +104,7 @@ int main(int ac, char **av)
 		/* Initialize the test directory name */
 
 		/* create a directory */
-		if (mkdir(tstdir, PERMS) == -1) {
-			tst_brkm(TBROK, cleanup, "mkdir(%s, %#o) Failed",
-				 tstdir, PERMS);
-		}
+		SAFE_MKDIR(cleanup, tstdir, PERMS);
 		/* call rmdir using TEST macro */
 
 		TEST(rmdir(tstdir));
diff --git a/testcases/kernel/syscalls/rmdir/rmdir03.c b/testcases/kernel/syscalls/rmdir/rmdir03.c
index 8a42058f4..2bdc8bae1 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir03.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir03.c
@@ -132,10 +132,7 @@ int main(int ac, char **av)
 				 "tmp directory %s found!", tstdir1);
 		}
 		/* create a directory */
-		if (mkdir(tstdir1, PERMS) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "Couldnot create directory %s", tstdir1);
-		}
+		SAFE_MKDIR(cleanup, tstdir1, PERMS);
 		if (stat(tstdir1, &buf1) == -1) {
 			perror("stat");
 			tst_brkm(TBROK, cleanup, "failed to stat directory %s "
@@ -150,10 +147,7 @@ int main(int ac, char **av)
 
 		}
 		/* create a sub directory under tstdir1 */
-		if (mkdir(tstdir2, PERMS) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "Could not create directory %s", tstdir2);
-		}
+		SAFE_MKDIR(cleanup, tstdir2, PERMS);
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() failed");
@@ -172,15 +166,9 @@ int main(int ac, char **av)
 
 //test2:       $
 		/* create the a directory with 0700 permits */
-		if (mkdir(tstdir3, 0700) == -1) {
-			tst_brkm(TBROK, cleanup, "mkdir(%s, %#o) Failed",
-				 tstdir3, PERMS);
-		}
+		SAFE_MKDIR(cleanup, tstdir3, 0700);
 		/* create the a directory with 0700 permits */
-		if (mkdir(tstdir4, 0777) == -1) {
-			tst_brkm(TBROK, cleanup, "mkdir(%s, %#o) Failed",
-				 tstdir4, PERMS);
-		}
+		SAFE_MKDIR(cleanup, tstdir4, 0777);
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() failed");
diff --git a/testcases/kernel/syscalls/rmdir/rmdir04.c b/testcases/kernel/syscalls/rmdir/rmdir04.c
index 1b32dafba..fe5e320ca 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir04.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir04.c
@@ -118,6 +118,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -149,11 +150,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		if (mkdir(fname, 0777) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "mkdir(%s) Failure. errno=%d : %s", fname,
-				 errno, strerror(errno));
-		}
+		SAFE_MKDIR(cleanup, fname, 0777);
 		/*
 		 * Call rmdir(2)
 		 */
diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
index 2f0f10253..bef3b4702 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
@@ -45,6 +45,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include "test.h"
+#include "safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -214,9 +215,7 @@ void setup(void)
 	tst_tmpdir();
 
 	/* Create a directory. */
-	if (mkdir("dir1", 0777) == -1) {
-		tst_brkm(TBROK, cleanup, "mkdir() failed to create dir1.");
-	}
+	SAFE_MKDIR(cleanup, "dir1", 0777);
 
 	/* Create a unique directory name. */
 	sprintf(dir_name, "./dir_%d", getpid());
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 0ae452bc2..6b9c73213 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -58,6 +58,7 @@
 # include <sys/xattr.h>
 #endif
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "setxattr02";
 
@@ -203,9 +204,7 @@ static void setup(void)
 			 FILENAME);
 	close(fd);
 
-	if (mkdir(DIRNAME, 0644) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create test dir(%s) failed",
-			 DIRNAME);
+	SAFE_MKDIR(cleanup, DIRNAME, 0644);
 
 	if (symlink(FILENAME, SYMLINK) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "Create symlink(%s->%s)"
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index ef3991f26..0edf38646 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -279,9 +279,7 @@ int setup1(void)
 	int fd;			/* file handle for testfile */
 
 	/* Creat a test directory */
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 
 	/* Creat a test file under above test directory */
 	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1) {
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index c8b178a04..0ed4a349f 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -282,9 +282,7 @@ int setup1(void)
 {
 	int fd;			/* file handle for testfile */
 
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
 
 	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1) {
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index 8e471e28b..fbe624146 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -117,6 +117,7 @@
 #include <unistd.h>
 #include <string.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup(void);
 void cleanup(void);
@@ -278,11 +279,7 @@ int unwrite_dir_setup(int flag)
 	int fd;
 
 	if (!flag) {		/* initial setup */
-		if (mkdir("unwrite_dir", 0777) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "mkdir(unwrite_dir, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_MKDIR(cleanup, "unwrite_dir", 0777);
 
 		if ((fd = creat("unwrite_dir/file", 0777)) == -1) {
 			tst_brkm(TBROK, cleanup,
@@ -327,11 +324,7 @@ int unsearch_dir_setup(int flag)
 	int fd;
 
 	if (!flag) {		/* initial setup */
-		if (mkdir("unsearch_dir", 0777) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "mkdir(unsearch_dir, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_MKDIR(cleanup, "unsearch_dir", 0777);
 
 		if ((fd = creat("unsearch_dir/file", 0777)) == -1) {
 			tst_brkm(TBROK, cleanup,
@@ -373,11 +366,7 @@ int unsearch_dir_setup(int flag)
  ******************************************************************/
 int dir_setup(int flag)
 {
-	if (mkdir("regdir", 0777) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "mkdir(unwrite_dir, 0777) failed, errno:%d %s",
-			 errno, strerror(errno));
-	}
+	SAFE_MKDIR(cleanup, "regdir", 0777);
 	return 0;
 }
 
-- 
2.13.5

