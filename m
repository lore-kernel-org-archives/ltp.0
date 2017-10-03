From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:48 +0200
Subject: [LTP] [COMMITTED] [PATCH 15/40] Make use of SAFE_CHMOD()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-15-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_tmpdir.c                              |  7 ++----
 testcases/kernel/syscalls/chown/chown02.c     |  4 +--
 testcases/kernel/syscalls/inotify/inotify01.c |  5 +---
 testcases/kernel/syscalls/inotify/inotify02.c |  5 +---
 testcases/kernel/syscalls/lchown/lchown02.c   |  5 +---
 testcases/kernel/syscalls/lstat/lstat02.c     |  3 +--
 testcases/kernel/syscalls/mknod/mknod03.c     |  4 +--
 testcases/kernel/syscalls/mknod/mknod04.c     |  4 +--
 testcases/kernel/syscalls/mknod/mknod05.c     |  4 +--
 testcases/kernel/syscalls/stat/stat02.c       |  6 ++---
 testcases/kernel/syscalls/stat/stat03.c       |  4 +--
 testcases/kernel/syscalls/statfs/statfs03.c   |  5 ++--
 testcases/kernel/syscalls/symlink/symlink03.c |  8 ++----
 testcases/kernel/syscalls/unlink/unlink08.c   | 36 +++++----------------------
 14 files changed, 23 insertions(+), 77 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 824caded5..5cd554361 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -71,6 +71,7 @@
 #include <fcntl.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "ltp_priv.h"
 #include "lapi/futex.h"
 
@@ -276,11 +277,7 @@ void tst_tmpdir(void)
 		return;
 	}
 
-	if (chmod(TESTDIR, DIR_MODE) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
-		return;
-	}
+	SAFE_CHMOD(NULL, TESTDIR, DIR_MODE);
 
 	if (getcwd(test_start_work_dir, sizeof(test_start_work_dir)) == NULL) {
 		tst_resm(TINFO, "Failed to record test working dir");
diff --git a/testcases/kernel/syscalls/chown/chown02.c b/testcases/kernel/syscalls/chown/chown02.c
index f1d905e22..a459f092b 100644
--- a/testcases/kernel/syscalls/chown/chown02.c
+++ b/testcases/kernel/syscalls/chown/chown02.c
@@ -242,9 +242,7 @@ int setup1(void)
 	SAFE_CLOSE(cleanup, fd);
 
 	/* Set setuid/setgid bits on the test file created */
-	if (chmod(TESTFILE1, NEW_PERMS1) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, ..) failed",
-			 TESTFILE1);
+	SAFE_CHMOD(cleanup, TESTFILE1, NEW_PERMS1);
 	return 0;
 }
 
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 753154076..8a471ae5f 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -81,10 +81,7 @@ int main(int ac, char **av)
 		/*
 		 * generate sequence of events
 		 */
-		if (chmod(fname, 0755) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "chmod(%s, 0755) failed", fname);
-		}
+		SAFE_CHMOD(cleanup, fname, 0755);
 		event_set[tst_count] = IN_ATTRIB;
 		tst_count++;
 
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index ff5be64ae..2c92f1616 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -95,10 +95,7 @@ int main(int ac, char **av)
 		/*
 		 * generate sequence of events
 		 */
-		if (chmod(".", 0755) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "chmod(\".\", 0755) failed");
-		}
+		SAFE_CHMOD(cleanup, ".", 0755);
 		event_set[tst_count].mask = IN_ISDIR | IN_ATTRIB;
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index b5992a105..326e584c9 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -240,10 +240,7 @@ static void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
 	SAFE_SYMLINK(cleanup, TEST_FILE2, SFILE2);
 
 	/* modify mode permissions on test directory */
-	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(2) %s failed",
-			 DIR_TEMP);
-	}
+	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
index afc2c7c3c..ab4678704 100644
--- a/testcases/kernel/syscalls/lstat/lstat02.c
+++ b/testcases/kernel/syscalls/lstat/lstat02.c
@@ -124,8 +124,7 @@ static void setup(void)
 
 	SAFE_MKDIR(cleanup, TEST_DIR, MODE_RWX);
 	SAFE_TOUCH(cleanup, TEST_EACCES, 0666, NULL);
