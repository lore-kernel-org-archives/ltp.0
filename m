From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 1 Aug 2019 15:42:29 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls/ftruncate: Rewrite ftruncate04
In-Reply-To: <1564645349-10859-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1564395109-7165-3-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1564645349-10859-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1564645349-10859-3-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ftruncate/ftruncate04.c | 244 +++++++---------------
 1 file changed, 77 insertions(+), 167 deletions(-)

diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index a1080be..097c283 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -1,26 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+ /*
+  * Copyright (c) International Business Machines  Corp., 2002
+  * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
+  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+  *
+  * Robbie Williamson <robbiew@us.ibm.com>
+  * Roy Lee <roylee@andestech.com>
+  */
 /*
- * Copyright (c) International Business Machines  Corp., 2002
- * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Test Description:
  *
- *  Robbie Williamson <robbiew@us.ibm.com>
- *  Roy Lee <roylee@andestech.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
  * Tests truncate and mandatory record locking.
  *
  * Parent creates a file, child locks a region and sleeps.
@@ -31,111 +20,44 @@
  * Parent wakes up child, child exits, lock is unlocked.
  *
  * Parent checks that ftruncate now works in all cases.
+ *
  */
 
-#include <signal.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/wait.h>
-#include <inttypes.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
+#include <unistd.h>
+#include <stdlib.h>
 #include <sys/statvfs.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define RECLEN	100
-#define MOUNT_DIR "dir/"
-
-const char *TCID = "ftruncate04";
-int TST_TOTAL = 6;
-
-static int len = 8 * 1024;
-static char filename[80];
-
-static int recstart;
-static int reclen;
-
-static const char *device;
-static const char *fs_type;
-static int mount_flag;
-
-static void dochild(void);
-static void doparent(void);
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
-{
-	int lc, pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-#ifdef UCLINUX
-	maybe_run_child(&dochild, "sdd", filename, &recstart, &reclen);
-#endif
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		sprintf(filename, MOUNT_DIR"%s.%d.%d\n", TCID, getpid(), lc);
-
-		if (tst_fill_file(filename, 0, 1024, 8)) {
-			tst_brkm(TBROK, cleanup,
-			         "Failed to create test file '%s'", filename);
-		}
-
-		SAFE_CHMOD(cleanup, filename, 02666);
-
-		reclen = RECLEN;
-		/*
-		 * want at least RECLEN bytes BEFORE AND AFTER the
-		 * record lock.
-		 */
-		recstart = RECLEN + rand() % (len - 3 * RECLEN);
-
-		if ((pid = FORK_OR_VFORK()) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
-
-		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "sdd", filename, recstart,
-			              reclen) < -1) {
-				tst_brkm(TBROK, cleanup, "self_exec() failed");
-			}
-#else
-			dochild();
-#endif
-		}
-
-		doparent();
-	}
+#define MNTPOINT	"mntpoint"
+#define TESTFILE	MNTPOINT"/testfile"
 
-	cleanup();
-	tst_exit();
-}
+static int len = 1024;
+static int recstart, reclen;
 
 static void ftruncate_expect_fail(int fd, off_t offset, const char *msg)
 {
 	TEST(ftruncate(fd, offset));
 
-	if (TEST_RETURN == 0) {
-		tst_resm(TFAIL, "ftruncate() %s succeeded unexpectedly", msg);
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "ftruncate() %s succeeded unexpectedly", msg);
 		return;
 	}
 
-	if (TEST_ERRNO != EAGAIN) {
-		tst_resm(TFAIL | TTERRNO,
-		         "ftruncate() %s failed unexpectedly, expected EAGAIN",
-			 msg);
+	if (TST_ERR != EAGAIN) {
+		tst_res(TFAIL | TTERRNO,
+			"ftruncate() %s failed unexpectedly, expected EAGAIN",
+			msg);
 		return;
 	}
 
-	tst_resm(TPASS, "ftruncate() %s failed with EAGAIN", msg);
+	tst_res(TPASS, "ftruncate() %s failed with EAGAIN", msg);
 }
 
 static void ftruncate_expect_success(int fd, off_t offset, const char *msg)
@@ -144,46 +66,44 @@ static void ftruncate_expect_success(int fd, off_t offset, const char *msg)
 
 	TEST(ftruncate(fd, offset));
 
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TTERRNO,
-		         "ftruncate() %s failed unexpectedly", msg);
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"ftruncate() %s failed unexpectedly", msg);
 		return;
 	}
 
-	SAFE_FSTAT(cleanup, fd, &sb);
+	SAFE_FSTAT(fd, &sb);
 
 	if (sb.st_size != offset) {
-		tst_resm(TFAIL,
-			 "ftruncate() to %li bytes succeded but fstat() reports size %li",
-			 (long)offset, (long)sb.st_size);
+		tst_res(TFAIL,
+			"ftruncate() to %li bytes succeded but fstat() reports size %li",
+			(long)offset, (long)sb.st_size);
 		return;
 	}
 
