Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WTR7Y-0008Fu-BQ
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 07:22:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WTR7V-0003VL-0E
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 07:22:30 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2S7MCKp021550
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Mar 2014 15:22:12 +0800
Message-ID: <1395991331.5017.4.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 28 Mar 2014 15:22:11 +0800
In-Reply-To: <1395991214.5017.2.camel@G08JYZSD130126>
References: <1395991214.5017.2.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH] read/read02.c: add new error number tests
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

Add EINVAL errnor nuber tests for read(2):
* The file was opened with the O_DIRECT flag, and the alignment of the user
  buffer was not multiples of the logical block size of the file system,
  expect an EINVAL.

* The file was opened with the O_DIRECT flag, and transfer sizes was not
  multiples of the logical block size of the file system, expect an EINVAL.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/read/read02.c | 53 ++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 8aabe93..0e227fe 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -27,6 +27,16 @@
  *
  *	test 3:
  *	Pass buf = -1 as a parmeter to read, expect an EFAULT.
+ *
+ *	test 4:
+ *	The file was opened with the O_DIRECT flag, and the alignment of the
+ *	user buffer was not multiples of the logical block size of the file
+ *	system, expect an EINVAL.
+ *
+ *	test 5:
+ *	The file was opened with the O_DIRECT flag, and transfer sizes was not
+ *	multiples of the logical block size of the file system, expect an
+ *	EINVAL.
  */
 
 #define _GNU_SOURCE
@@ -41,22 +51,30 @@
 #include "safe_macros.h"
 
 #define TEST_FILE	"test_file"
+#define TEST_FILE4	"/root/test_file4"
 
 char *TCID = "read02";
 
 static int badfd = -1;
-static int fd2, fd3;
+static int fd2, fd3, fd4;
 static char buf[BUFSIZ];
-static int exp_enos[] = { EBADF, EISDIR, EFAULT, 0 };
+static void *outside_buf = (void *)-1;
+static void *temp;
+static void *addr4;
+static void *addr5;
+static int exp_enos[] = { EBADF, EISDIR, EFAULT, EINVAL, 0 };
 
 static struct test_case_t {
 	int *fd;
-	void *buf;
+	void **buf;
+	size_t count;
 	int exp_error;
 } TC[] = {
-	{&badfd, buf, EBADF},
-	{&fd2, buf, EISDIR},
-	{&fd3, (void *)-1, EFAULT},
+	{&badfd, (void **)&buf, 1, EBADF},
+	{&fd2, (void **)&buf, 1, EISDIR},
+	{&fd3, &outside_buf, 1, EFAULT},
+	{&fd4, &addr4, 4096, EINVAL},
+	{&fd4, &addr5, 1, EINVAL},
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
@@ -89,6 +107,11 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	if ((tst_kvercmp(2, 4, 10)) < 0)
+		tst_brkm(TCONF, NULL, "This test needs kernel 2.4.10 or newer");
+
+	tst_require_root(NULL);
+
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
@@ -100,11 +123,19 @@ static void setup(void)
 	SAFE_FILE_PRINTF(cleanup, TEST_FILE, "A");
 
 	fd3 = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
+
+	temp = SAFE_MALLOC(cleanup, 4096*10);
+
+	addr4 = (char *)(((long)buf & (~4095)) + 1);
+	addr5 = (char *)((long)buf & (~4095));
+
+	SAFE_FILE_PRINTF(cleanup, TEST_FILE4, "A");
+	fd4 = SAFE_OPEN(cleanup, TEST_FILE4, O_RDWR | O_DIRECT, 0777);
 }
 
 static void read_verify(const struct test_case_t *test)
 {
-	TEST(read(*test->fd, test->buf, 1));
+	TEST(read(*test->fd, *test->buf, test->count));
 
 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL, "call succeeded unexpectedly");
@@ -127,6 +158,14 @@ static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	free(temp);
+
+	if (fd4 > 0)
+		close(fd4);
+
+	if (unlink(TEST_FILE4) < 0)
+		tst_resm(TWARN | TERRNO, "unlink(\"%s\") failed", TEST_FILE4);
+
 	if (fd3 > 0)
 		close(fd3);
 
-- 
1.8.4.2




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
