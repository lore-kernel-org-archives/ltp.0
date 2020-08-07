From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Aug 2020 15:10:43 +0200
Subject: [LTP] [PATCH V8 4/5] syscalls: semop: Rename semop05.c
In-Reply-To: <aecc872dc379eb572e3d5ae9b6795c639abf33f0.1596008484.git.viresh.kumar@linaro.org>
References: <fab6e65d02767b60594916da89cca34221989229.1596008484.git.viresh.kumar@linaro.org>
 <aecc872dc379eb572e3d5ae9b6795c639abf33f0.1596008484.git.viresh.kumar@linaro.org>
Message-ID: <20200807131043.GA9851@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've merget all these changes into a single patch and added bunch of
cleanups on the top. My diff against your patchset follows. Thanks a lot
for the cleanups.

diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index 19607ee6d..2daf6bbc5 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -13,12 +13,13 @@
 #include "libnewipc.h"
 #include "lapi/semun.h"
 
-#define NSEMS	4		/* the number of primitive semaphores to test */
+#define NSEMS 4
 
-static int sem_id = -1;		/* a semaphore set with read & alter permissions */
+static int sem_id = -1;
 static key_t semkey;
 
-static union semun get_arr;
+static unsigned short int sarr[PSEMS];
+static union semun get_arr = {.array = sarr};
 static struct sembuf sops[PSEMS];
 
 static void run(void)
@@ -30,25 +31,26 @@ static void run(void)
 	TEST(semop(sem_id, sops, NSEMS));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "semop() failed");
-	} else {
-		if (semctl(sem_id, 0, GETALL, get_arr) == -1) {
-			tst_brk(TBROK | TERRNO, "semctl() failed in functional test");
-		}
+		return;
+	}
 
-		for (i = 0; i < NSEMS; i++) {
-			if (get_arr.array[i] != i * i) {
-				fail = 1;
-			}
+	if (semctl(sem_id, 0, GETALL, get_arr) == -1)
+		tst_brk(TBROK | TERRNO, "semctl(%i, 0, GETALL, ...)", sem_id);
+
+	for (i = 0; i < NSEMS; i++) {
+		if (get_arr.array[i] != i * i) {
+			fail = 1;
 		}
-		if (fail)
-			tst_res(TFAIL | TERRNO, "semaphore values are wrong");
-		else
-			tst_res(TPASS, "semaphore values are correct");
 	}
 
+	if (fail)
+		tst_res(TFAIL, "semaphore values are wrong");
+	else
+		tst_res(TPASS, "semaphore values are correct");
+
 	for (i = 0; i < NSEMS; i++) {
 		if (semctl(sem_id, i, SETVAL, arr) == -1)
-			tst_brk(TBROK | TERRNO, "semctl failed");
+			tst_brk(TBROK | TERRNO, "semctl(%i, %i, SETVAL, ...)", sem_id, i);
 	}
 }
 
