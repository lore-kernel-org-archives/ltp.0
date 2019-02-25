From: Jason Xing <kerneljasonxing@linux.alibaba.com>
Date: Mon, 25 Feb 2019 16:22:25 +0800
Subject: [LTP] [PATCH] syscalls/cma: fix the failure of compiling with O2
	option
In-Reply-To: <20190223062135.GB49700@linux.alibaba.com>
References: <20190223062135.GB49700@linux.alibaba.com>
Message-ID: <1551082945-75385-1-git-send-email-kerneljasonxing@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This issue is triggered by the commit 9b02cd465f70 which I wrote. If
compile the process_vm_readv03.c with O2 option and run, it will return
TFAIL. By casting the int type to long type in the ltp_syscall calling
functions can we avoid this failure.

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
---
 testcases/kernel/syscalls/cma/process_vm_readv03.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 45f7c92..e15ffee 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -181,7 +181,7 @@ static long *fetch_remote_addrs(void)
 	remote.iov_len = len;
 
 	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &local,
-			 1, &remote, 1, 0));
+			 1L, &remote, 1L, 0L));
 	if (TEST_RETURN != len)
 		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
 
@@ -213,8 +213,8 @@ static void child_invoke(int *bufsz_arr)
 	tst_resm(TINFO, "child 1: %d local iovecs initialized.",
 		 NUM_LOCAL_VECS);
 
-	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local, NUM_LOCAL_VECS,
-				   remote, nr_iovecs, 0));
+	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local, (long)NUM_LOCAL_VECS,
+				   remote, (long)nr_iovecs, 0L));
 	if (TEST_RETURN != bufsz)
 		tst_brkm(TBROK | TERRNO, tst_exit, "process_vm_readv");
 
@@ -248,7 +248,7 @@ static void setup(void)
 	tst_require_root();
 
 	/* Just a sanity check of the existence of syscall */
-	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0, NULL, 0, 0);
+	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0L, NULL, 0L, 0L);
 
 	nr_iovecs = nflag ? SAFE_STRTOL(NULL, nr_opt, 1, IOV_MAX) : 10;
 	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, NUM_LOCAL_VECS, LONG_MAX)
-- 
1.8.3.1

