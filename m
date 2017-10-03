From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:35 +0200
Subject: [LTP] [COMMITTED] [PATCH 02/40] Make use of SAFE_CLOSE()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/io/direct_io/diotest4.c               |  6 ++----
 .../kernel/security/prot_hsymlinks/prot_hsymlinks.c    |  3 +--
 testcases/kernel/syscalls/asyncio/asyncio02.c          |  5 ++---
 testcases/kernel/syscalls/chmod/chmod01.c              |  4 ++--
 testcases/kernel/syscalls/chmod/chmod03.c              |  5 ++---
 testcases/kernel/syscalls/chmod/chmod07.c              |  4 ++--
 testcases/kernel/syscalls/chown/chown02.c              |  9 +++------
 testcases/kernel/syscalls/chown/chown03.c              |  5 ++---
 testcases/kernel/syscalls/chown/chown05.c              |  4 ++--
 testcases/kernel/syscalls/dup/dup01.c                  |  6 ++----
 testcases/kernel/syscalls/dup/dup02.c                  |  5 ++---
 testcases/kernel/syscalls/dup/dup03.c                  |  5 ++---
 testcases/kernel/syscalls/dup/dup04.c                  |  8 +++-----
 testcases/kernel/syscalls/dup/dup05.c                  |  5 ++---
 testcases/kernel/syscalls/dup2/dup203.c                | 11 ++++-------
 testcases/kernel/syscalls/dup2/dup204.c                |  5 ++---
 testcases/kernel/syscalls/fchmod/fchmod02.c            |  6 ++----
 testcases/kernel/syscalls/fchmod/fchmod04.c            |  7 ++-----
 testcases/kernel/syscalls/fchmod/fchmod05.c            |  7 ++-----
 testcases/kernel/syscalls/fchmod/fchmod07.c            |  7 ++-----
 testcases/kernel/syscalls/fdatasync/fdatasync02.c      |  5 ++---
 testcases/kernel/syscalls/fstat/fstat03.c              |  5 ++---
 testcases/kernel/syscalls/fstat/fstat05.c              |  5 ++---
 testcases/kernel/syscalls/getdents/getdents01.c        |  3 +--
 testcases/kernel/syscalls/inotify/inotify01.c          | 13 ++++---------
 testcases/kernel/syscalls/inotify/inotify02.c          |  6 ++----
 testcases/kernel/syscalls/inotify/inotify03.c          |  4 ++--
 testcases/kernel/syscalls/ioctl/ioctl02.c              |  7 +++----
 testcases/kernel/syscalls/lchown/lchown01.c            |  5 ++---
 testcases/kernel/syscalls/lchown/lchown02.c            | 11 ++++-------
 testcases/kernel/syscalls/llseek/llseek02.c            |  6 ++----
 testcases/kernel/syscalls/mprotect/mprotect03.c        |  4 +---
 testcases/kernel/syscalls/mremap/mremap01.c            |  5 ++---
 testcases/kernel/syscalls/munmap/munmap02.c            |  6 ++----
 testcases/kernel/syscalls/pread/pread01.c              |  6 ++----
 testcases/kernel/syscalls/pread/pread02.c              |  6 ++----
 testcases/kernel/syscalls/pwrite/pwrite01.c            |  6 ++----
 testcases/kernel/syscalls/read/read04.c                |  5 ++---
 testcases/kernel/syscalls/readahead/readahead02.c      |  3 +--
 testcases/kernel/syscalls/readv/readv02.c              |  5 ++---
 testcases/kernel/syscalls/readv/readv03.c              |  5 ++---
 testcases/kernel/syscalls/stat/stat03.c                | 13 +++----------
 testcases/kernel/syscalls/symlink/symlink03.c          | 18 ++++--------------
 testcases/kernel/syscalls/truncate/truncate01.c        |  7 ++-----
 44 files changed, 96 insertions(+), 180 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index f3b7d3ba8..dbcacf1ae 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -70,6 +70,7 @@
 #include "diotest_routines.h"
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "diotest4";	/* Test program identifier.    */
 int TST_TOTAL = 17;		/* Total number of test conditions */
