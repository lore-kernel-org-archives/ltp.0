From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:03 +0200
Subject: [LTP] [COMMITTED] [PATCH 30/40] Make use of SAFE_STAT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-30-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/asyncio/asyncio02.c   |  4 +---
 testcases/kernel/syscalls/mkdir/mkdir05.c       |  5 +----
 testcases/kernel/syscalls/mknod/mknod02.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod03.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod04.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod05.c       |  4 +---
 testcases/kernel/syscalls/mknod/mknod08.c       |  4 +---
 testcases/kernel/syscalls/mount/mount03.c       |  3 +--
 testcases/kernel/syscalls/rename/rename01.c     | 18 +++---------------
 testcases/kernel/syscalls/rename/rename03.c     | 18 +++---------------
 testcases/kernel/syscalls/rename/rename04.c     | 12 ++----------
 testcases/kernel/syscalls/rename/rename05.c     | 12 ++----------
 testcases/kernel/syscalls/rename/rename06.c     | 12 ++----------
 testcases/kernel/syscalls/rename/rename07.c     | 12 ++----------
 testcases/kernel/syscalls/rename/rename12.c     |  5 +----
 testcases/kernel/syscalls/rename/rename13.c     | 18 +++---------------
 testcases/kernel/syscalls/sendfile/sendfile02.c |  5 ++---
 testcases/kernel/syscalls/sendfile/sendfile04.c |  4 +---
 testcases/kernel/syscalls/sendfile/sendfile05.c |  5 ++---
 19 files changed, 31 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/syscalls/asyncio/asyncio02.c b/testcases/kernel/syscalls/asyncio/asyncio02.c
index 6f7ef9110..e532cc287 100644
--- a/testcases/kernel/syscalls/asyncio/asyncio02.c
+++ b/testcases/kernel/syscalls/asyncio/asyncio02.c
@@ -248,9 +248,7 @@ int testrun(int flag, int bytes, int ti)
 	 *  same as the number of bytes in the file.
 	 */
 
-	if (stat(filename, &buffer) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "stat() failed");
-	}
+	SAFE_STAT(cleanup, filename, &buffer);
 
 	if (buffer.st_size != (off_t) (bytes * WRITES)) {
 		ret = (int)buffer.st_size;
diff --git a/testcases/kernel/syscalls/mkdir/mkdir05.c b/testcases/kernel/syscalls/mkdir/mkdir05.c
index ee52771c8..3d25c439d 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir05.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir05.c
@@ -84,10 +84,7 @@ int main(int ac, char **av)
 			continue;
 		}
 
