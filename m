From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Nov 2017 16:34:33 -0800
Subject: [LTP] [PATCH v2 1/6] syscalls/cma: Make process_vm_{readv,
	writev} tests bionic friendly
In-Reply-To: <20171109003438.130802-1-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
Message-ID: <20171109003438.130802-2-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All testcases under testcases/kernel/syscalls/cma depend on SysV
semaphore to do event notification from parent<->child processes.
Since bionic / android doesn't have SysV IPC, the tests can't be built
against bionic.

Fix this by using the ltp TST_SAFE_CHECKPOINT APIs taht are based on
futexes. The change enables following tests for Android devices.

   process_vm01, process_vm_readv0[23], process_vm_writev02

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
v1->v2
------
- Use TST_CHECKPOINT APIs instead of eventfd as suggested by Jan

 testcases/kernel/syscalls/cma/process_vm.h         | 38 ----------------------
 testcases/kernel/syscalls/cma/process_vm_readv02.c | 10 +++---
 testcases/kernel/syscalls/cma/process_vm_readv03.c | 10 +++---
 .../kernel/syscalls/cma/process_vm_writev02.c      | 10 +++---
 4 files changed, 15 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
index 7df9aacd0..1ecf325bb 100644
--- a/testcases/kernel/syscalls/cma/process_vm.h
+++ b/testcases/kernel/syscalls/cma/process_vm.h
@@ -59,42 +59,4 @@ static inline ssize_t test_process_vm_writev(pid_t pid,
 #endif
 }
 
-void safe_semop(int id, unsigned short num, short op)
-{
-	int ret;
-	struct sembuf sem_op;
-	sem_op.sem_num = num,
-	sem_op.sem_op = op,
-	sem_op.sem_flg = 0;
-
-	do {
-		ret = semop(id, &sem_op, 1);
-	} while (ret == -1 && errno == EINTR);
-	if (ret == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "semop(%d, (%d, %d)) failed",
-			id, num, op);
-}
-
-int init_sem(int num)
-{
-	int id, i;
-	union semun u;
-	if ((id = semget(IPC_PRIVATE, num, IPC_CREAT|S_IRWXU)) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "Couldn't allocate semaphore");
-
-	for (i = 0; i < num; i++) {
-		u.val = 0;
-		if (semctl(id, 0, SETVAL, u) == -1)
-			tst_brkm(TBROK|TERRNO, NULL,
-				"Couldn't initialize sem %d value", i);
-	}
-	return id;
-}
-
-void clean_sem(int id)
-{
-	if (semctl(id, 0, IPC_RMID) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "Couldn't remove sem");
-}
-
 #endif /* _PROCESS_VM_H_ */
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index f84f79ef7..aa81f17f7 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -38,7 +38,6 @@ static char *tst_string = "THIS IS A TEST";
 static int len;
 static int pipe_fd[2];
 static pid_t pids[2];
-static int semid;
 
 static void child_alloc(void);
 static void child_invoke(void);
@@ -84,7 +83,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* child_alloc is free to exit now */
-		safe_semop(semid, 0, 1);
+		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
 
 		SAFE_WAITPID(cleanup, pids[0], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
@@ -112,7 +111,7 @@ static void child_alloc(void)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_invoke is done reading from our VM */
-	safe_semop(semid, 0, -1);
+	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
 }
 
 static void child_invoke(void)
@@ -153,12 +152,13 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(cleanup);
 
 	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-	clean_sem(semid);
+	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 2e69f855f..d1ca87a14 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -51,7 +51,6 @@ static int nr_iovecs;
 static long bufsz;
 static int pipe_fd[2];
 static pid_t pids[2];
-static int semid;
 
 static void gen_random_arr(int *arr, int arr_sz);
 static void child_alloc(int *bufsz_arr);
@@ -103,7 +102,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* child_alloc is free to exit now */
-		safe_semop(semid, 0, 1);
+		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
 
 		SAFE_WAITPID(cleanup, pids[0], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
@@ -157,7 +156,7 @@ static void child_alloc(int *bufsz_arr)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_invoke is done reading from our VM */
-	safe_semop(semid, 0, -1);
+	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
 }
 
 static long *fetch_remote_addrs(void)
@@ -255,7 +254,8 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(cleanup);
 	srand(time(NULL));
 
 	TEST_PAUSE;
@@ -263,7 +263,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	clean_sem(semid);
+	tst_rmdir();
 }
 
 static void help(void)
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 952081811..544bda8d5 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -48,7 +48,6 @@ static option_t options[] = {
 static long bufsz;
 static int pipe_fd[2];
 static pid_t pids[2];
-static int semid;
 
 static void child_init_and_verify(void);
 static void child_write(void);
@@ -97,7 +96,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* signal child_init_and_verify to verify its VM now */
-		safe_semop(semid, 0, 1);
+		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
 
 		SAFE_WAITPID(cleanup, pids[0], &status, 0);
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
@@ -126,7 +125,7 @@ static void child_init_and_verify(void)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_write() is done writing to our VM */
-	safe_semop(semid, 0, -1);
+	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
 
 	nr_err = 0;
 	for (i = 0; i < bufsz; i++) {
@@ -189,14 +188,15 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(cleanup);
 
 	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-	clean_sem(semid);
+	tst_rmdir();
 }
 
 static void help(void)
-- 
2.15.0.448.gf294e3d99a-goog