@@ -329,10 +330,7 @@ int main(int argc, char *argv[])
 	/* Test-7: Closed file descriptor */
 	offset = 4096;
 	count = bufsize;
-	if (close(fd) < 0) {
-		tst_brkm(TBROK, cleanup, "can't close fd %d: %s", fd,
-			 strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd);
 	ret = runtest_f(fd, buf2, offset, count, EBADF, 7, "closed fd");
 	testcheck_end(ret, &failed, &fail_count, "Closed file descriptor");
 	total++;
diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 1d615ae5b..ecfbd1533 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -554,8 +554,7 @@ static int try_open(const char *name, int mode)
 	if (fd == -1)
 		return fd;
 
-	if (close(fd) == -1)
-		tst_brkm(TBROK, cleanup, "Can't close file: %s", name);
+	SAFE_CLOSE(cleanup, fd);
 
 	return 0;
 }
diff --git a/testcases/kernel/syscalls/asyncio/asyncio02.c b/testcases/kernel/syscalls/asyncio/asyncio02.c
index e97cc4932..9e3ca7ad4 100644
--- a/testcases/kernel/syscalls/asyncio/asyncio02.c
+++ b/testcases/kernel/syscalls/asyncio/asyncio02.c
@@ -97,6 +97,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define FLAG O_RDWR | O_CREAT | O_TRUNC	/* Flags used when opening temp tile */
 #define MODE  0777		/* Mode to open file with */
@@ -238,9 +239,7 @@ int testrun(int flag, int bytes, int ti)
 	 *      Attempt to close the file which also flushes the buffers.
 	 */
 
-	if (close(fildes) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "close() failed");
-	}
+	SAFE_CLOSE(cleanup, fildes);
 
 	ret = OK;
 
diff --git a/testcases/kernel/syscalls/chmod/chmod01.c b/testcases/kernel/syscalls/chmod/chmod01.c
index 9631c92a1..4428c9cd1 100644
--- a/testcases/kernel/syscalls/chmod/chmod01.c
+++ b/testcases/kernel/syscalls/chmod/chmod01.c
@@ -76,6 +76,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define TESTFILE	"testfile"
@@ -152,8 +153,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_RDWR|O_CREAT, %o) failed",
 			 TESTFILE, FILE_MODE);
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", TESTFILE);
+	SAFE_CLOSE(cleanup, fd);
 
 }
 
diff --git a/testcases/kernel/syscalls/chmod/chmod03.c b/testcases/kernel/syscalls/chmod/chmod03.c
index 47c5c97f9..1ea242396 100644
--- a/testcases/kernel/syscalls/chmod/chmod03.c
+++ b/testcases/kernel/syscalls/chmod/chmod03.c
@@ -80,6 +80,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define FILE_MODE       S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define PERMS		01777	/*
@@ -167,9 +168,7 @@ void setup(void)
 			 TESTFILE, FILE_MODE);
 	}
 
-	if (close(fd) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", TESTFILE);
-	}
+	SAFE_CLOSE(cleanup, fd);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index c7508ff9c..1cfec3bd0 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -81,6 +81,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define LTPUSER		"nobody"
 #define LTPGRP		"users"
@@ -182,8 +183,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
 			 TESTFILE, FILE_MODE);
-	if (close(fd) == -1)
-		tst_brkm(TBROK, cleanup, "close(%s) failed", TESTFILE);
+	SAFE_CLOSE(cleanup, fd);
 	if (chown(TESTFILE, user1_uid, group1_gid) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "chown(%s) failed", TESTFILE);
 
diff --git a/testcases/kernel/syscalls/chown/chown02.c b/testcases/kernel/syscalls/chown/chown02.c
index 227986eff..f1d905e22 100644
--- a/testcases/kernel/syscalls/chown/chown02.c
+++ b/testcases/kernel/syscalls/chown/chown02.c
@@ -78,6 +78,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
@@ -238,9 +239,7 @@ int setup1(void)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_RDWR|O_CREAT, %o) failed",
 			 TESTFILE1, FILE_MODE);
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
-			 TESTFILE1);
+	SAFE_CLOSE(cleanup, fd);
 
 	/* Set setuid/setgid bits on the test file created */
 	if (chmod(TESTFILE1, NEW_PERMS1) == -1)
