From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:33 +0100
Subject: [LTP] [PATCH 04/18] hugeshmctl01: Fix synchronization issue in
	parent process
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-5-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Wait for the children from the first test to detach and exit, before
proceeding to the next round. Otherwise we could have incorrect
references on the shm_id lying around from the previous run.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 37a8a0d6f..ea249d1b6 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -260,10 +260,16 @@ fail:
 static void stat_cleanup(void)
 {
 	int i;
+	int status;
 
 	/* wake up the childern so they can detach the memory and exit */
-	for (i = 0; i < N_ATTACH; i++)
+	for (i = 0; i < N_ATTACH; i++) {
 		SAFE_KILL(pid_arr[i], SIGCONT);
+		/* Wait for the child to exit */
+		if (waitpid(pid_arr[i], &status, 0) != pid_arr[i] &&
+			!WIFEXITED(status))
+			tst_brk(TBROK | TERRNO, "waitpid for exit");
+	}
 
 	/* remove the parent's shared memory the second time through */
 	if (stat_time == SECOND)
-- 
2.14.2

