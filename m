From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:52 +0200
Subject: [LTP] [RFC PATCH 6/8] syscalls/link08: Rewrite to the new library
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Make use of .needs_rofs

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/link/link08.c | 115 +++++++-------------------------
 1 file changed, 25 insertions(+), 90 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index 8cb72d1df..986d5552e 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -15,7 +15,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  */
 /*
  * Test Description:
@@ -32,134 +31,70 @@
  *   4. link() fails with -1 return value and sets errno to ELOOP
  *      if too many symbolic links were encountered in resolving path.
  */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <pwd.h>
-#include <sys/mount.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define MNT_POINT	"mntpoint"
 #define TEST_FILE	"testfile"
 #define TEST_FILE1	"testfile1"
-#define TEST_FILE2	"mntpoint/testfile3"
+#define TEST_FILE2	"mntpoint/file"
 #define TEST_FILE3	"mntpoint/testfile4"
 
 static char test_file4[PATH_MAX] = ".";
 static void setup(void);
-static void cleanup(void);
-
-static const char *device;
-static int mount_flag;
 
-static struct test_case_t {
+static struct tcase {
 	char *oldpath;
 	char *newpath;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{TEST_FILE1, TEST_FILE, EPERM},
 	{TEST_FILE2, TEST_FILE, EXDEV},
 	{TEST_FILE2, TEST_FILE3, EROFS},
 	{test_file4, TEST_FILE, ELOOP},
 };
 
-static void link_verify(const struct test_case_t *);
-
-char *TCID = "link08";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
+static void link_verify(unsigned int i)
 {
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct tcase *tc = &tcases[i];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			link_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-
-}
-
-static void link_verify(const struct test_case_t *tc)
-{
 	TEST(link(tc->oldpath, tc->newpath));
 
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "link succeeded unexpectedly");
+		tst_res(TFAIL, "link() succeeded unexpectedly (%li)",
+		        TEST_RETURN);
 		return;
 	}
 
 	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "link failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "link failed unexpectedly; expected: %d - %s",
-			 tc->exp_errno, strerror(tc->exp_errno));
+		tst_res(TPASS | TTERRNO, "link() failed as expected");
+		return;
 	}
-}
 
+	tst_res(TFAIL | TTERRNO,
+		"link() failed unexpectedly; expected: %d - %s",
+		tc->exp_errno, tst_strerrno(tc->exp_errno));
+}
 
 static void setup(void)
 {
 	int i;
-	const char *fs_type;
-
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
 
-	SAFE_MKDIR(cleanup, TEST_FILE1, DIR_MODE);
+	SAFE_MKDIR(TEST_FILE1, DIR_MODE);
 
-	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
-	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
+	SAFE_MKDIR("test_eloop", DIR_MODE);
+	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
 	for (i = 0; i < 43; i++)
 		strcat(test_file4, "/test_eloop");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, 0, NULL);
-	mount_flag = 1;
-
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0644, NULL);
-	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type,
-		   MS_REMOUNT | MS_RDONLY, NULL);
 }
 
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(MNT_POINT) < 0)
-		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = link_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+};
-- 
2.13.6