@@ -268,9 +267,7 @@ int setup2(void)
 	/* Set setgid bit on the test file created */
 	if (fchmod(fd, NEW_PERMS2) != 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "fchmod failed");
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
-			 TESTFILE2);
+	SAFE_CLOSE(cleanup, fd);
 	return 0;
 }
 
diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index fdf40014f..6188315df 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -81,6 +81,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
@@ -194,9 +195,7 @@ void setup(void)
 	if (seteuid(ltpuser->pw_uid) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "seteuid to nobody failed");
 
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "closing %s failed",
-			 TESTFILE);
+	SAFE_CLOSE(cleanup, fd);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/chown/chown05.c b/testcases/kernel/syscalls/chown/chown05.c
index 51a7fc06c..840558c08 100644
--- a/testcases/kernel/syscalls/chown/chown05.c
+++ b/testcases/kernel/syscalls/chown/chown05.c
@@ -76,6 +76,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
@@ -162,8 +163,7 @@ void setup(void)
 	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "opening %s failed",
 			 TESTFILE);
-	if (close(fd) == -1)
-		tst_brkm(TBROK, cleanup, "closing %s failed", TESTFILE);
+	SAFE_CLOSE(cleanup, fd);
 
 }
 
diff --git a/testcases/kernel/syscalls/dup/dup01.c b/testcases/kernel/syscalls/dup/dup01.c
index 231958d63..5c82ebefc 100644
--- a/testcases/kernel/syscalls/dup/dup01.c
+++ b/testcases/kernel/syscalls/dup/dup01.c
@@ -115,6 +115,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -151,10 +152,7 @@ int main(int ac, char **av)
 				 filename, TEST_RETURN);
 
 			/* close the new file so loops do not open too many files */
-			if (close(TEST_RETURN) == -1) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "closing %s failed", filename);
-			}
+			SAFE_CLOSE(cleanup, TEST_RETURN);
 		}
 
 	}
diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index 36ac76041..c0919ef09 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -114,6 +114,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -152,9 +153,7 @@ int main(int ac, char **av)
 			} else {
 				tst_resm(TFAIL, "dup succeeded unexpectedly");
 
-				if (close(TEST_RETURN) == -1)
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "close failed");
+				SAFE_CLOSE(cleanup, TEST_RETURN);
 			}
 		}
 	}
diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index 8b4c72635..e41c9e445 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -112,6 +112,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -148,9 +149,7 @@ int main(int ac, char **av)
 		} else {
 			tst_resm(TFAIL, "dup succeeded unexpectedly");
 
-			if (close(TEST_RETURN) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "close failed");
+			SAFE_CLOSE(cleanup, TEST_RETURN);
 		}
 
 	}
diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index ec050fd17..4abe451c1 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -119,6 +119,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -150,8 +151,7 @@ int main(int ac, char **av)
 				 "dup(%d) read side of syspipe returned %ld",
 				 fd[0], TEST_RETURN);
 
-			if (close(TEST_RETURN) == -1)
-				tst_brkm(TBROK, cleanup, "close failed");
+			SAFE_CLOSE(cleanup, TEST_RETURN);
 		}
 
 		TEST(dup(fd[1]));
@@ -165,9 +165,7 @@ int main(int ac, char **av)
 				 fd[1], TEST_RETURN);
 
 
