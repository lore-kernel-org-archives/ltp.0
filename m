From: Li Wang <liwang@redhat.com>
Date: Mon, 23 Nov 2020 08:31:36 +0000
Subject: [LTP] [PATCH 1/2] syscalls: avoid time() using __cvdso_gettimeofday
 in use-level's VDSO
Message-ID: <20201123083137.11575-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This shmctl01 test detect the time as the number of seconds twice
(before and after) the shmget() instruction, then it verifies
whether the 'struct shmid_ds ds' gets data correctly. But here it
shows 'ds->ctime' out of the seconds range (1604298586, 1604298586),

The reason is that shmget()/msgsnd() always use ktime_get_real_second
to get real seconds, but time() on aarch64 via gettimeofday() or (it
depends on different kernel versions) clock_gettime() in use-level's
VDSO to return tv_sec.

time()
  __cvdso_gettimeofday
   ...
     do_gettimeofday
       ktime_get_real_ts64
        timespc64_add_ns

Situation can be simplify as difference between ktime_get_real_second
and ktime_get_real_ts64. As we can see ktime_get_real_second return
tk->xtime_sec directly, however

timespc64_add_ns more easily add 1 more second via "a->tv_sec +=..."
on a virtual machine, that's why we got occasional errors like:

shmctl01.c:183: TFAIL: SHM_STAT: shm_ctime=1604298585, expected <1604298586,1604298586>
...
msgsnd01.c:59: TFAIL: msg_stime = 1605730573 out of [1605730574, 1605730574]

Here we propose to use '__NR_time' to invoke syscall directly that makes
test all get real seconds via ktime_get_real_second.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c | 5 +++--
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c | 5 +++--
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index 5c1e317e9..6fdc47dc3 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -10,6 +10,7 @@
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
+#include "tst_timer.h"
 
 static key_t msgkey;
 static int queue_id = -1, pid;
@@ -25,13 +26,13 @@ static void verify_msgrcv(void)
 
 	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
-	time(&before_rcv);
+	tst_syscall(__NR_time, &before_rcv);
 	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgrcv failed");
 		return;
 	}
-	time(&after_rcv);
+	tst_syscall(__NR_time, &after_rcv);
 
 	if (strcmp(rcv_buf.mtext, snd_buf.mtext) == 0)
 		tst_res(TPASS, "message received(%s) = message sent(%s)",
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 5f5da52d2..9101f2668 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -16,6 +16,7 @@
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
+#include "tst_timer.h"
 
 static key_t msgkey;
 static int queue_id = -1, pid;
@@ -29,13 +30,13 @@ static void verify_msgsnd(void)
 	struct msqid_ds qs_buf;
 	time_t before_snd, after_snd;
 
-	time(&before_snd);
+	tst_syscall(__NR_time, &before_snd);
 	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgsnd() failed");
 		return;
 	}
-	time(&after_snd);
+	tst_syscall(__NR_time, &after_snd);
 
 	SAFE_MSGCTL(queue_id, IPC_STAT, &qs_buf);
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 3a39a4d74..f5b8eaef9 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -19,6 +19,7 @@
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
+#include "tst_timer.h"
 
 #define NCHILD 20
 
@@ -240,9 +241,9 @@ static int get_shm_idx_from_id(int shm_id)
 
 static void setup(void)
 {
-	ctime_min = time(NULL);
+	ctime_min = tst_syscall(__NR_time, NULL);
 	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
-	ctime_max = time(NULL);
+	ctime_max = tst_syscall(__NR_time, NULL);
 
 	shm_idx = get_shm_idx_from_id(shm_id);
 
-- 
2.21.1

