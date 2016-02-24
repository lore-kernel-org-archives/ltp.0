From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Wed, 24 Feb 2016 18:19:14 +0800
Subject: [LTP] [PATCH] mem/oom: call WEXITSTATUS() only if WIFEXITED()
	returned true
Message-ID: <20160224101914.GA4402@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Only when WIFEXITED() returned true that WEXITSTATUS() can return a
meanful result. So we should check WIFEXITED() first.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/mem/lib/mem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index cedcf32..8327998 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -150,12 +150,16 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 				WTERMSIG(status),
 				tst_strsig(WTERMSIG(status)));
 		}
-	} else	if (WIFEXITED(status) && WEXITSTATUS(status) == retcode) {
-		tst_resm(TPASS, "victim retcode: (%d) %s",
+	} else if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) == retcode) {
+			tst_resm(TPASS, "victim retcode: (%d) %s",
 				retcode, strerror(retcode));
-	} else {
-		tst_resm(TFAIL, "victim unexpectedly ended with retcode: %d, "
+		} else {
+			tst_resm(TFAIL, "victim unexpectedly ended with retcode: %d, "
 				"expected: %d", WEXITSTATUS(status), retcode);
+		}
+	} else {
+		tst_resm(TFAIL, "victim unexpectedly ended");
 	}
 }
 
-- 
1.9.3

