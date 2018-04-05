From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:50 +0200
Subject: [LTP] [RFC PATCH 4/8] syscalls/rmdir02: Make use of .needs_rofs
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/rmdir/rmdir02.c | 83 +++++++++++--------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 55123c727..d7cec8d4e 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -14,41 +14,21 @@
  * You should have received a copy of the GNU General Public License
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
-
 /*
  * Description:
- *  1) create a directory tstdir1, create a file under it.
- *     call rmdir(tstdir1), verify the return value is -1
- *     and the errno is ENOTEMPTY.
- *  2) create a directory with long path, call rmdir(tstdir1),
- *     verify the return value is -1 and the errno is ENAMETOOLONG.
- *  3) pass a pathname containing non-exist directory component
- *     to rmdir(), verify the return value is -1 and the errno
- *     is ENOENT.
- *  4) pass a pathname containing a file component to rmdir(),
- *     verify the return value is -1 and the errno is ENOTDIR.
- *  5) attempt to pass an invalid pathname with an address
- *     pointing outside the address space of the process, as the
- *     argument to rmdir(), verify the return value is -1 and
- *     the errno is EFAULT.
- *  6) pass a pathname with too many symbolic links to rmdir(),
- *     verify the return value is -1 and the errno is ELOOP.
- *  7) pass a pathname which refers to a directory on a read-only
- *     file system to rmdir(), verify the return value is -1 and
- *     the errno is EROFS.
- *  8) pass a pathname which is currently used as a mount point
- *     to rmdir(), verify the return value is -1 and the errno is
- *     EBUSY.
- *  9) pass a pathname which points to the current directory(.)
- *     to  rmdir(), verify the return value is -1 and the errno is
- *     EINVAL.
+ *   1) attempt to rmdir() non-empty directory -> ENOTEMPTY
+ *   2) attempt to rmdir() directory with long path name -> ENAMETOOLONG
+ *   3) attempt to rmdir() non-existing directory -> ENOENT
+ *   4) attempt to rmdir() a file -> ENOTDIR
+ *   5) attempt to rmdir() invalid pointer -> EFAULT
+ *   6) attempt to rmdir() symlink loop -> ELOOP
+ *   7) attempt to rmdir() dir on RO mounted FS -> EROFS
+ *   8) attempt to rmdir() mount point -> EBUSY
+ *   9) attempt to rmdir() current directory "." -> EINVAL
  */
 
 #include <errno.h>
-#include <sys/mman.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/mount.h>
+
 #include "tst_test.h"
 
 #define DIR_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
@@ -58,11 +38,10 @@
 #define TESTDIR2	"nosuchdir/testdir2"
 #define TESTDIR3	"testfile2/testdir3"
 #define TESTDIR4	"/loopdir"
-#define MNTPOINT	"mntpoint"
-#define TESTDIR5	"mntpoint/testdir5"
+#define MNT_POINT	"mntpoint"
+#define TESTDIR5	"mntpoint/dir"
 #define TESTFILE    "testdir/testfile"
 #define TESTFILE2   "testfile2"
-#define CURRENTDIR  "."
 
 static char longpathname[PATH_MAX + 2];
 static char looppathname[sizeof(TESTDIR4) * 43] = ".";
@@ -78,17 +57,14 @@ static struct testcase {
 	{NULL, EFAULT},
 	{looppathname, ELOOP},
 	{TESTDIR5, EROFS},
-	{MNTPOINT, EBUSY},
-	{CURRENTDIR, EINVAL},
+	{MNT_POINT, EBUSY},
+	{".", EINVAL}
 };
 
 static void setup(void)
 {
 	unsigned int i;
 
-	SAFE_MKDIR(TESTDIR5, DIR_MODE);
-	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type,
-				 MS_REMOUNT | MS_RDONLY, NULL);
 	SAFE_MKDIR(TESTDIR, DIR_MODE);
 	SAFE_TOUCH(TESTFILE, FILE_MODE, NULL);
 
@@ -97,16 +73,15 @@ static void setup(void)
 	SAFE_TOUCH(TESTFILE2, FILE_MODE, NULL);
 
 	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
-		if (tcases[i].exp_errno == EFAULT) {
+		if (!tcases[i].dir)
 			tcases[i].dir = tst_get_bad_addr(NULL);
-		}
 	}
 
 	/*
-	* NOTE: the ELOOP test is written based on that the
-	* consecutive symlinks limit in kernel is hardwire
-	* to 40.
-	*/
+	 * NOTE: the ELOOP test is written based on that the
+	 * consecutive symlinks limit in kernel is hardwired
+	 * to 40.
+	 */
 	SAFE_MKDIR("loopdir", DIR_MODE);
 	SAFE_SYMLINK("../loopdir", "loopdir/loopdir");
 	for (i = 0; i < 43; i++)
@@ -118,18 +93,21 @@ static void verify_rmdir(unsigned int n)
 	struct testcase *tc = &tcases[n];
 
 	TEST(rmdir(tc->dir));
+
 	if (TEST_RETURN != -1) {
-		tst_res(TFAIL, "rmdir() succeeded unexpectedly");
+		tst_res(TFAIL, "rmdir() succeeded unexpectedly (%li)",
+			TEST_RETURN);
 		return;
 	}
 
 	if (TEST_ERRNO == tc->exp_errno) {
 		tst_res(TPASS | TTERRNO, "rmdir() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO,
-			"rmdir() failed unexpectedly; expected: %d, got ",
-			tc->exp_errno);
+		return;
 	}
+
+	tst_res(TFAIL | TTERRNO,
+		"rmdir() failed unexpectedly; expected: %d - %s",
+		tc->exp_errno, tst_strerrno(tc->exp_errno));
 }
 
 static struct tst_test test = {
@@ -137,9 +115,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_rmdir,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
-	.mntpoint = MNTPOINT,
-	.mount_device = 1,
-
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
 };
-
-- 
2.13.6

