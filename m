From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 30 Dec 2017 15:17:02 +0100
Subject: [LTP] [PATCH] syscalls/cma: write also null term. byte to address
	pipe
Message-ID: <206532ed86be182f1b5745c6930f21847f40183a.1514643260.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Problem is that first child doesn't write null term. byte
and other child doesn't initialise buffer it reads into,
so occasionally there's garbage that makes address longer
and therefore invalid and test fails:
 process_vm_readv02    0  TINFO  :  child 1: reading string from same memory location.
 process_vm_readv02    1  TFAIL  :  process_vm_readv02.c:143: process_vm_readv: errno=EFAULT(14): Bad address
 process_vm_readv02    0  TINFO  :  child 0: memory allocated and initialized.
 process_vm_readv02    1  TFAIL  :  process_vm_readv02.c:86: child 1 returns 256

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/cma/process_vm_readv02.c  | 2 +-
 testcases/kernel/syscalls/cma/process_vm_readv03.c  | 2 +-
 testcases/kernel/syscalls/cma/process_vm_writev02.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index aa81f17f7bd2..ef9b7e137d13 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -107,7 +107,7 @@ static void child_alloc(void)
 	/* passing addr of string "foo" via pipe */
 	SAFE_CLOSE(tst_exit, pipe_fd[0]);
 	snprintf(buf, BUFSIZ, "%p", foo);
-	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf));
+	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf) + 1);
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_invoke is done reading from our VM */
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index d1ca87a14b4d..8b8dfc316193 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -152,7 +152,7 @@ static void child_alloc(int *bufsz_arr)
 	/* passing addr via pipe */
 	SAFE_CLOSE(tst_exit, pipe_fd[0]);
 	snprintf(buf, BUFSIZ, "%p", (void *)foo);
-	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf));
+	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf) + 1);
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_invoke is done reading from our VM */
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 544bda8d5361..b707760b1884 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -121,7 +121,7 @@ static void child_init_and_verify(void)
 	/* passing addr of string "foo" via pipe */
 	SAFE_CLOSE(tst_exit, pipe_fd[0]);
 	snprintf(buf, bufsz, "%p", foo);
-	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf));
+	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf) + 1);
 	SAFE_CLOSE(tst_exit, pipe_fd[1]);
 
 	/* wait until child_write() is done writing to our VM */
-- 
1.8.3.1

