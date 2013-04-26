Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UVdT2-0005bR-Jq
	for ltp-list@lists.sourceforge.net; Fri, 26 Apr 2013 07:53:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UVdT0-0007W1-1U
	for ltp-list@lists.sourceforge.net; Fri, 26 Apr 2013 07:53:16 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3Q7r6Cq002012
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Apr 2013 15:53:06 +0800
Message-ID: <517A31DE.2050003@cn.fujitsu.com>
Date: Fri, 26 Apr 2013 15:50:54 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/2] syscalls/mount/mount02.c: cleanup
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

1. Remove redundant comments

2. Revise code to follow ltp-code-style

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount02.c | 165 ++++++++++--------------------
 1 file changed, 56 insertions(+), 109 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index 1d1a5c1..8dcf8de 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -14,76 +14,34 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
-/******************************************************************************
- *
- *    TEST IDENTIFIER	: mount02
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Test for checking basic error conditions  for mount(2)
- *
- *    TEST CASE TOTAL	: 13
- *
- *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Check for basic errors returned by mount(2) system call.
- *
- *	Verify that mount(2) returns -1 and sets errno to
- *
- *	1) ENODEV if filesystem type not configured
- *	2) ENOTBLK if specialfile is not a block device
- *	3) EBUSY if specialfile is already mounted or
- *		 it  cannot  be remounted read-only, because it still holds
- *		 files open for writing.
- *	4) EINVAL if specialfile or device is invalid or
- *		 a remount was attempted, while source was not already
- *		 mounted on target.
- *	5) EFAULT if specialfile or device file points to invalid address space.
- *	6) ENAMETOOLONG if pathname was longer than MAXPATHLEN.
- *	7) ENOENT if pathname was empty or has a nonexistent component.
- *	8) ENOTDIR if not a directory.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Create a mount point.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- *	  Do necessary setup for each test.
- *	  Execute system call
- *	  Check return code, if system call failed and errno == expected errno
- *		Issue sys call passed with expected return value and errno.
- *	  Otherwise,
- *		Issue sys call failed to produce expected error.
- *	  Do cleanup for each test.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *	  Delete the temporary directory(s)/file(s) created.
- *
- * USAGE:  <for command-line>
- *  mount02 [-T type] -D device [-e] [-i n] [-I x] [-p x] [-t]
- *			where,  -T type : specifies the type of filesystem to
- *					  be mounted. Default ext2.
- *				-D device : device to be mounted.
- *				-e   : Turn on errno logging.
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
- * RESTRICTIONS
- *	test must be run with the -D option
- *	test doesn't support -c option to run it in parallel, as mount
- *	syscall is not supposed to run in parallel.
- *****************************************************************************/
+
+/*
+   AUTHOR: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
+
+   EXECUTED BY: root / superuser
+
+   DESCRIPTION
+	Check for basic errors returned by mount(2) system call.
+
+	Verify that mount(2) returns -1 and sets errno to
+	1) ENODEV if filesystem type not configured
+	2) ENOTBLK if specialfile is not a block device
+	3) EBUSY if specialfile is already mounted or
+		it  cannot  be remounted read-only, because it still holds
+		files open for writing.
+	4) EINVAL if specialfile or device is invalid or
+		 a remount was attempted, while source was not already
+		 mounted on target.
+	5) EFAULT if specialfile or device file points to invalid address space.
+	6) ENAMETOOLONG if pathname was longer than MAXPATHLEN.
+	7) ENOENT if pathname was empty or has a nonexistent component.
+	8) ENOTDIR if not a directory.
+
+   RESTRICTIONS
+	test must be run with the -D option
+	test doesn't support -c option to run it in parallel, as mount
+	syscall is not supposed to run in parallel.
+*/

 #include <errno.h>
 #include <sys/mount.h>
@@ -104,8 +62,8 @@ char *TCID = "mount02";

 #define DEFAULT_FSTYPE "ext2"
 #define FSTYPE_LEN	20
-#define DIR_MODE	S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP
-#define FILE_MODE	S_IRWXU | S_IRWXG | S_IRWXO
+#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
+#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)

 static char *Einval = (char *)-1;
 static char Longpathname[PATH_MAX + 2];
@@ -120,8 +78,8 @@ static int fd;
 static char mntpoint[PATH_MAX];
 static char *fstype;
 static char *device;
