From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:19 +0800
Subject: [LTP] [PATCH 2/7] epoll_ctl: Add docparse formatting and cleanup
 for epoll_ctl02
In-Reply-To: <20210817064924.127970-1-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
Message-ID: <20210817064924.127970-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Add docparse formatting.
2. Make use of TST_EXP_FAIL(...).
3. Add test for events=NULL.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/epoll_ctl/epoll_ctl02.c   | 87 +++++++------------
 1 file changed, 32 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index 280fd6724..f477625a6 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -4,34 +4,23 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */

-/*
- * Test Name: epoll_ctl02.c
- *
- * Description:
- * 1) epoll_ctl(2) fails if epfd is a invalid file descriptor.
- * 2) epoll_ctl(2) fails if fd is a invalid file descriptor.
- * 3) epoll_ctl(2) fails if op is not supported by this interface.
- * 4) epoll_ctl(2) fails if fd is the same as epfd.
- * 5) epoll_ctl(2) fails with EPOLL_CTL_DEL if fd is not registered
- *    with this epoll instance.
- * 6) epoll_ctl(2) fails with EPOLL_CTL_MOD if fd is not registered
- *    with this epoll instance.
- * 7) epoll_ctl(2) fails with EPOLL_CTL_ADD if fd is already registered
- *    with this epoll instance.
- *
- * Expected Result:
- * 1) epoll_ctl(2) should return -1 and set errno to EBADF.
- * 2) epoll_ctl(2) should return -1 and set errno to EBADF.
- * 3) epoll_ctl(2) should return -1 and set errno to EINVAL.
- * 4) epoll_ctl(2) should return -1 and set errno to EINVAL.
- * 5) epoll_ctl(2) should return -1 and set errno to ENOENT.
- * 6) epoll_ctl(2) should return -1 and set errno to ENOENT.
- * 7) epoll_ctl(2) should return -1 and set errno to EEXIST.
+/*\
+ * [Description]
  *
+ * Verify that,
+ * - epoll_ctl fails with EBADF if epfd is an invalid fd.
+ * - epoll_ctl fails with EBADF if fd is an invalid fd.
+ * - epoll_ctl fails with EINVAL if op is not supported.
+ * - epoll_ctl fails with EINVAL if fd is the same as epfd.
+ * - epoll_ctl fails with EINVAL if events is NULL.
+ * - epoll_ctl fails with ENOENT if fd is not registered with EPOLL_CTL_DEL.
+ * - epoll_ctl fails with ENOENT if fd is not registered with EPOLL_CTL_MOD.
+ * - epoll_ctl fails with EEXIST if fd is already registered with EPOLL_CTL_ADD.
  */
-#include <sys/epoll.h>
+
 #include <poll.h>
-#include <errno.h>
+#include <sys/epoll.h>
+
 #include "tst_test.h"

 static int epfd;
@@ -44,19 +33,21 @@ static struct epoll_event events[2] = {
 };

 static struct testcase {
-	int *epfds;
+	int *epfd;
 	int opt;
-	int *fds;
-	struct epoll_event *ts_event;
+	int *fd;
+	struct epoll_event *event;
 	int exp_err;
-} tcases[] = {
-	{&inv, EPOLL_CTL_ADD, &fd[1], &events[1], EBADF},
-	{&epfd, EPOLL_CTL_ADD, &inv, &events[1], EBADF},
-	{&epfd, -1, &fd[1], &events[1], EINVAL},
-	{&epfd, EPOLL_CTL_ADD, &epfd, &events[1], EINVAL},
-	{&epfd, EPOLL_CTL_DEL, &fd[1], &events[1], ENOENT},
-	{&epfd, EPOLL_CTL_MOD, &fd[1], &events[1], ENOENT},
-	{&epfd, EPOLL_CTL_ADD, &fd[0], &events[0], EEXIST}
+	const char *desc;
+} tc[] = {
+	{&inv, EPOLL_CTL_ADD, &fd[1], &events[1], EBADF, "epfd is an invalid fd"},
+	{&epfd, EPOLL_CTL_ADD, &inv, &events[1], EBADF, "fd is an invalid fd"},
+	{&epfd, -1, &fd[1], &events[1], EINVAL, "op is not supported"},
+	{&epfd, EPOLL_CTL_ADD, &epfd, &events[1], EINVAL, "fd is the same as epfd"},
+	{&epfd, EPOLL_CTL_ADD, &fd[1], NULL, EFAULT, "events is NULL"},
+	{&epfd, EPOLL_CTL_DEL, &fd[1], &events[1], ENOENT, "fd is not registered with EPOLL_CTL_DEL"},
+	{&epfd, EPOLL_CTL_MOD, &fd[1], &events[1], ENOENT, "fd is not registered with EPOLL_CTL_MOD"},
+	{&epfd, EPOLL_CTL_ADD, &fd[0], &events[0], EEXIST, "fd is already registered with EPOLL_CTL_ADD"}
 };

 static void setup(void)
@@ -70,9 +61,8 @@ static void setup(void)
 	events[0].data.fd = fd[0];
 	events[1].data.fd = fd[1];

-	TEST(epoll_ctl(epfd, EPOLL_CTL_ADD, fd[0], &events[0]));
-	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "epoll_ctl() fails to init");
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd[0], &events[0]))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
 }

 static void cleanup(void)
@@ -89,25 +79,12 @@ static void cleanup(void)

 static void verify_epoll_ctl(unsigned int n)
 {
-	struct testcase *tc = &tcases[n];
-
-	TEST(epoll_ctl(*tc->epfds, tc->opt, *tc->fds,  tc->ts_event));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "epoll_ctl() succeeds unexpectedly");
-		return;
-	}
-
-	if (tc->exp_err == TST_ERR) {
-		tst_res(TPASS | TTERRNO, "epoll_ctl() fails as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO,
-			"epoll_ctl() fails unexpectedly, expected %i: %s",
-			tc->exp_err, tst_strerrno(tc->exp_err));
-	}
+	TST_EXP_FAIL(epoll_ctl(*tc[n].epfd, tc[n].opt, *tc[n].fd, tc[n].event),
+		     tc[n].exp_err, "epoll_clt(...) if %s", tc[n].desc);
 }

 static struct tst_test test = {
-	.tcnt = ARRAY_SIZE(tcases),
+	.tcnt = ARRAY_SIZE(tc),
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_epoll_ctl,
--
2.17.1

