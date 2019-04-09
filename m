From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  9 Apr 2019 15:02:01 +0300
Subject: [LTP] [PATCH] syscalls/fcntl33.c: fix test for fuse fs again
Message-ID: <1554811321-19337-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The previous fix commit 7703cb3e10ea ("syscall/fcntl33.c: fix test on FUSE
fs") moved open() (can sleep on fuse fs) before fork()/do_child(). But the
fix was removed by commit e5c990c5c55b ("Convert fcntl33 to newlib").

In this patch, instead of moving open(), use LTP checkpoints: wake the
child only after setting the lease in a parent process.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/fcntl/fcntl33.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index 35eebb5..43dc5a2 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -124,6 +124,7 @@ static void do_test(unsigned int i)
 		goto exit;
 	}
 
+	TST_CHECKPOINT_WAKE(0);
 	/* Wait for SIGIO caused by lease breaker. */
 	TEST(sigtimedwait(&newset, NULL, &timeout));
 	if (TST_RET == -1) {
@@ -174,7 +175,7 @@ static void do_child(unsigned int i)
 {
 	long long elapsed_ms;
 
-	TST_PROCESS_STATE_WAIT(getppid(), 'S');
+	TST_CHECKPOINT_WAIT(0);
 
 	tst_timer_start(CLOCK_MONOTONIC);
 
@@ -225,6 +226,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.needs_checkpoints = 1,
 	.tcnt = ARRAY_SIZE(test_cases),
 	.setup = setup,
 	.test = do_test,
-- 
1.7.1

