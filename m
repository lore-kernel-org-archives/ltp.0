From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:53 +0200
Subject: [LTP] [RFC PATCH 7/8] syscalls/utimes01: Rewrite to the new library
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Make use of .needs_rofs

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/utimes/utimes01.c | 131 +++++-----------------------
 1 file changed, 24 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index c79bd092c..b67543b09 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -36,45 +36,28 @@
  */
 
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <dirent.h>
 #include <unistd.h>
-#include <getopt.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <stdio.h>
 #include <pwd.h>
-#include <sys/mount.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 
-#define MNTPOINT "mntpoint"
+#define MNT_POINT "mntpoint"
 #define TESTFILE1 "testfile1"
 #define TESTFILE2 "testfile2"
-#define TESTFILE3 "mntpoint/testfile"
+#define TESTFILE3 "mntpoint/file"
 #define FILE_MODE (S_IRWXU | S_IRGRP | S_IXGRP | \
 					S_IROTH | S_IXOTH)
 #define DIR_MODE (S_IRWXU | S_IRWXG | S_IRWXO)
 
-#define LTPUSER1 "nobody"
-#define LTPUSER2 "bin"
-
-static const char *device;
-static int mount_flag;
-
 static struct timeval a_tv[2] = { {0, 0}, {1000, 0} };
 static struct timeval m_tv[2] = { {1000, 0}, {0, 0} };
 static struct timeval tv[2] = { {1000, 0}, {2000, 0} };
 
-static struct test_case_t {
+static struct tcase {
 	char *pathname;
 	struct timeval *times;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{ TESTFILE1, a_tv, 0 },
 	{ TESTFILE1, m_tv, 0 },
 	{ TESTFILE2, NULL, EACCES },
@@ -84,83 +67,23 @@ static struct test_case_t {
 	{ TESTFILE3, tv, EROFS },
 };
 
-static void setup(void);
-static void cleanup(void);
-static void utimes_verify(const struct test_case_t *);
-
-char *TCID = "utimes01";
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
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			utimes_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
-	struct passwd *ltpuser;
-	const char *fs_type;
-
-	tst_require_root();
+	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
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
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	SAFE_TOUCH(cleanup, TESTFILE1, FILE_MODE, NULL);
-	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
-	SAFE_CHOWN(cleanup, TESTFILE1, ltpuser->pw_uid,
-		ltpuser->pw_gid);
-
-	SAFE_TOUCH(cleanup, TESTFILE2, FILE_MODE, NULL);
-	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER2);
-	SAFE_CHOWN(cleanup, TESTFILE2, ltpuser->pw_uid,
-		ltpuser->pw_gid);
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
-	mount_flag = 1;
-	SAFE_TOUCH(cleanup, TESTFILE3, FILE_MODE, NULL);
-	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
-	SAFE_CHOWN(cleanup, TESTFILE3, ltpuser->pw_uid,
-		ltpuser->pw_gid);
-	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_REMOUNT | MS_RDONLY,
-		   NULL);
-
-	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER1);
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	SAFE_TOUCH(TESTFILE2, FILE_MODE, NULL);
+	SAFE_SETEUID(ltpuser->pw_uid);
+	SAFE_TOUCH(TESTFILE1, FILE_MODE, NULL);
 }
 
-static void utimes_verify(const struct test_case_t *tc)
+static void utimes_verify(unsigned int i)
 {
 	struct stat st;
 	struct timeval tmp_tv[2];
+	struct tcase *tc = &tcases[i];
 
 	if (tc->exp_errno == 0) {
-		SAFE_STAT(cleanup, tc->pathname, &st);
+		SAFE_STAT(tc->pathname, &st);
 
 		tmp_tv[0].tv_sec = st.st_atime;
 		tmp_tv[0].tv_usec = 0;
@@ -171,28 +94,22 @@ static void utimes_verify(const struct test_case_t *tc)
 	TEST(utimes(tc->pathname, tc->times));
 
 	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "utimes() worked as expected");
+		tst_res(TPASS | TTERRNO, "utimes() worked as expected");
 	} else {
-		tst_resm(TFAIL | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"utimes() failed unexpectedly; expected: %d - %s",
-			tc->exp_errno, strerror(tc->exp_errno));
+			tc->exp_errno, tst_strerrno(tc->exp_errno));
 	}
 
 	if (TEST_ERRNO == 0 && utimes(tc->pathname, tmp_tv) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "utimes() failed.");
+		tst_brk(TBROK | TERRNO, "utimes() failed.");
 }
 
-static void cleanup(void)
-{
-	if (seteuid(0) == -1)
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
-
-	if (mount_flag && tst_umount(MNTPOINT) == -1)
-		tst_resm(TWARN | TERRNO, "umount %s failed", MNTPOINT);
-
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = utimes_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+};
-- 
2.13.6

