From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Wed, 14 Feb 2018 00:01:35 +0800
Subject: [LTP] [PATCH 2/3] syscalls/rmdir02,
	05: Cleanup && Convert to new API
In-Reply-To: <1518537696-22033-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1518537696-22033-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <1518537696-22033-2-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Merge rmdir05 into rmdir02
3) Remove duplicate tests for EFAULT
4) Fix wrong bitwise operation for errno

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |    1 -
 runtest/quickhit                          |    2 -
 runtest/stress.part3                      |    1 -
 runtest/syscalls                          |    1 -
 testcases/kernel/syscalls/.gitignore      |    1 -
 testcases/kernel/syscalls/rmdir/rmdir02.c |  186 ++++++++---------------
 testcases/kernel/syscalls/rmdir/rmdir05.c |  235 -----------------------------
 7 files changed, 64 insertions(+), 363 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rmdir/rmdir05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f664edc..95ab7cb 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -666,7 +666,6 @@ rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
 rmdir03A symlink01 -T rmdir03
-rmdir05 rmdir05
 
 sbrk01 sbrk01
 sbrk02 sbrk02
diff --git a/runtest/quickhit b/runtest/quickhit
index 56dcc65..5bda8a2 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -199,8 +199,6 @@ readlink02 readlink02
 # Basic test for readlink(2)
 rename02 rename02
 # Basic test for rename(2)
-rmdir05 rmdir05
-# rmdir(2) test for errno(s) EINVAL, EMLINK, EFAULT
 sbrk01 sbrk01
 # Basic test for sbrk(2)
 select01 select01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index eaa97cd..9b8bfd3 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -565,7 +565,6 @@ rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
 rmdir03A symlink01 -T rmdir03
-rmdir05 rmdir05
 
 sbrk01 sbrk01
 sbrk02 sbrk02
diff --git a/runtest/syscalls b/runtest/syscalls
index bc8cf2d..18b46a2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -943,7 +943,6 @@ rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
 rmdir03A symlink01 -T rmdir03
-rmdir05 rmdir05
 
 rt_sigaction01 rt_sigaction01
 rt_sigaction02 rt_sigaction02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 04b5c5f..6a78384 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -781,7 +781,6 @@
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
-/rmdir/rmdir05
 /rt_sigaction/rt_sigaction01
 /rt_sigaction/rt_sigaction02
 /rt_sigaction/rt_sigaction03
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 9f6954a..e6bfe46 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -1,5 +1,4 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
+/* Copyright (c) International Business Machines  Corp., 2001
  * 07/2001 Ported by Wayne Boyer
  *
  * This program is free software;  you can redistribute it and/or modify
@@ -13,49 +12,44 @@
  * the GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
+
 /*
  * Description:
- *   1) create a directory tstdir1, create a file under it.
- *      call rmdir(tstdir1), verify the return value is -1
- *      and the errno is ENOTEMPTY.
- *   2) create a directory with long path, call rmdir(tstdir1),
- *      verify the return value is -1 and the errno is ENAMETOOLONG.
- *   3) pass a pathname containing non-exist directory component
- *      to rmdir(), verify the return value is -1 and the errno
- *      is ENOENT.
- *   4) pass a pathname containing a file component to rmdir(),
- *      verify the return value is -1 and the errno is ENOTDIR.
- *   5) attempt to pass an invalid pathname with an address
- *      pointing outside the address space of the process, as the
- *      argument to rmdir(), verify the return value is -1 and
- *      the errno is EFAULT.
- *   6) attempt to pass an invalid pathname with NULL, as the
- *      argument to rmdir(), verify the return value is -1 and
- *      the errno is EFAULT.
- *   7) pass a pathname with too many symbolic links to rmdir(),
- *      verify the return value is -1 and the errno is ELOOP.
- *   8) pass a pathname which refers to a directory on a read-only
- *      file system to rmdir(), verify the return value is -1 and
- *      the errno is EROFS.
- *   9) pass a pathname which is currently used as a mount point
- *      to rmdir(), verify the return value is -1 and the errno is
- *      EBUSY.
+ *  1) create a directory tstdir1, create a file under it.
+ *     call rmdir(tstdir1), verify the return value is -1
+ *     and the errno is ENOTEMPTY.
+ *  2) create a directory with long path, call rmdir(tstdir1),
+ *     verify the return value is -1 and the errno is ENAMETOOLONG.
+ *  3) pass a pathname containing non-exist directory component
+ *     to rmdir(), verify the return value is -1 and the errno
+ *     is ENOENT.
+ *  4) pass a pathname containing a file component to rmdir(),
+ *     verify the return value is -1 and the errno is ENOTDIR.
+ *  5) attempt to pass an invalid pathname with an address
+ *     pointing outside the address space of the process, as the
+ *     argument to rmdir(), verify the return value is -1 and
+ *     the errno is EFAULT.
+ *  6) pass a pathname with too many symbolic links to rmdir(),
+ *     verify the return value is -1 and the errno is ELOOP.
+ *  7) pass a pathname which refers to a directory on a read-only
+ *     file system to rmdir(), verify the return value is -1 and
+ *     the errno is EROFS.
+ *  8) pass a pathname which is currently used as a mount point
+ *     to rmdir(), verify the return value is -1 and the errno is
+ *     EBUSY.
+ *  9) pass a pathname which points to the current directory(.)
+ *     to  rmdir(), verify the return value is -1 and the errno is
+ *     EINVAL.
  */
 
 #include <errno.h>
