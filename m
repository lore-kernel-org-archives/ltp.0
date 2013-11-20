Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Viwwt-0002eP-QN
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 01:51:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Viwwr-0005QU-Q6
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 01:51:23 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAK1p9mv019462
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Nov 2013 09:51:11 +0800
Message-ID: <1384912265.7680.23.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 20 Nov 2013 09:51:05 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] fchmod/fchmod06.c: cleanup
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

cleanup of fchmod06.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchmod/fchmod06.c | 115 ++++++++--------------------
 1 file changed, 34 insertions(+), 81 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index c0e02cd..7776e1e 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -13,8 +13,8 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -68,10 +68,6 @@
  *  This test should be executed by 'non-super-user' only.
  */
 
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdio.h>
@@ -87,49 +83,36 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-#define MODE_RWX	(S_IRWXU|S_IRWXG|S_IRWXO)
 #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define TEST_FILE1	"tfile_1"
 #define TEST_FILE2	"tfile_2"
 
-void setup1();			/* setup function to test chmod for EPERM */
-void setup2();			/* setup function to test chmod for EBADF */
-
-int fd1;			/* File descriptor for testfile1 */
-int fd2;			/* File descriptor for testfile2 */
+static int fd1;
+static int fd2;
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	int fd;
+static struct test_case_t {
+	int *fd;
 	int mode;
 	int exp_errno;
-	void (*setupfunc) ();
 } test_cases[] = {
-	{
-	1, FILE_MODE, EPERM, setup1}, {
-2, FILE_MODE, EBADF, setup2},};
+	{&fd1, FILE_MODE, EPERM},
+	{&fd2, FILE_MODE, EBADF},
+};
 
 char *TCID = "fchmod06";
-int TST_TOTAL = 2;
-int exp_enos[] = { EPERM, EBADF, 0 };
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EPERM, EBADF, 0 };
+static struct passwd *ltpuser;
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-char *test_home;		/* variable to hold TESTHOME env. */
-
-void setup();			/* Main setup function for the tests */
-void cleanup();			/* cleanup function for the test */
+static void setup(void);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
 	int lc;
-	char *msg;
-	int fd;			/* test file descriptor */
 	int i;
-	int mode;		/* creation mode for the node created */
-
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
@@ -140,26 +123,21 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
-			fd = test_cases[i].fd;
-			mode = test_cases[i].mode;
 
-			if (fd == 1)
-				fd = fd1;
-			else
-				fd = fd2;
-
-			TEST(fchmod(fd, mode));
+			TEST(fchmod(*test_cases[i].fd, test_cases[i].mode));
 
 			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == test_cases[i].exp_errno)
+				if (TEST_ERRNO == test_cases[i].exp_errno) {
 					tst_resm(TPASS | TTERRNO,
 						 "fchmod failed as expected");
-				else
+				} else {
 					tst_resm(TFAIL | TTERRNO,
 						 "fchmod failed unexpectedly");
-			} else
+				}
+			} else {
 				tst_resm(TFAIL,
 					 "fchmod succeeded unexpectedly");
+			}
 		}
 
 	}
@@ -168,66 +146,41 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-void setup()
+static void setup(void)
 {
-	int i;
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_resm(TBROK | TERRNO, "seteuid failed");
 
-	test_home = get_current_dir_name();
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
-	for (i = 0; i < TST_TOTAL; i++)
-		test_cases[i].setupfunc();
-}
-
-void setup1()
-{
-	uid_t old_uid;
+	fd1 = SAFE_OPEN(cleanup, TEST_FILE1, O_RDWR | O_CREAT, 0666);
 
-	if ((fd1 = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(%s, ..) failed",
-			 TEST_FILE1);
+	fd2 = SAFE_OPEN(cleanup, TEST_FILE2, O_RDWR | O_CREAT, 0666);
 
-	old_uid = geteuid();
-	if (seteuid(0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "seteuid(0) failed");
+	SAFE_SETEUID(cleanup, 0);
 
-	if (fchown(fd1, 0, 0) == -1)
+	if (fchown(fd1, 0, 0) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup, "fchown of %s failed",
 			 TEST_FILE1);
+	}
 
-	if (seteuid(old_uid) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "seteuid(%d) failed",
-			 old_uid);
-
-}
+	SAFE_CLOSE(cleanup, fd2);
 
-void setup2()
-{
-	if ((fd2 = open(TEST_FILE2, O_RDWR | O_CREAT, 0666)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(%s, ..) failed",
-			 TEST_FILE2);
-	if (close(fd2) == -1)
-		tst_brkm(TBROK, cleanup, "closing %s failed", TEST_FILE2);
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
-	if (close(fd1) == -1)
-		tst_resm(TWARN | TERRNO, "closing %s failed", TEST_FILE1);
+	SAFE_CLOSE(NULL, fd1);
 
 	tst_rmdir();
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
