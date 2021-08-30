From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Mon, 30 Aug 2021 19:16:38 +0800
Subject: [LTP] [PATCH 3/3] epoll_ctl02: Add test for fd not supporting epoll
In-Reply-To: <20210830111638.66371-1-ziyaoxie@outlook.com>
References: <20210830111638.66371-1-ziyaoxie@outlook.com>
Message-ID: <OSZP286MB0871D15C101A02A134430703CCCB9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that epoll_ctl() fails with EPERM if fd does not support epoll.
This error can occur if fd refers to, for example, a regular file or a
directory.

Signed-off-by: Xie Ziyao <ziyaoxie@outlook.com>
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index 4872fcacb..fe16ad1cb 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -7,9 +7,10 @@
 /*\
  * [Description]
  *
- * Verify that epoll_cnt() fails with:
+ * Verify that epoll_ctl() fails with:
  *
  * - EBADF if epfd is an invalid fd.
+ * - EPERM if fd does not support epoll.
  * - EBADF if fd is an invalid fd.
  * - EINVAL if op is not supported.
  * - EINVAL if fd is the same as epfd.
@@ -25,7 +26,7 @@
 #include "tst_test.h"

 static int epfd;
-static int fd[2];
+static int fd[2], unsupported_fd;
 static int inv = -1;

 static struct epoll_event events[2] = {
@@ -42,6 +43,7 @@ static struct testcase {
 	const char *desc;
 } tc[] = {
 	{&inv, EPOLL_CTL_ADD, &fd[1], &events[1], EBADF, "epfd is an invalid fd"},
+	{&epfd, EPOLL_CTL_ADD, &unsupported_fd, &events[1], EPERM, "fd does not support epoll"},
 	{&epfd, EPOLL_CTL_ADD, &inv, &events[1], EBADF, "fd is an invalid fd"},
 	{&epfd, -1, &fd[1], &events[1], EINVAL, "op is not supported"},
 	{&epfd, EPOLL_CTL_ADD, &epfd, &events[1], EINVAL, "fd is the same as epfd"},
@@ -53,6 +55,8 @@ static struct testcase {

 static void setup(void)
 {
+	unsupported_fd = SAFE_OPEN(".", O_RDONLY|O_DIRECTORY, 0);
+
 	epfd = epoll_create(2);
 	if (epfd == -1)
 		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
--
2.25.1

