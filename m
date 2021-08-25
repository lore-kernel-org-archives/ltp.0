From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 11:46:06 +0200
Subject: [LTP] [PATCH 4/7] epoll_create1: Add docparse formatting and
 cleanup for epoll_create1_01
In-Reply-To: <20210817064924.127970-5-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
 <20210817064924.127970-5-xieziyao@huawei.com>
Message-ID: <YSYRXrgx6u+kxnpc@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

The main problem was that the commit added empty epoll_create1_02.c
which did break the compilation and had to be removed.

Apart from that I've changed the tst_brk(TFAIL, ...) to tst_res(TFAIL,
...) since there is no real need for tst_brk() and adjusted the messages
a bit.

diff:

diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index 39e01eb8b..ed359d434 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -8,7 +8,7 @@
  * [Description]
  *
  * Verify that epoll_create1 sets the close-on-exec flag for the returned
- * file descriptor with the only flag support, EPOLL_CLOEXEC.
+ * file descriptor with EPOLL_CLOEXEC.
  */
 
 #include <sys/epoll.h>
@@ -22,8 +22,8 @@ static struct test_case_t {
 	int exp_flag;
 	const char *desc;
 } tc[] = {
-	{0, 0, "flags=0 didn't set close-on-exec flag"},
-	{EPOLL_CLOEXEC, 1, "flags=EPOLL_CLOEXEC set close-on-exec"}
+	{0, 0, "without EPOLL_CLOEXEC"},
+	{EPOLL_CLOEXEC, 1, "with EPOLL_CLOEXEC"}
 };
 
 static void run(unsigned int n)
@@ -36,8 +36,9 @@ static void run(unsigned int n)
 
 	coe = SAFE_FCNTL(fd, F_GETFD);
 	if ((coe & FD_CLOEXEC) != tc[n].exp_flag)
-		tst_brk(TFAIL, "epoll_create1(...) with %s", tc[n].desc);
-	tst_res(TPASS, "epoll_create1(...) with %s", tc[n].desc);
+		tst_res(TFAIL, "epoll_create1(...) %s", tc[n].desc);
+	else
+		tst_res(TPASS, "epoll_create1(...) %s", tc[n].desc);
 
 	SAFE_CLOSE(fd);
 }

-- 
Cyril Hrubis
chrubis@suse.cz
