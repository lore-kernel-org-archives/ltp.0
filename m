From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 30 Mar 2021 14:32:00 +0800
Subject: [LTP] [PATCH v3] syscalls/ipc: Check that whether if kernel
 supports *_STAT_ANY
Message-ID: <20210330063200.23654-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SHM_STAT_ANY,SEM_STAT_ANY and MSG_STAT_ANY are imported to linux
in v4.17, and some linux distribution such as centos7.8 has
backported this feature, so we should call SHM_STAT_ANY directly
to detect whether kernel supports *_STAT_ANY.

Also fix wrong TTERRNO usage.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v2->v3:
        1) modify git msg
        2) check that whether if errno is equal to EFAULT

 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c | 14 +++++++++++++-
 testcases/kernel/syscalls/ipc/semctl/semctl09.c | 17 ++++++++++++++++-
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 12 ++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index 722a0cca0..badbaaede 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -115,7 +115,7 @@ static void verify_msgctl(unsigned int n)
 	msgid = msgctl(TST_RET, MSG_STAT_ANY, &buf);

 	if (msgid == -1) {
-		tst_res(TFAIL | TTERRNO, "MSG_INFO haven't returned a valid index");
+		tst_res(TFAIL | TERRNO, "MSG_INFO haven't returned a valid index");
 	} else {
 		tst_res(TPASS, "MSG_INFO returned valid index %li to msgid %i",
 			TST_RET, msgid);
@@ -138,12 +138,24 @@ static void verify_msgctl(unsigned int n)

 static void setup(void)
 {
+	struct msqid_ds temp_buf;
 	ltpuser = SAFE_GETPWNAM("nobody");
 	nobody_uid = ltpuser->pw_uid;
 	root_uid = 0;

 	msg_id = SAFE_MSGGET(IPC_PRIVATE, IPC_CREAT | MSG_RW);
 	SAFE_MSGSND(msg_id, "abcd", 4, 0);
+
+	TEST(msgctl(msg_id, MSG_STAT_ANY, &temp_buf));
+	if (TST_RET == -1) {
+		if (TST_ERR == EINVAL)
+			tst_brk(TCONF, "kernel doesn't support MSG_STAT_ANY");
+		else
+			tst_brk(TBROK | TTERRNO,
+					"Current environment doesn't permit "
+					"MSG_STAT_ANY");
+	}
+
 }

 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index 5a81f778c..b40f5ba8b 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -158,7 +158,7 @@ static void verify_semctl(unsigned int n)
 				"specified by the caller to kernel");
 		return;
 	} else if (semid == -1) {
-		tst_res(TFAIL | TTERRNO, "SEM_INFO haven't returned a valid index");
+		tst_res(TFAIL | TERRNO, "SEM_INFO haven't returned a valid index");
 	} else {
 		tst_res(TPASS, "SEM_INFO returned valid index %li to semid %i",
 			TST_RET, semid);
@@ -193,6 +193,21 @@ static void setup(void)
 #endif

 	sem_id = SAFE_SEMGET(IPC_PRIVATE, 2, IPC_CREAT | 0600);
+
+	TEST(do_semctl(sem_id, 0, SEM_STAT_ANY));
+	if (TST_RET == -1) {
+		if (errno == EFAULT)
+			tst_brk(TFAIL, "SEM_STAT_ANY doesn't pass the buffer "
+					"specified by the caller to kernel");
+		if (TST_ERR == EINVAL)
+			tst_brk(TCONF, "kernel doesn't support "
+					"SEM_STAT_ANY");
+		else
+			tst_brk(TBROK | TTERRNO,
+					"Current environment doesn't permit "
+					"SEM_STAT_ANY");
+	}
+
 }

 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 9e8ec4199..9a60c5170 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -155,10 +155,22 @@ static void verify_shminfo(unsigned int n)
 static void setup(void)
 {
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
+	struct shmid_ds temp_ds;
 	nobody_uid = ltpuser->pw_uid;
 	root_uid = 0;

 	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
+
+	TEST(shmctl(shm_id, SHM_STAT_ANY, &temp_ds));
+	if (TST_RET == -1) {
+		if (TST_ERR == EINVAL)
+			tst_brk(TCONF, "kernel doesn't support "
+					"SHM_STAT_ANY");
+		else
+			tst_brk(TBROK | TTERRNO,
+					"Current environment doesn't permit "
+					"SHM_STAT_ANY");
+	}
 }

 static void cleanup(void)
--
2.17.1

