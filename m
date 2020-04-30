From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 30 Apr 2020 16:57:42 +0800
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
References: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200430085742.1663-2-yangx.jy@cn.fujitsu.com>
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
 .../kernel/syscalls/pidfd_open/pidfd_open01.c      |  1 -
 .../kernel/syscalls/pidfd_open/pidfd_open02.c      |  1 -
 .../kernel/syscalls/pidfd_open/pidfd_open03.c      | 14 +++++++++-----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index 293e93b63..983dcdccb 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -32,6 +32,5 @@ static void run(void)
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
index 48470e5e1..2fc3b3a5f 100644
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
 
@@ -49,8 +47,14 @@ static void run(void)
 		tst_res(TPASS, "pidfd_open() passed");
 }
 
+static void setup(void)
+{
+	// Check if pidfd_open(2) is not supported
+	tst_syscall(__NR_pidfd_open, -1, 0);
+}
+
 static struct tst_test test = {
-	.min_kver = "5.3",
+	.setup = setup,
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-- 
2.21.0



