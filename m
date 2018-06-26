From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Jun 2018 16:22:37 +0200
Subject: [LTP] [PATCH v3] open08: rewrite to newlib
Message-ID: <6da44d664c386d6d2d931768d460fbe7c0d94467.1530022835.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: https://github.com/linux-test-project/ltp/issues/330

EACCES testcase changed:
Test now creates file (0600) in tmpdir, that is owned by privileged user,
and unprivileged user tries to open it for writing.

EFAULT testcase changed:
Comments say the intent is to use address outside of process mapped space.
So, test is changed to map/unmap rather than map as PROT_NONE.

uclinux ifdefs dropped.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/open/open08.c | 142 +++++++++++++-------------------
 1 file changed, 58 insertions(+), 84 deletions(-)

Changes in v3:
  use **char in testcase array
  some variables renamed

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index d55d8e6bdd53..5b247525c3ca 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -1,5 +1,6 @@
 /*
  *   Copyright (c) 2013 Wanlong Gao <gaowanlong@cn.fujitsu.com>
+ *   Copyright (c) 2018 Linux Test Project
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -39,7 +40,7 @@
  *	4. Attempt to open() a filename which is more than VFS_MAXNAMLEN, and
  *	   check for errno to be ENAMETOOLONG.
  *
- *	5. Attempt to open a test executable in WRONLY mode,
+ *	5. Attempt to open a (0600) file owned by different user in WRONLY mode,
  *	   open(2) should fail with EACCES.
  *
  *	6. Attempt to pass an invalid pathname with an address pointing outside
@@ -56,113 +57,86 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <pwd.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
+static char *existing_fname = "open08_testfile";
+static char *toolong_fname = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+static char *dir_fname = "/tmp";
+static char *user2_fname = "user2_0600";
+static char *unmapped_fname;
 
-char *TCID = "open08";
-
-static char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
-
-static char *bad_addr;
-
-static char filename[40] = "";
-static char fname[] = "/bin/cat";
-static char bad_file[] = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
+struct test_case_t;
 
 static struct test_case_t {
-	char *fname;
+	char **fname;
 	int flags;
 	int error;
-} TC[] = {
-	{filename, O_CREAT | O_EXCL, EEXIST},
-	{"/tmp", O_RDWR, EISDIR},
-	{filename, O_DIRECTORY, ENOTDIR},
-	{bad_file, O_RDWR, ENAMETOOLONG},
-	{fname, O_WRONLY, EACCES},
-#if !defined(UCLINUX)
-	{(char *)-1, O_CREAT, EFAULT}
-#endif
+} tcases[] = {
+	{&existing_fname, O_CREAT | O_EXCL, EEXIST},
+	{&dir_fname, O_RDWR, EISDIR},
+	{&existing_fname, O_DIRECTORY, ENOTDIR},
+	{&toolong_fname, O_RDWR, ENAMETOOLONG},
+	{&user2_fname, O_WRONLY, EACCES},
+	{&unmapped_fname, O_CREAT, EFAULT}
 };
 
-int TST_TOTAL = sizeof(TC) / sizeof(TC[0]);
-
-int main(int ac, char **av)
+void verify_open(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(open(TC[i].fname, TC[i].flags,
-				  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
+	TEST(open(*tcases[i].fname, tcases[i].flags,
+		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH));
+
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (TEST_ERRNO == tcases[i].error) {
+		tst_res(TPASS, "expected failure - "
+				"errno = %d : %s", TEST_ERRNO,
+				strerror(TEST_ERRNO));
+	} else {
+		tst_res(TFAIL, "unexpected error - %d : %s - "
+				"expected %d", TEST_ERRNO,
+				strerror(TEST_ERRNO), tcases[i].error);
+	}
 }
 
-static void setup(void)
+static void *get_invalid_addr(void)
 {
-	int fildes;
+	char *bad_addr;
+	int len = 2 * 1024 * 1024;
 
-	tst_require_root();
+	bad_addr = SAFE_MMAP(0, len, PROT_READ|PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	SAFE_MUNMAP(bad_addr, len);
+	return bad_addr + len/2;
+}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+static void setup(void)
+{
+	int fildes;
+	char nobody_uid[] = "nobody";
+	struct passwd *ltpuser;
 
 	umask(0);
 
-	TEST_PAUSE;
+	SAFE_CREAT(user2_fname, 0600);
 
 	/* Switch to nobody user for correct error code collection */
 	ltpuser = getpwnam(nobody_uid);
-	SAFE_SETGID(NULL, ltpuser->pw_gid);
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-	tst_tmpdir();
-
-	sprintf(filename, "open3.%d", getpid());
-
-	fildes = SAFE_CREAT(cleanup, filename, 0600);
+	SAFE_SETGID(ltpuser->pw_gid);
+	SAFE_SETUID(ltpuser->pw_uid);
 
+	fildes = SAFE_CREAT(existing_fname, 0600);
 	close(fildes);
 
-#if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED)
-		tst_brkm(TBROK, cleanup, "mmap failed");
-
-	TC[5].fname = bad_addr;
-#endif
+	unmapped_fname = get_invalid_addr();
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.test = verify_open,
+};
-- 
1.8.3.1

