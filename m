From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 11 Aug 2020 15:05:02 +0200
Subject: [LTP] [PATCH 4/4] Add taint check to syscalls/ptrace08
In-Reply-To: <20200811130502.12010-1-mdoucha@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
Message-ID: <20200811130502.12010-4-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test may pass on some kernels despite triggering a kernel segfault. Check
for kernel taint just in case.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ptrace/ptrace08.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
index 448bc72e3..591aa0dd2 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace08.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
@@ -48,7 +48,8 @@ static void setup(void)
 
 		if (fcount < 2) {
 			fclose(fr);
-			tst_brk(TBROK, "Unexpected data in /proc/kallsyms %d", fcount);
+			tst_brk(TBROK, "Unexpected data in /proc/kallsyms %d",
+				fcount);
 		}
 
 		if (fcount >= 3 && endl != '\n')
@@ -89,9 +90,8 @@ static void run(void)
 
 	child = child_pid = SAFE_FORK();
 
-	if (!child_pid) {
+	if (!child_pid)
 		child_main();
-	}
 
 	if (SAFE_WAITPID(child_pid, &status, WUNTRACED) != child_pid)
 		tst_brk(TBROK, "Received event from unexpected PID");
@@ -133,6 +133,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f67b15037a7a"},
 		{"CVE", "2018-1000199"},
-- 
2.27.0

