From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:45 +0200
Subject: [LTP] [COMMITTED] [PATCH 12/40] Make use of SAFE_UNLINK()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-12-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/asyncio/asyncio02.c   |  5 +----
 testcases/kernel/syscalls/chdir/chdir01.c       |  4 +---
 testcases/kernel/syscalls/close/close08.c       |  6 ++----
 testcases/kernel/syscalls/creat/creat08.c       | 13 +++----------
 testcases/kernel/syscalls/fork/fork09.c         |  5 ++---
 testcases/kernel/syscalls/inotify/inotify02.c   |  5 +----
 testcases/kernel/syscalls/mprotect/mprotect03.c |  4 +---
 testcases/kernel/syscalls/open/open03.c         |  5 ++---
 testcases/kernel/syscalls/readv/readv02.c       |  5 +----
 testcases/kernel/syscalls/rename/rename03.c     |  4 +---
 testcases/kernel/syscalls/rename/rename09.c     |  8 ++------
 testcases/kernel/syscalls/symlink/symlink02.c   |  7 ++-----
 testcases/kernel/syscalls/symlink/symlink04.c   |  7 ++-----
 testcases/kernel/syscalls/symlink/symlink05.c   |  7 ++-----
 14 files changed, 23 insertions(+), 62 deletions(-)

diff --git a/testcases/kernel/syscalls/asyncio/asyncio02.c b/testcases/kernel/syscalls/asyncio/asyncio02.c
index 9e3ca7ad4..6f7ef9110 100644
--- a/testcases/kernel/syscalls/asyncio/asyncio02.c
+++ b/testcases/kernel/syscalls/asyncio/asyncio02.c
@@ -256,10 +256,7 @@ int testrun(int flag, int bytes, int ti)
 		ret = (int)buffer.st_size;
 	}
 
-	if (unlink(filename) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "unlink(%s) failed",
-			 filename);
-	}
+	SAFE_UNLINK(cleanup, filename);
 
 	return ret;
 
diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index 1933377a4..81cf7c564 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -107,9 +107,7 @@ int main(int ac, char **av)
 		else
 			tst_resm(TPASS, "failed as expected with ENOTDIR");
 
-		if (unlink(filname) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Couldn't remove file");
+		SAFE_UNLINK(cleanup, filname);
 
 		SAFE_CHDIR(cleanup, "..");
 
diff --git a/testcases/kernel/syscalls/close/close08.c b/testcases/kernel/syscalls/close/close08.c
index b8e899095..ccdefa173 100644
--- a/testcases/kernel/syscalls/close/close08.c
+++ b/testcases/kernel/syscalls/close/close08.c
@@ -115,6 +115,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -150,10 +151,7 @@ int main(int ac, char **av)
 				 TEST_RETURN);
 		}
 
-		if (unlink(fname) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "unlink(%s) failed", fname);
-		}
+		SAFE_UNLINK(cleanup, fname);
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index 5f564273e..284ae5f1a 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -443,16 +443,9 @@ static void cleanup(void)
 		tst_resm(TBROK, "unlink %s failed", nosetgid_A);
 	}
 	SAFE_RMDIR(NULL, DIR_A);
-	if (unlink(setgid_B) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "unlink %s failed", setgid_B);
-	}
-	if (unlink(root_setgid_B) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "unlink %s failed",
-			 root_setgid_B);
-	}
-	if (unlink(nosetgid_B) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "unlink %s failed", nosetgid_B);
-	}
+	SAFE_UNLINK(NULL, setgid_B);
+	SAFE_UNLINK(NULL, root_setgid_B);
+	SAFE_UNLINK(NULL, nosetgid_B);
 	SAFE_RMDIR(NULL, DIR_B);
 
 	tst_rmdir();
diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index 35ba01507..dedc8a41c 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -47,6 +47,7 @@
 #include <errno.h>
 #include <unistd.h>		/* for _SC_OPEN_MAX */
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "fork09";
 int TST_TOTAL = 1;
@@ -91,9 +92,7 @@ int main(int ac, char **av)
 
 		tst_resm(TINFO, "first file descriptor is %d ", first);
 
-		if (unlink(filname) == -1)
-			tst_brkm(TBROK, cleanup, "Cannot unlink file %s, "
-				 "errno = %d", filname, errno);
+		SAFE_UNLINK(cleanup, filname);
 
 		/*
 		 * now open all the files for the test
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index cb4b94e55..ff5be64ae 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -146,10 +146,7 @@ int main(int ac, char **av)
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
 
-		if (unlink(FILE_NAME2) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "unlink(%s) failed", FILE_NAME2);
-		}
+		SAFE_UNLINK(cleanup, FILE_NAME2);
 		event_set[tst_count].mask = IN_DELETE;
 		strcpy(event_set[tst_count].name, FILE_NAME2);
 		tst_count++;
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index 944b45e87..28f54c9ae 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -122,9 +122,7 @@ int main(int ac, char **av)
 		/* clean up things in case we are looping */
 		SAFE_MUNMAP(cleanup, addr, strlen(buf));
 		SAFE_CLOSE(cleanup, fd);
