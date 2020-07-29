From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jul 2020 13:25:51 +0530
Subject: [LTP] [PATCH V8 3/5] syscalls: semop: Merge semop0[234].c files
In-Reply-To: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
References: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
Message-ID: <56d89f2356cf51135c3b6d9219745cbe3868dec8.1596008484.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All these can be handled together in semop02.c easily.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                               |  2 -
 runtest/syscalls-ipc                           |  2 -
 testcases/kernel/syscalls/ipc/semop/.gitignore |  2 -
 testcases/kernel/syscalls/ipc/semop/semop02.c  | 47 ++++++++++-----
 testcases/kernel/syscalls/ipc/semop/semop03.c  | 67 ---------------------
 testcases/kernel/syscalls/ipc/semop/semop04.c  | 80 --------------------------
 6 files changed, 34 insertions(+), 166 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/semop/semop03.c
 delete mode 100644 testcases/kernel/syscalls/ipc/semop/semop04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 70b3277d38ea..99831f6aa36e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1169,8 +1169,6 @@ semget06 semget06
 
 semop01 semop01
 semop02 semop02
-semop03 semop03
-semop04 semop04
 semop05 semop05
 
 send01 send01
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index c3a35896c5a8..1a63071b22cf 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -44,8 +44,6 @@ semget06 semget06
 
 semop01 semop01
 semop02 semop02
-semop03 semop03
-semop04 semop04
 semop05 semop05
 
 shmat01 shmat01
diff --git a/testcases/kernel/syscalls/ipc/semop/.gitignore b/testcases/kernel/syscalls/ipc/semop/.gitignore
index cc67b1862f41..35b7af66c465 100644
--- a/testcases/kernel/syscalls/ipc/semop/.gitignore
+++ b/testcases/kernel/syscalls/ipc/semop/.gitignore
@@ -1,5 +1,3 @@
 /semop01
 /semop02
-/semop03
-/semop04
 /semop05
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 66b0bef56257..7a49b2648b2b 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -18,24 +18,37 @@
 static int sem_id_1 = -1;	/* a semaphore set with read & alter permissions */
 static int sem_id_2 = -1;	/* a semaphore set without read & alter permissions */
 static int bad_id = -1;
+static short sem_op_dyn, sem_op_1 = 1, sem_op_negative = -1, sem_op_zero = 0;
 static key_t semkey;
 static struct sembuf s_buf[PSEMS];
+static struct sembuf *faulty_buf;
+static struct sembuf *valid_buf = s_buf;
+static union semun arr;
 
 #define NSOPS	5		/* a reasonable number of operations */
 #define	BIGOPS	1024		/* a value that is too large for the number */
 				/* of semop operations that are permitted */
 static struct test_case_t {
 	int *semid;
-	struct sembuf *t_sbuf;
+	struct sembuf **buf;
+	short *sem_op; /* semaphore operation */
+	unsigned short ctl_sem_num;
+	unsigned short sem_num; /* semaphore index in array */
+	short sem_flg; /* operation flags */
 	unsigned t_ops;
+	int arr_val;
 	int error;
 } tc[] = {
-	{&sem_id_1, s_buf, BIGOPS, E2BIG},
-	{&sem_id_2, s_buf, NSOPS, EACCES},
-	{&sem_id_1, (struct sembuf *)-1, NSOPS, EFAULT},
-	{&sem_id_1, s_buf, 0, EINVAL},
-	{&bad_id, s_buf, NSOPS, EINVAL},
-	{&sem_id_1, s_buf, 1, ERANGE}
+	{&sem_id_1, &valid_buf, &sem_op_dyn, 0, 0, 0, BIGOPS, 1, E2BIG},
+	{&sem_id_2, &valid_buf, &sem_op_dyn, 0, 0, 0, NSOPS, 1, EACCES},
+	{&sem_id_1, &faulty_buf, &sem_op_dyn, 0, 0, 0, NSOPS, 1, EFAULT},
+	{&sem_id_1, &valid_buf, &sem_op_dyn, 0, 0, 0, 0, 1, EINVAL},
+	{&bad_id, &valid_buf, &sem_op_dyn, 0, 0, 0, NSOPS, 1, EINVAL},
+	{&sem_id_1, &valid_buf, &sem_op_dyn, 0, 0, 0, 1, 1, ERANGE},
+	{&sem_id_1, &valid_buf, &sem_op_1, 0, -1, SEM_UNDO, 1, 1, EFBIG},
+	{&sem_id_1, &valid_buf, &sem_op_1, 0, PSEMS + 1, SEM_UNDO, 1, 1, EFBIG},
+	{&sem_id_1, &valid_buf, &sem_op_zero, 2, 2, IPC_NOWAIT, 1, 1, EAGAIN},
+	{&sem_id_1, &valid_buf, &sem_op_negative, 2, 2, IPC_NOWAIT, 1, 0, EAGAIN}
 };
 
 static void setup(void)
@@ -44,7 +57,6 @@ static void setup(void)
 	struct passwd *ltpuser;
 	key_t semkey2;
 	struct seminfo ipc_buf;
-	union semun arr;
 
 	ltpuser = SAFE_GETPWNAM(nobody_uid);
 	SAFE_SETUID(ltpuser->pw_uid);