-			if (close(TEST_RETURN) == -1)
-				tst_brkm(TBROK | TTERRNO, cleanup,
-					 "close failed");
+			SAFE_CLOSE(cleanup, TEST_RETURN);
 		}
 
 	}
diff --git a/testcases/kernel/syscalls/dup/dup05.c b/testcases/kernel/syscalls/dup/dup05.c
index 6d4623631..3ef61cfa0 100644
--- a/testcases/kernel/syscalls/dup/dup05.c
+++ b/testcases/kernel/syscalls/dup/dup05.c
@@ -116,6 +116,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -146,9 +147,7 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "dup returned %ld",
 				 TEST_RETURN);
 
-			if (close(TEST_RETURN) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "close failed");
+			SAFE_CLOSE(cleanup, TEST_RETURN);
 		}
 
 	}
diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index 4fdc9f4d0..d3c228362 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -49,6 +49,7 @@
 #include <errno.h>
 #include <string.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup(void);
 void cleanup(void);
@@ -90,13 +91,11 @@ int main(int ac, char **av)
 		if (write(fd1, filename1, strlen(filename1)) == -1)
 			tst_brkm(TBROK, cleanup, "filename1: write(2) failed");
 
-		if (close(fd0) == -1)
-			tst_brkm(TBROK, cleanup, "close(2) fd0 failed");
+		SAFE_CLOSE(cleanup, fd0);
 		if ((fd0 = open(filename0, O_RDONLY)) == -1)
 			tst_brkm(TBROK, cleanup, "open(2) on filename0 failed");
 
-		if (close(fd1) == -1)
-			tst_brkm(TBROK, cleanup, "close(2) fd1 failed");
+		SAFE_CLOSE(cleanup, fd1);
 		if ((fd1 = open(filename1, O_RDONLY)) == -1)
 			tst_brkm(TBROK, cleanup, "open(2) on filename1 failed");
 
@@ -145,9 +144,7 @@ int main(int ac, char **av)
 			tst_brkm(TBROK, cleanup, "Cannot create second file");
 		}
 
-		if (close(fd2) == -1) {
-			tst_brkm(TBROK, cleanup, "close(2) fd_closed failed");
-		}
+		SAFE_CLOSE(cleanup, fd2);
 
 		TEST(dup2(fd0, fd2));
 
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index 083968272..ab8de5d08 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -50,6 +50,7 @@
 #include <signal.h>
 #include <string.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -97,9 +98,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "original and duped "
 					 "inodes are the same");
 
-			if (close(TEST_RETURN) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "close failed");
+			SAFE_CLOSE(cleanup, TEST_RETURN);
 		}
 	}
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index 6abb04d68..207bbab8c 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -81,6 +81,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define LTPUSER		"nobody"
 #define LTPGRP		"users"
@@ -213,10 +214,7 @@ void cleanup(void)
 {
 
 	/* Close the testfile created in the setup() */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, NULL, "close(%s) Failed, errno=%d : %s",
-			 TESTFILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fd);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index 77948fd35..dd79b6cb3 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -80,6 +80,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define DIR_MODE 	S_IRWXU | S_IRWXG | S_IRWXO
 #define PERMS		01777	/*
@@ -190,11 +191,7 @@ void cleanup(void)
 {
 
 	/* Close the test directory opened during setup() */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, NULL,
-			 "close(%s) Failed, errno=%d : %s",
-			 TESTDIR, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fd);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 9b32ebe66..4ef62d4cc 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -87,6 +87,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define MODE_RWX	(S_IRWXU | S_IRWXG | S_IRWXO)
 #define PERMS		043777
@@ -226,11 +227,7 @@ void cleanup(void)
 {
 
 	/* Close the test directory opened in the setup() */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, NULL,
-			 "close(%s) Failed, errno=%d : %s",
-			 TESTDIR, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fd);
 
 	setegid(0);
 	seteuid(0);
