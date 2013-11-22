Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VjkCa-0006sr-1x
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 06:26:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjkCX-0001Zr-RX
	for ltp-list@lists.sourceforge.net; Fri, 22 Nov 2013 06:26:52 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAM6QfIe016566
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Nov 2013 14:26:42 +0800
Message-ID: <1385101595.1552.11.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 22 Nov 2013 14:26:35 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] fchown/fchown04.c: cleanup
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

cleanup of fchown04.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchown/fchown04.c | 106 ++++++++--------------------
 1 file changed, 31 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index 8329550..707a979 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
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
@@ -84,84 +84,59 @@
 #include "usctest.h"
 #include "safe_macros.h"
 
-#define MODE_RWX	(S_IRWXU|S_IRWXG|S_IRWXO)
-#define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define TEST_FILE1	"tfile_1"
 #define TEST_FILE2	"tfile_2"
 
-void setup1();			/* setup function to test chmod for EPERM */
-void setup2();			/* setup function to test chmod for EBADF */
+static int fd1;
+static int fd2;
 
-int fd1;			/* File descriptor for testfile1 */
-int fd2;			/* File descriptor for testfile2 */
-
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	int fd;
+static struct test_case_t {
+	int *fd;
 	int exp_errno;
-	void (*setupfunc) ();
 } test_cases[] = {
-	{
-	1, EPERM, setup1}, {
-2, EBADF, setup2},};
+	{&fd1, EPERM},
+	{&fd2, EBADF},
+};
 
-char test_home[PATH_MAX];	/* variable to hold TESTHOME env */
 char *TCID = "fchown04";
-int TST_TOTAL = 2;
-int exp_enos[] = { EPERM, EBADF, 0 };
-
-char bin_uid[] = "bin";
-struct passwd *ltpuser;
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EPERM, EBADF, 0 };
 
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
-	uid_t user_id;		/* Effective user id of a test process */
-	gid_t group_id;		/* Effective group id of a test process */
-
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
 	TEST_EXP_ENOS(exp_enos);
 
-	user_id = geteuid();
-	group_id = getegid();
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			fd = test_cases[i].fd;
-
-			if (fd == 1)
-				fd = fd1;
-			else
-				fd = fd2;
-
-			TEST(fchown(fd, user_id, group_id));
+			TEST(fchown(*test_cases[i].fd, geteuid(), getegid()));
 
 			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == test_cases[i].exp_errno)
+				if (TEST_ERRNO == test_cases[i].exp_errno) {
 					tst_resm(TPASS | TTERRNO,
 						 "fchown failed as expected");
-				else
+				} else {
 					tst_resm(TFAIL | TTERRNO,
 						 "fchown failed unexpectedly; "
 						 "expected %d - %s",
 						 test_cases[i].exp_errno,
 						 strerror(test_cases[i].
 							  exp_errno));
-			} else
+				}
+			} else {
 				tst_resm(TFAIL, "fchown passed unexpectedly");
+			}
 		}
 
 	}
@@ -171,58 +146,39 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-void setup()
+static void setup(void)
 {
-	int i;
+	struct passwd *ltpuser;
 
 	TEST_PAUSE;
 
 	tst_require_root(NULL);
 
-	ltpuser = SAFE_GETPWNAM(NULL, bin_uid);
-
-	tst_tmpdir();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	initgroups("root", getgid());
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
 
-	SAFE_SETEGID(NULL, ltpuser->pw_uid);
-	SAFE_SETEUID(NULL, ltpuser->pw_gid);
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	tst_tmpdir();
 
-	for (i = 0; i < TST_TOTAL; i++)
-		if (test_cases[i].setupfunc != NULL)
-			test_cases[i].setupfunc();
-}
-
-void setup1()
-{
-	int old_uid;
-	struct passwd *nobody;
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	/* EPERM */
 	fd1 = SAFE_OPEN(cleanup, TEST_FILE1, O_RDWR | O_CREAT, 0666);
 
-	old_uid = geteuid();
-
 	SAFE_SETEUID(cleanup, 0);
 
-	nobody = SAFE_GETPWNAM(cleanup, "nobody");
-
-	if (fchown(fd1, nobody->pw_uid, nobody->pw_gid) < 0)
+	if (fchown(fd1, 0, 0) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "fchown failed");
 
-	SAFE_SETEUID(cleanup, old_uid);
-}
-
-void setup2()
-{
+	/* EBADF */
 	fd2 = SAFE_OPEN(cleanup, TEST_FILE2, O_RDWR | O_CREAT, 0666);
+
 	SAFE_CLOSE(cleanup, fd2);
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
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
