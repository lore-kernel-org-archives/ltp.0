From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:47 +0200
Subject: [LTP] [COMMITTED] [PATCH 14/40] Make use of SAFE_SYMLINK()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-14-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/security/prot_hsymlinks/prot_hsymlinks.c |  6 +-----
 testcases/kernel/syscalls/lchown/lchown01.c         |  4 +---
 testcases/kernel/syscalls/lchown/lchown02.c         |  8 ++------
 testcases/kernel/syscalls/open/open07.c             | 21 +++++++--------------
 testcases/kernel/syscalls/readlink/readlink01.c     |  5 +----
 testcases/kernel/syscalls/readlink/readlink04.c     |  5 +----
 testcases/kernel/syscalls/setxattr/setxattr02.c     |  4 +---
 testcases/kernel/syscalls/symlink/symlink03.c       |  6 +-----
 8 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index ecfbd1533..058d7f982 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -453,11 +453,7 @@ static int create_check_slinks(const struct user_file *ufile, int owner)
 			slink_info.in_sticky = bdirs[dir].sticky;
 			slink_info.dir_owner = bdirs[dir].owner;
 
-			if (symlink(ufile->path, slink_info.path) == -1) {
-				tst_brkm(TBROK, cleanup,
-					"Can't create symlink: %s",
-					slink_info.path);
-			}
+			SAFE_SYMLINK(cleanup, ufile->path, slink_info.path);
 			result |= check_symlink(&slink_info);
 		}
 	}
diff --git a/testcases/kernel/syscalls/lchown/lchown01.c b/testcases/kernel/syscalls/lchown/lchown01.c
index 06ebd0c07..89c85e987 100644
--- a/testcases/kernel/syscalls/lchown/lchown01.c
+++ b/testcases/kernel/syscalls/lchown/lchown01.c
@@ -161,9 +161,7 @@ static void setup(void)
 	}
 	SAFE_CLOSE(cleanup, fd);
 
-	if (symlink(TESTFILE, SFILE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "symlink failed");
-	}
+	SAFE_SYMLINK(cleanup, TESTFILE, SFILE);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 245c86fa1..b5992a105 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -207,8 +207,7 @@ static void setup_eperm(int pos LTP_ATTRIBUTE_UNUSED)
 		tst_resm(TBROK | TERRNO, "setuid(0) failed");
 
 	/* create symling to testfile */
-	if (symlink(TEST_FILE1, SFILE1) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "symlink failed");
+	SAFE_SYMLINK(cleanup, TEST_FILE1, SFILE1);
 
 	/* back to the user nobody */
 	if (seteuid(ltpuser->pw_uid) == -1)
@@ -238,10 +237,7 @@ static void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
 	SAFE_CLOSE(cleanup, fd);
 
 	/* create a symlink of testfile */
-	if (symlink(TEST_FILE2, SFILE2) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "symlink(2) %s to %s failed",
-			 TEST_FILE2, SFILE2);
-	}
+	SAFE_SYMLINK(cleanup, TEST_FILE2, SFILE2);
 
 	/* modify mode permissions on test directory */
 	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
diff --git a/testcases/kernel/syscalls/open/open07.c b/testcases/kernel/syscalls/open/open07.c
index 934d6f512..b941f4b81 100644
--- a/testcases/kernel/syscalls/open/open07.c
+++ b/testcases/kernel/syscalls/open/open07.c
@@ -167,8 +167,7 @@ static void setupfunc_test1(void)
 	if (fd1 < 0)
 		tst_brkm(TBROK, cleanup, "creat(2) failed: errno: %d", errno);
 
-	if (symlink(file1, file2) < 0)
-		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
+	SAFE_SYMLINK(cleanup, file1, file2);
 
 	strcpy(TC[0].filename, file2);
 }
@@ -181,8 +180,7 @@ static void setupfunc_test2(void)
 	sprintf(file2, "open03.4.%d", getpid());
 	SAFE_MKDIR(cleanup, file1, 00700);
 
