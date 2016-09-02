From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 2 Sep 2016 02:00:04 +0000
Subject: [LTP]  [PATCH] overcommit_memory: Fix spelling mistake
Message-ID: <1472781604-148934-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix spelling mistake for 'CommmitLimit'

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/mem/tunable/overcommit_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 9c33758..79a3034 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -274,7 +274,7 @@ static void update_mem(void)
 		commit_left = commit_limit - committed;
 
 		if (commit_left < 0) {
-			tst_resm(TINFO, "CommmitLimit is %ld, Committed_AS"
+			tst_resm(TINFO, "CommitLimit is %ld, Committed_AS"
 				 " is %ld", commit_limit, committed);
 			tst_brkm(TBROK, cleanup, "Unexpected error: "
 				 "CommitLimit < Committed_AS");
-- 
1.8.3.4