-static int Tflag = 0;
-static int Dflag = 0;
+static int Tflag;
+static int Dflag;

 static int exp_enos[] = { ENODEV, ENOTBLK, EBUSY, EINVAL, EFAULT, ENAMETOOLONG,
 	ENOENT, ENOTDIR, 0
@@ -129,9 +87,9 @@ static int exp_enos[] = { ENODEV, ENOTBLK, EBUSY, EINVAL, EFAULT, ENAMETOOLONG,

 int TST_TOTAL = (sizeof(exp_enos) / sizeof(exp_enos[0])) - 1;

-static option_t options[] = {	/* options supported by mount02 test */
-	{"T:", &Tflag, &fstype},	/* -T type of filesystem        */
-	{"D:", &Dflag, &device},	/* -D device used for mounting  */
+static option_t options[] = {
+	{"T:", &Tflag, &fstype},
+	{"D:", &Dflag, &device},
 	{NULL, NULL, NULL}
 };

@@ -140,7 +98,8 @@ int main(int ac, char **av)
 	int lc, i;
 	char *msg;

-	if ((msg = parse_opts(ac, av, options, &help)) != NULL)
+	msg = parse_opts(ac, av, options, &help);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

 	/* Check for mandatory option of the testcase */
@@ -149,9 +108,8 @@ int main(int ac, char **av)
 			 " mounting with -D option.");

 	Type = malloc(FSTYPE_LEN);
-	if (Type == NULL) {
+	if (Type == NULL)
 		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
-	}

 	if (Tflag == 1) {
 		strncpy(Type, fstype,
@@ -183,8 +141,8 @@ int main(int ac, char **av)

 			/* Call mount(2) to test different test conditions.
 			 * verify that it fails with -1 return value and
-			 * sets appropriate errno.*/
-
+			 * sets appropriate errno.
+			 */
 			TEST(mount(Device, Mntpoint, Fstype, Flag, NULL));

 			/* check return code */
@@ -192,11 +150,11 @@ int main(int ac, char **av)
 				tst_resm(TPASS | TERRNO,
 					 "mount got expected failure");
 			} else {
-				if (umount(mntpoint) == -1) {
+				if (umount(mntpoint) == -1)
 					tst_brkm(TBROK | TERRNO, cleanup,
 						 "umount of %s failed",
 						 Mntpoint);
-				}
+
 				tst_resm(TFAIL | TERRNO,
 					 "mount(2) failed to produce expected "
 					 "error (%d)", exp_enos[i]);
@@ -207,7 +165,6 @@ int main(int ac, char **av)
 		}
 	}

-	/* cleanup and exit */
 	cleanup();

 	tst_exit();
@@ -218,7 +175,7 @@ int main(int ac, char **av)
  * setup_test() - Setup function for test cases based on the error values
  *		  to be returned.
  */
-int setup_test(int i, int cnt)
+static int setup_test(int i, int cnt)
 {
 	char temp[20];

@@ -271,7 +228,9 @@ int setup_test(int i, int cnt)
 		}
 		sprintf(temp, "/%s/t3_%d", mntpoint, cnt);
 		strcat(Path, temp);
-		if ((fd = open(Path, O_CREAT | O_RDWR, S_IRWXU)) == -1) {
+
+		fd = open(Path, O_CREAT | O_RDWR, S_IRWXU);
+		if (fd == -1) {
 			tst_resm(TWARN | TERRNO, "open() failed to create %s",
 				 Path);
 			return 1;
@@ -330,7 +289,8 @@ int setup_test(int i, int cnt)
 		}
 		sprintf(temp, "/t_%d_%d", getpid(), cnt);
 		strcat(Path, temp);
-		if ((fd = open(Path, O_CREAT, S_IRWXU)) == -1) {
+		fd = open(Path, O_CREAT, S_IRWXU);
+		if (fd == -1) {
 			tst_resm(TWARN, "open failed to create %s", Path);
 			return 1;
 		} else {
@@ -346,7 +306,7 @@ int setup_test(int i, int cnt)
  * cleanup_test() - Setup function for test cases based on the error values
  *		  to be returned.
  */
-int cleanup_test(int i)
+static int cleanup_test(int i)
 {
 	switch (i) {
 	case 0:
@@ -366,9 +326,8 @@ int cleanup_test(int i)
 		/* FALLTHROUGH */
 	case 2:
 		TEST(umount(mntpoint));
-		if (TEST_RETURN != 0) {
+		if (TEST_RETURN != 0)
 			tst_resm(TWARN | TTERRNO, "umount failed");
-		}
 		break;
 	case 12:
 		close(fd);
@@ -377,41 +336,29 @@ int cleanup_test(int i)
 	return 0;
 }

-/* setup() - performs all ONE TIME setup for this test */
-void setup()
+static void setup(void)
 {
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);

 	tst_require_root(NULL);

-	/* make a temp directory */
 	tst_tmpdir();

 	(void)sprintf(mntpoint, "mnt_%d", getpid());

-	if (mkdir(mntpoint, DIR_MODE) == -1) {
+	if (mkdir(mntpoint, DIR_MODE) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
 			 mntpoint, DIR_MODE);
-	}

 	TEST_EXP_ENOS(exp_enos);

 	TEST_PAUSE;
 }

-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup()
+static void cleanup(void)
 {
 	free(Type);

-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;

 	tst_rmdir();
@@ -420,9 +367,9 @@ void cleanup()
 /*
  * issue a help message
  */
-void help()
+static void help(void)
 {
 	printf("-T type	  : specifies the type of filesystem to be mounted."
-	       " Default ext2. \n");
-	printf("-D device : device used for mounting \n");
+		" Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
 }
-- 
1.8.1

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
