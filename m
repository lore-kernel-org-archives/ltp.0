From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2019 17:38:56 +0800
Subject: [LTP] [PATCH RFC 1/3] min_free_kbytes: Fix child exit status check
	conditions
Message-ID: <20190319093858.584-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Vipin K Parashar <vipin@linux.vnet.ibm.com>

Fixes: #349

min_free_kbytes test has badly formed if conditions in mem_tune()
for child exit status check. This is causing test to declare as FAILED
despite that not being the case. Fix child exit status check conditions.

---ERROR LOG---
<..snip..>
mem.c:839: INFO: set overcommit_memory to 1
mem.c:839: INFO: set min_free_kbytes to 11580
memfree is 6974720 kB before eatup mem
memfree is 15488 kB after eatup mem
min_free_kbytes.c:135: FAIL: child unexpectedly failed: 0
mem.c:839: INFO: set min_free_kbytes to 23160
memfree is 7104128 kB before eatup mem
memfree is 26560 kB after eatup mem
min_free_kbytes.c:135: FAIL: child unexpectedly failed: 0
mem.c:839: INFO: set min_free_kbytes to 145812
memfree is 7101504 kB before eatup mem
memfree is 215872 kB after eatup mem
min_free_kbytes.c:135: FAIL: child unexpectedly failed: 0
min_free_kbytes.c:81: PASS: min_free_kbytes test pass
mem.c:839: INFO: set min_free_kbytes to 11580
---------------

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/mem/tunable/min_free_kbytes.c      | 40 +++++--------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index f114dc493..d2378a700 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -119,39 +119,21 @@ static void test_tune(unsigned long overcommit_policy)
 
 		SAFE_WAITPID(pid[i], &status, WUNTRACED | WCONTINUED);
 
-		if (overcommit_policy == 2) {
-			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_res(TFAIL,
-					 "child unexpectedly failed: %d",
-					 status);
-		} else if (overcommit_policy == 1) {
-			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
+			tst_res(TFAIL,
+				"child unexpectedly failed: %d", status);
+		} else if (WIFSIGNALED(status) && WTERMSIG(status) != SIGKILL) {
 #if __WORDSIZE == 32
-			{
-				if (total_mem < 3145728UL)
+			if (total_mem < 3145728UL)
 #endif
-					tst_res(TFAIL,
-						 "child unexpectedly failed: %d",
-						 status);
+				tst_res(TFAIL,
+					"child unexpectedly failed: %d", status);
 #if __WORDSIZE == 32
-				/* in 32-bit system, a process allocate about 3Gb memory@most */
-				else
-					tst_res(TINFO, "Child can't allocate "
-						 ">3Gb memory in 32bit system");
-			}
+			/* in 32-bit system, a process allocate about 3Gb memory at most */
+			else
+				tst_res(TINFO, "Child can't allocate "
+					">3Gb memory in 32bit system");
 #endif
-		} else {
-			if (WIFEXITED(status)) {
-				if (WEXITSTATUS(status) != 0) {
-					tst_res(TFAIL, "child unexpectedly "
-						 "failed: %d", status);
-				}
-			} else if (!WIFSIGNALED(status) ||
-				   WTERMSIG(status) != SIGKILL) {
-				tst_res(TFAIL,
-					 "child unexpectedly failed: %d",
-					 status);
-			}
 		}
 	}
 }
-- 
2.20.1

