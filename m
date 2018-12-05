From: Jason Xing <kerneljasonxing@linux.alibaba.com>
Date: Wed,  5 Dec 2018 21:43:45 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/cma: test case should return TCONF if
	syscall doesn't exist
In-Reply-To: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
References: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
Message-ID: <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original code returns TFAIL when process_vm_readv/_writev syscalls
do not exist, while we are expecting a TCONF. During investigation, we
find it is due to '#if defined(__NR_process_vm_readv/_writev)' fails to
work as expected.  We fix this issue by using ltp_syscall() function in
setup function. BTW, we don't use new tst_syscall() interface due to
compatibility issue exists between old apis and new ones.

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
Signed-off-by: Caspar Zhang <caspar@linux.alibaba.com>
---
 testcases/kernel/syscalls/cma/process_vm.h         | 62 ----------------------
 testcases/kernel/syscalls/cma/process_vm01.c       | 30 ++++-------
 testcases/kernel/syscalls/cma/process_vm_readv02.c | 12 ++---
 testcases/kernel/syscalls/cma/process_vm_readv03.c | 14 ++---
 .../kernel/syscalls/cma/process_vm_writev02.c      | 12 ++---
 5 files changed, 30 insertions(+), 100 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/cma/process_vm.h

diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
deleted file mode 100644
index 1ecf325..0000000
--- a/testcases/kernel/syscalls/cma/process_vm.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (C) 2012 Linux Test Project, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef _PROCESS_VM_H_
-#define _PROCESS_VM_H_
-
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/sem.h>
-#include <sys/syscall.h>
-#include <sys/uio.h>
-#include <unistd.h>
-#include "lapi/semun.h"
-
-static inline ssize_t test_process_vm_readv(pid_t pid,
-		const struct iovec *lvec, unsigned long liovcnt,
-		const struct iovec *rvec, unsigned long riovcnt,
-		unsigned long flags)
-{
-#if defined(__NR_process_vm_readv)
-	return syscall(__NR_process_vm_readv, pid, lvec, liovcnt,
-			rvec, riovcnt, flags);
-#else
-	return syscall(-1);
-#endif
-}
-
-static inline ssize_t test_process_vm_writev(pid_t pid,
-		const struct iovec *lvec, unsigned long liovcnt,
-		const struct iovec *rvec, unsigned long riovcnt,
-		unsigned long flags)
-{
-#if defined(__NR_process_vm_writev)
-	return syscall(__NR_process_vm_writev, pid, lvec, liovcnt,
-			rvec, riovcnt, flags);
-#else
-	return syscall(-1);
-#endif
-}
-
-#endif /* _PROCESS_VM_H_ */
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index bc6b04f..f9bd865 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -42,7 +42,7 @@
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
-#include "process_vm.h"
+#include "lapi/syscalls.h"
 
 struct process_vm_params {
 	int len;
@@ -103,20 +103,10 @@ static void setup(char *argv[])
 			 " at the same time.");
 	else if (rflag) {
 		TCID = TCID_readv;
-#if defined(__NR_process_vm_readv)
 		cma_test_params = cma_test_params_read;
-#else
-		tst_brkm(TCONF, NULL, "process_vm_readv does not"
-			 " exist on your system.");
-#endif
 	} else if (wflag) {
 		TCID = TCID_writev;
-#if defined(__NR_process_vm_writev)
 		cma_test_params = cma_test_params_write;
-#else
-		tst_brkm(TCONF, NULL, "process_vm_writev does not"
-			 " exist on your system.");
-#endif
 	} else
 		tst_brkm(TBROK, NULL, "Parameter missing, required -r or -w.");
 	TEST_PAUSE;
@@ -134,18 +124,20 @@ static void help(void)
 
 static void cma_test_params_read(struct process_vm_params *params)
 {
-	TEST(test_process_vm_readv(params->pid,
-				   params->lvec, params->liovcnt,
-				   params->rvec, params->riovcnt,
-				   params->flags));
+	TEST(ltp_syscall(__NR_process_vm_readv,
+			 params->pid,
+			 params->lvec, params->liovcnt,
+			 params->rvec, params->riovcnt,
+			 params->flags));
 }
 
 static void cma_test_params_write(struct process_vm_params *params)
 {
-	TEST(test_process_vm_writev(params->pid,
-				    params->lvec, params->liovcnt,
-				    params->rvec, params->riovcnt,
-				    params->flags));
+	TEST(ltp_syscall(__NR_process_vm_writev,
+			 params->pid,
+			 params->lvec, params->liovcnt,
+			 params->rvec, params->riovcnt,
+			 params->flags));
 }
 
 static int cma_check_ret(long expected_ret, long act_ret)
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index ef9b7e1..e1fc32a 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -29,7 +29,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-#include "process_vm.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "process_vm_readv02";
 int TST_TOTAL = 1;
