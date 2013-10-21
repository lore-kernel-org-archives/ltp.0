Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VYAsc-0007Hk-0K
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 08:30:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYAsZ-0000xt-IK
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 08:30:25 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9L8UGvS001363
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 16:30:16 +0800
Message-ID: <5264E618.6040904@cn.fujitsu.com>
Date: Mon, 21 Oct 2013 16:30:16 +0800
From: "Wang, Xiaoguang" <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]  access/access05.c: clean up
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
To: ltp-list@lists.sourceforge.net


Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/access05.c |  204 +++++++++------------------
 1 files changed, 68 insertions(+), 136 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access05.c b/testcases/kernel/syscalls/access/access05.c
index be86225..739b4b2 100644
--- a/testcases/kernel/syscalls/access/access05.c
+++ b/testcases/kernel/syscalls/access/access05.c
@@ -49,6 +49,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 #define INV_OK		-1
 #define TEST_FILE1	"test_file1"
@@ -56,13 +57,6 @@
 #define TEST_FILE3	"test_file3"
 #define TEST_FILE4	"test_file4"
 
-#define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
-
-static void setup1(void);	/* setup() to test access() for EACCES */
-static void setup2(void);	/* setup() to test access() for EACCES */
-static void setup3(void);	/* setup() to test access() for EACCES */
-static void setup4(void);	/* setup() to test access() for EINVAL */
-static void longpath_setup();	/* setup function to test access() for ENAMETOOLONG */
 
 #if !defined(UCLINUX)
 static char high_address_node[64];
@@ -74,22 +68,21 @@ static struct test_case_t {
 	char *pathname;
 	int a_mode;
 	int exp_errno;
-	void (*setupfunc) (void);
 } test_cases[] = {
-	{TEST_FILE1, R_OK, EACCES, setup1},
-	{TEST_FILE2, W_OK, EACCES, setup2},
-	{TEST_FILE3, X_OK, EACCES, setup3},
-	{TEST_FILE4, INV_OK, EINVAL, setup4},
+	{TEST_FILE1, R_OK, EACCES},
+	{TEST_FILE2, W_OK, EACCES},
+	{TEST_FILE3, X_OK, EACCES},
+	{TEST_FILE4, INV_OK, EINVAL},
 #if !defined(UCLINUX)
-	{(char *)-1, R_OK, EFAULT, NULL},
-	{high_address_node, R_OK, EFAULT, NULL},
+	{(char *)-1, R_OK, EFAULT},
+	{high_address_node, R_OK, EFAULT},
 #endif
-	{"", W_OK, ENOENT, NULL},
-	{longpathname, R_OK, ENAMETOOLONG, longpath_setup},
+	{"", W_OK, ENOENT},
+	{longpathname, R_OK, ENAMETOOLONG},
 };
 
 char *TCID = "access05";
-int TST_TOTAL = sizeof(test_cases) / sizeof(*test_cases);
+int TST_TOTAL = ARRAY_SIZE(test_cases);
 
 static int exp_enos[] = { EACCES, EFAULT, EINVAL, ENOENT, ENAMETOOLONG, 0 };
 
@@ -97,6 +90,7 @@ static const char nobody_uid[] = "nobody";
 static struct passwd *ltpuser;
 
 static void setup(void);
+static void access_verify(int i);
 static void cleanup(void);
 
 static char *bad_addr;
@@ -105,8 +99,6 @@ int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	char *file_name;
-	int access_mode;
 	int i;
 
 	msg = parse_opts(ac, av, NULL, NULL);
@@ -120,39 +112,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			file_name = test_cases[i].pathname;
-			access_mode = test_cases[i].a_mode;
-
-#if !defined(UCLINUX)
-			if (file_name == high_address_node)
-				file_name = get_high_address();
-#endif
-
-			/*
-			 * Call access(2) to test different test conditions.
-			 * verify that it fails with -1 return value and
-			 * sets appropriate errno.
-			 */
-			TEST(access(file_name, access_mode));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL,
-					 "access(%s, %#o) succeeded unexpectedly",
-					 file_name, access_mode);
-				continue;
-			}
-
-			if (TEST_ERRNO == test_cases[i].exp_errno)
-				tst_resm(TPASS | TTERRNO,
-					 "access failed as expected");
-			else
-				tst_resm(TFAIL | TTERRNO,
-					 "access failed unexpectedly; expected: "
-					 "%d - %s",
-					 test_cases[i].exp_errno,
-					 strerror(test_cases[i].exp_errno));
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			access_verify(i);
 	}
 
 	cleanup();
