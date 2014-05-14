Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WkUzC-0000yX-U3
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 08:56:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WkUzB-000841-KQ
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 08:56:26 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4E8to3D031430
	for <ltp-list@lists.sourceforge.net>; Wed, 14 May 2014 16:55:50 +0800
Message-ID: <1400057694.2768.8.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 14 May 2014 16:54:54 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] readdir/readdir21.c: Add EBADF and EFAULT errno testes
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

Add EBADF and EFAULT errno testes for readdir(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/readdir/readdir21.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/readdir/readdir21.c b/testcases/kernel/syscalls/readdir/readdir21.c
index daf6080..6db2371 100644
--- a/testcases/kernel/syscalls/readdir/readdir21.c
+++ b/testcases/kernel/syscalls/readdir/readdir21.c
@@ -20,6 +20,9 @@
  *   1. Creat a directory and open it, then delete the directory, ENOENT would
  *	return.
  *   2. File descriptor does not refer to a directory, ENOTDIR would return.
+ *   3. Invalid file descriptor fd, EBADF would return.
+ *   4. Argument points outside the calling process's address space, EFAULT
+ *	would return.
  *
  *  PS:
  *   This file is for readdir(2) and the other files(readdir01.c and
@@ -34,6 +37,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -43,11 +47,14 @@
 char *TCID = "readdir21";
 
 #define TEST_DIR	"test_dir"
+#define TEST_DIR4	"test_dir4"
 #define TEST_FILE	"test_file"
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 
 static unsigned int del_dir_fd, file_fd;
+static unsigned int invalid_fd = 999;
+static unsigned int dir_fd;
 static struct old_linux_dirent dirp;
 static void setup(void);
 static void cleanup(void);
@@ -60,6 +67,11 @@ static struct test_case_t {
 } test_cases[] = {
 	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT},
 	{&file_fd, &dirp, sizeof(struct old_linux_dirent), ENOTDIR},
+	{&invalid_fd, &dirp, sizeof(struct old_linux_dirent), EBADF},
+#if !defined(UCLINUX)
+	{&dir_fd, (struct old_linux_dirent *)-1,
+	 sizeof(struct old_linux_dirent), EFAULT},
+#endif
 };
 
 int TST_TOTAL = ARRAY_SIZE(test_cases);
@@ -102,6 +114,14 @@ static void setup(void)
 	SAFE_RMDIR(cleanup, TEST_DIR);
 
 	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0777);
+
+	SAFE_MKDIR(cleanup, TEST_DIR4, DIR_MODE);
+	dir_fd = SAFE_OPEN(cleanup, TEST_DIR4, O_RDONLY | O_DIRECTORY);
+
+#if !defined(UCLINUX)
+	test_cases[3].dirp = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+				       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+#endif
 }
 
 static void readdir_verify(const struct test_case_t *test)
@@ -126,6 +146,9 @@ static void cleanup(void)
 {
 	TEST_CLEANUP;
 
+	if (dir_fd > 0)
+		close(dir_fd);
+
 	if (del_dir_fd > 0)
 		close(del_dir_fd);
 
-- 
1.7.1




------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