@@ -134,7 +134,8 @@ static void child_invoke(void)
 	remote.iov_len = len;
 
 	tst_resm(TINFO, "child 1: reading string from same memory location.");
-	TEST(test_process_vm_readv(pids[0], &local, 1, &remote, 1, 0));
+	TEST(ltp_syscall(__NR_process_vm_readv, pids[0],
+			 &local, 1, &remote, 1, 0));
 	if (TEST_RETURN != len)
 		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
 	if (strncmp(lp, tst_string, len) != 0)
@@ -148,10 +149,9 @@ static void setup(void)
 {
 	tst_require_root();
 
-#if !defined(__NR_process_vm_readv)
-	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
-		 "on your system");
-#endif
+	/* Just a sanity check of the existence of syscall */
+	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0, NULL, 0, 0);
+
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(cleanup);
 
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 8b8dfc3..45f7c92 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -32,7 +32,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-#include "process_vm.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "process_vm_readv03";
 int TST_TOTAL = 1;
@@ -180,7 +180,8 @@ static long *fetch_remote_addrs(void)
 	remote.iov_base = foo;
 	remote.iov_len = len;
 
-	TEST(test_process_vm_readv(pids[0], &local, 1, &remote, 1, 0));
+	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &local,
+			 1, &remote, 1, 0));
 	if (TEST_RETURN != len)
 		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
 
@@ -212,7 +213,7 @@ static void child_invoke(int *bufsz_arr)
 	tst_resm(TINFO, "child 1: %d local iovecs initialized.",
 		 NUM_LOCAL_VECS);
 
-	TEST(test_process_vm_readv(pids[0], local, NUM_LOCAL_VECS,
+	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local, NUM_LOCAL_VECS,
 				   remote, nr_iovecs, 0));
 	if (TEST_RETURN != bufsz)
 		tst_brkm(TBROK | TERRNO, tst_exit, "process_vm_readv");
@@ -246,14 +247,13 @@ static void setup(void)
 {
 	tst_require_root();
 
+	/* Just a sanity check of the existence of syscall */
+	ltp_syscall(__NR_process_vm_readv, getpid(), NULL, 0, NULL, 0, 0);
+
 	nr_iovecs = nflag ? SAFE_STRTOL(NULL, nr_opt, 1, IOV_MAX) : 10;
 	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, NUM_LOCAL_VECS, LONG_MAX)
 	    : 100000;
 
-#if !defined(__NR_process_vm_readv)
-	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
-		 "on your system");
-#endif
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(cleanup);
 	srand(time(NULL));
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index b707760..b1edba5 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -30,7 +30,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-#include "process_vm.h"
+#include "lapi/syscalls.h"
 
 char *TCID = "process_vm_writev02";
 int TST_TOTAL = 1;
@@ -171,7 +171,8 @@ static void child_write(void)
 	remote.iov_len = bufsz;
 
 	tst_resm(TINFO, "child 2: write to the same memory location.");
-	TEST(test_process_vm_writev(pids[0], &local, 1, &remote, 1, 0));
+	TEST(ltp_syscall(__NR_process_vm_writev, pids[0], &local,
+			 1, &remote, 1, 0));
 	if (TEST_RETURN != bufsz)
 		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
 }
@@ -180,14 +181,13 @@ static void setup(void)
 {
 	tst_require_root();
 
+	/* Just a sanity check of the existence of syscall */
+	ltp_syscall(__NR_process_vm_writev, getpid(), NULL, 0, NULL, 0, 0);
+
 	bufsz =
 	    sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX - PADDING_SIZE * 2)
 	    : 100000;
 
-#if !defined(__NR_process_vm_readv)
-	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
-		 "on your system");
-#endif
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(cleanup);
 
-- 
1.8.3.1

