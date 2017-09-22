From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Sep 2017 10:26:05 +0200
Subject: [LTP] [PATCH] syscalls/cma: Make process_vm_{readv,
 writev} tests bionic friendly
In-Reply-To: <20170921215755.85005-1-sspatil@google.com>
References: <20170921215755.85005-1-sspatil@google.com>
Message-ID: <a46801be-c84a-a37c-2788-10cac3cba184@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/21/2017 11:57 PM, Sandeep Patil wrote:
> All testcases under testcases/kernel/syscalls/cma depend on SysV
> semaphore to do event notification from parent<->child processes.
> Since bionic / android doesn't have SysV IPC, the tests cant be built
> against bionic.
> 
> Fix this by keeping the old behavior for non bionic builds and switch to
> using eventfd(EFD_SEMAPHORE) when building against bionic.

Hi,

If we can, we should use LTP's checkpoints for synchronization.
It's based on futexes and works well for simple cases, which
should fit all cma tests.

Something like patch below. Would that work for you?

Regards,
Jan

---
 testcases/kernel/syscalls/cma/process_vm.h         | 38 ----------------------
 testcases/kernel/syscalls/cma/process_vm01.c       |  6 ++--
 testcases/kernel/syscalls/cma/process_vm_readv02.c | 10 +++---
 testcases/kernel/syscalls/cma/process_vm_readv03.c | 14 ++++----
 .../kernel/syscalls/cma/process_vm_writev02.c      | 10 +++---
 5 files changed, 21 insertions(+), 57 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
index 7df9aacd0ef2..1ecf325bb05d 100644
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
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 110db6e76602..e63a3c8b70c2 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -71,7 +71,7 @@ char *TCID = "cma01";
 int TST_TOTAL = 1;
 static void (*cma_test_params) (struct process_vm_params * params) = NULL;

-static void setup(char *argv[]);
+static void setup(void);
 static void cleanup(void);
 static void help(void);

@@ -85,7 +85,7 @@ int main(int argc, char *argv[])

 	tst_parse_opts(argc, argv, options, &help);

-	setup(argv);
+	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 		cma_test_errnos();
@@ -94,7 +94,7 @@ int main(int argc, char *argv[])
 	tst_exit();
 }

-static void setup(char *argv[])
+static void setup(void)
 {
 	tst_require_root();

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index b7dd9b2e5bea..39eb57c59aa1 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -38,7 +38,6 @@ static char *tst_string = "THIS IS A TEST";
 static int len;
 static int pipe_fd[2];
 static pid_t pids[2];
-static int semid;

 static void child_alloc(void);
 static void child_invoke(void);
@@ -86,7 +85,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);

 		/* child_alloc is free to exit now */
-		safe_semop(semid, 0, 1);
+		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);

 		if (waitpid(pids[0], &status, 0) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
@@ -115,7 +114,7 @@ static void child_alloc(void)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);

 	/* wait until child_invoke is done reading from our VM */
-	safe_semop(semid, 0, -1);
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
 }

 static void child_invoke(void)
@@ -156,12 +155,13 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(tst_rmdir);

 	TEST_PAUSE;
 }

 static void cleanup(void)
 {
-	clean_sem(semid);
+	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 17f0a5dcc627..83c988ac3ffa 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -51,7 +51,6 @@ static int nr_iovecs;
 static long bufsz;
 static int pipe_fd[2];
 static pid_t pids[2];
-static int semid;

 static void gen_random_arr(int *arr, int arr_sz);
 static void child_alloc(int *bufsz_arr);
@@ -105,7 +104,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);

 		/* child_alloc is free to exit now */
-		safe_semop(semid, 0, 1);
+		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);

 		if (waitpid(pids[0], &status, 0) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
@@ -160,7 +159,7 @@ static void child_alloc(int *bufsz_arr)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);

 	/* wait until child_invoke is done reading from our VM */
-	safe_semop(semid, 0, -1);
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
 }

 static long *fetch_remote_addrs(void)
@@ -193,7 +192,8 @@ static long *fetch_remote_addrs(void)

 static void child_invoke(int *bufsz_arr)
 {
-	int i, j, count, nr_error;
+	unsigned int j;
+	int i, count, nr_error;
 	unsigned char expect, actual;
 	long *addrs;
 	struct iovec local[NUM_LOCAL_VECS], *remote;
@@ -258,15 +258,17 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
 	srand(time(NULL));

+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(tst_rmdir);
+
 	TEST_PAUSE;
 }

 static void cleanup(void)
 {
-	clean_sem(semid);
+	tst_rmdir();
 }

 static void help(void)
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 04cf6d14999f..bdb30d1ad945 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -48,7 +48,6 @@ static option_t options[] = {
 static long bufsz;
 static int pipe_fd[2];
 static pid_t pids[2];
-static int semid;

 static void child_init_and_verify(void);
 static void child_write(void);
@@ -99,7 +98,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);

 		/* signal child_init_and_verify to verify its VM now */
-		safe_semop(semid, 0, 1);
+		TST_SAFE_CHECKPOINT_WAKE(NULL, 0);

 		if (waitpid(pids[0], &status, 0) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
@@ -129,7 +128,7 @@ static void child_init_and_verify(void)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);

 	/* wait until child_write() is done writing to our VM */
-	safe_semop(semid, 0, -1);
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);

 	nr_err = 0;
 	for (i = 0; i < bufsz; i++) {
@@ -192,14 +191,15 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(tst_rmdir);

 	TEST_PAUSE;
 }

 static void cleanup(void)
 {
-	clean_sem(semid);
+	tst_rmdir();
 }

 static void help(void)
-- 
1.8.3.1

