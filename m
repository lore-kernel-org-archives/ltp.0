From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:54 +0200
Subject: [LTP] [COMMITTED] [PATCH 21/40] Make use of SAFE_KILL()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-21-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/containers/pidns/pidns20.c            | 4 +---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 3 +--
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c        | 4 ++--
 testcases/kernel/syscalls/ipc/semctl/semctl01.c        | 3 +--
 testcases/kernel/syscalls/ipc/semop/semop05.c          | 6 ++----
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c        | 3 +--
 testcases/kernel/syscalls/nanosleep/nanosleep02.c      | 6 ++----
 testcases/kernel/syscalls/nanosleep/nanosleep03.c      | 6 ++----
 testcases/kernel/syscalls/sighold/sighold02.c          | 7 ++-----
 testcases/kernel/syscalls/vfork/vfork02.c              | 6 ++----
 10 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index 70e9356fd..e28bcbdd6 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -180,9 +180,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* Enqueue SIGUSR1 in pending signal queue of container */
-	if (kill(cpid, SIGUSR1) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "kill() failed");
-	}
+	SAFE_KILL(NULL, cpid, SIGUSR1);
 
 	tst_resm(TINFO, "parent: signalled SIGUSR1 to container");
 	if (write(parent_cinit[1], "p:go", 5) != 5) {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 0e37b8f96..ad7a80d70 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -287,8 +287,7 @@ static void stat_cleanup(void)
 
 	/* wake up the childern so they can detach the memory and exit */
 	for (i = 0; i < N_ATTACH; i++)
-		if (kill(pid_arr[i], SIGUSR1) == -1)
-			tst_brk(TBROK | TERRNO, "kill with SIGUSR1");
+		SAFE_KILL(pid_arr[i], SIGUSR1);
 
 	/* remove the parent's shared memory the second time through */
 	if (stat_time == SECOND)
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
index 7a8b680b9..66c4341f1 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
@@ -56,6 +56,7 @@
  */
 
 #include "test.h"
+#include "safe_macros.h"
 
 #include "ipcmsg.h"
 
@@ -116,8 +117,7 @@ int main(int ac, char **av)
 			TST_PROCESS_STATE_WAIT(cleanup, c_pid, 'S');
 
 			/* send a signal that must be caught to the child */
-			if (kill(c_pid, SIGHUP) == -1)
-				tst_brkm(TBROK, cleanup, "kill failed");
+			SAFE_KILL(cleanup, c_pid, SIGHUP);
 
 			waitpid(c_pid, NULL, 0);
 		}
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index 739eb5e4e..2f443db89 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -128,8 +128,7 @@ static void kill_all_children(void)
 	int j, status;
 
 	for (j = 0; j < NCHILD; j++) {
-		if (kill(pid_arr[j], SIGKILL) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "child kill failed");
+		SAFE_KILL(cleanup, pid_arr[j], SIGKILL);
 	}
 
 	/*
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
index 34bb4da35..6ed25014c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop05.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
@@ -64,6 +64,7 @@
 
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "safe_macros.h"
 
 char *TCID = "semop05";
 int TST_TOTAL = 4;
@@ -160,10 +161,7 @@ int main(int ac, char **av)
 					/* remove the semaphore resource */
 					rm_sema(sem_id_1);
 				} else {
-					if (kill(pid, SIGHUP) == -1) {
-						tst_brkm(TBROK, cleanup,
-							 "kill failed");
-					}
+					SAFE_KILL(cleanup, pid, SIGHUP);
 				}
 
 				/* let the child carry on */
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index ac3660f4a..ddf6b86d1 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -338,8 +338,7 @@ void stat_cleanup(void)
 
 	/* wake up the childern so they can detach the memory and exit */
 	for (i = 0; i < N_ATTACH; i++) {
-		if (kill(pid_arr[i], SIGUSR1) == -1)
-			tst_brkm(TBROK, cleanup, "kill failed");
+		SAFE_KILL(cleanup, pid_arr[i], SIGUSR1);
 	}
 
 	/* remove the parent's shared memory the second time through */
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep02.c b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
index 8ee22b49e..42c825190 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep02.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
@@ -36,6 +36,7 @@
 #include <inttypes.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "nanosleep02";
 int TST_TOTAL = 1;
@@ -92,10 +93,7 @@ int main(int ac, char **av)
 		sleep(1);
 
 		/* Now send signal to child */
-		if (kill(cpid, SIGINT) < 0) {
-			tst_brkm(TBROK, NULL,
-				 "kill() fails send signal to child");
-		}
+		SAFE_KILL(NULL, cpid, SIGINT);
 
 		tst_record_childstatus(NULL, cpid);
 	}
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep03.c b/testcases/kernel/syscalls/nanosleep/nanosleep03.c
index 291396b43..456e140e9 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep03.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep03.c
@@ -33,6 +33,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "nanosleep03";
 int TST_TOTAL = 1;
@@ -81,10 +82,7 @@ int main(int ac, char **av)
 		sleep(1);
 
 		/* Now send signal to child */
-		if (kill(cpid, SIGINT) < 0) {
-			tst_brkm(TBROK, NULL,
-				 "kill() fails send signal to child");
-		}
+		SAFE_KILL(NULL, cpid, SIGINT);
 
 		/* Wait for child to execute */
 		wait(&status);
diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index be018748b..8df5fa7db 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -48,6 +48,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "test.h"
+#include "safe_macros.h"
 
 /* _XOPEN_SOURCE disables NSIG */
 #ifndef NSIG
@@ -111,11 +112,7 @@ int main(int ac, char **av)
 			for (sig = 1; sig < NUMSIGS; sig++) {
 				if (skip_sig(sig))
 					continue;
-				if (kill(pid, sig) < 0) {
-					tst_brkm(TBROK | TERRNO, NULL,
-						 "kill(%d, %d(%s)) failed",
-						 pid, sig, tst_strsig(sig));
-				}
+				SAFE_KILL(NULL, pid, sig);
 			}
 
 			TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
diff --git a/testcases/kernel/syscalls/vfork/vfork02.c b/testcases/kernel/syscalls/vfork/vfork02.c
index aadc5993f..efa70d0be 100644
--- a/testcases/kernel/syscalls/vfork/vfork02.c
+++ b/testcases/kernel/syscalls/vfork/vfork02.c
@@ -78,6 +78,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "vfork02";
 int TST_TOTAL = 1;
@@ -185,10 +186,7 @@ void setup(void)
 	}
 
 	/* Send the signal SIGUSR1 to itself so that SIGUSR1 is pending */
-	if (kill(getpid(), SIGUSR1) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "Fails to send the signal to the parent process");
-	}
+	SAFE_KILL(cleanup, getpid(), SIGUSR1);
 
 	/* If SIGUSR1 is not pending in the parent, fail */
 	if (sigpending(&PendSig) == -1) {
-- 
2.13.5

