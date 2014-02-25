Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WIA9D-0007VM-NM
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 05:01:39 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WIA9B-0001kK-Fe
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 05:01:39 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1P51QKL018828
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Feb 2014 13:01:29 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 25 Feb 2014 13:00:01 +0800
Message-Id: <1393304401-22031-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] mincore/mincore01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Delete some useless comments.
Move the test body from main() to mincore_verify().
Use some SAFE_* macros.
Make ENOMEM error value tests sufficient.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mincore/mincore01.c | 184 ++++++++++++++------------
 1 file changed, 100 insertions(+), 84 deletions(-)

diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index d3519f2..f8dae11 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -28,6 +28,10 @@
  * test3:
  *	Invoke mincore() when the starting address + length contained unmapped
  *	memory. ENOMEM
+ * test4:
+ *      Invoke mincore() when length is greater than (TASK_SIZE - addr).ENOMEM.
+ *      In Linux 2.6.11 and earlier, the error EINVAL  was  returned for this
+ *      condition.
  */
 
 #include <fcntl.h>
@@ -40,40 +44,46 @@
 #include <sys/stat.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 static int PAGESIZE;
 static rlim_t STACK_LIMIT = 10485760;
 
 static void cleanup(void);
 static void setup(void);
-static void setup1(void);
-static void setup2(void);
-static void setup3(void);
 
 char *TCID = "mincore01";
-int TST_TOTAL = 3;
 
-static char *global_pointer = NULL;
-static unsigned char *global_vec = NULL;
-static int global_len = 0;
-static int fd = 0;
+static char *global_pointer;
+static unsigned char *global_vec;
+static int global_len;
+
+struct test_case_t;
+static void setup1(struct test_case_t *tc);
+static void setup2(struct test_case_t *tc);
+static void setup3(struct test_case_t *tc);
+static void setup4(struct test_case_t *tc);
 
 static struct test_case_t {
 	char *addr;
-	int len;
+	size_t len;
 	unsigned char *vector;
 	int exp_errno;
-	void (*setupfunc) (void);
+	void (*setupfunc) (struct test_case_t *tc);
 } TC[] = {
 	{NULL, 0, NULL, EINVAL, setup1},
 	{NULL, 0, NULL, EFAULT, setup2},
 	{NULL, 0, NULL, ENOMEM, setup3},
+	{NULL, 0, NULL, ENOMEM, setup4}
 };
 
+static void mincore_verify(struct test_case_t *tc);
+
+int TST_TOTAL = ARRAY_SIZE(TC);
+
 int main(int ac, char **av)
 {
-	int lc;
-	int i;
+	int i, lc;
 	char *msg;
 
 	msg = parse_opts(ac, av, NULL, NULL);
@@ -85,57 +95,30 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (TC[i].setupfunc != NULL)
-				TC[i].setupfunc();
-			
-			TEST(mincore(TC[i].addr, TC[i].len, TC[i].vector));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == TC[i].exp_errno) {
-				tst_resm(TPASS, "expected failure: "
-					 "errno = %d (%s)", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error %d (%s), "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].exp_errno);
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			mincore_verify(&TC[i]);
 	}
+
 	cleanup();
 	tst_exit();
 }
 
-static void setup1(void)
+static void setup1(struct test_case_t *tc)
 {
-	TC[0].addr = global_pointer + 1;
-	TC[0].len = global_len;
-	TC[0].vector = global_vec;
+	tc->addr = global_pointer + 1;
+	tc->len = global_len;
+	tc->vector = global_vec;
 }
 
