From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 15:30:26 +0800
Subject: [LTP] [PATCH v1 2/3] syscalls/msgrcv07: Add different msgtyp test
In-Reply-To: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1595230227-21468-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After lookging msgcrv(2) man-page, the different msgtyp has the following effect:
1) If msgtyp is 0, then the first message in the queue is read.
2) If msgtyp is greater than 0, then the first message in the queue of type msgtyp is read.
3) If msgtyp is less than 0, then the first message in the queue with the lowest type less
 than or equal to the absolute value of msgtyp will be read.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     | 81 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
index 39fbdb67a..9b04fd2ac 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
@@ -3,7 +3,8 @@
  * Copyright (c) 2014-2020 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
  *
- * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR
+ * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR and different
+ * msg_typ(zero,positive,negative).
  */
 
 #define  _GNU_SOURCE
@@ -22,15 +23,20 @@ static int queue_id = -1;
 static struct buf {
 	long type;
 	char mtext[MSGSIZE];
-} rcv_buf, snd_buf[2] = {
+} rcv_buf, snd_buf[3] = {
 	{MSGTYPE1, MSG1},
-	{MSGTYPE2, MSG2}
+	{MSGTYPE2, MSG2},
 };
 
 static void test_msg_except(void);
 static void test_msg_noerror(void);
+static void test_zero_msgtyp(void);
+static void test_positive_msgtyp(void);
+static void test_negative_msgtyp(void);
 static void cleanup(void);
-static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror};
+static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror,
+				   test_zero_msgtyp, test_positive_msgtyp,
+				   test_negative_msgtyp};
 
 static void verify_msgcrv(unsigned int n)
 {
@@ -81,6 +87,73 @@ static void test_msg_noerror(void)
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
+static void test_zero_msgtyp(void)
+{
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	SAFE_MSGSND(queue_id, &snd_buf[0], MSGSIZE, 0);
+	SAFE_MSGSND(queue_id, &snd_buf[1], MSGSIZE, 0);
+	memset(&rcv_buf, 0, sizeof(rcv_buf));
+
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 0, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "msgrcv(zero_msgtyp) failed");
+		cleanup();
+		return;
+	}
+	tst_res(TPASS, "msgrcv(zero_msgtyp) succeeded");
+	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
+		tst_res(TPASS, "msgrcv(zero_msgtyp) got the first message");
+	else
+		tst_res(TFAIL, "msgrcv(zero_msgtyp) didn't get the first message");
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+}
+
+static void test_positive_msgtyp(void)
+{
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	SAFE_MSGSND(queue_id, &snd_buf[0], MSGSIZE, 0);
+	SAFE_MSGSND(queue_id, &snd_buf[1], MSGSIZE, 0);
+	memset(&rcv_buf, 0, sizeof(rcv_buf));
+
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, MSGTYPE2, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "msgrcv(positive_msgtyp) failed");
+		cleanup();
+		return;
+	}
+	tst_res(TPASS, "msgrcv(positive_msgtyp) succeeded");
+	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
+		tst_res(TPASS, "msgrcv(positive_msgtyp) got the first message"
+			       " in the queue of type msgtyp");
+	else
+		tst_res(TFAIL, "msgrcv(positive_msgtyp) didn't get the first "
+			       "message in the queue of type msgtyp");
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+}
+
+static void test_negative_msgtyp(void)
+{
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	SAFE_MSGSND(queue_id, &snd_buf[0], MSGSIZE, 0);
+	SAFE_MSGSND(queue_id, &snd_buf[1], MSGSIZE, 0);
+	memset(&rcv_buf, 0, sizeof(rcv_buf));
+
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, -MSGTYPE2, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "msgrcv(negative_msgtyp) failed");
+		cleanup();
+		return;
+	}
+	tst_res(TPASS, "msgrcv(negative_msgtyp) succeeded");
+	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
+		tst_res(TPASS, "msgrcv(negative_msgtyp) got the first message"
+				" in the queue with the lowest type");
+	else
+		tst_res(TFAIL, "msgrcv(negative_msgtyp) didn't get the first "
+				"message in the queue with the lowest type");
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+}
+
 static void setup(void)
 {
 	msgkey = GETIPCKEY();
-- 
2.23.0



