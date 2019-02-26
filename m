From: Jason Xing <kerneljasonxing@linux.alibaba.com>
Date: Tue, 26 Feb 2019 10:22:40 +0800
Subject: [LTP] [PATCH v3] syscalls/cma: fix the failure of compiling with O2
	option
In-Reply-To: <1551145346-34128-1-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <1551145346-34128-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Message-ID: <1551147760-52601-1-git-send-email-kerneljasonxing@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This issue is triggered by the commit 9b02cd465f70 which I wrote. If
compile the process_vm_readv03.c with O2 option and run, it will return
TFAIL. By casting the int type to unsigned long type in the ltp_syscall
calling functions can we avoid this failure. Thus I modify all the
testcases which might be affected by the previous commit.

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
---
 testcases/kernel/syscalls/cma/process_vm_readv02.c  | 4 ++--
 testcases/kernel/syscalls/cma/process_vm_readv03.c  | 9 +++++----
 testcases/kernel/syscalls/cma/process_vm_writev02.c | 4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index e1fc32a..68e1bea 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -135,7 +135,7 @@ static void child_invoke(void)
 
 	tst_resm(TINFO, "child 1: reading string from same memory location.");
 	TEST(ltp_syscall(__NR_process_vm_readv, pids[0],
-			 &local, 1, &remote, 1, 0));
+			 &local, 1UL, &remote, 1UL, 0UL));
 	if (TEST_RETURN != len)
 		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
 	if (strncmp(lp, tst_string, len) != 0)
@@ -150,7 +150,7 @@ static void setup(void)
 	tst_require_root();
 
 	/* Just a sanity check of the existence of syscall */
-	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0, NULL, 0, 0);
+	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(cleanup);
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 45f7c92..f09dfb0 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -181,7 +181,7 @@ static long *fetch_remote_addrs(void)
 	remote.iov_len = len;
 
 	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &local,
-			 1, &remote, 1, 0));
+			 1UL, &remote, 1UL, 0UL));
 	if (TEST_RETURN != len)
 		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
 
@@ -213,8 +213,9 @@ static void child_invoke(int *bufsz_arr)
 	tst_resm(TINFO, "child 1: %d local iovecs initialized.",
 		 NUM_LOCAL_VECS);
 
-	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local, NUM_LOCAL_VECS,
-				   remote, nr_iovecs, 0));
+	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local,
+			    (unsigned long)NUM_LOCAL_VECS, remote,
+			    (unsigned long)nr_iovecs, 0UL));
 	if (TEST_RETURN != bufsz)
 		tst_brkm(TBROK | TERRNO, tst_exit, "process_vm_readv");
 
@@ -248,7 +249,7 @@ static void setup(void)
 	tst_require_root();
 
 	/* Just a sanity check of the existence of syscall */
-	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0, NULL, 0, 0);
+	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
 	nr_iovecs = nflag ? SAFE_STRTOL(NULL, nr_opt, 1, IOV_MAX) : 10;
 	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, NUM_LOCAL_VECS, LONG_MAX)
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index b1edba5..2e7a8d6 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -172,7 +172,7 @@ static void child_write(void)
 
 	tst_resm(TINFO, "child 2: write to the same memory location.");
 	TEST(ltp_syscall(__NR_process_vm_writev, pids[0], &local,
-			 1, &remote, 1, 0));
+			 1UL, &remote, 1UL, 0UL));
 	if (TEST_RETURN != bufsz)
 		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
 }
@@ -182,7 +182,7 @@ static void setup(void)
 	tst_require_root();
 
 	/* Just a sanity check of the existence of syscall */
-	ltp_syscall(__NR_process_vm_writev, getpid(), NULL, 0, NULL, 0, 0);
+	ltp_syscall(__NR_process_vm_writev, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
 
 	bufsz =
 	    sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX - PADDING_SIZE * 2)
-- 
1.8.3.1

