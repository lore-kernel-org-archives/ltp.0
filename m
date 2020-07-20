From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 10:16:32 +0800
Subject: [LTP] [PATCH] syscalls/msgsnd01: Add check for msg_lspid and
 msg_stime
Message-ID: <1595211392-17141-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ipc/msgsnd/msgsnd01.c     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index fca7c6789..6368690de 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -18,7 +18,8 @@
 #include "libnewipc.h"
 
 static key_t msgkey;
-static int queue_id = -1;
+static time_t creat_time, last_snd_time;
+static int queue_id = -1, pid;
 static struct buf {
 	long type;
 	char text[MSGSIZE];
@@ -40,15 +41,30 @@ static void verify_msgsnd(void)
 		tst_res(TPASS, "queue bytes and number of queues matched");
 	else
 		tst_res(TFAIL, "queue bytes or number of queues mismatched");
+	if (qs_buf.msg_lspid == pid)
+		tst_res(TPASS, "PID of last msgsnd(2) matched");
+	else
+		tst_res(TFAIL, "PID of last msgsnd(2) mismatched");
+
+	if (qs_buf.msg_stime >= creat_time && qs_buf.msg_stime >= last_snd_time)
+		tst_res(TPASS, "create time = %lu, last_snd_time = %lu, msg_stime = %lu",
+			(unsigned long)creat_time, (unsigned long)last_snd_time,
+			(unsigned long)qs_buf.msg_stime);
+	else
+		tst_res(TFAIL, "create time = %lu, last_snd_time = %lu, msg_stime = %lu",
+			(unsigned long)creat_time, (unsigned long)last_snd_time,
+			(unsigned long)qs_buf.msg_stime);
 
 	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 1, 0);
+	last_snd_time = qs_buf.msg_stime;
 }
 
 static void setup(void)
 {
 	msgkey = GETIPCKEY();
-
 	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	pid = getpid();
+	time(&creat_time);
 }
 
 static void cleanup(void)
-- 
2.23.0



