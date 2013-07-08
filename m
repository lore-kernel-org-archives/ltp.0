Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Uw3qZ-0006wW-MS
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 05:18:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uw3qW-00061y-Q7
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 05:18:47 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r685IaRP014478
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Jul 2013 13:18:36 +0800
Message-ID: <51DA4B63.9010700@cn.fujitsu.com>
Date: Mon, 08 Jul 2013 13:17:23 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/2 v2] mount/mount03.c: clean up
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>


Clean up mount03.c:
    xxx func() -> xxx func(void)

    clean up setup()


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount03.c | 179 +++++-------------------------
 1 file changed, 27 insertions(+), 152 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index b1aa71f..a4c065a 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -16,15 +16,7 @@
  */

 /*
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Test for checking mount(2) flags
- *
- *    TEST CASE TOTAL	: 6
- *
- *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- *    DESCRIPTION
+ * DESCRIPTION
  *	Check for basic mount(2) system call flags.
  *
  *	Verify that mount(2) syscall passes for each flag setting and validate
@@ -35,30 +27,7 @@
  *	4) MS_SYNCHRONOUS - writes are synced at once.
  *	5) MS_REMOUNT - alter flags of a mounted FS.
  *	6) MS_NOSUID - ignore suid and sgid bits.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Create a mount point.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	  Loop if the proper options are given.
- *	  Execute mount system call for each flag
- *	  Validate each flag setting. if validation fails
- *		Delete the mount point.
- *		Log the errno and Issue a FAIL message.
- *	  Delete the mount point.
- *	  Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *	  Delete the temporary directory(s)/file(s) created.
- *
- * RESTRICTIONS
- *	test must run with the -D option
- *	test doesn't support -c option to run it in parallel, as mount
- *	syscall is not supposed to run in parallel.
- *****************************************************************************/
+ */

 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
@@ -73,14 +42,15 @@
 #include <fcntl.h>
 #include <pwd.h>
 #include <unistd.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"

 static void help(void);
 static void setup(void);
 static void cleanup(void);
 static int test_rwflag(int, int);
-static int setup_uid(void);

 char *TCID = "mount03";
 int TST_TOTAL = 6;
@@ -92,9 +62,9 @@ int TST_TOTAL = 6;
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define SUID_MODE	(S_ISUID|S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH)

-static char *fs_type;
+static const char *fs_type = "ext2";

-static char mntpoint[20];
+static const char mntpoint[] = "mntpoint";
 static char *fstype;
 static char *device;
 static int tflag;
@@ -104,9 +74,7 @@ static int fildes;
 static char write_buffer[BUFSIZ];
 static char read_buffer[BUFSIZ];
 static char path_name[PATH_MAX];
-static char testhome_path[PATH_MAX];
 static char file[PATH_MAX];
-static char *cmd = "cp";

 long rwflags[] = {
 	MS_RDONLY,
@@ -138,21 +106,9 @@ int main(int argc, char *argv[])
 			 "you must specify the device used for mounting with -D "
 			 "option");

