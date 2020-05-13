From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 May 2020 22:36:28 +0800
Subject: [LTP] [PATCH v3 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
Message-ID: <20200513143629.2103-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

pidfd_open(2) will set close-on-exec flag on the file descriptor
as its manpage states, so check close-on-exec flag by fcntl(2).

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/pidfd_open/pidfd_open01.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index 93bb86687..f475fe28e 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -11,12 +11,21 @@
 
 static void run(void)
 {
-	TEST(pidfd_open(getpid(), 0));
+	int pidfd, flag;
 
-	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
+	pidfd = pidfd_open(getpid(), 0);
+	if (pidfd == -1)
+		tst_brk(TFAIL | TERRNO, "pidfd_open(getpid(), 0) failed");
 
-	SAFE_CLOSE(TST_RET);
+	flag = fcntl(pidfd, F_GETFD);
+
+	SAFE_CLOSE(pidfd);
+
+	if (flag == -1)
+		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFD) failed");
+
+	if (!(flag & FD_CLOEXEC))
+		tst_brk(TFAIL, "pidfd_open(getpid(), 0) didn't set close-on-exec flag");
 
 	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
 }
-- 
2.21.0



