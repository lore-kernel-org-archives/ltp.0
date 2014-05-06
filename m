Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WhabB-0004GX-My
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:19:37 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WhabA-0002LQ-Ax
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:19:37 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s468H3AJ031105
	for <ltp-list@lists.sourceforge.net>; Tue, 6 May 2014 16:17:03 +0800
Message-ID: <536899FF.1040605@cn.fujitsu.com>
Date: Tue, 6 May 2014 16:14:55 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050201050505090906010500"
Subject: [LTP] [PATCH v2 2/2] pwrite/pwrite02.c: make EBADF error value
	tests sufficient
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP <ltp-list@lists.sourceforge.net>

--------------050201050505090906010500
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,
 
    This is a patch following  "[PATCH v2 1/2] pwrite/pwrite02.c: cleanup", thanks

Regards,
Wang

--------------050201050505090906010500
Content-Type: text/x-patch;
	name="v2-0002-pwrite-pwrite02.c-make-EBADF-error-value-tests-su.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="v2-0002-pwrite-pwrite02.c-make-EBADF-error-value-tests-su.pa";
	filename*1="tch"

From 11e724ef0e7d18930d2f25f845d46f264feb69b8 Mon Sep 17 00:00:00 2001
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 6 May 2014 14:16:40 +0800
Subject: [PATCH v2 2/2] pwrite/pwrite02.c: make EBADF error value tests
 sufficient

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pwrite/pwrite02.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index c9fc840..a934de8 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -26,8 +26,9 @@
  *   	returns EINVAL.
  *   3) pwrite() fails if fd is not a valid file descriptor,
  *	returns EBADF.
- *   4) pwrite() fails when attempted to write with buf outside
- *      accessible address space, returns EFAULT.
+ *   4) pwrite() fails if fd is not open for writing, return EBADF.
+ *   5) pwrite() fails when attempted to write with buf outside
+ *      accessible address space.
  */
 
 #define _XOPEN_SOURCE 500
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


--------------050201050505090906010500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--------------050201050505090906010500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050201050505090906010500--