-	if (tflag) {
-		fs_type = malloc(strlen(fstype) + 1);
-		if (fs_type == NULL)
-			tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
+	if (tflag)
+		fs_type = fstype;

-		fs_type[strlen(fstype)] = '\0';
-		strncpy(fs_type, fstype, strlen(fstype));
-	} else {
-		fs_type = malloc(strlen(DEFAULT_FSTYPE) + 1);
-		if (fs_type == NULL)
-			tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
-
-		strncpy(fs_type, DEFAULT_FSTYPE, strlen(DEFAULT_FSTYPE));
-		fs_type[strlen(DEFAULT_FSTYPE)] = '\0';
-	}

 	if (STD_COPIES != 1) {
 		tst_resm(TINFO, "-c option has no effect for this testcase - "
@@ -169,11 +125,9 @@ int main(int argc, char *argv[])

 		for (i = 0; i < TST_TOTAL; ++i) {

-			/* Call mount(2) */
 			TEST(mount(device, mntpoint, fs_type, rwflags[i],
 				   NULL));

-			/* check return code */
 			if (TEST_RETURN != 0) {
 				tst_resm(TFAIL | TTERRNO, "mount(2) failed");
 				continue;
@@ -203,12 +157,12 @@ int main(int argc, char *argv[])
  * test_rwflag(int i, int cnt)
  * Validate the mount system call for rwflags.
  */
-
 int test_rwflag(int i, int cnt)
 {
 	int ret, fd, pid, status;
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
+	struct stat setuid_test_stat;

 	switch (i) {
 	case 0:
@@ -337,21 +291,23 @@ int test_rwflag(int i, int cnt)
 	case 5:
 		/* Validate MS_NOSUID flag of mount call */

-		if (setup_uid() != 0) {
-			tst_resm(TBROK | TERRNO, "setup_uid failed");
-			return 1;
-		}
+		snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
+		SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");
+
+		if (stat(file, &setuid_test_stat) < 0)
+			tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
+
+		if (setuid_test_stat.st_mode != SUID_MODE &&
+		    chmod(file, SUID_MODE) < 0)
+			tst_brkm(TBROK, cleanup,
+				 "setuid for setuid_test failed");
+
 		pid = fork();
 		switch (pid) {
 		case -1:
 			tst_resm(TBROK | TERRNO, "fork failed");
 			return 1;
 		case 0:
-			snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
-			if (chmod(file, SUID_MODE) != 0)
-				tst_resm(TWARN, "chmod(%s, %#o) failed",
-					 file, SUID_MODE);
-
 			ltpuser = getpwnam(nobody_uid);
 			if (setreuid(ltpuser->pw_uid, ltpuser->pw_uid) == -1)
 				tst_resm(TWARN | TERRNO,
@@ -374,68 +330,18 @@ int test_rwflag(int i, int cnt)
 	return 0;
 }

-/* setup_uid() - performs setup for NOUID test */
-int setup_uid()
+void setup(void)
 {
-	int pid, status;
-	char command[PATH_MAX];
-
-	pid = fork();
-	switch (pid) {
-	case -1:
-		tst_resm(TWARN | TERRNO, "fork failed");
-		return 1;
-	case 0:
-		/* Put command into string */
-		sprintf(command, "%s %s %s", cmd, testhome_path, path_name);
-
-		/* Run command to cp file to right spot */
-		if (system(command) == 0)
-			execlp(file, basename(file), NULL);
-		else
-			printf("call to %s failed\n", command);
-
-		exit(1);
-	default:
-		waitpid(pid, &status, 0);
-		if (WIFEXITED(status)) {
-			return WEXITSTATUS(status);
-		} else if (WIFSIGNALED(status)) {
-			return WTERMSIG(status);
-		} else {
-			/* Should be 0. */
-			assert(status == 0);
-			return 0;
-		}
-	}
-}
-
-void setup()
-{
-	int fd;
 	char path[PATH_MAX];
-	char *test_home;
-	struct stat setuid_test_stat;

 	tst_sig(FORK, DEF_HANDLER, cleanup);

-	/* Check whether we are root */
-	if (geteuid() != 0) {
-		free(fs_type);
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);

 	tst_tmpdir();

-	test_home = get_current_dir_name();
-
-	sprintf(mntpoint, "mnt_%d", getpid());
-
-	if (mkdir(mntpoint, DIR_MODE))
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
-			 mntpoint, DIR_MODE);
+	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);

-	/* Get the current working directory of the process */
 	if (getcwd(path_name, sizeof(path_name)) == NULL)
 		tst_brkm(TBROK, cleanup, "getcwd failed");

@@ -443,53 +349,22 @@ void setup()
 		tst_brkm(TBROK, cleanup, "chmod(%s, %#o) failed",
 			 path_name, DIR_MODE);

-	snprintf(file, PATH_MAX, "%s/setuid_test", path_name);
-	fd = open(file, O_CREAT | O_TRUNC, S_IRWXU);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup, "open file failed");
-	close(fd);
-
-	if (stat(file, &setuid_test_stat) < 0) {
-		tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
-	} else {
-		if ((setuid_test_stat.st_uid || setuid_test_stat.st_gid) &&
-		    chown(file, 0, 0) < 0)
-			tst_brkm(TBROK, cleanup,
-				 "chown for setuid_test failed");
-
-		if (setuid_test_stat.st_mode != SUID_MODE &&
-		    chmod(file, SUID_MODE) < 0)
-			tst_brkm(TBROK, cleanup,
-				 "setuid for setuid_test failed");
-	}
-
-	/*
-	 * under temporary directory
-	 */
 	strncpy(path, path_name, PATH_MAX);
 	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
-	strcpy(testhome_path, test_home);
-	strcat(testhome_path, "/setuid_test");

 	TEST_PAUSE;
-
 }

-void cleanup()
+void cleanup(void)
 {
-	free(fs_type);
-
 	TEST_CLEANUP;

 	tst_rmdir();
 }

-/*
- * issue a help message
- */
-void help()
+void help(void)
 {
-	printf("-T type	  : specifies the type of filesystem to be mounted."
-	       " Default ext2.\n");
+	printf("-T type	  : specifies the type of filesystem to be mounted. "
+	       "Default ext2.\n");
 	printf("-D device : device used for mounting.\n");
 }
-- 
1.8.1

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