@@ -65,15 +77,24 @@ static void setup(void)
 	if (semctl(sem_id_1, 0, IPC_INFO, arr) == -1)
 		tst_brk(TBROK | TERRNO, "semctl() IPC_INFO failed");
 
-	arr.val = 1;
-	s_buf[0].sem_op = ipc_buf.semvmx;
-	if (semctl(sem_id_1, 0, SETVAL, arr) == -1)
-		tst_brk(TBROK | TERRNO, "semctl() SETVAL failed");
+	sem_op_dyn = ipc_buf.semvmx;
+	faulty_buf = tst_get_bad_addr(NULL);
 }
 
 static void run(unsigned int i)
 {
-	TEST(semop(*(tc[i].semid), tc[i].t_sbuf, tc[i].t_ops));
+	if (*tc[i].buf != faulty_buf) {
+		arr.val = tc[i].arr_val;
+
+		if (semctl(sem_id_1, tc[i].ctl_sem_num, SETVAL, arr) == -1)
+			tst_brk(TBROK | TERRNO, "semctl() SETVAL failed");
+
+		s_buf[0].sem_op = *tc[i].sem_op;
+		s_buf[0].sem_flg = tc[i].sem_flg;
+		s_buf[0].sem_num = tc[i].sem_num;
+	}
+
+	TEST(semop(*(tc[i].semid), *tc[i].buf, tc[i].t_ops));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
deleted file mode 100644
index c569033eebc2..000000000000
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * semop03 - test for EFBIG error
- *
- * Copyright (c) International Business Machines  Corp., 2001
- *	03/2001 - Written by Wayne Boyer
- */
-
-#include <sys/sem.h>
-#include "tst_test.h"
-#include "libnewipc.h"
-#include "lapi/semun.h"
-
-static key_t semkey;
-static int sem_id = -1;
-static struct sembuf s_buf;
-
-static int tc[] = { -1, PSEMS + 1 }; /* negative and too many "primitive" semas */
-
-static void run(unsigned int i)
-{
-	s_buf.sem_op = 1;
-	s_buf.sem_flg = SEM_UNDO;
-	s_buf.sem_num = tc[i];
-
-	TEST(semop(sem_id, &s_buf, 1));
-	if (TST_RET != -1) {
-		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
-		return;
-	}
-
-	switch (TST_ERR) {
-	case EFBIG:
-		tst_res(TPASS | TTERRNO, "expected failure");
-		break;
-	default:
-		tst_res(TFAIL | TTERRNO, "unexpected failure");
-		break;
-	}
-}
-
-static void setup(void)
-{
-	semkey = GETIPCKEY();
-
-	if ((sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) ==
-	    -1)
-		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
-}
-
-static void cleanup(void)
-{
-	union semun arr;
-
-	if (sem_id != -1) {
-		if (semctl(sem_id, 0, IPC_RMID, arr) == -1)
-			tst_res(TINFO, "WARNING: semaphore deletion failed.");
-	}
-}
-
-static struct tst_test test = {
-	.test = run,
-	.tcnt = ARRAY_SIZE(tc),
-	.setup = setup,
-	.cleanup = cleanup,
-	.needs_tmpdir = 1,
-};
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
deleted file mode 100644
index 1904b177f71b..000000000000
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * semop04 - test for EAGAIN error
- *
- * Copyright (c) International Business Machines  Corp., 2001
- *	03/2001 - Written by Wayne Boyer
- */
-
-#include <sys/sem.h>
-#include "tst_test.h"
-#include "libnewipc.h"
-#include "lapi/semun.h"
-
-static int sem_id = -1;
-static int val;
-
-static key_t semkey;
-static struct sembuf s_buf;
-
-static struct test_case_t {
-	union semun get_arr;
-	short op;
-	short flg;
-	short num;
-	int error;
-} tc[] = {
-	{{1}, 0, IPC_NOWAIT, 2, EAGAIN},
-	{{0}, -1, IPC_NOWAIT, 2, EAGAIN}
-};
-
-static void run(unsigned int i)
-{
-	s_buf.sem_op = tc[i].op;
-	s_buf.sem_flg = tc[i].flg;
-	s_buf.sem_num = tc[i].num;
-
-	tc[i].get_arr.val = val--;
-	if (semctl(sem_id, tc[i].num, SETVAL, tc[i].get_arr) == -1)
-		tst_brk(TBROK | TERRNO, "semctl() failed");
-
-	TEST(semop(sem_id, &s_buf, 1));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "call succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == tc[i].error)
-		tst_res(TPASS | TTERRNO, "expected failure");
-	else
-		tst_res(TFAIL | TTERRNO, "unexpected failure");
-}
-
-static void setup(void)
-{
-	val = 1;
-	semkey = GETIPCKEY();
-
-	if ((sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) ==
-	     -1) {
-		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
-	}
-}
-
-static void cleanup(void)
-{
-	union semun arr;
-
-	if (sem_id != -1) {
-		if (semctl(sem_id, 0, IPC_RMID, arr) == -1)
-			tst_res(TINFO, "WARNING: semaphore deletion failed.");
-	}
-}
-
-static struct tst_test test = {
-	.test = run,
-	.tcnt = ARRAY_SIZE(tc),
-	.setup = setup,
-	.cleanup = cleanup,
-	.needs_tmpdir = 1,
-};
-- 
2.14.1