-	tst_resm(TPASS, "ftruncate() %s succeded", msg);
+	tst_res(TPASS, "ftruncate() %s succeded", msg);
 }
 
 static void doparent(void)
 {
 	int fd;
 
-	/* Wait for child lock */
-	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
+	TST_CHECKPOINT_WAIT(0);
 
-	fd = SAFE_OPEN(cleanup, filename, O_RDWR | O_NONBLOCK);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_NONBLOCK);
 
 	ftruncate_expect_fail(fd, RECLEN, "offset before lock");
 	ftruncate_expect_fail(fd, recstart + RECLEN/2, "offset in lock");
 	ftruncate_expect_success(fd, recstart + RECLEN, "offset after lock");
 
-	/* wake child and wait for it to exit (to free record lock) */
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-	SAFE_WAIT(NULL, NULL);
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_WAIT(NULL);
 
 	ftruncate_expect_success(fd, recstart + RECLEN/2, "offset in lock");
 	ftruncate_expect_success(fd, recstart, "offset before lock");
 	ftruncate_expect_success(fd, recstart + RECLEN, "offset after lock");
 
-	SAFE_CLOSE(NULL, fd);
+	SAFE_CLOSE(fd);
 }
 
 void dochild(void)
@@ -191,81 +111,71 @@ void dochild(void)
 	int fd;
 	struct flock flocks;
 
-#ifdef UCLINUX
-	TST_CHECKPOINT_INIT(NULL);
-#endif
-
-	fd = SAFE_OPEN(NULL, filename, O_RDWR);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR);
 
-	tst_resm(TINFO, "Child locks file");
+	tst_res(TINFO, "Child locks file");
 
 	flocks.l_type = F_WRLCK;
 	flocks.l_whence = SEEK_CUR;
 	flocks.l_start = recstart;
 	flocks.l_len = reclen;
 
-	if (fcntl(fd, F_SETLKW, &flocks) < 0)
-		tst_brkm(TFAIL, NULL, "child fcntl failed");
+	SAFE_FCNTL(fd, F_SETLKW, &flocks);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	tst_resm(TINFO, "Child unlocks file");
+	tst_res(TINFO, "Child unlocks file");
 
-	tst_exit();
+	exit(0);
 }
 
-static void setup(void)
+static void verify_ftruncate(void)
 {
-	struct statvfs fs;
-
-	srand(getpid());
-
-	tst_tmpdir();
+	int pid;
 
-	SAFE_MKDIR(tst_rmdir, MOUNT_DIR, 0777);
+	if (tst_fill_file(TESTFILE, 0, 1024, 8))
+		tst_brk(TBROK, "Failed to create test file");
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
+	SAFE_CHMOD(TESTFILE, 02666);
 
-	if (statvfs(".", &fs) == -1)
-		tst_brkm(TFAIL | TERRNO, tst_rmdir, "statvfs failed");
+	reclen = RECLEN;
+	recstart = RECLEN + rand() % (len - 3 * RECLEN);
 
-	if ((fs.f_flag & MS_MANDLOCK))
-		return;
+	pid = SAFE_FORK();
 
-	tst_resm(TINFO, "TMPDIR does not support mandatory locks");
+	if (pid == 0)
+		dochild();
 
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	doparent();
+}
 
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+static void setup(void)
+{
+	struct statvfs fs;
 
-	/* the kernel returns EPERM when CONFIG_MANDATORY_FILE_LOCKING is not
-	 * supported - to avoid false negatives, mount the fs first without
-	 * flags and then remount it as MS_MANDLOCK */
+	if (statvfs(".", &fs) == -1)
+		tst_brk(TFAIL | TERRNO, "statvfs failed");
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-	SAFE_MOUNT(cleanup, device, MOUNT_DIR, fs_type, 0, NULL);
-	mount_flag = 1;
+	if ((fs.f_flag & MS_MANDLOCK))
+		return;
 
-	if (mount(NULL, MOUNT_DIR, NULL, MS_REMOUNT|MS_MANDLOCK, NULL) == -1) {
+	if (mount(NULL, MNTPOINT, NULL, MS_REMOUNT|MS_MANDLOCK, NULL) == -1) {
 		if (errno == EPERM) {
-			tst_brkm(TCONF, cleanup, "Mandatory locking (likely) "
-				 "not supported by this system");
+			tst_brk(TCONF,
+				"Mandatory lock not supported by this system");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Remount with MS_MANDLOCK failed");
+			tst_brk(TBROK | TTERRNO,
+				"Remount with MS_MANDLOCK failed");
 		}
 	}
 }
 
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(MOUNT_DIR))
-		tst_resm(TWARN | TERRNO, "umount(%s) failed", device);
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test_all = verify_ftruncate,
+	.setup = setup,
+	.needs_checkpoints = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+};
-- 
1.8.3.1



