From: Nicolas Joly <njoly@pasteur.fr>
Date: Sun, 15 Nov 2015 11:09:16 +0100
Subject: [LTP] [PATCH] Cleanup syscalls/utime test messages
Message-ID: <20151115100916.GA24895@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Please find a small patch that cleanup utime(2) syscalls tests to use
TTERRNO/TERRNO in messages instead of home made versions with
TEST_ERRNO/errno.

Regards.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit 0ac8109dc3ce43f37a1141cd8f352690b5800123
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Sun Nov 15 11:04:57 2015 +0100

    syscalls/utime: Cleanup.
    
    Use TERRNO/TTERRNO in messages instead of home made versions.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 4bb33e9..2eb49d4 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -131,8 +131,7 @@ int main(int ac, char **av)
 		TEST(utime(TEMP_FILE, NULL));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "utime(%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
 		} else {
 			/*
 			 * Sleep for a second so that mod time and
@@ -146,10 +145,9 @@ int main(int ac, char **av)
 			 * utime(2)
 			 */
 			if ((pres_time = time(&tloc)) < 0) {
-				tst_brkm(TFAIL, cleanup, "time() "
+				tst_brkm(TFAIL|TERRNO, cleanup, "time() "
 					 "failed to get present time "
-					 "after utime, error=%d",
-					 errno);
+					 "after utime");
 			}
 
 			/*
@@ -157,9 +155,8 @@ int main(int ac, char **av)
 			 * temporary file using stat(2).
 			 */
 			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed, error:%d",
-					 TEMP_FILE, TEST_ERRNO);
+				tst_brkm(TFAIL|TERRNO, cleanup, "stat(2) of "
+					 "%s failed", TEMP_FILE);
 			}
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
@@ -205,22 +202,20 @@ void setup(void)
 
 	/* Creat a temporary file under above directory */
 	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "creat(%s, %#o) Failed", TEMP_FILE, FILE_MODE);
 	}
 
 	/* Close the temporary file created */
 	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "close(%s) failed", TEMP_FILE);
 	}
 
 	/* Get the current time */
 	if ((curr_time = time(&tloc)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "time() failed to get current time, errno=%d", errno);
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "time() failed to get current time");
 	}
 
 	/*
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index 2a68bd5..c5e49ce 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -137,8 +137,7 @@ int main(int ac, char **av)
 		TEST(utime(TEMP_FILE, NULL));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "utime(%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
 		} else {
 			/*
 			 * Sleep for a second so that mod time and
@@ -152,10 +151,9 @@ int main(int ac, char **av)
 			 * utime(2)
 			 */
 			if ((pres_time = time(&tloc)) < 0) {
-				tst_brkm(TFAIL, cleanup, "time() "
+				tst_brkm(TFAIL|TERRNO, cleanup, "time() "
 					 "failed to get present time "
-					 "after utime, error=%d",
-					 errno);
+					 "after utime");
 			}
 
 			/*
@@ -163,9 +161,8 @@ int main(int ac, char **av)
 			 * temporary file using stat(2).
 			 */
 			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed, errno:%d",
-					 TEMP_FILE, TEST_ERRNO);
+				tst_brkm(TFAIL|TERRNO, cleanup, "stat(2) of "
+					 "%s failed", TEMP_FILE);
 			}
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
@@ -208,9 +205,8 @@ void setup(void)
 	/* Switch to nobody user for correct error code collection */
 	ltpuser = getpwnam(nobody_uid);
 	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