@@ -56,10 +58,6 @@ static void setup(void)
 {
 	int i;
 
-	get_arr.array = malloc(sizeof(unsigned short int) * PSEMS);
-	if (get_arr.array == NULL)
-		tst_brk(TBROK, "malloc failed");
-
 	semkey = GETIPCKEY();
 
 	sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
@@ -75,13 +73,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	union semun arr;
-
 	if (sem_id != -1) {
-		if (semctl(sem_id, 0, IPC_RMID, arr) == -1)
-			tst_res(TINFO, "WARNING: semaphore deletion failed.");
+		if (semctl(sem_id, 0, IPC_RMID) == -1)
+			tst_res(TWARN, "semaphore deletion failed.");
 	}
-	free(get_arr.array);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index 7a49b2648..0dff8e537 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -1,6 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * semop02 - test for E2BIG, EACCES, EFAULT, EINVAL and ERANGE errors
+ * E2BIG   - nsops is greater than max number of operations allowed per syscall
+ * EACCESS - calling process does not have permission to alter semaphore
+ * EFAULT  - invalid address passed for sops
+ * EINVAL  - nonpositive nsops
+ * EINVAL  - negative semid
+ * ERANGE  - semop + semval > semvmx a maximal semaphore value
+ * EFBIG   - sem_num less than zero
+ * EFBIG   - sem_num > number of semaphores in a set
+ * EAGAIN  - semop = 0 for non-zero semaphore and IPC_NOWAIT passed in flags
+ * EAGAIN  - semop = -1 for zero semaphore and IPC_NOWAIT passed in flags
  *
  * Copyright (c) International Business Machines  Corp., 2001
  *	03/2001 - Written by Wayne Boyer
@@ -15,86 +24,87 @@
 #include "libnewipc.h"
 #include "lapi/semun.h"
 
-static int sem_id_1 = -1;	/* a semaphore set with read & alter permissions */
-static int sem_id_2 = -1;	/* a semaphore set without read & alter permissions */
-static int bad_id = -1;
-static short sem_op_dyn, sem_op_1 = 1, sem_op_negative = -1, sem_op_zero = 0;
-static key_t semkey;
-static struct sembuf s_buf[PSEMS];
+static int valid_sem_id = -1;
+static int noperm_sem_id = -1;
+static int bad_sem_id = -1;
+static short sem_op_max, sem_op_1 = 1, sem_op_negative = -1, sem_op_zero = 0;
 static struct sembuf *faulty_buf;
-static struct sembuf *valid_buf = s_buf;
-static union semun arr;
 
-#define NSOPS	5		/* a reasonable number of operations */
-#define	BIGOPS	1024		/* a value that is too large for the number */
-				/* of semop operations that are permitted */
+#define NSOPS	1
+#define	BIGOPS	1024
+
 static struct test_case_t {
 	int *semid;
 	struct sembuf **buf;
-	short *sem_op; /* semaphore operation */
+	short *sem_op;
 	unsigned short ctl_sem_num;
-	unsigned short sem_num; /* semaphore index in array */
-	short sem_flg; /* operation flags */
+	unsigned short sem_num;
+	short sem_flg;
 	unsigned t_ops;
 	int arr_val;
 	int error;
 } tc[] = {
-	{&sem_id_1, &valid_buf, &sem_op_dyn, 0, 0, 0, BIGOPS, 1, E2BIG},
-	{&sem_id_2, &valid_buf, &sem_op_dyn, 0, 0, 0, NSOPS, 1, EACCES},
-	{&sem_id_1, &faulty_buf, &sem_op_dyn, 0, 0, 0, NSOPS, 1, EFAULT},
-	{&sem_id_1, &valid_buf, &sem_op_dyn, 0, 0, 0, 0, 1, EINVAL},
-	{&bad_id, &valid_buf, &sem_op_dyn, 0, 0, 0, NSOPS, 1, EINVAL},
-	{&sem_id_1, &valid_buf, &sem_op_dyn, 0, 0, 0, 1, 1, ERANGE},
-	{&sem_id_1, &valid_buf, &sem_op_1, 0, -1, SEM_UNDO, 1, 1, EFBIG},
-	{&sem_id_1, &valid_buf, &sem_op_1, 0, PSEMS + 1, SEM_UNDO, 1, 1, EFBIG},
-	{&sem_id_1, &valid_buf, &sem_op_zero, 2, 2, IPC_NOWAIT, 1, 1, EAGAIN},
-	{&sem_id_1, &valid_buf, &sem_op_negative, 2, 2, IPC_NOWAIT, 1, 0, EAGAIN}
+	{&valid_sem_id, NULL, &sem_op_1, 0, 0, 0, BIGOPS, 1, E2BIG},
+	{&noperm_sem_id, NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, EACCES},
+	{&valid_sem_id, &faulty_buf, &sem_op_1, 0, 0, 0, NSOPS, 1, EFAULT},
+	{&valid_sem_id, NULL, &sem_op_1, 0, 0, 0, 0, 1, EINVAL},
+	{&bad_sem_id,   NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, EINVAL},
+	{&valid_sem_id, NULL, &sem_op_max, 0, 0, 0, 1, 1, ERANGE},
+	{&valid_sem_id, NULL, &sem_op_1, 0, -1, SEM_UNDO, 1, 1, EFBIG},
+	{&valid_sem_id, NULL, &sem_op_1, 0, PSEMS + 1, SEM_UNDO, 1, 1, EFBIG},
+	{&valid_sem_id, NULL, &sem_op_zero, 2, 2, IPC_NOWAIT, 1, 1, EAGAIN},
+	{&valid_sem_id, NULL, &sem_op_negative, 2, 2, IPC_NOWAIT, 1, 0, EAGAIN}
 };
 
 static void setup(void)
 {
-	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
-	key_t semkey2;
+	key_t semkey;
+	union semun arr;
 	struct seminfo ipc_buf;
 
-	ltpuser = SAFE_GETPWNAM(nobody_uid);
+	ltpuser = SAFE_GETPWNAM("nobody");
 	SAFE_SETUID(ltpuser->pw_uid);
 
 	semkey = GETIPCKEY();
 
-	sem_id_1 = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
-	if (sem_id_1 == -1)
+	valid_sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	if (valid_sem_id == -1)
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
 
-	semkey2 = GETIPCKEY();
+	semkey = GETIPCKEY();
 
-	sem_id_2 = semget(semkey2, PSEMS, IPC_CREAT | IPC_EXCL);
-	if (sem_id_2 == -1)
+	noperm_sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL);
+	if (noperm_sem_id == -1)
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
 
 	arr.__buf = &ipc_buf;
-	if (semctl(sem_id_1, 0, IPC_INFO, arr) == -1)
+	if (semctl(valid_sem_id, 0, IPC_INFO, arr) == -1)
 		tst_brk(TBROK | TERRNO, "semctl() IPC_INFO failed");
 
-	sem_op_dyn = ipc_buf.semvmx;
+	sem_op_max = ipc_buf.semvmx;
 	faulty_buf = tst_get_bad_addr(NULL);
 }
 
 static void run(unsigned int i)
 {
-	if (*tc[i].buf != faulty_buf) {
-		arr.val = tc[i].arr_val;
-
-		if (semctl(sem_id_1, tc[i].ctl_sem_num, SETVAL, arr) == -1)
+	union semun arr = {.val = tc[i].arr_val};
+	struct sembuf buf = {
+		.sem_op = *tc[i].sem_op,
+		.sem_flg = tc[i].sem_flg,
+		.sem_num = tc[i].sem_num,
+	};
+	struct sembuf *ptr = &buf;
+
+	if (*tc[i].semid == valid_sem_id) {
+		if (semctl(valid_sem_id, tc[i].ctl_sem_num, SETVAL, arr) == -1)
 			tst_brk(TBROK | TERRNO, "semctl() SETVAL failed");
-
-		s_buf[0].sem_op = *tc[i].sem_op;
-		s_buf[0].sem_flg = tc[i].sem_flg;
-		s_buf[0].sem_num = tc[i].sem_num;
 	}
 
-	TEST(semop(*(tc[i].semid), *tc[i].buf, tc[i].t_ops));
+	if (tc[i].buf)
+		ptr = *tc[i].buf;
+
+	TEST(semop(*(tc[i].semid), ptr, tc[i].t_ops));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL | TTERRNO, "call succeeded unexpectedly");
@@ -105,22 +115,21 @@ static void run(unsigned int i)
 		tst_res(TPASS | TTERRNO, "semop failed as expected");
 	} else {
 		tst_res(TFAIL | TTERRNO,
-			 "semop failed unexpectedly; expected: "
-			 "%d - %s", tc[i].error, strerror(tc[i].error));
+		        "semop failed unexpectedly; expected: %s",
+		        tst_strerrno(tc[i].error));
 	}
 }
 
 static void cleanup(void)
 {
-	union semun arr;
-
-	if (sem_id_1 != -1) {
-		if (semctl(sem_id_1, 0, IPC_RMID, arr) == -1)
-			tst_res(TINFO, "WARNING: semaphore deletion failed.");
+	if (valid_sem_id != -1) {
+		if (semctl(valid_sem_id, 0, IPC_RMID) == -1)
+			tst_res(TWARN, "semaphore deletion failed.");
 	}
-	if (sem_id_2 != -1) {
-		if (semctl(sem_id_2, 0, IPC_RMID, arr) == -1)
-			tst_res(TINFO, "WARNING: semaphore deletion failed.");
+
+	if (noperm_sem_id != -1) {
+		if (semctl(noperm_sem_id, 0, IPC_RMID) == -1)
+			tst_res(TWARN, "semaphore deletion failed.");
 	}
 }
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index df8ce7d16..25123f08c 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -18,7 +18,6 @@
 
 static key_t semkey;
 static int sem_id = -1;
-static struct sembuf s_buf;
 
 struct test_case_t {
 	union semun semunptr;
@@ -33,41 +32,18 @@ struct test_case_t {
 	{{0}, -1, 0, 5, EINTR}
 };
 
-static inline int process_state_wait2(pid_t pid, const char state)
-{
-	char proc_path[128], cur_state;
-
-	snprintf(proc_path, sizeof(proc_path), "/proc/%i/stat", pid);
-
-	for (;;) {
-		FILE *f = fopen(proc_path, "r");
-		if (!f) {
-			tst_res(TFAIL, "Failed to open '%s': %s\n", proc_path,
-				strerror(errno));
-			return 1;
-		}
-
-		if (fscanf(f, "%*i %*s %c", &cur_state) != 1) {
-			fclose(f);
-			tst_res(TFAIL, "Failed to read '%s': %s\n", proc_path,
-				strerror(errno));
-			return 1;
-		}
-		fclose(f);
-
-		if (state == cur_state)
-			return 0;
-
-		usleep(10000);
-	}
-}
-
 static void do_child(int i)
 {
+	struct sembuf s_buf = {
+		.sem_op = tc[i].op,
+		.sem_flg = tc[i].flg,
+		.sem_num = tc[i].num,
+	};
+
 	TEST(semop(sem_id, &s_buf, 1));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "call succeeded when error expected");
-		exit(-1);
+		exit(0);
 	}
 
 	if (TST_ERR == tc[i].error)
@@ -89,18 +65,16 @@ static void setup(void)
 	SAFE_SIGNAL(SIGHUP, sighandler);
 	semkey = GETIPCKEY();
 
-	if ((sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) ==
-	    -1)
+	sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	if (sem_id == -1)
 		tst_brk(TBROK | TERRNO, "couldn't create semaphore in setup");
 }
 
 static void cleanup(void)
 {
-	union semun arr;
-
 	if (sem_id != -1) {
-		if (semctl(sem_id, 0, IPC_RMID, arr) == -1)
-			tst_res(TINFO, "WARNING: semaphore deletion failed.");
+		if (semctl(sem_id, 0, IPC_RMID) == -1)
+			tst_res(TWARN, "semaphore deletion failed.");
 	}
 }
 
@@ -108,10 +82,6 @@ static void run(unsigned int i)
 {
 	pid_t pid;
 
-	s_buf.sem_op = tc[i].op;
-	s_buf.sem_flg = tc[i].flg;
-	s_buf.sem_num = tc[i].num;
-
 	if (semctl(sem_id, tc[i].num, SETVAL, tc[i].semunptr) == -1)
 		tst_brk(TBROK | TERRNO, "semctl() failed");
 
@@ -120,7 +90,7 @@ static void run(unsigned int i)
 	if (pid == 0) {
 		do_child(i);
 	} else {
-		process_state_wait2(pid, 'S');
+		TST_PROCESS_STATE_WAIT(pid, 'S', 0);
 
 		/*
 		 * If we are testing for EIDRM then remove
@@ -141,8 +111,8 @@ static void run(unsigned int i)
 	if (tc[i].error == EINTR)
 		return;
 
-	if ((sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) ==
-	    -1)
+	sem_id = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	if (sem_id == -1)
 		tst_brk(TBROK | TERRNO, "couldn't recreate semaphore");
 }
 

-- 
Cyril Hrubis
chrubis@suse.cz
