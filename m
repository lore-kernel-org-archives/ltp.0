From: Hongzhi.Song <hongzhi.song@windriver.com>
Date: Mon, 5 Nov 2018 02:30:31 -0500
Subject: [LTP] [PATCH] kernel/syscall/setrlimit05.c: use a legal bad address
	for mips
Message-ID: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This testcase fails on mips32. The process is killed by SIGBUS which
doesn't return EFAULT as expect.

This is because:
((void *)-1) is not a legal bad address which causes the process
killed by SIGBUG on mips.

'tst_get_bad_addr()' returns an address that should work on mips
and other arches.

Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit05.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
index e716722..57b0b82 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
@@ -31,9 +31,13 @@ static void verify_setrlimit(void)
 	int status;
 	pid_t pid;
 
+    void *bad_addr;
+
+    bad_addr = tst_get_bad_addr(NULL);
+
 	pid = SAFE_FORK();
 	if (!pid) {
-		TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
+		TEST(setrlimit(RLIMIT_NOFILE,(struct rlimit *)bad_addr));
 		if (TST_RET != -1) {
 			tst_res(TFAIL, "setrlimit()  succeeded unexpectedly");
 			exit(0);
-- 
2.8.1

