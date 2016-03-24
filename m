From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 24 Mar 2016 16:38:52 +0100
Subject: [LTP] [PATCH] readahead: use glibc wrapper function
Message-ID: <27e9eeb52d71394f8df405f98e66ffccec83803c.1458833602.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have had reports of this testcase not functioning
properly on 32bit powerpc systems, because syscall()
is not passing 64bit parameters correctly.

This patch is using glibc wrapper, which should be available
for a long time now (since glibc 2.3).

Reported-and-tested-by: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Reported-and-tested-by: Kshitij Malik <Kshitij.Malik@mitel.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/readahead/readahead01.c | 18 ++++++++++--------
 testcases/kernel/syscalls/readahead/readahead02.c |  3 +--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index f579174b8c8a..5f829bd838f4 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -25,14 +25,16 @@
 /*
  * errno tests for readahead() syscall
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/syscall.h>
-#include <sys/socket.h>
+#define _GNU_SOURCE
 #include <errno.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -84,7 +86,7 @@ static void test_bad_fd(void)
 	int fd;
 
 	tst_resm(TINFO, "test_bad_fd -1");
-	TEST(ltp_syscall(__NR_readahead, -1, 0, getpagesize()));
+	TEST(readahead(-1, 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EBADF);
 
@@ -96,7 +98,7 @@ static void test_bad_fd(void)
 	fd = open(tempname, O_WRONLY);
 	if (fd == -1)
 		tst_resm(TBROK | TERRNO, "Failed to open testfile");
-	TEST(ltp_syscall(__NR_readahead, fd, 0, getpagesize()));
+	TEST(readahead(fd, 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EBADF);
 	close(fd);
@@ -110,7 +112,7 @@ static void test_invalid_fd(void)
 	tst_resm(TINFO, "test_invalid_fd pipe");
 	if (pipe(fd) < 0)
 		tst_resm(TBROK | TERRNO, "Failed to create pipe");
-	TEST(ltp_syscall(__NR_readahead, fd[0], 0, getpagesize()));
+	TEST(readahead(fd[0], 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EINVAL);
 	close(fd[0]);
@@ -120,7 +122,7 @@ static void test_invalid_fd(void)
 	fd[0] = socket(AF_INET, SOCK_STREAM, 0);
 	if (fd[0] < 0)
 		tst_resm(TBROK | TERRNO, "Failed to create socket");
-	TEST(ltp_syscall(__NR_readahead, fd[0], 0, getpagesize()));
+	TEST(readahead(fd[0], 0, getpagesize()));
 	check_ret(-1);
 	check_errno(EINVAL);
 	close(fd[0]);
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 7dc308c03e5d..53278be7d84c 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -236,8 +236,7 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 
 	if (do_readahead) {
 		for (i = 0; i < fsize; i += readahead_size) {
-			TEST(ltp_syscall(__NR_readahead, fd,
-				(off64_t) i, readahead_size));
+			TEST(readahead(fd, (off64_t) i, readahead_size));
 			if (TEST_RETURN != 0)
 				break;
 		}
-- 
1.8.3.1

