From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 12 Feb 2018 18:21:38 +0800
Subject: [LTP] [PATCH 4/4] syscalls/readlink04.c: Cleanup && Convert to new
	API
In-Reply-To: <1518430898-13225-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1518430898-13225-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1518430898-13225-4-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/readlink/readlink04.c | 137 +++++++-----------------
 1 file changed, 36 insertions(+), 101 deletions(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
index 9c6c589..ff2736b 100644
--- a/testcases/kernel/syscalls/readlink/readlink04.c
+++ b/testcases/kernel/syscalls/readlink/readlink04.c
@@ -11,131 +11,62 @@
  * but WITHOUT ANY WARRANTY;  without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
  * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * Test Name : readlink04
- *
  * Test Description :
- *  Verify that, readlink call will succeed to read the contents of the
- *  symbolic link if invoked by non-root user who is not the owner of the
- *  symbolic link.
- *
- * Expected Result:
- *  readlink() should return the contents of symbolic link path in the
- *  specified buffer on success.
+ *  readlink() will succeed to read the contents of the symbolic link if
+ *  invoked by non-root user who is not the owner of the symbolic link.
  */
 
-#include <stdlib.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/wait.h>
 #include <errno.h>
 #include <string.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "readlink04";
-int TST_TOTAL = 1;
 
-static char *TESTFILE = "./testfile";
-static char *SYMFILE = "slink_file";
-
-#define MAX_SIZE	256
+#include "tst_test.h"
+#include "readlink.h"
 
 static int exp_val;
 static char buffer[MAX_SIZE];
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_readlink(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call readlink(2) to read the contents of
-		 * symlink into a buffer.
-		 */
-		TEST(readlink(SYMFILE, buffer, sizeof(buffer)));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "readlink() on %s failed",
-			         SYMFILE);
-			continue;
-		}
-
-		if (TEST_RETURN == exp_val) {
-			/* Check for the contents of buffer */
-			if (memcmp(buffer, TESTFILE, exp_val) != 0) {
-				tst_brkm(TFAIL, cleanup, "TESTFILE %s "
-					 "and buffer contents %s "
-					 "differ", TESTFILE, buffer);
-			} else {
-				tst_resm(TPASS, "readlink() "
-					 "functionality on '%s' is "
-					 "correct", SYMFILE);
-			}
+	TEST(readlink(SYMFILE, buffer, sizeof(buffer)));
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "readlink() on %s failed", SYMFILE);
+
+	if (TEST_RETURN != exp_val) {
+		tst_res(TFAIL, "readlink() return value %ld "
+			"did match, Expected %d", TEST_RETURN, exp_val);
+	} else {
+		if (memcmp(buffer, TESTFILE, exp_val) != 0) {
+			tst_brk(TFAIL, "TESTFILE %s and buffer "
+				"contents %s differ", TESTFILE, buffer);
 		} else {
-			tst_resm(TFAIL, "readlink() return value %ld "
-				 "doesn't match, Expected %d",
-				 TEST_RETURN, exp_val);
+			tst_res(TPASS, "readlink() functionality on '%s' was "
+				"correct", SYMFILE);
 		}
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-#define FILE_MODE  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-
 static void setup(void)
 {
 	int fd;
 	char *tmp_dir = NULL;
 	struct passwd *pwent;
 
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	/* get the name of the temporary directory */
-	if ((tmp_dir = getcwd(tmp_dir, 0)) == NULL)
-		tst_brkm(TBROK, NULL, "getcwd failed");
-
-	if ((pwent = getpwnam("bin")) == NULL)
-		tst_brkm(TBROK, cleanup, "getpwname() failed");
+	tmp_dir = SAFE_GETCWD(tmp_dir, 0);
+	pwent = SAFE_GETPWNAM("bin");
 
 	/* make the tmp directory belong to bin */
-	SAFE_CHOWN(cleanup, tmp_dir, pwent->pw_uid, pwent->pw_gid);
-
-	if (chmod(tmp_dir, 0711) != 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "chmod(%s) failed", tmp_dir);
+	SAFE_CHOWN(tmp_dir, pwent->pw_uid, pwent->pw_gid);
+	SAFE_CHMOD(tmp_dir, 0711);
 
 	/* create test file and symlink */
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open(%s) failed", TESTFILE);
-
-	if (close(fd))
-		tst_brkm(TBROK|TERRNO, cleanup, "close(%s) failed", TESTFILE);
-
-	SAFE_SYMLINK(cleanup, TESTFILE, SYMFILE);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
+	SAFE_CLOSE(fd);
+	SAFE_SYMLINK(TESTFILE, SYMFILE);
 
 	/* set up the expected return value from the readlink() call */
 	exp_val = strlen(TESTFILE);
@@ -144,15 +75,19 @@ static void setup(void)
 	memset(buffer, 0, MAX_SIZE);
 
 	/* finally, change the id of the parent process to "nobody" */
-	if ((pwent = getpwnam("nobody")) == NULL)
-		tst_brkm(TBROK, cleanup, "getpwname() failed for nobody");
-
-	SAFE_SETEUID(cleanup, pwent->pw_uid);
+	pwent = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(pwent->pw_uid);
 }
 
 static void cleanup(void)
 {
-	SAFE_SETEUID(NULL, 0);
-
-	tst_rmdir();
+	SAFE_SETEUID(0);
 }
+
+static struct tst_test test = {
+	.test_all = verify_readlink,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
1.8.3.1



