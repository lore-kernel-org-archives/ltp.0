From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Wed, 14 Jul 2021 14:34:38 +0800
Subject: [LTP] [PATCH] interfaces/sched_setparam/9-1.c: Fix leak of shared
 memory segment
Message-ID: <1626244478-15350-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since this case uses a shared memory segment to test, we should free it at the end.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../interfaces/sched_setparam/9-1.c           | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
index 87e726a8e..6f158da04 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
@@ -43,6 +43,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 #include "ncpu.h"
+#include "safe_helpers.h"
 
 static int nb_cpu;
 static int *shmptr;
@@ -134,7 +135,7 @@ int main(void)
 	shmptr = shmat(shm_id, 0, 0);
 	if (shmptr == (void *)-1) {
 		perror("An error occurs when calling shmat()");
-		return PTS_UNRESOLVED;
+		goto free_shm;
 	}
 	*shmptr = 0;
 
@@ -148,7 +149,7 @@ int main(void)
 			perror("An error occurs when calling"
 			       " sched_setscheduler()");
 		}
-		return PTS_UNRESOLVED;
+		goto free_shm;
 	}
 
 	for (i = 0; i < (nb_cpu - 1); i++) {
@@ -156,13 +157,13 @@ int main(void)
 		if (child_pid[i] == -1) {
 			perror("An error occurs when calling fork()");
 			kill_children(child_pid, i);
-			return PTS_UNRESOLVED;
+			goto free_shm;
 		} else if (child_pid[i] == 0) {
 
 			child_process();
 
 			printf("This code should not be executed.\n");
-			return PTS_UNRESOLVED;
+			goto free_shm;
 		}
 	}
 
@@ -170,13 +171,13 @@ int main(void)
 	if (child_pid[i] == -1) {
 		perror("An error occurs when calling fork()");
 		kill_children(child_pid, i);
-		return PTS_UNRESOLVED;
+		goto free_shm;
 	} else if (child_pid[i] == 0) {
 
 		test_process();
 
 		printf("This code should not be executed.\n");
-		return PTS_UNRESOLVED;
+		goto free_shm;
 	}
 
 	param.sched_priority = mean_prio;
@@ -184,10 +185,11 @@ int main(void)
 	if (sched_setparam(child_pid[i], &param) != 0) {
 		perror("An error occurs when calling sched_setparam()");
 		kill_children(child_pid, nb_cpu);
-		return PTS_UNRESOLVED;
+		goto free_shm;
 	}
 	newcount = *shmptr;
 
+	SAFE_FUNC(shmctl(shm_id, IPC_RMID, NULL));
 	if (newcount == oldcount) {
 		printf("The target process does not preempt"
 		       " the calling process\n");
@@ -198,4 +200,7 @@ int main(void)
 	printf("Test PASSED\n");
 	kill_children(child_pid, nb_cpu);
 	return PTS_PASS;
+free_shm:
+	SAFE_FUNC(shmctl(shm_id, IPC_RMID, NULL));
+	return PTS_UNRESOLVED;
 }
-- 
2.23.0

