Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VhDO1-0002Ri-4k
	for ltp-list@lists.sourceforge.net; Fri, 15 Nov 2013 07:00:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VhDNy-0001CV-SM
	for ltp-list@lists.sourceforge.net; Fri, 15 Nov 2013 07:00:13 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAF6iwWm028444
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Nov 2013 14:44:59 +0800
Message-ID: <1384497891.12576.3.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 15 Nov 2013 14:44:51 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] creat/creat06.c: cleanup
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

cleanup of creat06.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/creat/creat06.c | 146 ++++++++++--------------------
 1 file changed, 48 insertions(+), 98 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 51e46ab..6247c11 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
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
@@ -70,84 +70,62 @@
 #include <fcntl.h>
 #include "test.h"
 #include "usctest.h"
-
-void setup(void);
-void cleanup(void);
-
-char user1name[] = "nobody";
-
-char *TCID = "creat06";
-int fileHandle = 0;
-
-int exp_enos[] = { EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT, EACCES, 0 };
-
-#define	MODE1	0444
-#define	MODE2	0666
-#define NSIZE	1000
-
-char long_name[] =
-    "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
-
-char good_dir[NSIZE];
-char no_dir[] = "testfile/testdir";
-char not_dir[] = "file1/testdir";
-char test6_file[] = "dir6/file6";
-char nobody_uid[] = "nobody";
-
-struct passwd *ltpuser;
-struct test_case_t {
+#include "safe_macros.h"
+
+static void setup(void);
+static void cleanup(void);
+
+#define	MODE1		0444
+#define	MODE2		0666
+#define NSIZE		1000
+#define NO_DIR		"testfile/testdir"
+#define NOT_DIR		"file1/testdir"
+#define TEST6_FILE	"dir6/file6"
+
+static char long_name[PATH_MAX+2];
+static char good_dir[NSIZE];
+static int filehandle;
+static char *bad_addr;
+static struct passwd *ltpuser;
+static struct test_case_t {
 	char *fname;
 	int mode;
 	int error;
+	void (*setup)(void);
 } TC[] = {
-	/* The file name is an existing directory */
-	{
-	good_dir, MODE1, EISDIR},
-	    /* The file name is too long - ENAMETOOLONG */
-	{
-	long_name, MODE1, ENAMETOOLONG},
-	    /* Attempt to create a file in a directory that doesn't exist - ENOENT */
-	{
-	no_dir, MODE1, ENOENT},
-	    /* a compent of the file's path is not a directory - ENOTDIR */
-	{
-	not_dir, MODE1, ENOTDIR},
+	{good_dir, MODE1, EISDIR, NULL},
+	{long_name, MODE1, ENAMETOOLONG, NULL},
+	{NO_DIR, MODE1, ENOENT, NULL},
+	{NOT_DIR, MODE1, ENOTDIR, NULL},
 #if !defined(UCLINUX)
-	    /* The file address is bad - EFAULT */
-	{
-	(char *)-1, MODE1, EFAULT},
+	{(char *)-1, MODE1, EFAULT, NULL},
 #endif
-	    /* The directory lacks execute permission - EACCES */
-	{
-	test6_file, MODE1, EACCES}
+	{TEST6_FILE, MODE1, EACCES, NULL},
 };
 
-int TST_TOTAL = (sizeof(TC) / sizeof(*TC));
-
-char *bad_addr = 0;
+char *TCID = "creat06";
+int TST_TOTAL = ARRAY_SIZE(TC);
+static int exp_enos[] = { EISDIR, ENAMETOOLONG, ENOENT, ENOTDIR,
+			  EFAULT, EACCES, 0 };
 
 int main(int ac, char **av)
 {
 	int lc;
-	char *msg;
 	int i;
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
 	setup();
 
-	/* set up the expected errnos */
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
 
+			if (TC[i].setup)
+				TC[i].setup();
+
 			TEST(creat(TC[i].fname, TC[i].mode));
 
 			if (TEST_RETURN != -1) {
@@ -155,8 +133,6 @@ int main(int ac, char **av)
 				continue;
 			}
 
-			TEST_ERROR_LOG(TEST_ERRNO);
-
 			if (TEST_ERRNO == TC[i].error) {
 				tst_resm(TPASS | TTERRNO,
 					 "got expected failure");
@@ -171,21 +147,15 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void setup(void)
 {
 	char *cur_dir = NULL;
 
 	tst_require_root(NULL);
 
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getpwnam failed");
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "seteuid(%d) failed", ltpuser->pw_uid);
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -193,47 +163,27 @@ void setup()
 
 	tst_tmpdir();
 
-	/* get the current directory for the first test */
-	if ((cur_dir = getcwd(cur_dir, 0)) == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup, "getcwd failed");
-	}
+	cur_dir = SAFE_GETCWD(cleanup, cur_dir, 0);
 
 	strncpy(good_dir, cur_dir, NSIZE);
 
-	/* create a file that will be used in test #3 */
-	if ((fileHandle = creat("file1", MODE1)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create a test file");
-	}
+	if (memset(long_name, 'a', PATH_MAX+1) == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "getcwd failed");
+
+	filehandle = SAFE_CREAT(cleanup, "file1", MODE1);
+
 #if !defined(UCLINUX)
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-	}
+	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+			     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
 	TC[4].fname = bad_addr;
 #endif
 
-	/* create a directory that will be used in test #6 */
-	if (mkdir("dir6", MODE2) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't creat a test directory");
-	}
+	SAFE_MKDIR(cleanup, "dir6", MODE2);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup()
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	close(fileHandle);
-
 	TEST_CLEANUP;
 
-	/* delete the test directory created in setup() */
 	tst_rmdir();
-
 }
-- 
1.8.2.1




------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