-void setup2(void)
+void setup2(struct test_case_t *tc)
 {
 	unsigned char *t;
 	struct rlimit limit;
 	    
-	t = mmap(NULL, global_len, PROT_READ | PROT_WRITE,
-	         MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	t = SAFE_MMAP(cleanup, NULL, global_len, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
-	/* Create pointer to invalid address */
-	if (t == MAP_FAILED) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-		         "mmaping anonymous memory failed");
-	}
-
-	munmap(t, global_len);
+	SAFE_MUNMAP(cleanup, t, global_len);
 
 	/* set stack limit so that the unmaped pointer is invalid for architectures like s390 */
 	limit.rlim_cur = STACK_LIMIT;
@@ -144,63 +127,94 @@ void setup2(void)
 	if (setrlimit(RLIMIT_STACK, &limit) != 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "setrlimit failed");
 
-	TC[1].addr = global_pointer;
-	TC[1].len = global_len;
-	TC[1].vector = t;
+	tc->addr = global_pointer;
+	tc->len = global_len;
+	tc->vector = t;
 }
 
-static void setup3(void)
+static void setup3(struct test_case_t *tc)
 {
-	TC[2].addr = global_pointer;
-	TC[2].len = global_len * 2;
-	munmap(global_pointer + global_len, global_len);
-	TC[2].vector = global_vec;
+	tc->addr = global_pointer;
+	tc->len = global_len * 2;
+	SAFE_MUNMAP(cleanup, global_pointer + global_len, global_len);
+	tc->vector = global_vec;
+}
+
+static void setup4(struct test_case_t *tc)
+{
+	struct rlimit as_lim;
+
+	if (getrlimit(RLIMIT_AS, &as_lim) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "getrlimit(RLIMIT_AS) failed");
+	}
+
+	tc->addr = global_pointer;
+	tc->len = as_lim.rlim_cur - (rlim_t)global_pointer + PAGESIZE;
+	tc->vector = global_vec;
+
+	/*
+	 * In linux 2.6.11 and earlier, EINVAL was returned for this condition.
+	 */
+	if (tst_kvercmp(2, 6, 11) <= 0)
+		tc->exp_errno = EINVAL;
 }
 
 static void setup(void)
 {
 	char *buf;
+	int fd;
 
 	PAGESIZE = getpagesize();
 
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
 	tst_tmpdir();
 
+	TEST_PAUSE;
+
 	/* global_pointer will point to a mmapped area of global_len bytes */
 	global_len = PAGESIZE * 2;
 
-	buf = malloc(global_len);
+	buf = SAFE_MALLOC(cleanup, global_len);
 	memset(buf, 42, global_len);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	fd = SAFE_OPEN(cleanup, "mincore01", O_CREAT | O_RDWR,
+		       S_IRUSR | S_IWUSR);
 
-	/* create a temporary file */
-	fd = open("mincore01", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Error while creating temporary file");
-	}
+	SAFE_WRITE(cleanup, 1, fd, buf, global_len);
 
-	/* fill the temporary file with two pages of data */
-	if (write(fd, buf, global_len) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Error while writing to temporary file");
-	}
 	free(buf);
 
-	/* map the file in memory */
-	global_pointer = mmap(NULL, global_len * 2,
-	                      PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED,
-	                      fd, 0);
+	global_pointer = SAFE_MMAP(cleanup, NULL, global_len * 2,
+				   PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
-	if (global_pointer == MAP_FAILED) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Temporary file could not be mmapped");
+	global_vec = SAFE_MALLOC(cleanup,
+				 (global_len + PAGESIZE - 1) / PAGESIZE);
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void mincore_verify(struct test_case_t *tc)
+{
+	if (tc->setupfunc)
+		tc->setupfunc(tc);
+
+	TEST(mincore(tc->addr, tc->len, tc->vector));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "succeeded unexpectedly");
+		return;
 	}
 
-	/* initialize the vector buffer to collect the page info */
-	global_vec = malloc((global_len + PAGESIZE - 1) / PAGESIZE);
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"mincore failed unexpectedly; expected: "
+			"%d - %s", tc->exp_errno,
+			strerror(tc->exp_errno));
+	}
 }
 
 static void cleanup(void)
@@ -208,7 +222,9 @@ static void cleanup(void)
 	TEST_CLEANUP;
 
 	free(global_vec);
-	munmap(global_pointer, global_len);
-	close(fd);
+
+	if (munmap(global_pointer, global_len) == -1)
+		tst_resm(TWARN | TERRNO, "munmap failed");
+
 	tst_rmdir();
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
