From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 May 2020 22:36:29 +0800
Subject: [LTP] [PATCH v3 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <20200513143629.2103-1-yangx.jy@cn.fujitsu.com>
References: <20200513143629.2103-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200513143629.2103-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Drop .min_kver flag directly because of two following reasons:
   a) pidfd_open(2) may be backported to old kernel which is less
      than v5.3 so kernel version check is meaningless.
   b) tst_syscall() can report TCONF if pidfd_open(2) is not supported.
2) For pidfd_open03.c, check if pidfd_open(2) is not supported before
   calling fork() and remove unnecessary TEST().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/pidfd_open/pidfd_open01.c   |  1 -
 .../kernel/syscalls/pidfd_open/pidfd_open02.c   |  1 -
 .../kernel/syscalls/pidfd_open/pidfd_open03.c   | 17 ++++++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index f475fe28e..b88fd0bf9 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -31,6 +31,5 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "5.3",
 	.test_all = run,
 };
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
index dc86cae7a..a7328ddfe 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
@@ -51,7 +51,6 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
-	.min_kver = "5.3",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
index 48470e5e1..af719e1f4 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
@@ -27,11 +27,9 @@ static void run(void)
 		exit(EXIT_SUCCESS);
 	}
 
-	TEST(pidfd_open(pid, 0));
-
-	fd = TST_RET;
+	fd = pidfd_open(pid, 0);
 	if (fd == -1)
-		tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");
+		tst_brk(TFAIL | TERRNO, "pidfd_open() failed");
 
 	TST_CHECKPOINT_WAKE(0);
 
@@ -49,8 +47,17 @@ static void run(void)
 		tst_res(TPASS, "pidfd_open() passed");
 }
 
+static void pidfd_open_supported_by_kernel(void)
+{
+	int pidfd;
+
+	pidfd = tst_syscall(__NR_pidfd_open, getpid(), 0);
+	if (pidfd != -1)
+		SAFE_CLOSE(pidfd);
+}
+
 static struct tst_test test = {
-	.min_kver = "5.3",
+	.setup = pidfd_open_supported_by_kernel,
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-- 
2.21.0



