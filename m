From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:49 +0200
Subject: [LTP] [RFC PATCH 3/8] syscalls/chmod06: Rewrite the new library
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Make use of .needs_rofs

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/chmod/chmod06.c | 166 +++++++++---------------------
 1 file changed, 49 insertions(+), 117 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index acd653f7d..ad0a3615b 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  07/2001 Ported by Wayne Boyer
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2014-2018 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -37,27 +37,9 @@
  *   6) chmod(2) returns -1 and sets errno to ENOENT if the specified file
  *	does not exists.
  */
-
-#ifndef _GNU_SOURCE
-# define _GNU_SOURCE
-#endif
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <grp.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include <errno.h>
+#include "tst_test.h"
 
 #define MODE_RWX	(S_IRWXU|S_IRWXG|S_IRWXO)
 #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
@@ -73,14 +55,12 @@
 
 static char long_path[PATH_MAX + 2];
 
-static const char *device;
-static int mount_flag;
 static uid_t nobody_uid;
 
 static void set_root(void);
 static void set_nobody(void);
 
-struct test_case_t {
+static struct tcase {
 	char *pathname;
 	mode_t mode;
 	int exp_errno;
@@ -90,7 +70,7 @@ struct test_case_t {
 	{TEST_FILE1, FILE_MODE, EPERM, set_nobody, set_root},
 	{TEST_FILE2, FILE_MODE, EACCES, set_nobody, set_root},
 	{(char *)-1, FILE_MODE, EFAULT, NULL, NULL},
-	{(char *)-2, FILE_MODE, EFAULT, NULL, NULL},
+	{NULL, FILE_MODE, EFAULT, NULL, NULL},
 	{long_path, FILE_MODE, ENAMETOOLONG, NULL, NULL},
 	{"", FILE_MODE, ENOENT, NULL, NULL},
 	{TEST_FILE3, FILE_MODE, ENOTDIR, NULL, NULL},
@@ -98,109 +78,62 @@ struct test_case_t {
 	{TEST_FILE4, FILE_MODE, ELOOP, NULL, NULL},
 };
 
-char *TCID = "chmod06";
-int TST_TOTAL = ARRAY_SIZE(tc);
-
-static char *bad_addr = 0;
+static char *bad_addr;
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+void run(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	if (tc[i].setup)
+		tc[i].setup();
 
-	setup();
+	TEST(chmod(tc[i].pathname, tc[i].mode));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (tc[i].setup)
-				tc[i].setup();
-
-			TEST(chmod(tc[i].pathname, tc[i].mode));
-
-			if (tc[i].cleanup)
-				tc[i].cleanup();
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "chmod succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == tc[i].exp_errno)
-				tst_resm(TPASS | TTERRNO,
-					 "chmod failed as expected");
-			else
-				tst_resm(TFAIL | TTERRNO,
-					 "chmod failed unexpectedly; "
-					 "expected %d - %s",
-					 tc[i].exp_errno,
-					 tst_strerrno(tc[i].exp_errno));
-		}
+	if (tc[i].cleanup)
+		tc[i].cleanup();
 
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "chmod succeeded unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (TEST_ERRNO == tc[i].exp_errno) {
+		tst_res(TPASS | TTERRNO, "chmod failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO, "chmod failed unexpectedly; "
+		        "expected %d - %s", tc[i].exp_errno,
+			tst_strerrno(tc[i].exp_errno));
+	}
 }
 
 void set_root(void)
 {
-	SAFE_SETEUID(cleanup, 0);
+	SAFE_SETEUID(0);
 }
 
 void set_nobody(void)
 {
-	SAFE_SETEUID(cleanup, nobody_uid);
+	SAFE_SETEUID(nobody_uid);
 }
 
 void setup(void)
 {
 	struct passwd *nobody;
-	const char *fs_type;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	unsigned int i;
 
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	nobody = SAFE_GETPWNAM(NULL, "nobody");
+	nobody = SAFE_GETPWNAM("nobody");
 	nobody_uid = nobody->pw_uid;
 
-	bad_addr = SAFE_MMAP(NULL, 0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	tc[3].pathname = bad_addr;
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	bad_addr = SAFE_MMAP(0, 1, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	SAFE_TOUCH(cleanup, TEST_FILE1, 0666, NULL);
-	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
-	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
-	SAFE_TOUCH(cleanup, "t_file", MODE_RWX, NULL);
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+	for (i = 0; i < ARRAY_SIZE(tc); i++) {
+		if (!tc[i].pathname)
+			tc[i].pathname = bad_addr;
+	}
 
-	/*
-	 * mount a read-only file system for test EROFS
-	 */
-	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
-	mount_flag = 1;
+	SAFE_TOUCH(TEST_FILE1, 0666, NULL);
+	SAFE_MKDIR(DIR_TEMP, MODE_RWX);
+	SAFE_TOUCH(TEST_FILE2, 0666, NULL);
+	SAFE_CHMOD(DIR_TEMP, FILE_MODE);
+	SAFE_TOUCH("t_file", MODE_RWX, NULL);
 
 	memset(long_path, 'a', PATH_MAX+1);
 
@@ -208,22 +141,21 @@ void setup(void)
 	 * create two symbolic links who point to each other for
 	 * test ELOOP.
 	 */
-	SAFE_SYMLINK(cleanup, "test_file4", "test_file5");
-	SAFE_SYMLINK(cleanup, "test_file5", "test_file4");
+	SAFE_SYMLINK("test_file4", "test_file5");
+	SAFE_SYMLINK("test_file5", "test_file4");
 }
 
 static void cleanup(void)
 {
-	if (chmod(DIR_TEMP, MODE_RWX) == -1)
-		tst_resm(TBROK | TERRNO, "chmod(%s) failed", DIR_TEMP);
-
-	if (mount_flag && tst_umount(MNT_POINT) < 0) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "umount device:%s failed", device);
-	}
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
+	SAFE_CHMOD(DIR_TEMP, MODE_RWX);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+};
-- 
2.13.6

