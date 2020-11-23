From: Li Wang <liwang@redhat.com>
Date: Mon, 23 Nov 2020 08:31:37 +0000
Subject: [LTP] [PATCH 2/2] syscalls: shift to time() if __NR_time not support
In-Reply-To: <20201123083137.11575-1-liwang@redhat.com>
References: <20201123083137.11575-1-liwang@redhat.com>
Message-ID: <20201123083137.11575-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some platforms(aarch64) __NR_time is not supported, if that happens,
go back to invoke time() and relax 1-second in low bound for comparing.

This also to fix:
  TFAIL: msg_stime = 1605730573 out of [1605730574, 1605730574]

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c | 14 ++++++++++++--
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c | 14 ++++++++++++--
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c | 14 ++++++++++++--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index 6fdc47dc3..9dc778ca7 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -26,13 +26,23 @@ static void verify_msgrcv(void)
 
 	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
-	tst_syscall(__NR_time, &before_rcv);
+	before_rcv = syscall(__NR_time, NULL);
+	if (before_rcv == -1 && errno == ENOSYS) {
+		tst_res(TINFO, "__NR_time not supported");
+		before_rcv = time(NULL) - 1;
+	}
+
 	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgrcv failed");
 		return;
 	}
-	tst_syscall(__NR_time, &after_rcv);
+
+	after_rcv = syscall(__NR_time, NULL);
+	if (after_rcv == -1 && errno == ENOSYS) {
+		tst_res(TINFO, "__NR_time not supported");
+		after_rcv = time(NULL);
+	}
 
 	if (strcmp(rcv_buf.mtext, snd_buf.mtext) == 0)
 		tst_res(TPASS, "message received(%s) = message sent(%s)",
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 9101f2668..27464e79f 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -30,13 +30,23 @@ static void verify_msgsnd(void)
 	struct msqid_ds qs_buf;
 	time_t before_snd, after_snd;
 
-	tst_syscall(__NR_time, &before_snd);
+	before_snd = syscall(__NR_time, NULL);
+	if (before_snd == -1 && errno == ENOSYS) {
+		tst_res(TINFO, "__NR_time not supported");
+		before_snd = time(NULL) - 1;
+	}
+
 	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgsnd() failed");
 		return;
 	}
-	tst_syscall(__NR_time, &after_snd);
+
+	after_snd = syscall(__NR_time, NULL);
+	if (after_snd == -1 && errno == ENOSYS) {
+		tst_res(TINFO, "__NR_time not supported");
+		after_snd = time(NULL);
+	}
 
 	SAFE_MSGCTL(queue_id, IPC_STAT, &qs_buf);
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index f5b8eaef9..356513726 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -241,9 +241,19 @@ static int get_shm_idx_from_id(int shm_id)
 
 static void setup(void)
 {
-	ctime_min = tst_syscall(__NR_time, NULL);
+	ctime_min = syscall(__NR_time, NULL);
+	if (ctime_min == -1 && errno == ENOSYS) {
+		tst_res(TINFO, "__NR_time not supported");
+		ctime_min = time(NULL) - 1;
+	}
+
 	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
-	ctime_max = tst_syscall(__NR_time, NULL);
+
+	ctime_max = syscall(__NR_time, NULL);
+	if (ctime_max == -1 && errno == ENOSYS) {
+		tst_res(TINFO, "__NR_time not supported");
+		ctime_max = time(NULL);
+	}
 
 	shm_idx = get_shm_idx_from_id(shm_id);
 
-- 
2.21.1