-		if (unlink(file1) == -1) {
-			tst_brkm(TBROK, cleanup, "unlink failed");
-		}
+		SAFE_UNLINK(cleanup, file1);
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/open/open03.c b/testcases/kernel/syscalls/open/open03.c
index 7e82a9ae7..80e43c6e9 100644
--- a/testcases/kernel/syscalls/open/open03.c
+++ b/testcases/kernel/syscalls/open/open03.c
@@ -31,6 +31,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -66,9 +67,7 @@ int main(int ac, char **av)
 			if (close(fd) == -1)
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "close(%s) failed", fname);
-			else if (unlink(fname) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "unlink(%s) failed", fname);
+			else SAFE_UNLINK(cleanup, fname);
 		}
 	}
 
diff --git a/testcases/kernel/syscalls/readv/readv02.c b/testcases/kernel/syscalls/readv/readv02.c
index c37e629b8..be67c4ece 100644
--- a/testcases/kernel/syscalls/readv/readv02.c
+++ b/testcases/kernel/syscalls/readv/readv02.c
@@ -236,10 +236,7 @@ void setup(void)
  */
 void cleanup(void)
 {
-	if (unlink(f_name) < 0) {
-		tst_brkm(TBROK, NULL, "unlink FAILED: file %s, errno %d",
-			 f_name, errno);
-	}
+	SAFE_UNLINK(NULL, f_name);
 	tst_rmdir();
 
 }
diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
index 4d4f78d60..6ffbe5628 100644
--- a/testcases/kernel/syscalls/rename/rename03.c
+++ b/testcases/kernel/syscalls/rename/rename03.c
@@ -164,9 +164,7 @@ int main(int ac, char **av)
 		/* reset things in case we are looping */
 
 		/* unlink the new file */
-		if (unlink(mname) == -1) {
-			tst_brkm(TBROK, cleanup, "unlink() failed");
-		}
+		SAFE_UNLINK(cleanup, mname);
 
 		/* remove the new directory */
 		SAFE_RMDIR(cleanup, mdir);
diff --git a/testcases/kernel/syscalls/rename/rename09.c b/testcases/kernel/syscalls/rename/rename09.c
index 15e607981..9b2022592 100644
--- a/testcases/kernel/syscalls/rename/rename09.c
+++ b/testcases/kernel/syscalls/rename/rename09.c
@@ -195,12 +195,8 @@ int main(int ac, char **av)
 			}
 
 			/* clean up things in case we are looping */
-			if (unlink(fname) == -1) {
-				tst_brkm(TBROK, cleanup, "unlink() #1 failed");
-			}
-			if (unlink(mname) == -1) {
-				tst_brkm(TBROK, cleanup, "unlink() #2 failed");
-			}
+			SAFE_UNLINK(cleanup, fname);
+			SAFE_UNLINK(cleanup, mname);
 			SAFE_RMDIR(cleanup, fdir);
 			SAFE_RMDIR(cleanup, mdir);
 		} else {
diff --git a/testcases/kernel/syscalls/symlink/symlink02.c b/testcases/kernel/syscalls/symlink/symlink02.c
index fdf8e609c..c18db2b37 100644
--- a/testcases/kernel/syscalls/symlink/symlink02.c
+++ b/testcases/kernel/syscalls/symlink/symlink02.c
@@ -115,6 +115,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -157,11 +158,7 @@ int main(int ac, char **av)
 				 fname, symlnk, TEST_ERRNO,
 				 strerror(TEST_ERRNO));
 		} else {
-			if (unlink(symlnk) == -1) {
-				tst_brkm(TBROK, cleanup,
-					 "unlink(%s) Failed, errno=%d : %s",
-					 symlnk, errno, strerror(errno));
-			}
+			SAFE_UNLINK(cleanup, symlnk);
 		}
 	}
 
diff --git a/testcases/kernel/syscalls/symlink/symlink04.c b/testcases/kernel/syscalls/symlink/symlink04.c
index ef284007c..2190b3b1b 100644
--- a/testcases/kernel/syscalls/symlink/symlink04.c
+++ b/testcases/kernel/syscalls/symlink/symlink04.c
@@ -76,6 +76,7 @@
 #include <signal.h>
 #include <sys/stat.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define  TESTFILE	"testfile"
 #define  SYMFILE	"slink_file"
@@ -134,11 +135,7 @@ int main(int ac, char **av)
 		}
 
 		/* Unlink the symlink file for next loop */
-		if (unlink(SYMFILE) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "unlink(%s) Failed, errno=%d : %s",
-				 SYMFILE, errno, strerror(errno));
-		}
+		SAFE_UNLINK(cleanup, SYMFILE);
 		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
diff --git a/testcases/kernel/syscalls/symlink/symlink05.c b/testcases/kernel/syscalls/symlink/symlink05.c
index 89f8c8877..83b151f5d 100644
--- a/testcases/kernel/syscalls/symlink/symlink05.c
+++ b/testcases/kernel/syscalls/symlink/symlink05.c
@@ -77,6 +77,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define  TESTFILE	"testfile"
 #define  SYMFILE	"slink_file"
@@ -135,11 +136,7 @@ int main(int ac, char **av)
 		}
 
 		/* Unlink the symlink file for next loop */
-		if (unlink(SYMFILE) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "unlink(%s) Failed, errno=%d : %s",
-				 SYMFILE, errno, strerror(errno));
-		}
+		SAFE_UNLINK(cleanup, SYMFILE);
 		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
-- 
2.13.5

