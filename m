From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 12 Feb 2018 18:21:37 +0800
Subject: [LTP] [PATCH 3/4] syscalls/readlink03.c: Cleanup && Convert to new
	API
In-Reply-To: <1518430898-13225-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1518430898-13225-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1518430898-13225-3-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Add a new test for EFAULT

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/readlink/readlink03.c | 217 ++++++++++----------=
----
 1 file changed, 88 insertions(+), 129 deletions(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/ke=
rnel/syscalls/readlink/readlink03.c
index 0106621..7de4b64 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -1,25 +1,20 @@
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines  Corp., 2001
  *   07/2001 Ported by Wayne Boyer
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundati=
on,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
+
 /*
  * Test Description :
- *   Verify that,
  *   1) readlink(2) returns -1 and sets errno to EACCES if search/write
  *	permission is denied in the directory where the symbolic link
  *	resides.
@@ -35,155 +30,119 @@
  *	the path prefix is not a directory.
  *   7) readlink(2) returns -1 and sets errno to ELOOP if too many symbolic
  *	links were encountered in translating the pathname.
+ *   8) readlink(2) returns -1 and sets errno to EFAULT if buf outside the
+ *	process=E2=80=99s allocated address space.
  */
=20
-#include <stdio.h>
-#include <sys/types.h>
-#include <fcntl.h>
+#include <pwd.h>
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <pwd.h>
=20
-#include "test.h"
-#include "safe_macros.h"
-
-#define MODE_RWX	(S_IRWXU | S_IRWXG | S_IRWXO)
-#define FILE_MODE	(S_IRUSR | S_IRGRP | S_IROTH)
-#define DIR_TEMP	"testdir_1"
-#define TEST_FILE1	"testdir_1/tfile_1"
-#define SYM_FILE1	"testdir_1/sfile_1"
-#define TEST_FILE2	"tfile_2"
-#define SYM_FILE2	"sfile_2"
-#define TEST_FILE3	"tfile_3"
-#define SYM_FILE3	"tfile_3/sfile_3"
+#include "tst_test.h"
+#include "readlink.h"
+
+#define DIR_TEMP	"test_dir_1"
+#define TEST_FILE1	"test_dir_1/test_file_1"
+#define SYM_FILE1	"test_dir_1/slink_file_1"
+#define TEST_FILE2	"test_file_2"
+#define SYM_FILE2	"slink_file_2"
+#define TEST_FILE3	"test_file_3"
+#define SYM_FILE3	"test_file_3/slink_file_3"
 #define ELOOPFILE	"/test_eloop"
-#define MAX_SIZE	256
=20
 static char longpathname[PATH_MAX + 2];
 static char elooppathname[sizeof(ELOOPFILE) * 43] =3D ".";
+static char buffer[MAX_SIZE];
=20
-static struct test_case_t {
+static struct tcase {
 	char *link;
+	char *buf;
 	size_t buf_size;
 	int exp_errno;
-} test_cases[] =3D {
-	{SYM_FILE1, 1, EACCES},
-	    /* Don't test with bufsize -1, since this cause a fortify-check-fail =
when
-	       using glibc and -D_FORITY_SOURCE=3D2
-
-	       Discussion: http://lkml.org/lkml/2008/10/23/229
-	       Conclusion: Only test with 0 as non-positive bufsize.
-
-	       { SYM_FILE2, -1, EINVAL, NULL },
-	     */
-	{SYM_FILE2, 0, EINVAL},
-	{TEST_FILE2, 1, EINVAL},
-	{longpathname, 1, ENAMETOOLONG},
-	{"", 1, ENOENT},
-	{SYM_FILE3, 1, ENOTDIR},
-	{elooppathname, 1, ELOOP},
+} tcases[] =3D {
+	{SYM_FILE1, buffer, sizeof(buffer), EACCES},
+	/* Don't test with bufsize -1, since this cause a fortify-check-fail
+	   when using glibc and -D_FORITY_SOURCE=3D2
+
+	   Discussion: http://lkml.org/lkml/2008/10/23/229
+	   Conclusion: Only test with 0 as non-positive bufsize.
+
+	   { SYM_FILE2, -1, EINVAL, NULL },
+	*/
+	{SYM_FILE2, buffer, 0, EINVAL},
+	{TEST_FILE2, buffer, sizeof(buffer), EINVAL},
+	{longpathname, buffer, sizeof(buffer), ENAMETOOLONG},
+	{"", buffer, sizeof(buffer), ENOENT},
+	{SYM_FILE3, buffer, sizeof(buffer), ENOTDIR},
+	{elooppathname, buffer, sizeof(buffer), ELOOP},
+	{SYMFILE, (char *)-1, sizeof(buffer), EFAULT},
 };
=20
-static void setup(void);
-static void readlink_verify(struct test_case_t *);
-static void cleanup(void);
-
-char *TCID =3D "readlink03";
-int TST_TOTAL =3D ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
+static void verify_readlink(unsigned int n)
 {
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	struct tcase *tc =3D &tcases[n];
=20
-	setup();
+	TEST(readlink(tc->link, tc->buf, tc->buf_size));
+	if (TEST_RETURN !=3D -1) {
+		tst_res(TFAIL, "readlink() sueeeeded unexpectedly, errno");
+		return;
+	}
=20
-	for (lc =3D 0; TEST_LOOPING(lc); lc++) {
-		tst_count =3D 0;
+	if (TEST_ERRNO !=3D tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"readlink() failed unexpectedly; expected: %d - %s, got",
+			tc->exp_errno, tst_strerrno(tc->exp_errno));
=20
-		for (i =3D 0; i < TST_TOTAL; i++)
-			readlink_verify(&test_cases[i]);
+		if (tc->exp_errno =3D=3D ENOENT && TEST_ERRNO =3D=3D EINVAL) {
+			tst_res(TWARN | TTERRNO,
+				"It may be a Kernel Bug, see the patch:"
+				"http://git.kernel.org/linus/1fa1e7f6");
+		}
+	} else {
+		tst_res(TPASS | TTERRNO, "readlink() failed as expected");
 	}
-
-	cleanup();
-	tst_exit();
 }
=20
-void setup(void)
+static void setup(void)
 {
-	struct passwd *ltpuser;
 	int i;
+	struct passwd *pwent;
=20
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	ltpuser =3D SAFE_GETPWNAM(cleanup, "nobody");
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
-	TEST_PAUSE;
+	pwent =3D SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(pwent->pw_uid);
=20
-	tst_tmpdir();
+	SAFE_MKDIR(DIR_TEMP, MODE_RWX);
+	SAFE_TOUCH(TEST_FILE1, 0666, NULL);
+	SAFE_SYMLINK(TEST_FILE1, SYM_FILE1);
+	SAFE_CHMOD(DIR_TEMP, FILE_MODE);
=20
-	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	SAFE_TOUCH(cleanup, TEST_FILE1, 0666, NULL);
-	SAFE_SYMLINK(cleanup, TEST_FILE1, SYM_FILE1);
-	SAFE_CHMOD(cleanup, DIR_TEMP, FILE_MODE);
-
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
-	SAFE_SYMLINK(cleanup, TEST_FILE2, SYM_FILE2);
+	SAFE_TOUCH(TEST_FILE2, 0666, NULL);
+	SAFE_SYMLINK(TEST_FILE2, SYM_FILE2);
=20
 	memset(longpathname, 'a', PATH_MAX + 1);
=20
-	SAFE_TOUCH(cleanup, TEST_FILE3, 0666, NULL);
+	SAFE_TOUCH(TEST_FILE3, 0666, NULL);
+
+	SAFE_MKDIR("test_eloop", MODE_RWX);
+	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
=20
-	/*
-	 * NOTE: the ELOOP test is written based on that the consecutive
-	 * symlinks limit in kernel is hardwired to 40.
-	 */
-	SAFE_MKDIR(cleanup, "test_eloop", MODE_RWX);
-	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
 	for (i =3D 0; i < 43; i++)
 		strcat(elooppathname, ELOOPFILE);
-}
-
-void readlink_verify(struct test_case_t *tc)
-{
-	char buffer[MAX_SIZE];
-
-	if (tc->buf_size =3D=3D 1)
-		tc->buf_size =3D sizeof(buffer);
-
-	TEST(readlink(tc->link, buffer, tc->buf_size));
-
-	if (TEST_RETURN !=3D -1) {
-		tst_resm(TFAIL, "readlink() returned %ld, "
-			"expected -1, errno:%d", TEST_RETURN,
-			tc->exp_errno);
-		return;
-	}
=20
-	if (TEST_ERRNO =3D=3D tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "readlink() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			"readlink() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, strerror(tc->exp_errno));
-		if (tc->exp_errno =3D=3D ENOENT && TEST_ERRNO =3D=3D EINVAL) {
-			tst_resm(TWARN | TTERRNO,
-				"It may be a Kernel Bug, see the patch:"
-				"http://git.kernel.org/linus/1fa1e7f6");
-		}
-	}
+	SAFE_TOUCH(TESTFILE, 0666, NULL);
+	SAFE_SYMLINK(TESTFILE, SYMFILE);
 }
=20
-void cleanup(void)
+static void cleanup(void)
 {
-	if (seteuid(0) =3D=3D -1)
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
-
-	tst_rmdir();
+	SAFE_SETEUID(0);
 }
+
+static struct tst_test test =3D {
+	.tcnt =3D ARRAY_SIZE(tcases),
+	.test =3D verify_readlink,
+	.setup =3D setup,
+	.cleanup =3D cleanup,
+	.needs_tmpdir =3D 1,
+	.needs_root =3D 1,
+};
--=20
1.8.3.1