diff --git a/testcases/kernel/syscalls/fchmod/fchmod07.c b/testcases/kernel/syscalls/fchmod/fchmod07.c
index ab03721a1..66032e486 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod07.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod07.c
@@ -74,6 +74,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define TESTFILE	"testfile"
@@ -186,11 +187,7 @@ void cleanup(void)
 {
 
 	/* Close the TESTFILE opened in the setup() */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, NULL,
-			 "close(%s) Failed, errno=%d : %s",
-			 TESTFILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fd);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync02.c b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
index 5f0d492eb..9ce4fc7bb 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync02.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
@@ -76,6 +76,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define EXP_RET_VAL	-1
 #define SPL_FILE	"/dev/null"
@@ -166,9 +167,7 @@ int setup2(void)
 void cleanup2(void)
 {
 	/* close special file */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to close fd of %s", SPL_FILE);
-	}
+	SAFE_CLOSE(NULL, fd);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index 45e27b49d..1ff61c7ca 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -57,6 +57,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define TEST_FILE	"testfile"
@@ -141,9 +142,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "open(%s, O_RDWR|O_CREAT, 0666) failed", TEST_FILE);
 
-	if (close(fildes) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
-			 TEST_FILE);
+	SAFE_CLOSE(cleanup, fildes);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/fstat/fstat05.c b/testcases/kernel/syscalls/fstat/fstat05.c
index 7e4a4f1c2..69f746c73 100644
--- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ b/testcases/kernel/syscalls/fstat/fstat05.c
@@ -93,6 +93,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEST_FILE       "testfile"
 
@@ -232,9 +233,7 @@ void setup(void)
 void cleanup(void)
 {
 
-	if (close(fildes) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
-			 TEST_FILE);
+	SAFE_CLOSE(cleanup, fildes);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index 4dadd4bdc..3962d960b 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -154,8 +154,7 @@ int main(int ac, char **av)
 
 		} while (rval > 0);
 
-		if (close(fd) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "Directory close failed");
+		SAFE_CLOSE(cleanup, fd);
 	
 		check_flags();
 	}
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 7f08a8f95..753154076 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -38,6 +38,7 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 #include "inotify.h"
 
@@ -101,9 +102,7 @@ int main(int ac, char **av)
 		event_set[tst_count] = IN_ACCESS;
 		tst_count++;
 
-		if (close(fd) == -1) {
-			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
-		}
+		SAFE_CLOSE(cleanup, fd);
 		event_set[tst_count] = IN_CLOSE_NOWRITE;
 		tst_count++;
 
@@ -121,9 +120,7 @@ int main(int ac, char **av)
 		event_set[tst_count] = IN_MODIFY;
 		tst_count++;
 
-		if (close(fd) == -1) {
-			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
-		}
+		SAFE_CLOSE(cleanup, fd);
 		event_set[tst_count] = IN_CLOSE_WRITE;
 		tst_count++;
 
@@ -212,9 +209,7 @@ static void setup(void)
 	}
 
 	/* close the file we have open */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
