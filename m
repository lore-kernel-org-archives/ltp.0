Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W7xgF-0001l7-8i
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 01:41:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W7xgD-0007Hn-1T
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 01:41:35 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0S1fO9L032016
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Jan 2014 09:41:25 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 28 Jan 2014 09:40:14 +0800
Message-Id: <1390873214-3730-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] mincore/mincore01.c: cleanup
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

Use some SAFE_* macros.
Make ENOMEM error value tests sufficient.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mincore/mincore01.c | 86 ++++++++++++++++-----------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index d3519f2..51af028 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -28,6 +28,10 @@
  * test3:
  *	Invoke mincore() when the starting address + length contained unmapped
  *	memory. ENOMEM
+ * test4:
+ *      Invoke mincore() when length is greater than (TASK_SIZE - addr). ENOMEM.
+ *      In Linux 2.6.11 and earlier, the error EINVAL  was  returned for this
+ *      condition.
  */
 
 #include <fcntl.h>
@@ -40,6 +44,7 @@
 #include <sys/stat.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 static int PAGESIZE;
 static rlim_t STACK_LIMIT = 10485760;
@@ -49,9 +54,9 @@ static void setup(void);
 static void setup1(void);
 static void setup2(void);
 static void setup3(void);
+static void setup4(void);
 
 char *TCID = "mincore01";
-int TST_TOTAL = 3;
 
 static char *global_pointer = NULL;
 static unsigned char *global_vec = NULL;
@@ -68,8 +73,11 @@ static struct test_case_t {
 	{NULL, 0, NULL, EINVAL, setup1},
 	{NULL, 0, NULL, EFAULT, setup2},
 	{NULL, 0, NULL, ENOMEM, setup3},
+	{NULL, 0, NULL, ENOMEM, setup4,}
 };
 
+int TST_TOTAL = ARRAY_SIZE(TC);
+
 int main(int ac, char **av)
 {
 	int lc;
@@ -126,16 +134,10 @@ void setup2(void)
 	unsigned char *t;
 	struct rlimit limit;
 	    
-	t = mmap(NULL, global_len, PROT_READ | PROT_WRITE,
-	         MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-
-	/* Create pointer to invalid address */
-	if (t == MAP_FAILED) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-		         "mmaping anonymous memory failed");
-	}
+	t = SAFE_MMAP(cleanup, NULL, global_len, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 
-	munmap(t, global_len);
+	SAFE_MUNMAP(cleanup, t, global_len);
 
 	/* set stack limit so that the unmaped pointer is invalid for architectures like s390 */
 	limit.rlim_cur = STACK_LIMIT;
@@ -153,54 +155,65 @@ static void setup3(void)
 {
 	TC[2].addr = global_pointer;
 	TC[2].len = global_len * 2;
-	munmap(global_pointer + global_len, global_len);
+	SAFE_MUNMAP(cleanup, global_pointer + global_len, global_len);
 	TC[2].vector = global_vec;
 }
 
+static void setup4(void)
+{
+	struct rlimit as_lim;
+
+	if (getrlimit(RLIMIT_AS, &as_lim) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "getrlimit(RLIMIT_DATA, %p) failed", &as_lim);
+	}
+
+	TC[3].addr = global_pointer;
+	TC[3].len = as_lim.rlim_cur - (rlim_t)global_pointer + PAGESIZE;
+	TC[3].vector = global_vec;
+
+	/*
+	 * In linux 2.6.11 and earlier, EINVAL was returned
+	 * for this condition.
+	 */
+	if ((tst_kvercmp(2, 6, 11)) <= 0)
+		TC[3].exp_errno = EINVAL;
+}
+
 static void setup(void)
 {
 	char *buf;
 
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
-
 	/* create a temporary file */
-	fd = open("mincore01", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Error while creating temporary file");
-	}
+	fd = SAFE_OPEN(cleanup, "mincore01", O_CREAT | O_RDWR,
+		       S_IRUSR | S_IWUSR);
 
 	/* fill the temporary file with two pages of data */
-	if (write(fd, buf, global_len) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Error while writing to temporary file");
-	}
+	SAFE_WRITE(cleanup, 1, fd, buf, global_len);
+
 	free(buf);
 
 	/* map the file in memory */
-	global_pointer = mmap(NULL, global_len * 2,
+	global_pointer = SAFE_MMAP(cleanup, NULL, global_len * 2,
 	                      PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED,
 	                      fd, 0);
-
-	if (global_pointer == MAP_FAILED) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "Temporary file could not be mmapped");
-	}
-
 	/* initialize the vector buffer to collect the page info */
-	global_vec = malloc((global_len + PAGESIZE - 1) / PAGESIZE);
+	global_vec = SAFE_MALLOC(cleanup,
+				 (global_len + PAGESIZE - 1) / PAGESIZE);
 }
 
 static void cleanup(void)
@@ -208,7 +221,10 @@ static void cleanup(void)
 	TEST_CLEANUP;
 
 	free(global_vec);
-	munmap(global_pointer, global_len);
-	close(fd);
+	SAFE_MUNMAP(NULL, global_pointer, global_len);
+
+	if (fd > 0)
+		SAFE_CLOSE(NULL, fd);
+
 	tst_rmdir();
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