@@ -161,17 +122,13 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
-	int i;
+	int fd;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_require_root(NULL);
 
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid failed");
-
+	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
+	SAFE_SETUID(cleanup, ltpuser->pw_uid);
 	TEST_PAUSE;
 
 #if !defined(UCLINUX)
@@ -179,98 +136,73 @@ static void setup(void)
 			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr == MAP_FAILED)
 		tst_brkm(TBROK | TERRNO, NULL, "mmap failed");
-	test_cases[5].pathname = bad_addr;
+	test_cases[4].pathname = bad_addr;
+
+	test_cases[5].pathname = get_high_address();
 #endif
 
 	tst_tmpdir();
 
-	for (i = 0; i < TST_TOTAL; i++)
-		if (test_cases[i].setupfunc != NULL)
-			test_cases[i].setupfunc();
+	/*
+	 * create TEST_FILE1 to test R_OK EACCESS
+	 */
+	fd = SAFE_CREAT(cleanup, TEST_FILE1, 0333);
+	SAFE_CLOSE(cleanup, fd);
+
+	/*
+	 * create TEST_FILE2 to test W_OK EACCESS
+	 */
+	fd = SAFE_CREAT(cleanup, TEST_FILE2, 0555);
+	SAFE_CLOSE(cleanup, fd);
+
+	/*
+	 * create TEST_FILE3 to test X_OK EACCESS
+	 */
+	fd = SAFE_CREAT(cleanup, TEST_FILE3, 0666);
+	SAFE_CLOSE(cleanup, fd);
+
+	/*
+	 * create TEST_FILE4 to test EINVAL
+	 */
+	fd = SAFE_CREAT(cleanup, TEST_FILE4, 0333);
+	SAFE_CLOSE(cleanup, fd);
+
+	/*
+	 *setup to create a node with a name length exceeding
+	 *the MAX length of PATH_MAX.
+	 */
+	memset(longpathname, 'a', sizeof(longpathname) - 1);
 }
 
-static void setup_file(const char *file, mode_t perms)
-{
-	int fd = open(file, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 file, FILE_MODE);
-
-	if (fchmod(fd, perms) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, %#o) failed",
-			 file, perms);
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", file);
-}
-
-/*
- * setup1() - Setup function to test access() for return value -1
- *	      and errno EACCES when read access denied for specified
- *	      testfile.
- *
- *   Creat/open a testfile and close it.
- *   Deny read access permissions on testfile.
- *   This function returns 0.
- */
-static void setup1(void)
-{
-	setup_file(TEST_FILE1, 0333);
-}
-
-/*
- * setup2() - Setup function to test access() for return value -1 and
- *	      errno EACCES when write access denied on testfile.
- *
- *   Creat/open a testfile and close it.
- *   Deny write access permissions on testfile.
- *   This function returns 0.
- */
-static void setup2(void)
+static void access_verify(int i)
 {
-	setup_file(TEST_FILE2, 0555);
-}
+	char *file_name;
+	int access_mode;
 
-/*
- * setup3() - Setup function to test access() for return value -1 and
- *	      errno EACCES when execute access denied on testfile.
- *
- *   Creat/open a testfile and close it.
- *   Deny search access permissions on testfile.
- *   This function returns 0.
- */
-static void setup3(void)
-{
-	setup_file(TEST_FILE3, 0666);
-}
+	file_name = test_cases[i].pathname;
+	access_mode = test_cases[i].a_mode;
 
-/*
- * setup4() - Setup function to test access() for return value -1
- *	      and errno EINVAL when specified access mode argument is
- *	      invalid.
- *
- *   Creat/open a testfile and close it.
- *   This function returns 0.
- */
-static void setup4(void)
-{
-	setup_file(TEST_FILE4, FILE_MODE);
-}
+	TEST(access(file_name, access_mode));
 
-/*
- * longpath_setup() - setup to create a node with a name length exceeding
- *		      the MAX. length of PATH_MAX.
- */
-static void longpath_setup(void)
-{
-	int i;
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "access(%s, %#o) succeeded unexpectedly",
+			 file_name, access_mode);
+		return;
+	}
 
-	for (i = 0; i <= (PATH_MAX + 1); i++)
-		longpathname[i] = 'a';
+	if (TEST_ERRNO == test_cases[i].exp_errno) {
+		tst_resm(TPASS | TTERRNO, "access failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "access failed unexpectedly; expected: "
+			 "%d - %s", test_cases[i].exp_errno,
+			 strerror(test_cases[i].exp_errno));
+	}
 }
 
 static void cleanup(void)
 {
 	TEST_CLEANUP;
+
 	tst_rmdir();
 }
-- 
1.7.1



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