-	}
+	SAFE_CLOSE(cleanup, fd);
 	if ((fd_notify = myinotify_init()) < 0) {
 		if (errno == ENOSYS) {
 			tst_brkm(TCONF, cleanup,
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 991342656..cb4b94e55 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -40,6 +40,7 @@
 #include <sys/syscall.h>
 #include <limits.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 #include "inotify.h"
 
@@ -114,10 +115,7 @@ int main(int ac, char **av)
 		strcpy(event_set[tst_count].name, FILE_NAME1);
 		tst_count++;
 
-		if (close(fd) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "close(%s) failed", FILE_NAME1);
-		}
+		SAFE_CLOSE(cleanup, fd);
 		event_set[tst_count].mask = IN_CLOSE_WRITE;
 		strcpy(event_set[tst_count].name, FILE_NAME1);
 		tst_count++;
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index ec2f5d2bc..9393f1dbb 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -42,6 +42,7 @@
 #include <sys/syscall.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 #include "inotify.h"
 
@@ -211,8 +212,7 @@ static void setup(void)
 	}
 
 	/* close the file we have open */
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", fname);
+	SAFE_CLOSE(cleanup, fd);
 
 	fd_notify = myinotify_init();
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index c5648234b..9201ce205 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -67,6 +67,7 @@
 #include <sys/ioctl.h>
 #include <sys/termios.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define	CNUL	0
 
@@ -183,8 +184,7 @@ int main(int ac, char **av)
 		 */
 		if (ioctl(parentfd, TCSETA, &save_io) == -1)
 			tst_resm(TINFO, "ioctl restore failed in main");
-		if (close(parentfd) == -1)
-			tst_brkm(TBROK, cleanup, "close() failed in main");
+		SAFE_CLOSE(cleanup, parentfd);
 
 		closed = 1;
 	}
@@ -443,8 +443,7 @@ static void setup(void)
 			 "do_parent_setup");
 
 	/* Close the device */
-	if (close(fd) == -1)
-		tst_brkm(TBROK, cleanup, "close failed in setup");
+	SAFE_CLOSE(cleanup, fd);
 
 	/* Set up the signal handlers */
 	act.sa_handler = (void *)sigterm_handler;
diff --git a/testcases/kernel/syscalls/lchown/lchown01.c b/testcases/kernel/syscalls/lchown/lchown01.c
index eaf71c7eb..06ebd0c07 100644
--- a/testcases/kernel/syscalls/lchown/lchown01.c
+++ b/testcases/kernel/syscalls/lchown/lchown01.c
@@ -40,6 +40,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
@@ -158,9 +159,7 @@ static void setup(void)
 	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
 		tst_brkm(TBROK, cleanup, "open failed");
 	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "close failed");
-	}
+	SAFE_CLOSE(cleanup, fd);
 
 	if (symlink(TESTFILE, SFILE) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "symlink failed");
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 765ae7a9f..5031c0b2f 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -57,6 +57,7 @@
 #include <sys/mman.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define TEST_USER       "nobody"
@@ -199,8 +200,7 @@ static void setup_eperm(int pos LTP_ATTRIBUTE_UNUSED)
 	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
 
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close failed");
+	SAFE_CLOSE(cleanup, fd);
 
 	/* become root once more */
 	if (seteuid(0) == -1)
@@ -236,8 +236,7 @@ static void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
 	if ((fd = open(TEST_FILE2, O_RDWR | O_CREAT, 0666)) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
 
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close failed");
+	SAFE_CLOSE(cleanup, fd);
 
 	/* create a symlink of testfile */
 	if (symlink(TEST_FILE2, SFILE2) < 0) {
@@ -298,9 +297,7 @@ static void setup_enotdir(int pos LTP_ATTRIBUTE_UNUSED)
 		tst_brkm(TBROK | TERRNO, cleanup, "open(2) %s failed", TFILE3);
 	}
 
-	if (close(fd) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "close(2) %s failed", TFILE3);
-	}
+	SAFE_CLOSE(cleanup, fd);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/llseek/llseek02.c b/testcases/kernel/syscalls/llseek/llseek02.c
index 9227f70ed..5f2e398e1 100644
--- a/testcases/kernel/syscalls/llseek/llseek02.c
+++ b/testcases/kernel/syscalls/llseek/llseek02.c
@@ -82,6 +82,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMP_FILE1	"tmp_file1"
 #define TEMP_FILE2	"tmp_file2"
@@ -249,10 +250,7 @@ int setup2(void)
 	}
 
 	/* Close the temporary file created above */