-#include <sys/stat.h>
-#include <sys/types.h>
 #include <sys/mman.h>
-#include <fcntl.h>
+#include <string.h>
 #include <unistd.h>
-#include <pwd.h>
 #include <sys/mount.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define DIR_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
 #define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
@@ -68,133 +62,81 @@
 #define TESTDIR5	"mntpoint/testdir5"
 #define TESTFILE    "testdir/testfile"
 #define TESTFILE2   "testfile2"
+#define CURRENTDIR  "."
 
 static char longpathname[PATH_MAX + 2];
 static char looppathname[sizeof(TESTDIR4) * 43] = ".";
 
-static const char *device;
-static int mount_flag;
-
-static struct test_case_t {
+static struct testcase {
 	char *dir;
 	int exp_errno;
-} test_cases[] =  {
+} tcases[] =  {
 	{TESTDIR, ENOTEMPTY},
 	{longpathname, ENAMETOOLONG},
 	{TESTDIR2, ENOENT},
 	{TESTDIR3, ENOTDIR},
-#if !defined(UCLINUX)
 	{(char *)-1, EFAULT},
-#endif
-	{NULL, EFAULT},
 	{looppathname, ELOOP},
 	{TESTDIR5, EROFS},
 	{MNTPOINT, EBUSY},
+	{CURRENTDIR, EINVAL},
 };
 
-static void setup(void);
-static void rmdir_verify(struct test_case_t *tc);
-static void cleanup(void);
-
-char *TCID = "rmdir02";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
-{
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			rmdir_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
 	int i;
-	const char *fs_type;
 
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to acquire device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
-	SAFE_MKDIR(cleanup, TESTDIR5, DIR_MODE);
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
-		   NULL);
-	mount_flag = 1;
-
-	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
-	SAFE_TOUCH(cleanup, TESTFILE, FILE_MODE, NULL);
+	SAFE_MKDIR(TESTDIR5, DIR_MODE);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type,
+				 MS_REMOUNT | MS_RDONLY, NULL);
+	SAFE_MKDIR(TESTDIR, DIR_MODE);
+	SAFE_TOUCH(TESTFILE, FILE_MODE, NULL);
 
 	memset(longpathname, 'a', PATH_MAX + 1);
 
-	SAFE_TOUCH(cleanup, TESTFILE2, FILE_MODE, NULL);
+	SAFE_TOUCH(TESTFILE2, FILE_MODE, NULL);
 
-#if !defined(UCLINUX)
-	test_cases[4].dir = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+	tcases[4].dir = SAFE_MMAP(0, 1, PROT_NONE,
 		MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-#endif
 
 	/*
-	 * NOTE: the ELOOP test is written based on that the
-	 * consecutive symlinks limit in kernel is hardwired
-	 * to 40.
-	 */
-	SAFE_MKDIR(cleanup, "loopdir", DIR_MODE);
-	SAFE_SYMLINK(cleanup, "../loopdir", "loopdir/loopdir");
+	* NOTE: the ELOOP test is written based on that the
+	* consecutive symlinks limit in kernel is hardwire
+	* to 40.
+	*/
+	SAFE_MKDIR("loopdir", DIR_MODE);
+	SAFE_SYMLINK("../loopdir", "loopdir/loopdir");
 	for (i = 0; i < 43; i++)
 		strcat(looppathname, TESTDIR4);
 }
 
-static void rmdir_verify(struct test_case_t *tc)
+static void verify_rmdir(unsigned int n)
 {
-	TEST(rmdir(tc->dir));
+	struct testcase *tc = &tcases[n];
 
+	TEST(rmdir(tc->dir));
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "rmdir() returned %ld, "
-			"expected -1, errno:%d", TEST_RETURN,
-			tc->exp_errno);
+		tst_res(TFAIL, "rmdir() succeeded unexpectedly");
 		return;
 	}
 
 	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "rmdir() failed as expected");