-		if (stat(tstdir1, &buf) == -1) {
-			tst_brkm(TBROK, cleanup, "failed to stat the "
-				 "new directory");
-		}
+		SAFE_STAT(cleanup, tstdir1, &buf);
 		/* check the owner */
 		if (buf.st_uid != geteuid()) {
 			tst_resm(TFAIL, "mkdir() FAILED to set owner ID"
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index 7ac8db5ef..e5741c3d6 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -244,9 +244,7 @@ void setup(void)
 	 * Verify that test directory created with expected permission modes
 	 * and ownerships.
 	 */
-	if (stat(DIR_TEMP, &buf) < 0) {
-		tst_brkm(TBROK, cleanup, "stat(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_STAT(cleanup, DIR_TEMP, &buf);
 
 	/* Verify modes of test directory */
 	if (buf.st_mode & S_ISGID) {
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 8fd58a732..fc3468673 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -242,9 +242,7 @@ void setup(void)
 	 * Verify that test directory created with expected permission modes
 	 * and ownerships.
 	 */
-	if (stat(DIR_TEMP, &buf) < 0) {
-		tst_brkm(TBROK, cleanup, "stat(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_STAT(cleanup, DIR_TEMP, &buf);
 
 	/* Verify modes of test directory */
 	if (!(buf.st_mode & S_ISGID)) {
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index 9615c15a6..6a8e08e54 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -244,9 +244,7 @@ void setup(void)
 	 * Verify that test directory created with expected permission modes
 	 * and ownerships.
 	 */
-	if (stat(DIR_TEMP, &buf) < 0) {
-		tst_brkm(TBROK, cleanup, "stat(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_STAT(cleanup, DIR_TEMP, &buf);
 
 	/* Verify modes of test directory */
 	if (!(buf.st_mode & S_ISGID)) {
diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index 57f097b9e..a00a0e441 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -236,9 +236,7 @@ void setup(void)
 	 * Verify that test directory created with expected permission modes
 	 * and ownerships.
 	 */
-	if (stat(DIR_TEMP, &buf) < 0) {
-		tst_brkm(TBROK, cleanup, "stat(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_STAT(cleanup, DIR_TEMP, &buf);
 	/* Verify modes of test directory */
 	if (!(buf.st_mode & S_ISGID)) {
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
index 39c024833..3cc24ab65 100644
--- a/testcases/kernel/syscalls/mknod/mknod08.c
+++ b/testcases/kernel/syscalls/mknod/mknod08.c
@@ -239,9 +239,7 @@ void setup(void)
 	 * Verify that test directory created with expected permission modes
 	 * and ownerships.
 	 */
-	if (stat(DIR_TEMP, &buf) < 0) {
-		tst_brkm(TBROK, cleanup, "stat(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_STAT(cleanup, DIR_TEMP, &buf);
 
 	/* Verify modes of test directory */
 	if (buf.st_mode & S_ISGID) {
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index a8abbff73..bf78c797f 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -264,8 +264,7 @@ int test_rwflag(int i, int cnt)
 		snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
 		SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");
 
-		if (stat(file, &file_stat) < 0)
-			tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
+		SAFE_STAT(cleanup, file, &file_stat);
 
 		if (file_stat.st_mode != SUID_MODE &&
 		    chmod(file, SUID_MODE) < 0)
diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index 80977d35f..e7de18ff4 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -133,11 +133,7 @@ int main(int ac, char **av)
 				continue;
 			}
 
-			if (stat(TC[i].name2, &buf1) == -1) {
-				tst_brkm(TBROK, cleanup, "stat of %s "
-					 "failed", TC[i].desc);
-
-			}
+			SAFE_STAT(cleanup, TC[i].name2, &buf1);
 
 			/*
 			 * verify the new file or directory is the
@@ -194,11 +190,7 @@ void setup(void)
 
 	SAFE_TOUCH(cleanup, fname, 0700, NULL);
 
-	if (stat(fname, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat file %s"
-			 "in setup()", fname);
-
-	}
+	SAFE_STAT(cleanup, fname, &buf1);
 
 	f_olddev = buf1.st_dev;
 	f_oldino = buf1.st_ino;
@@ -206,11 +198,7 @@ void setup(void)
 	/* create "old" directory */
 	SAFE_MKDIR(cleanup, fdir, 00770);
 
-	if (stat(fdir, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s"
-			 "in setup()", fname);
-
-	}
+	SAFE_STAT(cleanup, fdir, &buf1);
 
 	d_olddev = buf1.st_dev;
 	d_oldino = buf1.st_ino;
diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
index 6ffbe5628..396e95c4d 100644
--- a/testcases/kernel/syscalls/rename/rename03.c
+++ b/testcases/kernel/syscalls/rename/rename03.c
@@ -130,11 +130,7 @@ int main(int ac, char **av)
 				continue;
 			}
 
-			if (stat(TC[i].name2, &buf2) == -1) {
-				tst_brkm(TBROK, cleanup, "stat of %s "
-					 "failed", TC[i].desc);
-
-			}
+			SAFE_STAT(cleanup, TC[i].name2, &buf2);
 
 			/*
 			 * verify the new file or directory is the
@@ -201,11 +197,7 @@ void setup2(void)
 {
 	SAFE_TOUCH(cleanup, fname, 0700, NULL);
 
-	if (stat(fname, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat file %s"
-			 "in rename()", fname);
-
-	}
+	SAFE_STAT(cleanup, fname, &buf1);
 
 	/* save original file's dev and ino */
 	f_olddev = buf1.st_dev;
@@ -215,11 +207,7 @@ void setup2(void)
 
 	/* create "old" directory */
 	SAFE_MKDIR(cleanup, fdir, 00770);
-	if (stat(fdir, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s"
-			 "in rename()", fdir);
-
-	}
+	SAFE_STAT(cleanup, fdir, &buf1);
 
 	d_olddev = buf1.st_dev;
 	d_oldino = buf1.st_ino;
diff --git a/testcases/kernel/syscalls/rename/rename04.c b/testcases/kernel/syscalls/rename/rename04.c
index 5c6d4fda8..32594a776 100644
--- a/testcases/kernel/syscalls/rename/rename04.c
+++ b/testcases/kernel/syscalls/rename/rename04.c
@@ -150,11 +150,7 @@ void setup(void)
 	/* create "old" directory */
 	SAFE_MKDIR(cleanup, fdir, 00770);
 
-	if (stat(fdir, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s"
-			 "in rename()", fdir);
-
-	}
+	SAFE_STAT(cleanup, fdir, &buf1);
 
 	/* save "old"'s dev and ino */
 	olddev = buf1.st_dev;
@@ -165,11 +161,7 @@ void setup(void)
 
 	SAFE_TOUCH(cleanup, tstfile, 0700, NULL);
 
-	if (stat(mdir, &buf2) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
-			 "in rename()", mdir);
-
-	}
+	SAFE_STAT(cleanup, mdir, &buf2);
 
 	/* save "new"'s dev and ino */
 	olddev1 = buf2.st_dev;
diff --git a/testcases/kernel/syscalls/rename/rename05.c b/testcases/kernel/syscalls/rename/rename05.c
index b60da57f8..db10720fe 100644
--- a/testcases/kernel/syscalls/rename/rename05.c
+++ b/testcases/kernel/syscalls/rename/rename05.c
@@ -140,11 +140,7 @@ void setup(void)
 
 	/* create "old" file */
 	SAFE_TOUCH(cleanup, fname, 0700, NULL);
-	if (stat(fname, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat file %s"
-			 "in rename()", fname);
-
-	}
+	SAFE_STAT(cleanup, fname, &buf1);
 
 	/* save "old"'s dev and ino */
 	olddev = buf1.st_dev;
@@ -157,11 +153,7 @@ void setup(void)
 
 	SAFE_MKDIR(cleanup, mdir, 00770);
 
-	if (stat(mdir, &buf2) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
-			 "in rename()", mdir);
-
-	}
+	SAFE_STAT(cleanup, mdir, &buf2);
 
 	/* save "new"'s dev and ino */
 	olddev1 = buf2.st_dev;
diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
index 8ea96fd70..e415b4158 100644
--- a/testcases/kernel/syscalls/rename/rename06.c
+++ b/testcases/kernel/syscalls/rename/rename06.c
@@ -141,11 +141,7 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "tmp directory %s found!", fdir);
 	}
 	SAFE_MKDIR(cleanup, fdir, 00770);
-	if (stat(fdir, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
-			 "in rename()", fdir);
-
-	}
+	SAFE_STAT(cleanup, fdir, &buf1);
 	/* save "old"'s dev and ino */
 	olddev = buf1.st_dev;
 	oldino = buf1.st_ino;
@@ -156,11 +152,7 @@ void setup(void)
 	}
 	SAFE_MKDIR(cleanup, mdir, 00770);
 
-	if (stat(mdir, &buf2) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
-			 "in rename()", mdir);
-
-	}
+	SAFE_STAT(cleanup, mdir, &buf2);
 
 	/* save "new"'s dev and ino */
 	olddev1 = buf2.st_dev;
diff --git a/testcases/kernel/syscalls/rename/rename07.c b/testcases/kernel/syscalls/rename/rename07.c
index 061d73556..5b95f84bb 100644
--- a/testcases/kernel/syscalls/rename/rename07.c
+++ b/testcases/kernel/syscalls/rename/rename07.c
@@ -125,11 +125,7 @@ void setup(void)
 
 	SAFE_MKDIR(cleanup, fdir, 00770);
 
-	if (stat(fdir, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s "
-			 "in rename()", fdir);
-
-	}
+	SAFE_STAT(cleanup, fdir, &buf1);
 
 	/* save "old"'s dev and ino */
 	olddev = buf1.st_dev;
@@ -137,11 +133,7 @@ void setup(void)
 
 	SAFE_TOUCH(cleanup, mname, 0700, NULL);
 
-	if (stat(mname, &buf2) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat file %s in rename()",
-			 mname);
-
-	}
+	SAFE_STAT(cleanup, mname, &buf2);
 
 	/* save "new"'s dev and ino */
 	olddev1 = buf2.st_dev;
diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
index 3555b41c3..36691783f 100644
--- a/testcases/kernel/syscalls/rename/rename12.c
+++ b/testcases/kernel/syscalls/rename/rename12.c
@@ -196,10 +196,7 @@ void setup(void)
 	/* create a directory */
 	SAFE_MKDIR(cleanup, fdir, PERMS);
 
-	if (stat(fdir, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat directory %s", fdir);
-
-	}
+	SAFE_STAT(cleanup, fdir, &buf1);
 
 	/* set the sticky bit */
 	if (chmod(fdir, buf1.st_mode | S_ISVTX) != 0) {
diff --git a/testcases/kernel/syscalls/rename/rename13.c b/testcases/kernel/syscalls/rename/rename13.c
index 72394a2d7..07a90c4d1 100644
--- a/testcases/kernel/syscalls/rename/rename13.c
+++ b/testcases/kernel/syscalls/rename/rename13.c
@@ -114,18 +114,10 @@ int main(int ac, char **av)
 		}
 
 		/* check the existence of "new", and get the status */
-		if (stat(mname, &buf2) == -1) {
-			tst_brkm(TBROK, cleanup, "failed to stat file "
-				 "%s in rename()", mname);
-
-		}
+		SAFE_STAT(cleanup, mname, &buf2);
 
 		/* check the existence of "old", and get the status */
-		if (stat(fname, &buf1) == -1) {
-			tst_brkm(TBROK, cleanup, "failed to stat file "
-				 "%s in rename()", fname);
-
-		}
+		SAFE_STAT(cleanup, fname, &buf1);
 
 		/* verify the new file is the same as the original */
 		if (buf2.st_dev != olddev || buf2.st_ino != oldino) {
@@ -169,11 +161,7 @@ void setup(void)
 
 	SAFE_TOUCH(cleanup, fname, 0700, NULL);
 
-	if (stat(fname, &buf1) == -1) {
-		tst_brkm(TBROK, cleanup, "failed to stat file %s"
-			 "in rename()", fname);
-
-	}
+	SAFE_STAT(cleanup, fname, &buf1);
 
 	/* save the dev and inode */
 	olddev = buf1.st_dev;
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index ba12308b3..111b2741a 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -57,6 +57,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef OFF_T
 #define OFF_T off_t
@@ -107,9 +108,7 @@ void do_sendfile(OFF_T offset, int i)
 	if ((in_fd = open(in_file, O_RDONLY)) < 0) {
 		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
 	}
-	if (stat(in_file, &sb) < 0) {
-		tst_brkm(TBROK, cleanup, "stat failed: %d", errno);
-	}
+	SAFE_STAT(cleanup, in_file, &sb);
 
 	if ((before_pos = lseek(in_fd, 0, SEEK_CUR)) < 0) {
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 779e7dc70..13389150c 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -115,9 +115,7 @@ void do_sendfile(int prot, int pass_unmapped_buffer)
 	if ((in_fd = open(in_file, O_RDONLY)) < 0) {
 		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
 	}
-	if (stat(in_file, &sb) < 0) {
-		tst_brkm(TBROK, cleanup, "stat failed: %d", errno);
-	}
+	SAFE_STAT(cleanup, in_file, &sb);
 
 	if (pass_unmapped_buffer) {
 		SAFE_MUNMAP(cleanup, protected_buffer,
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 110194b84..1c700a61f 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -52,6 +52,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef OFF_T
 #define OFF_T off_t
@@ -88,9 +89,7 @@ void do_sendfile(void)
 	if ((in_fd = open(in_file, O_RDONLY)) < 0) {
 		tst_brkm(TBROK, cleanup, "open failed: %d", errno);
 	}
-	if (stat(in_file, &sb) < 0) {
-		tst_brkm(TBROK, cleanup, "stat failed: %d", errno);
-	}
+	SAFE_STAT(cleanup, in_file, &sb);
 
 	offset = -1;
 	TEST(sendfile(out_fd, in_fd, &offset, sb.st_size));
-- 
2.13.5