-	if (close(fd2) < 0) {
-		tst_brkm(TBROK, cleanup, "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE2, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd2);
 
 	return 0;
 }
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index 4bda261d3..099afb6bc 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -123,9 +123,7 @@ int main(int ac, char **av)
 		if (munmap(addr, strlen(buf)) == -1) {
 			tst_brkm(TBROK, cleanup, "munamp failed");
 		}
-		if (close(fd) == -1) {
-			tst_brkm(TBROK, cleanup, "close failed");
-		}
+		SAFE_CLOSE(cleanup, fd);
 		if (unlink(file1) == -1) {
 			tst_brkm(TBROK, cleanup, "unlink failed");
 		}
diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
index d63d1e456..16519a23c 100644
--- a/testcases/kernel/syscalls/mremap/mremap01.c
+++ b/testcases/kernel/syscalls/mremap/mremap01.c
@@ -82,6 +82,7 @@
 #include <fcntl.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMPFILE	"mremapfile"
 
@@ -230,9 +231,7 @@ void cleanup(void)
 		tst_brkm(TBROK | TERRNO, NULL, "munmap failed");
 
 	/* Close the temporary file */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, NULL, "closing %s failed", TEMPFILE);
-	}
+	SAFE_CLOSE(NULL, fildes);
 
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
index 7f1d9f4c2..3997b445c 100644
--- a/testcases/kernel/syscalls/munmap/munmap02.c
+++ b/testcases/kernel/syscalls/munmap/munmap02.c
@@ -76,6 +76,7 @@
 #include <sys/mman.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMPFILE	"mmapfile"
 
@@ -269,10 +270,7 @@ void cleanup(void)
 	}
 
 	/* Close the temporary file */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, NULL, "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fildes);
 
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/pread/pread01.c b/testcases/kernel/syscalls/pread/pread01.c
index 94c9d9461..607fc33b3 100644
--- a/testcases/kernel/syscalls/pread/pread01.c
+++ b/testcases/kernel/syscalls/pread/pread01.c
@@ -76,6 +76,7 @@
 #include <inttypes.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMPFILE	"pread_file"
 #define K1              1024
@@ -340,10 +341,7 @@ void cleanup(void)
 	}
 
 	/* Close the temporary file */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, NULL, "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fildes);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index b9739775e..d2da21f6c 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -72,6 +72,7 @@
 #include <fcntl.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMPFILE	"pread_file"
 #define K1              1024
@@ -290,10 +291,7 @@ void cleanup(void)
 	}
 
 	/* Close the temporary file created in setup2 */
-	if (close(fd1) < 0) {
-		tst_brkm(TBROK, NULL, "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fd1);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
index 2d00fb11b..937160ae5 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite01.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite01.c
@@ -78,6 +78,7 @@
 #include <inttypes.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define _XOPEN_SOURCE 500
 #define TEMPFILE	"pwrite_file"
@@ -328,10 +329,7 @@ void cleanup(void)
 	}
 
 	/* Close the temporary file */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, NULL, "close() on %s Failed, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(NULL, fildes);
 
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
index aa9a7bf89..11469ad29 100644
--- a/testcases/kernel/syscalls/read/read04.c
+++ b/testcases/kernel/syscalls/read/read04.c
@@ -51,6 +51,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void cleanup(void);
 void setup(void);
@@ -103,9 +104,7 @@ int main(int ac, char **av)
 		}
 		tst_resm(TPASS, "functionality of read() is correct");
 
-		if (close(rfild) == -1) {
-			tst_brkm(TBROK, cleanup, "close() failed");
-		}
+		SAFE_CLOSE(cleanup, rfild);
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 7e51cd314..a5b01c756 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -282,8 +282,7 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 	time_end_usec = now.tv_sec * 1000000 + now.tv_usec;
 	*usec = time_end_usec - time_start_usec;
 
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close failed");
+	SAFE_CLOSE(cleanup, fd);
 }
 
 static void test_readahead(void)
