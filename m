From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 16 Nov 2020 14:11:48 +0100
Subject: [LTP] [PATCH] pipe13: Increase time to wait for child processes to
 terminate
Message-ID: <20201116131148.19243-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If the system is not fast enough, to clean up
the child processes, the test shows a false negative result.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/syscalls/pipe/pipe13.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe13.c b/testcases/kernel/syscalls/pipe/pipe13.c
index 4e6777e63..5d76e1f00 100644
--- a/testcases/kernel/syscalls/pipe/pipe13.c
+++ b/testcases/kernel/syscalls/pipe/pipe13.c
@@ -60,7 +60,7 @@ static void verify_pipe(unsigned int n)
 	SAFE_CLOSE(fds[0]);
 	SAFE_CLOSE(fds[1]);
 
-	while (cnt < child_num && sleep_us < 100000) {
+	while (cnt < child_num && sleep_us < 1000000) {
 		ret = waitpid(-1, NULL, WNOHANG);
 		if (ret < 0)
 			tst_brk(TBROK | TERRNO, "waitpid()");
-- 
2.25.1

