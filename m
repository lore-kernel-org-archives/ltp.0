From: Nicolas Joly <njoly@pasteur.fr>
Date: Sat, 28 Nov 2015 10:26:14 +0100
Subject: [LTP] [PATCH] Cleanup syscalls/utime test messages
In-Reply-To: <20151121094124.GA16808@issan.sis.pasteur.fr>
References: <20151115100916.GA24895@issan.sis.pasteur.fr>
 <20151119160051.GF28969@rei.lan>
 <20151121094124.GA16808@issan.sis.pasteur.fr>
Message-ID: <20151128092614.GA21891@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Nov 21, 2015 at 10:41:24AM +0100, Nicolas Joly wrote:
> On Thu, Nov 19, 2015 at 05:00:51PM +0100, Cyril Hrubis wrote:
[...]
> > Lookig at the time man page the only error defined for time is EFAULT
> > when you pass wrong pointer to it. So I would just remove the check for
> > failure for all time() calls. What do you think?
> 
> Fine. My cleanup was mostly mecanical to remove most errno direct use
> ... I did not check for anything else ;)
> 
> > > @@ -157,9 +155,8 @@ int main(int ac, char **av)
> > >  			 * temporary file using stat(2).
> > >  			 */
> > >  			if (stat(TEMP_FILE, &stat_buf) < 0) {
> > > -				tst_brkm(TFAIL, cleanup, "stat(2) of "
> > > -					 "%s failed, error:%d",
> > > -					 TEMP_FILE, TEST_ERRNO);
> > > +				tst_brkm(TFAIL|TERRNO, cleanup, "stat(2) of "
> > > +					 "%s failed", TEMP_FILE);
> > >  			}
> > 
> > Hint: we have safe macros so this could be easily done with just:
> > 
> >       SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
> > 
> >       And the same for creat(), close(), etc.
> 
> That's even simplier indeed.
> 
> Will try to setup a new version that include both.

Finally got some spare time to setup this ...

New version attached, that address all concerns.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit bcad1e1a7d0a8c82d6dfe32f38232126a3afb5ea
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Sat Nov 28 10:19:46 2015 +0100

    syscalls/utime: Cleanup.
    
    Avoid errno direct use, call safe macros instead.
    Simplify time() calls which should never fail.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 4bb33e9..505f875 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -82,6 +82,7 @@
 
 #include "test.h"
 #include "tst_fs_type.h"
+#include "safe_macros.h"
 
 #define TEMP_FILE	"tmp_file"
 #define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
@@ -89,7 +90,6 @@
 char *TCID = "utime01";
 int TST_TOTAL = 1;
 time_t curr_time;		/* current time in seconds */
-time_t tloc;
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -131,8 +131,7 @@ int main(int ac, char **av)
 		TEST(utime(TEMP_FILE, NULL));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "utime(%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
 		} else {
 			/*
 			 * Sleep for a second so that mod time and
@@ -145,22 +144,13 @@ int main(int ac, char **av)
 			 * Get the current time now, after calling
 			 * utime(2)
 			 */
-			if ((pres_time = time(&tloc)) < 0) {
-				tst_brkm(TFAIL, cleanup, "time() "
-					 "failed to get present time "
-					 "after utime, error=%d",
-					 errno);
-			}
+			pres_time = time(NULL);
 
 			/*
 			 * Get the modification and access times of
 			 * temporary file using stat(2).
 			 */
-			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed, error:%d",
-					 TEMP_FILE, TEST_ERRNO);
-			}
+			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
 
@@ -204,24 +194,13 @@ void setup(void)
 	tst_tmpdir();
 
 	/* Creat a temporary file under above directory */
-	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
+	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
 
 	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fildes);
 
 	/* Get the current time */
-	if ((curr_time = time(&tloc)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "time() failed to get current time, errno=%d", errno);
-	}
+	curr_time = time(NULL);
 
 	/*
 	 * Sleep for a second so that mod time and access times will be
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index 2a68bd5..d2ec958 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -85,6 +85,7 @@
 
 #include "test.h"
 #include "tst_fs_type.h"
+#include "safe_macros.h"
 
 #define TEMP_FILE	"tmp_file"
 #define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
@@ -92,7 +93,6 @@
 char *TCID = "utime02";
 int TST_TOTAL = 1;
 time_t curr_time;		/* current time in seconds */
-time_t tloc;
 
 char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
@@ -137,8 +137,7 @@ int main(int ac, char **av)
 		TEST(utime(TEMP_FILE, NULL));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "utime(%s) Failed, errno=%d : %s",
-				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
 		} else {
 			/*
 			 * Sleep for a second so that mod time and
@@ -151,22 +150,13 @@ int main(int ac, char **av)
 			 * Get the current time now, after calling
 			 * utime(2)
 			 */
-			if ((pres_time = time(&tloc)) < 0) {
-				tst_brkm(TFAIL, cleanup, "time() "
-					 "failed to get present time "
-					 "after utime, error=%d",
-					 errno);
-			}
+			pres_time = time(NULL);
 
 			/*
 			 * Get the modification and access times of
 			 * temporary file using stat(2).
 			 */
-			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed, errno:%d",
-					 TEMP_FILE, TEST_ERRNO);
-			}
+			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
 
@@ -206,12 +196,8 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
+	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -i option.
@@ -223,24 +209,13 @@ void setup(void)
 	tst_tmpdir();
 
 	/* Creat a temporary file under above directory */
-	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
+	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
 
 	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fildes);
 
 	/* Get the current time */
