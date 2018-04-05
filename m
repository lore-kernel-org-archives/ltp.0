From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:54 +0200
Subject: [LTP] [RFC PATCH 8/8] syscalls/fchmod06: Convert to the new library
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Make use of .needs_rofs

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fchmod/fchmod06.c | 189 +++++++++-------------------
 1 file changed, 56 insertions(+), 133 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index a5c6d911c..b5240086e 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -1,23 +1,22 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Author: Wayne Boyer
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *   Author: Wayne Boyer
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
  * Test that fchmod() fails and sets the proper errno values.
  */
@@ -25,152 +24,76 @@
 #ifndef _GNU_SOURCE
 # define _GNU_SOURCE
 #endif
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <unistd.h>
-#include <grp.h>
+#include <sys/types.h>
 #include <pwd.h>
-#include <sys/mount.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
+#define MNT_POINT "mntpoint"
 
 static int fd1;
 static int fd2;
 static int fd3;
-static const char *device;
-static int mount_flag;
 
-static struct test_case_t {
-	char *name;
+static struct tcase {
 	int *fd;
 	int mode;
 	int exp_errno;
-} test_cases[] = {
-	{"EPERM", &fd1, 0644, EPERM},
-	{"EBADF", &fd2, 0644, EBADF},
-	{"EROFS", &fd3, 0644, EROFS},
+} tcases[] = {
+	{&fd1, 0644, EPERM},
+	{&fd2, 0644, EBADF},
+	{&fd3, 0644, EROFS},
 };
 
-char *TCID = "fchmod06";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_fchmod(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct tcase *tc = &tcases[i];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TEST(fchmod(*tc->fd, tc->mode));
 
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(fchmod(*test_cases[i].fd, test_cases[i].mode));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == test_cases[i].exp_errno) {
-					tst_resm(TPASS | TTERRNO,
-						 "fchmod: test %s success",
-						 test_cases[i].name);
-				} else {
-					tst_resm(TFAIL | TTERRNO,
-						 "fchmod: test %s FAILED with "
-						 "unexpect errno: %d",
-						 test_cases[i].name,
-						 TEST_ERRNO);
-				}
-			} else {
-				tst_resm(TFAIL,
-					 "fchmod: test %s success unexpectly",
-					 test_cases[i].name);
-			}
-		}
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "fchmod() passed unexpectedly (%li)",
+		        TEST_RETURN);
+		return;
+	}
 
+	if (TEST_ERRNO == tcases[i].exp_errno) {
+		tst_res(TPASS | TTERRNO, "fchmod() failed expectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TFAIL | TTERRNO,
+	        "fchmod() failed unexpectedly, expected %i - %s",
+	        TEST_ERRNO, tst_strerrno(TEST_ERRNO));
 }
 
 static void setup(void)
 {
-	struct passwd *ltpuser;
-	const char *fs_type;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	fd3 = SAFE_OPEN(MNT_POINT"/file", O_RDONLY);
+	fd1 = SAFE_OPEN("tfile_1", O_RDWR | O_CREAT, 0666);
+	fd2 = SAFE_OPEN("tfile_2", O_RDWR | O_CREAT, 0666);
+	SAFE_CLOSE(fd2);
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, "mntpoint", 0755);
-
-	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, 0, NULL);
-	mount_flag = 1;
-
-	/* Create a file in the file system, then remount it as read-only */
-	SAFE_TOUCH(cleanup, "mntpoint/tfile_3", 0644, NULL);
-
-	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type,
-		   MS_REMOUNT | MS_RDONLY, NULL);
-
-	fd3 = SAFE_OPEN(cleanup, "mntpoint/tfile_3", O_RDONLY);
-
-	fd1 = SAFE_OPEN(cleanup, "tfile_1", O_RDWR | O_CREAT, 0666);
-
-	fd2 = SAFE_OPEN(cleanup, "tfile_2", O_RDWR | O_CREAT, 0666);
-
-	SAFE_CLOSE(cleanup, fd2);
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	SAFE_SETEUID(ltpuser->pw_uid);
 }
 
 static void cleanup(void)
 {
-	if (seteuid(0))
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
-
-	if (fd1 > 0 && close(fd1))
-		tst_resm(TWARN | TERRNO, "close(fd1) failed");
-
-	if (fd3 > 0 && close(fd3))
-		tst_resm(TWARN | TERRNO, "close(fd1) failed");
-
-	if (mount_flag && tst_umount("mntpoint") < 0) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "umount device:%s failed", device);
-	}
-
-	if (device)
-		tst_release_device(device);
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
 
-	tst_rmdir();
+	if (fd3 > 0)
+		SAFE_CLOSE(fd3);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_fchmod,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+};
-- 
2.13.6

