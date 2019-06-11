From: Christian Amann <camann@suse.com>
Date: Tue, 11 Jun 2019 12:47:47 +0200
Subject: [LTP] [PATCH v1 2/2] syscalls/lstat02: rewrote testcase
In-Reply-To: <20190611104747.14689-1-camann@suse.com>
References: <20190611104747.14689-1-camann@suse.com>
Message-ID: <20190611104747.14689-2-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleaned up and ported to new library.

Signed-off-by: Christian Amann <camann@suse.com>
---
 testcases/kernel/syscalls/lstat/lstat02.c | 181 +++++++++++-------------------
 1 file changed, 66 insertions(+), 115 deletions(-)

diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
index 774867020..f39f33b34 100644
--- a/testcases/kernel/syscalls/lstat/lstat02.c
+++ b/testcases/kernel/syscalls/lstat/lstat02.c
@@ -1,24 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *   Copyright (c) International Business Machines  Corp., 2001
  *   07/2001 Ported by Wayne Boyer
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   06/2019 Ported to new library: Christian Amann <camann@suse.com>
  */
 /*
- * Test Description:
- *   Verify that,
+ * This test verifies that:
+ *
  *   1) lstat(2) returns -1 and sets errno to EACCES if search permission is
  *	denied on a component of the path prefix.
  *   2) lstat(2) returns -1 and sets errno to ENOENT if the specified file
@@ -33,70 +21,60 @@
  *	many symbolic links encountered while traversing.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <errno.h>
+#include <pwd.h>
+#include <stdlib.h>
 #include <string.h>
-#include <signal.h>
+#include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/mman.h>
-#include <pwd.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define MODE_RWX	S_IRWXU | S_IRWXG | S_IRWXO
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
+#define MODE_RWX	0777
+#define MODE_RW0	0666
 #define TEST_DIR	"test_dir"
-#define TEST_EACCES	TEST_DIR"/test_eacces"
-#define TEST_ENOENT	""
-#define TEST_ENOTDIR	"test_file/test_enotdir"
+#define TEST_FILE	"test_file"
+
 #define TEST_ELOOP	"/test_eloop"
+#define TEST_ENOENT	""
+#define TEST_EACCES	TEST_DIR"/test_eacces"
+#define TEST_ENOTDIR	TEST_FILE"/test_enotdir"
 
 static char longpathname[PATH_MAX + 2];
-static char elooppathname[sizeof(TEST_ELOOP) * 43] = ".";
-
-static void setup(void);
-static void lstat_verify(int);
-static void cleanup(void);
-static void bad_addr_setup(int);
+static char elooppathname[sizeof(TEST_ELOOP) * 43];
+static struct stat stat_buf;
 
 static struct test_case_t {
 	char *pathname;
 	int exp_errno;
-	void (*setup) ();
 } test_cases[] = {
-	{TEST_EACCES, EACCES, NULL},
-	{TEST_ENOENT, ENOENT, NULL},
-	{NULL, EFAULT, bad_addr_setup},
-	{longpathname, ENAMETOOLONG, NULL},
-	{TEST_ENOTDIR, ENOTDIR, NULL},
-	{elooppathname, ELOOP, NULL},
+	{TEST_EACCES, EACCES},
+	{TEST_ENOENT, ENOENT},
+	{NULL, EFAULT},
+	{longpathname, ENAMETOOLONG},
+	{TEST_ENOTDIR, ENOTDIR},
+	{elooppathname, ELOOP},
 };
 
-char *TCID = "lstat02";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
+static void run(unsigned int n)
 {
-	int lc;
-	int i;
+	struct test_case_t *tc = &test_cases[n];
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	TEST(lstat(tc->pathname, &stat_buf));
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			lstat_verify(i);
+	if (TST_RET != -1) {
+		tst_res(TFAIL | TTERRNO, "lstat() returned %ld, expected -1",
+			TST_RET);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (tc->exp_errno == TST_ERR) {
+		tst_res(TPASS | TTERRNO, "lstat() failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"lstat() failed unexpectedly; expected: %s - got",
+			tst_strerrno(tc->exp_errno));
+	}
 }
 
 static void setup(void)
@@ -104,71 +82,44 @@ static void setup(void)
 	int i;
 	struct passwd *ltpuser;
 
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_MKDIR(cleanup, TEST_DIR, MODE_RWX);
-	SAFE_TOUCH(cleanup, TEST_EACCES, 0666, NULL);
-	SAFE_CHMOD(cleanup, TEST_DIR, FILE_MODE);
-
-	SAFE_TOUCH(cleanup, "test_file", MODE_RWX, NULL);
+	/* Drop privileges for EACCES test */
+	if (geteuid() == 0) {
+		ltpuser = SAFE_GETPWNAM("nobody");
+		SAFE_SETEUID(ltpuser->pw_uid);
+	}
 
 	memset(longpathname, 'a', PATH_MAX+1);
+	longpathname[PATH_MAX+1] = '\0';
+
+	SAFE_MKDIR(TEST_DIR, MODE_RWX);
+	SAFE_TOUCH(TEST_EACCES, MODE_RWX, NULL);
+	SAFE_TOUCH(TEST_FILE, MODE_RWX, NULL);
+	SAFE_CHMOD(TEST_DIR, MODE_RW0);
 
-	SAFE_MKDIR(cleanup, "test_eloop", MODE_RWX);
-	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	SAFE_MKDIR("test_eloop", MODE_RWX);
+	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
 	/*
-	 * NOTE: the ELOOP test is written based on that the consecutive
-	 * symlinks limits in kernel is hardwired to 40.
+	 * NOTE: The ELOOP test is written based on the fact that the
+	 * consecutive symlinks limit in the kernel is hardwired to 40.
 	 */
+	elooppathname[0] = '.';
 	for (i = 0; i < 43; i++)
 		strcat(elooppathname, TEST_ELOOP);
-
-	for (i = 0; i < TST_TOTAL; i++) {
-		if (test_cases[i].setup)
-			test_cases[i].setup(i);
-	}
-}
-
-static void bad_addr_setup(int i)
-{
-	test_cases[i].pathname = tst_get_bad_addr(cleanup);
-}
-
-static void lstat_verify(int i)
-{
-	struct stat stat_buf;
-
-	TEST(lstat(test_cases[i].pathname, &stat_buf));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "lstat() returned %ld, expected -1, errno=%d",
-			 TEST_RETURN, test_cases[i].exp_errno);
-		return;
-	}
-
-	if (TEST_ERRNO == test_cases[i].exp_errno) {
-		tst_resm(TPASS | TTERRNO, "lstat() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "lstat() failed unexpectedly; expected: %d - %s",
-			 test_cases[i].exp_errno,
-			 strerror(test_cases[i].exp_errno));
-	}
 }
 
 static void cleanup(void)
 {
-	if (seteuid(0))
-		tst_resm(TINFO | TERRNO, "Failet to seteuid(0) before cleanup");
-
-	tst_rmdir();
+	SAFE_CHMOD(TEST_DIR, MODE_RWX);
+	SAFE_UNLINK("test_eloop/test_eloop");
+	SAFE_RMDIR("test_eloop");
+	SAFE_UNLINK(TEST_EACCES);
+	SAFE_RMDIR(TEST_DIR);
 }
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.16.4

