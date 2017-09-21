From: Sandeep Patil <sspatil@google.com>
Date: Thu, 21 Sep 2017 14:57:55 -0700
Subject: [LTP] [PATCH] syscalls/cma: Make process_vm_{readv,
	writev} tests bionic friendly
Message-ID: <20170921215755.85005-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All testcases under testcases/kernel/syscalls/cma depend on SysV
semaphore to do event notification from parent<->child processes.
Since bionic / android doesn't have SysV IPC, the tests cant be built
against bionic.

Fix this by keeping the old behavior for non bionic builds and switch to
using eventfd(EFD_SEMAPHORE) when building against bionic. This fixes
following tests for Android

   process_vm01, process_vm_readv0[23], process_vm_writev02

This means the tests can now test *all* Android kernels from now on as
EFD_SEMAPHORE support has been available in kernel since 2.6.30

Signed-off-by: Sandeep Patil <sspatil@google.com>
---

FYI, both bionic and glibc builds were tested to make sure the tests
continue to work with either of them.

 testcases/kernel/syscalls/cma/process_vm.h         | 110 ++++++++++++++++-----
 testcases/kernel/syscalls/cma/process_vm_readv02.c |   8 +-
 testcases/kernel/syscalls/cma/process_vm_readv03.c |   8 +-
 .../kernel/syscalls/cma/process_vm_writev02.c      |   8 +-
 4 files changed, 100 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
index 7df9aacd0..c371f1a3d 100644
--- a/testcases/kernel/syscalls/cma/process_vm.h
+++ b/testcases/kernel/syscalls/cma/process_vm.h
@@ -26,12 +26,16 @@
 #define _PROCESS_VM_H_
 
 #include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/sem.h>
 #include <sys/syscall.h>
 #include <sys/uio.h>
-#include <unistd.h>
+#ifdef __BIONIC__
+#include <sys/eventfd.h>
+#else
+#include <sys/ipc.h>
+#include <sys/sem.h>
 #include "lapi/semun.h"
+#endif /* __BIONIC__  */
+#include <unistd.h>
 
 static inline ssize_t test_process_vm_readv(pid_t pid,
 		const struct iovec *lvec, unsigned long liovcnt,
@@ -59,7 +63,55 @@ static inline ssize_t test_process_vm_writev(pid_t pid,
 #endif
 }
 
-void safe_semop(int id, unsigned short num, short op)
+#ifdef __BIONIC__
+
+/* not defined by default .. */
+#ifndef EFD_SEMAPHORE
+#define EFD_SEMAPHORE 	(1 << 0)
+#endif
+
+static int init_sem(int initval)
+{
+	uint64_t val = initval < 0 ? 0 : (uint64_t)initval;
+	int semid;
+
+	do {
+		semid = eventfd(val, EFD_CLOEXEC | EFD_SEMAPHORE);
+	} while (semid == -1 && errno == EINTR);
+	if (semid < 0)
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "Couldn't initialize eventfd semaphore");
+	return semid;
+}
+
+static void destroy_sem(int semid)
+{
+	close(semid);
+}
+
+static int sem_post_op(int semid, int val)
+{
+	uint64_t eventfd_val;
+
+	if (val < 0)
+		tst_brkm(TBROK, NULL, "Invalid sempost value %d", val);
+
+	eventfd_val = val;
+	SAFE_WRITE(NULL, 1, semid, &eventfd_val, sizeof(eventfd_val));
+	return 0;
+}
+
+static int sem_wait_op(int semid)
+{
+	uint64_t val;
+
+	SAFE_READ(NULL, 1, semid, &val, sizeof(val));
+	return 0;
+}
+
+#else
+
+static void safe_semop(int semid, unsigned short num, short op)
 {
 	int ret;
 	struct sembuf sem_op;
@@ -68,33 +120,47 @@ void safe_semop(int id, unsigned short num, short op)
 	sem_op.sem_flg = 0;
 
 	do {
-		ret = semop(id, &sem_op, 1);
+		ret = semop(semid, &sem_op, 1);
 	} while (ret == -1 && errno == EINTR);
 	if (ret == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "semop(%d, (%d, %d)) failed",
-			id, num, op);
+		tst_brkm(TBROK | TERRNO, NULL, "semop(%d, (%d, %d)) failed",
+			 semid, num, op);
 }
 
