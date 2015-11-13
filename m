From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 13 Nov 2015 14:19:49 +0100
Subject: [LTP] [PATCH] semctl01: wait for children to exit between tests
Message-ID: <2884421001fa51724ab19f03d6422f679509da3d.1447420556.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This testcase occasionally hanged:
 semctl01    1  TPASS  :  buf.sem_nsems and buf.sem_perm.mode are correct
 semctl01    2  TPASS  :  buf.sem_perm.mode is correct
 semctl01    3  TPASS  :  semaphores have expected values
 semctl01    4  TPASS  :  number of sleeping processes is correct
 semctl01    5  TPASS  :  last pid value is correct
 semctl01    6  TPASS  :  semaphore value is correct
 semctl01    7  TBROK  :  semctl01.c:338: semop succeeded - cnt_setup
<hangs here>

because somop in GETZCNT test unexpectedly suceeded. All children
are supposed to block here, because semval is not zero.

Problem is that semctl01 sends SIGKILL to children from previous
test (GETNCNT), but it doesn't wait for them to finish. Then it
proceeds to increase semval for GETZCNT test and one child from
previous test, which is still blocked on sem_op == -1 for SEM4
and has not exited yet, will decrease semval to 0. This breaks
GETZCNT test, child unexpectedly completes and becomes zombie.
Parent process then waits forever in TST_PROCESS_STATE_WAIT()
for state to be 'S' - sleeping.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ipc/semctl/semctl01.c | 30 +++++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index 9a516ed5e1f8..39cf64e118a7 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -45,10 +45,10 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
+#include <sys/wait.h>
 #include "ipcsem.h"
 
 char *TCID = "semctl01";
-int TST_TOTAL = 13;
 
 static int sem_id_1 = -1;
 static int sem_index;
@@ -120,10 +120,30 @@ static struct test_case_t {
 	{&sem_id_1, 0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };
 
+int TST_TOTAL = ARRAY_SIZE(TC);
+
+static void kill_all_children(void)
+{
+	int j, status;
+
+	for (j = 0; j < NCHILD; j++) {
+		if (kill(pid_arr[j], SIGKILL) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "child kill failed");
+	}
+
+	/*
+	 * make sure children finished before we proceed with next testcase
+	 */
+	for (j = 0; j < NCHILD; j++) {
+		if (wait(&status) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "wait() failed");
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	int lc;
-	int i, j;
+	int i;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 
@@ -192,11 +212,7 @@ int main(int argc, char *argv[])
 			switch (TC[i].cmd) {
 			case GETNCNT:
 			case GETZCNT:
-				for (j = 0; j < NCHILD; j++) {
-					if (kill(pid_arr[j], SIGKILL) == -1)
-						tst_brkm(TBROK, cleanup,
-							 "child kill failed");
-				}
+				kill_all_children();
 				break;
 			}
 		}
-- 
1.8.3.1

