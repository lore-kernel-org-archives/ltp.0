Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VlBLK-0008HJ-Tv
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 05:37:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VlBLI-0006fL-Hm
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 05:37:50 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAQ5bC9J030489
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Nov 2013 13:37:32 +0800
Message-ID: <1385443532.14061.0.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Tue, 26 Nov 2013 13:25:32 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] fchownat/fchownat01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

cleanup of fchownat01.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchownat/fchownat01.c | 209 ++++++++----------------
 1 file changed, 69 insertions(+), 140 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 8a81f41..b46a721 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -13,8 +13,8 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
  * NAME
  *      fchownat01.c
@@ -55,89 +55,60 @@
 #include <signal.h>
 #include "test.h"
 #include "usctest.h"
-#include "linux_syscall_numbers.h"
-
-#define TEST_CASES 6
-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
-void setup();
-void cleanup();
-void setup_every_copy();
+#include "safe_macros.h"
+
+static void setup(void);
+static void cleanup(void);
+
+static uid_t uid;
+static gid_t gid;
+static char pathname[PATH_MAX+1];
+static char testfile[PATH_MAX+1];
+static char testfile2[PATH_MAX+1];
+static char testfile3[PATH_MAX+1];
+static int dirfd;
+static int fd;
+static int no_fd;
+static int cu_fd;
+
+static struct test_case_t {
+	int ret;
+	int flag;
+	int *fds;
+	char *filenames;
+} test_cases[] = {
+	{0, 0, &dirfd, testfile},
+	{0, 0, &dirfd, testfile2},
+	{ENOTDIR, 0, &fd, testfile},
+	{EBADF, 0, &no_fd, testfile},
+	{EINVAL, 9999, &dirfd, testfile},
+	{0, 0, &cu_fd, testfile},
+};
 
 char *TCID = "fchownat01";
-int TST_TOTAL = TEST_CASES;
-char pathname[256];
-char testfile[256];
-char testfile2[256];
-char testfile3[256];
-int dirfd, fd, ret;
-int fds[TEST_CASES];
-char *filenames[TEST_CASES];
-int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, EINVAL, 0 };
-int flags[TEST_CASES] = { 0, 0, 0, 0, 9999, 0 };
-
-uid_t uid;
-gid_t gid;
-
-int myfchownat(int dirfd, const char *filename, uid_t owner, gid_t group,
-	       int flags)
-{
-	return ltp_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
-}
+int TST_TOTAL = ARRAY_SIZE(test_cases);
 
 int main(int ac, char **av)
 {
 	int lc;
-	char *msg;
 	int i;
 
-	/* Disable test if the version of the kernel is less than 2.6.16 */
-	if ((tst_kvercmp(2, 6, 16)) < 0) {
-		tst_resm(TWARN, "This test can only run on kernels that are ");
-		tst_resm(TWARN, "2.6.16 and higher");
-		exit(0);
-	}
-
-	/***************************************************************
-	 * parse standard options
-	 ***************************************************************/
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	/***************************************************************
-	 * perform global setup for test
-	 ***************************************************************/
 	setup();
 
-	/***************************************************************
-	 * check looping state if -c option given
-	 ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		setup_every_copy();
 
 		tst_count = 0;
 
-		/*
-		 * Call fchownat
-		 */
 		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(myfchownat
-			     (fds[i], filenames[i], uid, gid, flags[i]));
-
-			/* check return code */
-			if (TEST_ERRNO == expected_errno[i]) {
-
-				/***************************************************************
-				 * only perform functional verification if flag set (-f not given)
-				 ***************************************************************/
-				if (STD_FUNCTIONAL_TEST) {
-					/* No Verification test, yet... */
-					tst_resm(TPASS,
-						 "fchownat() returned the expected  errno %d: %s",
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-				}
+			TEST(fchownat(*test_cases[i].fds,
+				      test_cases[i].filenames, uid, gid,
+				      test_cases[i].flag));
+
+			if (TEST_ERRNO == test_cases[i].ret) {
+				tst_resm(TPASS,
+					 "fchownat() returned the expected "
+					 "errno %d: %s", TEST_ERRNO,
+					 strerror(TEST_ERRNO));
 			} else {
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TFAIL,
@@ -148,97 +119,55 @@ int main(int ac, char **av)
 
 	}
 
-	/***************************************************************
-	 * cleanup and exit
-	 ***************************************************************/
 	cleanup();
 
-	return (0);
+	tst_exit();
 }
 
-void setup_every_copy()
+void setup()
 {
-	/* Initialize test dir and file names */
+	uid = geteuid();
+	gid = getegid();
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
 	sprintf(pathname, "fchownattestdir%d", getpid());
-	sprintf(testfile, "fchownattestfile%d.txt", getpid());
-	sprintf(testfile2, "/tmp/fchownattestfile%d.txt", getpid());
-	sprintf(testfile3, "fchownattestdir%d/fchownattestfile%d.txt", getpid(),
-		getpid());
 
-	ret = mkdir(pathname, 0700);
-	if (ret < 0) {
-		perror("mkdir: ");
-		exit(-1);
-	}
+	SAFE_MKDIR(cleanup, pathname, 0700);
 
-	dirfd = open(pathname, O_DIRECTORY);
-	if (dirfd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	dirfd = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 
-	fd = open(testfile, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	sprintf(testfile, "fchownattestfile%d.txt", getpid());
 
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
 
-	fd = open(testfile3, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	sprintf(testfile2, "/tmp/fchownattestfile%d.txt", getpid());
 
-	fds[0] = fds[1] = fds[4] = dirfd;
-	fds[2] = fd;
-	fds[3] = 100;
-	fds[5] = AT_FDCWD;
+	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
 
-	filenames[0] = filenames[2] = filenames[3] = filenames[4] =
-	    filenames[5] = testfile;
-	filenames[1] = testfile2;
-}
+	sprintf(testfile3, "fchownattestdir%d/fchownattestfile%d.txt", getpid(),
+		getpid());
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup()
-{
-	/* Set uid and gid */
-	uid = geteuid();
-	gid = getegid();
+	fd = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	no_fd = 100;
 
-	TEST_PAUSE;
+	cu_fd = AT_FDCWD;
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
 void cleanup()
 {
-	/* Remove them */
-	char tmppathname[256];
-	strcpy(tmppathname, pathname);
-
-	close(fd);
-	unlink(testfile);
-	unlink(testfile2);
-	unlink(testfile3);
+	SAFE_CLOSE(NULL, fd);
+
+	SAFE_UNLINK(NULL, testfile);
+
+	SAFE_UNLINK(NULL, testfile2);
+
+	SAFE_UNLINK(NULL, testfile3);
+
 	rmdir(pathname);
 
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }
-- 
1.8.2.1




------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