-int init_sem(int num)
+static int init_sem(int initval)
 {
-	int id, i;
+	int semid;
 	union semun u;
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
+
+	semid = semget(IPC_PRIVATE, 1, IPC_CREAT | 0700);
+	if (semid == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "Couldn't allocate semaphore");
+
+	u.val = intval;
+	if (semctl(semid, 0, SETVAL, u) == -1)
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "Couldn't initialize sem %d value", semid);
+	return semid;
+}
+
+void destroy_sem(int semid)
+{
+	if (semctl(semid, 0, IPC_RMID) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "Couldn't remove sem");
 }
 
-void clean_sem(int id)
+static int sem_post_op(int semid, int val)
 {
-	if (semctl(id, 0, IPC_RMID) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "Couldn't remove sem");
+	if (val <= 0 || val >= SHRT_MAX)
+		tst_brkm(TBROK, NULL, "Invalid sempost value %d", val);
+	return safe_sameop(semid, 0, (short)val);
 }
 
+static int sem_wait_op(int semid)
+{
+	return safe_sameop(semid, 0, -1);
+}
+
+#endif /* __BIONIC__ */
+
 #endif /* _PROCESS_VM_H_ */
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index b7dd9b2e5..e5b249b3b 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -86,7 +86,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* child_alloc is free to exit now */
-		safe_semop(semid, 0, 1);
+		sem_post_op(semid, 1);
 
 		if (waitpid(pids[0], &status, 0) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
@@ -115,7 +115,7 @@ static void child_alloc(void)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_invoke is done reading from our VM */
-	safe_semop(semid, 0, -1);
+	sem_wait_op(semid);
 }
 
 static void child_invoke(void)
@@ -156,12 +156,12 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	semid = init_sem(0);
 
 	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-	clean_sem(semid);
+	destroy_sem(semid);
 }
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 17f0a5dcc..33eaaa6d1 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -105,7 +105,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* child_alloc is free to exit now */
-		safe_semop(semid, 0, 1);
+		sem_post_op(semid, 1);
 
 		if (waitpid(pids[0], &status, 0) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
@@ -160,7 +160,7 @@ static void child_alloc(int *bufsz_arr)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_invoke is done reading from our VM */
-	safe_semop(semid, 0, -1);
+	sem_wait_op(semid);
 }
 
 static long *fetch_remote_addrs(void)
@@ -258,7 +258,7 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	semid = init_sem(0);
 	srand(time(NULL));
 
 	TEST_PAUSE;
@@ -266,7 +266,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	clean_sem(semid);
+	destroy_sem(semid);
 }
 
 static void help(void)
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 04cf6d149..d42737bac 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL, "child 1 returns %d", status);
 
 		/* signal child_init_and_verify to verify its VM now */
-		safe_semop(semid, 0, 1);
+		sem_post_op(semid, 1);
 
 		if (waitpid(pids[0], &status, 0) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
@@ -129,7 +129,7 @@ static void child_init_and_verify(void)
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_write() is done writing to our VM */
-	safe_semop(semid, 0, -1);
+	sem_wait_op(semid);
 
 	nr_err = 0;
 	for (i = 0; i < bufsz; i++) {
@@ -192,14 +192,14 @@ static void setup(void)
 	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
 		 "on your system");
 #endif
-	semid = init_sem(1);
+	semid = init_sem(0);
 
 	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-	clean_sem(semid);
+	destroy_sem(semid);
 }
 
 static void help(void)
-- 
2.14.1.821.g8fa685d3b7-goog