-	if ((curr_time = time(&tloc)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "time() failed to get current time, errno=%d", errno);
-	}
+	curr_time = time(NULL);
 
 	/*
 	 * Sleep for a second so that mod time and access times will be
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 1ff939b..6d9cabe 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -90,6 +90,7 @@
 
 #include "test.h"
 #include "tst_fs_type.h"
+#include "safe_macros.h"
 
 #define TEMP_FILE	"tmp_file"
 #define FILE_MODE	S_IRWXU | S_IRGRP | S_IWGRP| S_IROTH | S_IWOTH
@@ -99,7 +100,6 @@
 char *TCID = "utime03";
 int TST_TOTAL = 1;
 time_t curr_time;		/* current time in seconds */
-time_t tloc;
 
 struct passwd *ltpuser;		/* password struct for ltpusers */
 uid_t user_uid;			/* user id of ltpuser */
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
@@ -178,25 +176,14 @@ int main(int ac, char **av)
 				 * Get the current time now, after
 				 * calling utime(2)
 				 */
-				if ((pres_time = time(&tloc)) < 0) {
-					tst_brkm(TFAIL, cleanup,
-						 "time() failed to get "
-						 "present time after "
-						 "utime, error=%d",
-						 errno);
-				}
+				pres_time = time(NULL);
 
 				/*
 				 * Get the modification and access
 				 * times of temporary file using
 				 * stat(2).
 				 */
-				if (stat(TEMP_FILE, &stat_buf) < 0) {
-					tst_brkm(TFAIL, cleanup,
-						 "stat(2) of %s failed, "
-						 "error:%d", TEMP_FILE,
-						 TEST_ERRNO);
-				}
+				SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
 				modf_time = stat_buf.st_mtime;
 				access_time = stat_buf.st_atime;
 
@@ -260,42 +247,22 @@ void setup(void)
 	tst_tmpdir();
 
 	/* get the name of the temporary directory */
-	if ((tmpd = getcwd(tmpd, 0)) == NULL) {
-		tst_brkm(TBROK, NULL, "getcwd failed");
-	}
+	tmpd = SAFE_GETCWD(NULL, tmpd, 0);
 
 	/* Creat a temporary file under above directory */
-	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
+	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
 
 	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fildes);
 
 	/*
 	 * Make sure that specified Mode permissions set as
 	 * umask value may be different.
 	 */
-	if (chmod(TEMP_FILE, FILE_MODE) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "chmod(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+	SAFE_CHMOD(cleanup, TEMP_FILE, FILE_MODE);
+	SAFE_CHMOD(cleanup, tmpd, 0711);
 
-	if (chmod(tmpd, 0711) != 0) {
-		tst_brkm(TBROK, cleanup, "chmod() failed");
-	}
-
-	if ((ltpuser = getpwnam(LTPUSER2)) == NULL) {
-		tst_brkm(TBROK, cleanup, "%s not found in /etc/passwd",
-			 LTPUSER2);
-	}
+	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER2);
 
 	/* get uid/gid of user accordingly */
 	user_uid = ltpuser->pw_uid;
@@ -305,16 +272,10 @@ void setup(void)
 	 * Change the ownership of test directory/file specified by
 	 * pathname to that of user_uid and group_gid.
 	 */
-	if (chown(TEMP_FILE, user_uid, group_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown() of %s failed, error %d",
-			 TEMP_FILE, errno);
-	}
+	SAFE_CHOWN(cleanup, TEMP_FILE, user_uid, group_gid);
 
 	/* Get the current time */
-	if ((curr_time = time(&tloc)) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "time() failed to get current time, errno=%d", errno);
-	}
+	curr_time = time(NULL);
 
 	/*
 	 * Sleep for a second so that mod time and access times will be
diff --git a/testcases/kernel/syscalls/utime/utime04.c b/testcases/kernel/syscalls/utime/utime04.c
index 0287296..5253f76 100644
--- a/testcases/kernel/syscalls/utime/utime04.c
+++ b/testcases/kernel/syscalls/utime/utime04.c
@@ -80,6 +80,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMP_FILE	"tmp_file"
 #define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
@@ -116,19 +117,13 @@ int main(int ac, char **av)
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
-			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup,
-					 "stat(2) of %s failed, "
-					 "error:%d", TEMP_FILE,
-					 TEST_ERRNO);
-			}
+			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
 
@@ -170,18 +165,10 @@ void setup(void)
 	tst_tmpdir();
 
 	/* Creat a temporary file under above directory */
-	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
+	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
 
 	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fildes);
 
 	/* Initialize the modification and access time in the times arg */
 	times.actime = NEW_TIME;
diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index 275f4fa..b2d2450 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -83,6 +83,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMP_FILE	"tmp_file"
 #define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
@@ -122,18 +123,13 @@ int main(int ac, char **av)
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
-			if (stat(TEMP_FILE, &stat_buf) < 0) {
-				tst_brkm(TFAIL, cleanup, "stat(2) of "
-					 "%s failed, error:%d",
-					 TEMP_FILE, TEST_ERRNO);
-			}
+			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
 			modf_time = stat_buf.st_mtime;
 			access_time = stat_buf.st_atime;
 
@@ -171,30 +167,18 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
+	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
 	/* Creat a temporary file under above directory */
-	if ((fildes = creat(TEMP_FILE, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "creat(%s, %#o) Failed, errno=%d :%s",
-			 TEMP_FILE, FILE_MODE, errno, strerror(errno));
-	}
+	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
 
 	/* Close the temporary file created */
-	if (close(fildes) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s:",
-			 TEMP_FILE, errno, strerror(errno));
-	}
+	SAFE_CLOSE(cleanup, fildes);
 
 	/* Initialize the modification and access time in the times arg */
 	times.actime = NEW_TIME;