+		tst_res(TPASS | TTERRNO, "rmdir() failed as expected");
 	} else {
-		tst_resm(TFAIL | TTERRNO,
-			"rmdir() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, strerror(tc->exp_errno));
+		tst_res(TFAIL | TTERRNO,
+			"rmdir() failed unexpectedly; expected: %d, got ",
+			tc->exp_errno);
 	}
 }
 
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(MNTPOINT) == -1)
-		tst_resm(TWARN | TERRNO, "umount %s failed", MNTPOINT);
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_rmdir,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
 
-	if (device)
-		tst_release_device(device);
+};
 
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
deleted file mode 100644
index bef3b47..0000000
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ /dev/null
@@ -1,235 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *    AUTHOR		: Bill Branum
- *    CO-PILOT		: Steve Shaw
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
- /*
-  * TEST CASES
-  *  rmdir(2) test for errno(s) EINVAL, EMLINK, EFAULT
-  */
-
-#include <errno.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <stdlib.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-
-#if !defined(UCLINUX)
-extern char *get_high_address();
-int TST_TOTAL = 6;
-#else
-int TST_TOTAL = 4;
-#endif
-
-char *TCID = "rmdir05";
-
-static struct stat stat_buf;
-static char dir_name[256];
-
-static char *bad_addr = NULL;
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/*
-		 * TEST CASE: 1
-		 * path points to the current directory
-		 */
-		TEST(rmdir("."));
-
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO & (EBUSY | ENOTEMPTY)) {
-				/* For functionality tests, verify that the
-				 * directory wasn't removed.
-				 */
-				if (stat(".", &stat_buf) == -1) {
-					tst_resm(TFAIL,
-						 "rmdir(\".\") removed the current working directory when it should have failed.");
-				} else {
-					tst_resm(TPASS,
-						 "rmdir(\".\") failed to remove the current working directory. Returned %d : %s",
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-				}
-			} else {
-				tst_resm(TFAIL,
-					 "rmdir(\".\") failed with errno %d : %s but expected %d (EBUSY)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EBUSY);
-			}
-		} else {
-			tst_resm(TFAIL,
-				 "rmdir(\".\") succeeded unexpectedly.");
-		}
-
-		/*
-		 * TEST CASE: 2
-		 * path points to the "." (dot) entry of a directory
-		 */
-		tst_resm(TCONF, "rmdir on \"dir/.\" supported on Linux");
-
-		tst_resm(TCONF,
-			 "linked directories test not implemented on Linux");
-
-		/*
-		 * TEST CASE: 4
-		 * path argument points below the minimum allocated address space
-		 */
-#if !defined(UCLINUX)
-		TEST(rmdir(bad_addr));
-
-		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EFAULT) {
-				tst_resm(TPASS,
-					 "rmdir() - path argument points below the minimum allocated address space failed as expected with errno %d : %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL,
-					 "rmdir() - path argument points below the minimum allocated address space failed with errno %d : %s but expected %d (EFAULT)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EFAULT);
-			}
-		} else {
-			tst_resm(TFAIL,
-				 "rmdir() - path argument points below the minimum allocated address space succeeded unexpectedly.");
-		}
-
-		/*
-		 * TEST CASE: 5
-		 * path argument points above the maximum allocated address space
-		 */
-
-		TEST(rmdir(get_high_address()));
-
-		if (TEST_RETURN == -1) {
-		}
-
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EFAULT) {
-				tst_resm(TPASS,
-					 "rmdir() - path argument points above the maximum allocated address space failed as expected with errno %d : %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL,
-					 "rmdir() - path argument points above the maximum allocated address space failed with errno %d : %s but expected %d (EFAULT)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EFAULT);
-			}
-		} else {
-			tst_resm(TFAIL,
-				 "rmdir() - path argument points above the maximum allocated address space succeeded unexpectedly.");
-		}
-#endif
-
-		/*
-		 * TEST CASE: 6
-		 * able to remove a directory
-		 */
-
-		if (mkdir(dir_name, 0777) != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "mkdir(\"%s\") failed with errno %d : %s",
-				 dir_name, errno, strerror(errno));
-		}
-
-		TEST(rmdir(dir_name));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "rmdir(\"%s\") failed when it should have passed. Returned %d : %s",
-				 dir_name, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			/* Verify the directory was removed. */
-			if (stat(dir_name, &stat_buf) != 0) {
-				tst_resm(TPASS,
-					 "rmdir(\"%s\") removed the directory as expected.",
-					 dir_name);
-			} else {
-				tst_resm(TFAIL,
-					 "rmdir(\"%s\") returned a zero exit status but failed to remove the directory.",
-					 dir_name);
-			}
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Create a directory. */
-	SAFE_MKDIR(cleanup, "dir1", 0777);
-
-	/* Create a unique directory name. */
-	sprintf(dir_name, "./dir_%d", getpid());
-
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-#endif
-}
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
-- 
1.7.1