diff --git a/testcases/kernel/syscalls/readv/readv02.c b/testcases/kernel/syscalls/readv/readv02.c
index d8b198182..c37e629b8 100644
--- a/testcases/kernel/syscalls/readv/readv02.c
+++ b/testcases/kernel/syscalls/readv/readv02.c
@@ -47,6 +47,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define	K_1	1024
 #define	M_1	K_1 * K_1
@@ -212,9 +213,7 @@ void setup(void)
 		}
 	}
 
-	if (close(fd[0]) < 0) {
-		tst_brkm(TBROK, cleanup, "close failed: errno = %d", errno);
-	}
+	SAFE_CLOSE(cleanup, fd[0]);
 
 	if ((fd[0] = open(f_name, O_RDONLY, 0666)) < 0) {
 		tst_brkm(TBROK, cleanup, "open failed: fname = %s, "
diff --git a/testcases/kernel/syscalls/readv/readv03.c b/testcases/kernel/syscalls/readv/readv03.c
index 7896d9144..09a2ce4d6 100644
--- a/testcases/kernel/syscalls/readv/readv03.c
+++ b/testcases/kernel/syscalls/readv/readv03.c
@@ -55,6 +55,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define	K_1	1024
 #define MODES   S_IRWXU
@@ -141,9 +142,7 @@ void setup(void)
  */
 void cleanup(void)
 {
-	if (close(fd) < 0) {
-		tst_brkm(TBROK, cleanup, "close failed: errno = %d", errno);
-	}
+	SAFE_CLOSE(cleanup, fd);
 	tst_rmdir();
 
 }
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 52db14b04..ef3991f26 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -87,6 +87,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define MODE_RWX	S_IRWXU | S_IRWXG | S_IRWXO
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
@@ -289,11 +290,7 @@ int setup1(void)
 			 TEST_FILE1, errno, strerror(errno));
 	}
 	/* Close the test file */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd);
 
 	/* Modify mode permissions on test directory */
 	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
@@ -322,11 +319,7 @@ int setup2(void)
 			 errno, strerror(errno));
 	}
 	/* Close the test file created above */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(t_file) Failed, errno=%d : %s",
-			 errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd);
 	return 0;
 }
 
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index 5fa985d68..c8b178a04 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -87,6 +87,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define MODE_RWX        S_IRWXU | S_IRWXG | S_IRWXO
 #define FILE_MODE       S_IRUSR | S_IRGRP | S_IROTH
@@ -290,11 +291,7 @@ int setup1(void)
 			 "open(%s, O_RDWR|O_CREAT, 0666) failed, errno=%d : %s",
 			 TEST_FILE1, errno, strerror(errno));
 	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TEST_FILE1, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd);
 
 	/* Modify mode permissions on test directory */
 	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
@@ -316,11 +313,7 @@ int setup2(void)
 			 "open(%s, O_RDWR|O_CREAT, 0666) failed, errno=%d : %s",
 			 TEST_FILE1, errno, strerror(errno));
 	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TEST_FILE2, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd);
 
 	if (symlink(TEST_FILE2, SYM_FILE2) < 0) {
 		tst_brkm(TBROK, cleanup,
@@ -365,10 +358,7 @@ int setup3(void)
 			 "open(2) on t_file failed, errno=%d : %s",
 			 errno, strerror(errno));
 	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup, "close(t_file) Failed, errno=%d : %s",
-			 errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd);
 	return 0;
 }
 
diff --git a/testcases/kernel/syscalls/truncate/truncate01.c b/testcases/kernel/syscalls/truncate/truncate01.c
index b6782ff1f..b3a535f94 100644
--- a/testcases/kernel/syscalls/truncate/truncate01.c
+++ b/testcases/kernel/syscalls/truncate/truncate01.c
@@ -77,6 +77,7 @@
 #include <inttypes.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TESTFILE	"testfile"	/* file under test */
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
@@ -200,11 +201,7 @@ void setup(void)
 	}
 
 	/* Close the testfile after writing data into it */
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TESTFILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fd);
 }
 
 /*
-- 
2.13.5