+		tst_resm(TINFO|TERRNO, "setuid failed to "
 			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
 	}
 
 	/* Pause if that option was specified
@@ -224,22 +220,20 @@ void setup(void)
 
 	/* Creat a temporary file under above directory */
 	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "creat(%s, %#o) failed", TEMP_FILE, FILE_MODE);
 	}
 
 	/* Close the temporary file created */
 	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "close(%s) failed", TEMP_FILE);
 	}
 
 	/* Get the current time */
 	if ((curr_time = time(&tloc)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "time() failed to get current time, errno=%d", errno);
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "time() failed to get current time");
 	}
 
 	/*
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 1ff939b..9877be3 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -162,10 +162,8 @@ int main(int ac, char **av)
 			TEST(utime(TEMP_FILE, NULL));
 
 			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL,
-					 "utime(%s) Failed, errno=%d : %s",
-					 TEMP_FILE, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO,
+					 "utime(%s) failed", TEMP_FILE);
 			} else {
 				/*
 				 * Sleep for a second so that mod time
@@ -179,11 +177,9 @@ int main(int ac, char **av)
 				 * calling utime(2)
 				 */
 				if ((pres_time = time(&tloc)) < 0) {
-					tst_brkm(TFAIL, cleanup,
+					tst_brkm(TFAIL|TERRNO, cleanup,
 						 "time() failed to get "
-						 "present time after "
-						 "utime, error=%d",
-						 errno);
+						 "present time after utime");
 				}
 
 				/*
@@ -266,16 +262,14 @@ void setup(void)
 
 	/* Creat a temporary file under above directory */
 	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "creat(%s, %#o) failed", TEMP_FILE, FILE_MODE);
 	}
 
 	/* Close the temporary file created */
 	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "close(%s) failed", TEMP_FILE);
 	}
 
 	/*
@@ -283,9 +277,8 @@ void setup(void)
 	 * umask value may be different.
 	 */
 	if (chmod(TEMP_FILE, FILE_MODE) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "chmod(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "chmod(%s) failed", TEMP_FILE);
 	}
 
 	if (chmod(tmpd, 0711) != 0) {
@@ -306,14 +299,14 @@ void setup(void)
 	 * pathname to that of user_uid and group_gid.
 	 */
 	if (chown(TEMP_FILE, user_uid, group_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown() of %s failed, error %d",
-			 TEMP_FILE, errno);
+		tst_brkm(TBROK|TERRNO, cleanup, "chown() of %s failed",
+			 TEMP_FILE);
 	}
 
 	/* Get the current time */
 	if ((curr_time = time(&tloc)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "time() failed to get current time, errno=%d", errno);
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "time() failed to get current time");
 	}
 
 	/*
diff --git a/testcases/kernel/syscalls/utime/utime04.c b/testcases/kernel/syscalls/utime/utime04.c
index 0287296..373f3a7 100644
--- a/testcases/kernel/syscalls/utime/utime04.c
+++ b/testcases/kernel/syscalls/utime/utime04.c
@@ -116,18 +116,15 @@ int main(int ac, char **av)
 		TEST(utime(TEMP_FILE, &times));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "utime(%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
 		} else {
 			/*
 			 * Get the modification and access times of
 			 * temporary file using stat(2).
 			 */
 			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "stat(2) of %s failed, "
-					 "error:%d", TEMP_FILE,
-					 TEST_ERRNO);
+				tst_brkm(TFAIL|TERRNO, cleanup,
+					 "stat(2) of %s failed", TEMP_FILE);
 			}
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
@@ -171,16 +168,14 @@ void setup(void)
 
 	/* Creat a temporary file under above directory */
 	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "creat(%s, %#o) failed", TEMP_FILE, FILE_MODE);
 	}
 
 	/* Close the temporary file created */
 	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "close(%s) failed", TEMP_FILE);
 	}
 
 	/* Initialize the modification and access time in the times arg */
diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index 275f4fa..7f120e5 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -122,17 +122,15 @@ int main(int ac, char **av)
 		TEST(utime(TEMP_FILE, &times));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "utime(%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
 		} else {
 			/*
 			 * Get the modification and access times of
 			 * temporary file using stat(2).
 			 */
 			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed, error:%d",
-					 TEMP_FILE, TEST_ERRNO);
+				tst_brkm(TFAIL|TERRNO, cleanup, "stat(2) of "
+					 "%s failed", TEMP_FILE);
 			}
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
@@ -184,16 +182,14 @@ void setup(void)
 
 	/* Creat a temporary file under above directory */
 	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "creat(%s, %#o) failed", TEMP_FILE, FILE_MODE);
 	}
 
 	/* Close the temporary file created */
 	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "close(%s) failed", TEMP_FILE);
 	}
 
 	/* Initialize the modification and access time in the times arg */
