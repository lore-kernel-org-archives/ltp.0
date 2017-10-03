From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:39 +0200
Subject: [LTP] [COMMITTED] [PATCH 06/40] Make use of SAFE_PIPE()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/containers/sysvipc/shmem_2nstest.c | 7 +++----
 testcases/kernel/syscalls/close/close01.c           | 5 ++---
 testcases/kernel/syscalls/cma/process_vm_readv02.c  | 3 +--
 testcases/kernel/syscalls/cma/process_vm_readv03.c  | 3 +--
 testcases/kernel/syscalls/cma/process_vm_writev02.c | 3 +--
 testcases/kernel/syscalls/dup/dup04.c               | 3 +--
 testcases/kernel/syscalls/dup2/dup204.c             | 3 +--
 testcases/kernel/syscalls/fsync/fsync03.c           | 5 ++---
 testcases/kernel/syscalls/pipe/pipe04.c             | 5 ++---
 testcases/kernel/syscalls/pread/pread02.c           | 5 +----
 testcases/kernel/syscalls/select/select02.c         | 5 ++---
 testcases/kernel/syscalls/setrlimit/setrlimit01.c   | 4 ++--
 12 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index 49fe19b6f..b172ee07c 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -45,6 +45,7 @@
 #include <sys/shm.h>
 #include <libclone.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "ipcns_helper.h"
 
 #define TESTKEY    124426L
@@ -132,10 +133,8 @@ int main(int argc, char *argv[])
 	}
 
 	/* Using PIPE's to sync between containers and Parent */
-	if (pipe(p1) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "pipe1 error");
-	if (pipe(p2) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "pipe2 error");
+	SAFE_PIPE(NULL, p1);
+	SAFE_PIPE(NULL, p2);
 
 	if (strcmp(argv[1], "clone") == 0) {
 		use_clone = T_CLONE;
diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index 7b119ce44..c734ff7d2 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -27,6 +27,7 @@
 #include <fcntl.h>
 #include <sys/stat.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void cleanup(void);
 void setup(void);
@@ -72,9 +73,7 @@ int main(int ac, char **av)
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "can't dup the file des");
 
-		if (pipe(pipefildes) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup, "can't open pipe");
-		}
+		SAFE_PIPE(cleanup, pipefildes);
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index b7dd9b2e5..6bbfb62b0 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -56,8 +56,7 @@ int main(int argc, char **argv)
 		tst_count = 0;
 		len = strlen(tst_string);
 
-		if (pipe(pipe_fd) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "pipe");
+		SAFE_PIPE(cleanup, pipe_fd);
 
 		/* the start of child_alloc and child_invoke is already
 		 * synchronized via pipe */
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 17f0a5dcc..07a72d97d 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -72,8 +72,7 @@ int main(int argc, char **argv)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		if (pipe(pipe_fd) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "pipe");
+		SAFE_PIPE(cleanup, pipe_fd);
 
 		bufsz_arr = SAFE_MALLOC(cleanup, nr_iovecs * sizeof(int));
 		gen_random_arr(bufsz_arr, nr_iovecs);
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 04cf6d149..c681f9f8b 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -66,8 +66,7 @@ int main(int argc, char **argv)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		if (pipe(pipe_fd) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "pipe");
+		SAFE_PIPE(cleanup, pipe_fd);
 
 		/* the start of child_init_and_verify and child_write is
 		 * already synchronized via pipe */
diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index 4abe451c1..1414b2a9e 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -184,8 +184,7 @@ void setup(void)
 
 	tst_tmpdir();
 
-	if (pipe(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
+	SAFE_PIPE(cleanup, fd);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index ab8de5d08..634bde8f2 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -116,8 +116,7 @@ void setup(void)
 
 	tst_tmpdir();
 
-	if (pipe(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
+	SAFE_PIPE(cleanup, fd);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index 87c4e5ab4..60d15f429 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -47,6 +47,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup(void);
 void cleanup(void);
@@ -122,9 +123,7 @@ void setup(void)
 	/* make a temporary directory and cd to it */
 	tst_tmpdir();
 
-	if (pipe(fd) < 0) {
-		tst_brkm(TBROK, cleanup, "pipe call failed");
-	}
+	SAFE_PIPE(cleanup, fd);
 
 	pfd = fd[1];
 }
diff --git a/testcases/kernel/syscalls/pipe/pipe04.c b/testcases/kernel/syscalls/pipe/pipe04.c
index dc3deade8..b3d255b33 100644
--- a/testcases/kernel/syscalls/pipe/pipe04.c
+++ b/testcases/kernel/syscalls/pipe/pipe04.c
@@ -49,6 +49,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "pipe04";
 int TST_TOTAL = 1;
@@ -95,9 +96,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if (pipe(fildes) == -1)
-			tst_brkm(TBROK, cleanup, "pipe() failed - errno %d",
-				 errno);
+		SAFE_PIPE(cleanup, fildes);
 
 		if ((c1pid = FORK_OR_VFORK()) == -1)
 			tst_brkm(TBROK, cleanup, "fork() failed - "
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index d2da21f6c..aa194f607 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -212,10 +212,7 @@ int no_setup(void)
 int setup1(void)
 {
 	/* Create a pair of unnamed pipe */
-	if (pipe(pfd) < 0) {
-		tst_brkm(TBROK, cleanup, "pipe() failed to create pair of "
-			 "pipe, error:%d", errno);
-	}
+	SAFE_PIPE(cleanup, pfd);
 
 	/* Write known data (0's) of K1 bytes */
 	if (write(pfd[1], write_buf[0], K1) != K1) {
diff --git a/testcases/kernel/syscalls/select/select02.c b/testcases/kernel/syscalls/select/select02.c
index 3c9742777..7aa0107c0 100644
--- a/testcases/kernel/syscalls/select/select02.c
+++ b/testcases/kernel/syscalls/select/select02.c
@@ -47,6 +47,7 @@
 #include <sys/time.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 static void setup(void);
 
@@ -104,9 +105,7 @@ static void setup(void)
 
 	TEST_PAUSE;
 
-	if (pipe(Fd) == -1) {
-		tst_brkm(TBROK, NULL, "pipe(&Fd) failed, errno=%d", errno);
-	}
+	SAFE_PIPE(NULL, Fd);
 
 	FD_ZERO(&saved_Readfds);
 	FD_ZERO(&saved_Writefds);
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index d0eb1b9d4..3118782f3 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -36,6 +36,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "setrlimit01";
 int TST_TOTAL = 1;
@@ -124,8 +125,7 @@ static void test2(void)
 	 */
 	int pipefd[2];
 	fflush(stdout);
-	if (pipe(pipefd) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "pipe creation failed");
+	SAFE_PIPE(NULL, pipefd);
 
 	/*
 	 * Spawn a child process, and reduce the filesize to
-- 
2.13.5

