From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jun 2016 18:54:43 +0800
Subject: [LTP] [PATCH] mem/lib: Skip oom(KSM) if child_alloc() makes single
	TESTMEM+MB allocation
Message-ID: <1466506483-30209-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We occasionally catch errors like:
oom03       0  TINFO  :  start OOM testing for KSM pages.
oom03       0  TINFO  :  expected victim is 3490.
oom03       6  TFAIL  :  mem.c:163: victim unexpectedly ended with retcode: 0, expected: 12
oom03       0  TINFO  :  set overcommit_memory to 0

It cames from the caller testoom(0, 1, ENOMEM, 1). The issue was occurred
since child_alloc() go into single(lite == 1) thread mode but successfully
finish the memory(TESTMEM+MB) allocation and return 0. That's not what we
expected because oom03 has already set 'limit_in_byte = TESTMEM' in cgroup.
A probably reason is that KSM scan merged samepages and disturbed the OOM
test.

By this patch, Let's skip the oom(KSM) test in cgroup.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 3d853a3..10eb0f7 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -224,8 +224,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 	tst_resm(TINFO, "start OOM testing for mlocked pages.");
 	oom(MLOCK, lite, retcode, allow_sigkill);
 
-	if (access(PATH_KSM, F_OK) == -1) {
-		tst_resm(TINFO, "KSM configuration is not enabled, "
+	/* Skip oom(KSM) if lite == 1, since limit_in_bytes may vary from
+	 * run to run, which isn't reliable for oom03 cgroup test.*/
+	if (access(PATH_KSM, F_OK) == -1 || lite == 1) {
+		tst_resm(TINFO, "KSM is not configed or lite == 1, "
 			 "skip OOM test for KSM pags");
 	} else {
 		tst_resm(TINFO, "start OOM testing for KSM pages.");
-- 
1.8.3.1

