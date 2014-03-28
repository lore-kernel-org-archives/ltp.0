Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WTRlo-0006yG-Jh
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 08:04:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WTRln-0004aF-3u
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 08:04:08 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2S83s9g000308
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Mar 2014 16:03:54 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 28 Mar 2014 16:02:06 +0800
Message-Id: <1395993726-10999-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1395993726-10999-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1395993726-10999-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] pwrite/pwrite02.c: make EBADF error value tests
	sufficient
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pwrite/pwrite02.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index 31f1b79..a934de8 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -26,7 +26,8 @@
  *   	returns EINVAL.
  *   3) pwrite() fails if fd is not a valid file descriptor,
  *	returns EBADF.
- *   4) pwrite() fails when attempted to write with buf outside
+ *   4) pwrite() fails if fd is not open for writing, return EBADF.
+ *   5) pwrite() fails when attempted to write with buf outside
  *      accessible address space.
  */
 
@@ -59,14 +60,15 @@ static int exp_enos[] = {
 
 static void test_espipe(void);
 static void test_einval(void);
-static void test_ebadf(void);
+static void test_ebadf1(void);
+static void test_ebadf2(void);
 
 #if !defined(UCLINUX)
 static void test_efault(void);
 #endif
 
 static void (*testfunc[])(void) = {
-	test_espipe, test_einval, test_ebadf,
+	test_espipe, test_einval, test_ebadf1, test_ebadf2,
 #if !defined(UCLINUX)
 	test_efault
 #endif
@@ -179,7 +181,7 @@ static void test_einval(void)
 	SAFE_CLOSE(cleanup, fd);
 }
 
-static void test_ebadf(void)
+static void test_ebadf1(void)
 {
 	int fd = -1;
 
@@ -188,6 +190,19 @@ static void test_ebadf(void)
 	print_test_result(errno, EBADF);
 }
 
+static void test_ebadf2(void)
+{
+	int fd;
+
+	fd = SAFE_OPEN(cleanup, TEMPFILE, O_RDONLY | O_CREAT, 0666);
+
+	TEST(pwrite(fd, write_buf, K1, 0));
+
+	print_test_result(errno, EBADF);
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
 #if !defined(UCLINUX)
 static void test_efault(void)
 {
-- 
1.8.2.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
