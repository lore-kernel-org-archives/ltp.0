From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 30 Jan 2020 17:13:37 +0100
Subject: [LTP] [PATCH] Taunt OOM killer in fork12 setup()
Message-ID: <20200130161337.31614-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On a system with low memory, fork12 can trigger OOM killer before it hits
any fork() limits. The OOM killer might accidentally kill e.g. the parent
shell and external testing tools will assume the test failed.

Set high oom_score_adj on the fork12 process so that the OOM killer focuses
on it and its children.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/fork/fork12.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fork/fork12.c b/testcases/kernel/syscalls/fork/fork12.c
index 75278b012..99b6900f4 100644
--- a/testcases/kernel/syscalls/fork/fork12.c
+++ b/testcases/kernel/syscalls/fork/fork12.c
@@ -108,6 +108,8 @@ int main(int ac, char **av)
 static void setup(void)
 {
 	tst_sig(FORK, fork12_sigs, cleanup);
+	/* Taunt the OOM killer so that it doesn't kill system processes */
+	SAFE_FILE_PRINTF(cleanup, "/proc/self/oom_score_adj", "500");
 	TEST_PAUSE;
 }
 
-- 
2.24.1

