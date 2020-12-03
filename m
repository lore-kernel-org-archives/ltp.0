From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Dec 2020 16:28:04 +0100
Subject: [LTP] [PATCH 2/2] syscalls/ipc: Make use of get_ipc_timestamp()
In-Reply-To: <20201203152804.846-1-chrubis@suse.cz>
References: <20201203152804.846-1-chrubis@suse.cz>
Message-ID: <20201203152804.846-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c | 4 ++--
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c | 4 ++--
 testcases/kernel/syscalls/ipc/shmctl/Makefile   | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index 5c1e317e9..afe552c4f 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -25,13 +25,13 @@ static void verify_msgrcv(void)
 
 	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
-	time(&before_rcv);
+	before_rcv = get_ipc_timestamp();
 	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgrcv failed");
 		return;
 	}
-	time(&after_rcv);
+	after_rcv = get_ipc_timestamp();
 
 	if (strcmp(rcv_buf.mtext, snd_buf.mtext) == 0)
 		tst_res(TPASS, "message received(%s) = message sent(%s)",
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 5f5da52d2..432b03def 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -29,13 +29,13 @@ static void verify_msgsnd(void)
 	struct msqid_ds qs_buf;
 	time_t before_snd, after_snd;
 
-	time(&before_snd);
+	before_snd = get_ipc_timestamp();
 	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgsnd() failed");
 		return;
 	}
-	time(&after_snd);
+	after_snd = get_ipc_timestamp();
 
 	SAFE_MSGCTL(queue_id, IPC_STAT, &qs_buf);
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index 106b73697..06d72d968 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -10,6 +10,6 @@ shmctl05: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-shmctl02 shmctl04 shmctl06: LTPLDLIBS = -lltpnewipc
+shmctl01 shmctl02 shmctl04 shmctl06: LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 3a39a4d74..eb5307d1e 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -240,9 +240,9 @@ static int get_shm_idx_from_id(int shm_id)
 
 static void setup(void)
 {
-	ctime_min = time(NULL);
+	ctime_min = get_ipc_timestamp();
 	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
-	ctime_max = time(NULL);
+	ctime_max = get_ipc_timestamp();
 
 	shm_idx = get_shm_idx_from_id(shm_id);
 
-- 
2.26.2

