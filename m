From: Andrea Arcangeli <aarcange@redhat.com>
Date: Thu, 24 Aug 2017 19:54:51 +0200
Subject: [LTP] [PATCH 2/2] mem: ksm: fixes for race conditions
In-Reply-To: <20170824175451.13225-1-aarcange@redhat.com>
References: <20170824175451.13225-1-aarcange@redhat.com>
Message-ID: <20170824175451.13225-3-aarcange@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

stop_ksm_children doesn't actually stop the children, it waits the
children to stop themselves after they finished setting up the memory.

Problem is the test was waiting for two passes of KSM (to merge all
the memory) in wait_ksmd_full_scan before waiting the child to stop
setting up the memory. Two passes of KSM aren't enough if the children
aren't settled yet. This fixes it by waiting the children to stop
operating before waiting KSM to merge the memory.

waitpid WCONTINUED also doesn't make sense, it's better and more
strict to wait until all children truly exited, otherwise it would
just return immediately because the children were waken by SIGCONT at
the last resume. Removing WCONTINUED will let the parent truly wait
the children to verify the memory and exit after it.

These issues showed up after speeding up the wait_ksmd_full_scan and
after removing other unnecessary wait times.

The test is now faster and at the same time more accurate by waiting
at least two passes of KSM which by the kernel implementation we know
is enough to reach a settled merged state without the need of other
artificial delays.

In case of failure of the checks, this now also prints the actual
value to provide more debug info in the log.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 6d8945081..4f9779ea5 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -261,7 +261,8 @@ static void check(char *path, long int value)
 	SAFE_FILE_SCANF(fullpath, "%ld", &actual_val);
 
 	if (actual_val != value)
-		tst_res(TFAIL, "%s is not %ld.", path, value);
+		tst_res(TFAIL, "%s is not %ld but %ld.", path, value,
+			actual_val);
 	else
 		tst_res(TPASS, "%s is %ld.", path, actual_val);
 }
@@ -523,21 +524,20 @@ void create_same_memory(int size, int num, int unit)
 	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
 
 	resume_ksm_children(child, num);
+	stop_ksm_children(child, num);
 	group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
 
-	stop_ksm_children(child, num);
 	resume_ksm_children(child, num);
+	stop_ksm_children(child, num);
 	group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
 
-	stop_ksm_children(child, num);
 	resume_ksm_children(child, num);
+	stop_ksm_children(child, num);
 	group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
 
-	stop_ksm_children(child, num);
 	resume_ksm_children(child, num);
-	group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
-
 	stop_ksm_children(child, num);
+	group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
 
 	tst_res(TINFO, "KSM unmerging...");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
@@ -549,7 +549,7 @@ void create_same_memory(int size, int num, int unit)
 	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
 	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
 
-	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
+	while (waitpid(-1, &status, 0) > 0)
 		if (WEXITSTATUS(status) != 0)
 			tst_res(TFAIL, "child exit status is %d",
 				 WEXITSTATUS(status));