-	if (symlink(file1, file2) < 0)
-		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
+	SAFE_SYMLINK(cleanup, file1, file2);
 
 	strcpy(TC[1].filename, file2);
 }
@@ -198,11 +196,9 @@ static void setupfunc_test3(void)
 	if (fd2 < 0)
 		tst_brkm(TBROK, cleanup, "creat(2) failed: errno: %d", errno);
 
-	if (symlink(file1, file2) < 0)
-		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
+	SAFE_SYMLINK(cleanup, file1, file2);
 
-	if (symlink(file2, file3) < 0)
-		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
+	SAFE_SYMLINK(cleanup, file2, file3);
 
 	strcpy(TC[2].filename, file3);
 }
@@ -216,11 +212,9 @@ static void setupfunc_test4(void)
 	sprintf(file3, "open03.10.%d", getpid());
 	SAFE_MKDIR(cleanup, file1, 00700);
 
-	if (symlink(file1, file2) < 0)
-		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
+	SAFE_SYMLINK(cleanup, file1, file2);
 
-	if (symlink(file2, file3) < 0)
-		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
+	SAFE_SYMLINK(cleanup, file2, file3);
 
 	strcpy(TC[3].filename, file3);
 }
@@ -233,8 +227,7 @@ static void setupfunc_test5(void)
 	sprintf(file2, "open12.4.%d", getpid());
 	SAFE_MKDIR(cleanup, file1, 00700);
 
-	if (symlink(file1, file2) < 0)
-		tst_brkm(TBROK, cleanup, "symlink(2) failed: errno: %d", errno);
+	SAFE_SYMLINK(cleanup, file1, file2);
 
 	strcpy(TC[4].filename, file2);
 	strcat(TC[4].filename, "/");
diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index 3999a3a48..5f6448a2b 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -178,10 +178,7 @@ void setup(void)
 	}
 
 	/* Create a symlink of testfile under temporary directory */
-	if (symlink(TESTFILE, SYMFILE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "symlink(%s, %s) failed",
-			 TESTFILE, SYMFILE);
-	}
+	SAFE_SYMLINK(cleanup, TESTFILE, SYMFILE);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
index 13175145d..8e1582142 100644
--- a/testcases/kernel/syscalls/readlink/readlink04.c
+++ b/testcases/kernel/syscalls/readlink/readlink04.c
@@ -136,10 +136,7 @@ static void setup(void)
 	if (close(fd))
 		tst_brkm(TBROK|TERRNO, cleanup, "close(%s) failed", TESTFILE);
 
-	if (symlink(TESTFILE, SYMFILE) < 0) {
-		tst_brkm(TBROK|TERRNO, cleanup, "symlink(%s, %s) failed",
-		         TESTFILE, SYMFILE);
-	}
+	SAFE_SYMLINK(cleanup, TESTFILE, SYMFILE);
 
 	/* set up the expected return value from the readlink() call */
 	exp_val = strlen(TESTFILE);
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 6b9c73213..b16ddce94 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -206,9 +206,7 @@ static void setup(void)
 
 	SAFE_MKDIR(cleanup, DIRNAME, 0644);
 
-	if (symlink(FILENAME, SYMLINK) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create symlink(%s->%s)"
-			 " failed", SYMLINK, FILENAME);
+	SAFE_SYMLINK(cleanup, FILENAME, SYMLINK);
 
 	if (mknod(FIFO, S_IFIFO | 0777, 0) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "Create FIFO(%s) failed",
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index 0ed4a349f..dc6d12262 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -313,11 +313,7 @@ int setup2(void)
 	}
 	SAFE_CLOSE(cleanup, fd);
 
-	if (symlink(TEST_FILE2, SYM_FILE2) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "symlink() Fails to create %s in setup2, error=%d",
-			 SYM_FILE2, errno);
-	}
+	SAFE_SYMLINK(cleanup, TEST_FILE2, SYM_FILE2);
 	return 0;
 }
 
-- 
2.13.5

