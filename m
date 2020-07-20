From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 15:30:25 +0800
Subject: [LTP] [PATCH v1 1/3] syscalls/msgrcv: Add check for msg_lrpid and
 msg_rtime
In-Reply-To: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1595230227-21468-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ipc/msgrcv/msgrcv01.c     | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index 204bf0575..3bdfa5b37 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -12,7 +12,8 @@
 #include "libnewipc.h"
 
 static key_t msgkey;
-static int queue_id = -1;
+static time_t creat_time, last_rcv_time;
+static int queue_id = -1, pid;
 static struct buf {
 	long type;
 	char mtext[MSGSIZE];
@@ -20,6 +21,8 @@ static struct buf {
 
 static void verify_msgrcv(void)
 {
+	struct msqid_ds qs_buf;
+
 	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
 	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
@@ -33,12 +36,35 @@ static void verify_msgrcv(void)
 	else
 		tst_res(TFAIL, "message received(%s) != message sent(%s)",
 			rcv_buf.mtext, snd_buf.mtext);
+
+	SAFE_MSGCTL(queue_id, IPC_STAT, &qs_buf);
+	if (qs_buf.msg_cbytes == 0 && qs_buf.msg_qnum == 0)
+		tst_res(TPASS, "queue bytes and number of queues matched");
+	else
+		tst_res(TFAIL, "queue bytes or number of queues mismatched");
+	if (qs_buf.msg_lrpid == pid)
+		tst_res(TPASS, "PID of last msgrcv(2) matched");
+	else
+		tst_res(TFAIL, "PID of last msgrcv(2) mismatched");
+
+	if (qs_buf.msg_rtime >= creat_time && qs_buf.msg_rtime >= last_rcv_time)
+		tst_res(TPASS, "create time = %lu, last_snd_time = %lu, msg_stime = %lu",
+			(unsigned long)creat_time, (unsigned long)last_rcv_time,
+			(unsigned long)qs_buf.msg_rtime);
+	else
+		tst_res(TFAIL, "create time = %lu, last_rcv_time = %lu, msg_rtime = %lu",
+			(unsigned long)creat_time, (unsigned long)last_rcv_time,
+			(unsigned long)qs_buf.msg_rtime);
+
+	last_rcv_time = qs_buf.msg_rtime;
 }
 
 static void setup(void)
 {
 	msgkey = GETIPCKEY();
 	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	pid = getpid();
+	time(&creat_time);
 }
 
 static void cleanup(void)
-- 
2.23.0



