From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 23 Jun 2016 16:56:47 +0800
Subject: [LTP] [PATCH] syscalls/epoll_ctl*: Fix cleanup()
Message-ID: <1466672207-24238-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Although process will be killed when timeout, but using
SAFE_CLOSE in cleanup may lead to infinite loop.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c | 15 ++++++++++-----
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c | 11 ++++++++---
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index c6233e5..2ecadf7 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -59,9 +59,14 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_CLOSE(epfd);
-	SAFE_CLOSE(fd[0]);
-	SAFE_CLOSE(fd[1]);
+	if (epfd > 0 && close(epfd))
+		tst_res(TWARN | TERRNO, "failed to close epoll instance");
+
+	if (fd[0] > 0 && close(fd[0]))
+		tst_res(TWARN | TERRNO, "failed to close pipe");
+
+	if (fd[1] > 0 && close(fd[1]))
+		tst_res(TWARN | TERRNO, "failed to close pipe");
 }
 
 static int has_event(struct epoll_event *epvs, int len,
@@ -85,8 +90,8 @@ static void check_epoll_ctl(int opt, int exp_num)
 	char read_buf[sizeof(write_buf)];
 
 	struct epoll_event res_evs[2] = {
-	{.events = 0, .data.fd = 0},
-	{.events = 0, .data.fd = 0}
+		{.events = 0, .data.fd = 0},
+		{.events = 0, .data.fd = 0}
 	};
 
 	SAFE_WRITE(1, fd[1], write_buf, sizeof(write_buf));
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index 3f11a3f..ae2465c 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -87,9 +87,14 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_CLOSE(epfd);
-	SAFE_CLOSE(fd[0]);
-	SAFE_CLOSE(fd[1]);
+	if (epfd > 0 && close(epfd))
+		tst_res(TWARN | TERRNO, "failed to close epoll instance");
+
+	if (fd[0] > 0 && close(fd[0]))
+		tst_res(TWARN | TERRNO, "failed to close pipe");
+
+	if (fd[1] > 0 && close(fd[1]))
+		tst_res(TWARN | TERRNO, "failed to close pipe");
 }
 
 static void verify_epoll_ctl(unsigned int n)
-- 
1.8.3.1