-	if (chmod(TEST_DIR, FILE_MODE) < 0)
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", TEST_DIR);
+	SAFE_CHMOD(cleanup, TEST_DIR, FILE_MODE);
 
 	SAFE_TOUCH(cleanup, "test_file", MODE_RWX, NULL);
 
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 4541b93e5..919327a65 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -238,9 +238,7 @@ void setup(void)
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
-	if (chmod(DIR_TEMP, MODE_SGID) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_SGID);
 
 	/*
 	 * Verify that test directory created with expected permission modes
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index 8cbc5401b..205bdcb36 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -240,9 +240,7 @@ void setup(void)
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
-	if (chmod(DIR_TEMP, MODE_SGID) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_SGID);
 
 	/*
 	 * Verify that test directory created with expected permission modes
diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index 4edcb9394..a7a5ea8ee 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -232,9 +232,7 @@ void setup(void)
 	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
 		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
 	}
-	if (chmod(DIR_TEMP, MODE_SGID) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_SGID);
 
 	/*
 	 * Verify that test directory created with expected permission modes
diff --git a/testcases/kernel/syscalls/stat/stat02.c b/testcases/kernel/syscalls/stat/stat02.c
index 1b7d60f53..aeaa7ab82 100644
--- a/testcases/kernel/syscalls/stat/stat02.c
+++ b/testcases/kernel/syscalls/stat/stat02.c
@@ -77,6 +77,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define TESTFILE	"testfile"
@@ -207,10 +208,7 @@ void setup(void)
 	}
 
 	/* Modify mode permissions on the testfile */
-	if (chmod(TESTFILE, NEW_MODE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "chmodding %s failed",
-			 TESTFILE);
-	}
+	SAFE_CHMOD(cleanup, TESTFILE, NEW_MODE);
 
 	/* Get the uid/gid of the process */
 	user_id = getuid();
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 0edf38646..ef3d93742 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -291,9 +291,7 @@ int setup1(void)
 	SAFE_CLOSE(cleanup, fd);
 
 	/* Modify mode permissions on test directory */
-	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
 	return 0;
 }
 
diff --git a/testcases/kernel/syscalls/statfs/statfs03.c b/testcases/kernel/syscalls/statfs/statfs03.c
index ab9720885..32aaf830e 100644
--- a/testcases/kernel/syscalls/statfs/statfs03.c
+++ b/testcases/kernel/syscalls/statfs/statfs03.c
@@ -54,6 +54,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <pwd.h>
 
 char *TCID = "statfs03";
@@ -119,9 +120,7 @@ void setup(void)
 
 	/* make a temporary directory and cd to it */
 	tst_tmpdir();
-	if (chmod(tst_get_tmpdir(), S_IRWXU) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, 700) failed",
-			 tst_get_tmpdir());
+	SAFE_CHMOD(cleanup, tst_get_tmpdir(), S_IRWXU);
 
 	/* create a test file */
 	sprintf(fname, "%s.%d", fname, getpid());
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index dc6d12262..89f23c952 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -292,9 +292,7 @@ int setup1(void)
 	SAFE_CLOSE(cleanup, fd);
 
 	/* Modify mode permissions on test directory */
-	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
 	return 0;
 }
 
@@ -367,9 +365,7 @@ void cleanup(void)
 {
 
 	/* Restore mode permissions on test directory created in setup2() */
-	if (chmod(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, NULL, "chmod(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHMOD(NULL, DIR_TEMP, MODE_RWX);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index fbe624146..9829a7c11 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -288,17 +288,9 @@ int unwrite_dir_setup(int flag)
 		}
 		close(fd);
 
-		if (chmod("unwrite_dir", 0555) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "chmod(unwrite_dir, 0555) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_CHMOD(cleanup, "unwrite_dir", 0555);
 	} else {		/* resetup */
-		if (chmod("unwrite_dir", 0777) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "chmod(unwrite_dir, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_CHMOD(cleanup, "unwrite_dir", 0777);
 
 		if ((fd = creat("unwrite_dir/file", 0777)) == -1) {
 			tst_brkm(TBROK, cleanup,
@@ -307,11 +299,7 @@ int unwrite_dir_setup(int flag)
 		}
 		close(fd);
 
-		if (chmod("unwrite_dir", 0555) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "chmod(unwrite_dir, 0555) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_CHMOD(cleanup, "unwrite_dir", 0555);
 	}
 	return 0;
 }
@@ -333,17 +321,9 @@ int unsearch_dir_setup(int flag)
 		}
 		close(fd);
 
-		if (chmod("unsearch_dir", 0666) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "chmod(unsearch_dir, 0666) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_CHMOD(cleanup, "unsearch_dir", 0666);
 	} else {		/* resetup */
-		if (chmod("unsearch_dir", 0777) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "chmod(unsearch_dir, 0777) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_CHMOD(cleanup, "unsearch_dir", 0777);
 
 		if ((fd = creat("unsearch_dir/file", 0777)) == -1) {
 			tst_brkm(TBROK, cleanup,
@@ -352,11 +332,7 @@ int unsearch_dir_setup(int flag)
 		}
 		close(fd);
 
-		if (chmod("unsearch_dir", 0666) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "chmod(unsearch_dir, 0666) failed, errno:%d %s",
-				 errno, strerror(errno));
-		}
+		SAFE_CHMOD(cleanup, "unsearch_dir", 0666);
 	}
 	return 0;
 }
-- 
2.13.5

