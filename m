From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 9 Sep 2020 16:27:25 +0800
Subject: [LTP] [PATCH v3 1/2] syscalls/msgrcv07: Add functional test for
 MSG_COPY flag
In-Reply-To: <20200908140838.GB17482@yuki.lan>
References: <20200908140838.GB17482@yuki.lan>
Message-ID: <1599640046-10135-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When specifying MSG_COPY flag, we can read the msg but don't destroy
it in msg queue and mtype is interpreted as number of the message to
copy. We check the read data whether correctly and use msgctl to
check whether we still have 2 msg in msg queue after msgrcv(MSG_COPY).

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v2-v3:
1.modify the detection way about MSG_COPY flag
2.make messages short and to the point
3.zero rcv_buf when call msgrcv the second time

 .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     | 74 +++++++++++++++++--
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
index 8005a9acd..d4568956f 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
@@ -2,9 +2,10 @@
 /*
  * Copyright (c) 2014-2020 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  *
- * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR and different
- * msg_typ(zero,positive,negative).
+ * Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR, MSG_COPY and
+ * different msg_typ(zero,positive,negative).
  *
  * * With MSG_EXCEPT flag any message type but the one passed to the function
  *   is received.
@@ -12,6 +13,9 @@
  * * With MSG_NOERROR and buffer size less than message size only part of the
  *   buffer is received.
  *
+ * * With MSG_COPY and IPC_NOWAIT flag read the msg but don't destroy it in
+ *   msg queue.
+ *
  * * With msgtyp is 0, then the first message in the queue is read.
  *
  * * With msgtyp is greater than 0, then the first message in the queue of type
@@ -33,7 +37,7 @@
 #define MSG2	"messagetype2"
 
 static key_t msgkey;
-static int queue_id = -1;
+static int queue_id = -1, msg_copy_sup;
 static struct buf {
 	long type;
 	char mtext[MSGSIZE];
@@ -97,6 +101,60 @@ static void test_msg_noerror(void)
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
+static void test_msg_copy(void)
+{
+	struct msqid_ds buf = {0};
+
+	if (!msg_copy_sup) {
+		tst_res(TCONF, "MSG_COPY was not supported, skip it");
+		return;
+	}
+	prepare_queue();
+
+	/*
+	 * If MSG_COPY flag was specified, then mtype is interpreted as number
+	 * of the message to copy.
+	 */
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 0, MSG_COPY | IPC_NOWAIT));
+	if (TST_RET == -1) {
+		if (TST_ERR == ENOSYS) {
+			tst_res(TCONF,
+				"MSG_COPY needs CONFIG_CHECKPORINT_RESTORE");
+			msg_copy_sup = 0;
+		} else {
+			tst_res(TFAIL | TTERRNO, "msgrcv(0, MSG_COPY) failed");
+		}
+		cleanup();
+		return;
+	}
+	tst_res(TPASS, "msgrcv(0, MSG_COPY) succeeded");
+	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
+		tst_res(TPASS, "MSG_COPY got MSGTYPE1 data correctly");
+	else
+		tst_res(TFAIL, "MSG_COPY got MSGTYPE1 data incorrectly");
+
+	memset(&rcv_buf, 0, sizeof(rcv_buf));
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, MSG_COPY | IPC_NOWAIT));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "msgrcv(1, MSG_COPY) failed");
+		cleanup();
+		return;
+	}
+	tst_res(TPASS, "msgrcv(1, MSG_COPY) succeeded");
+	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
+		tst_res(TPASS, "MSG_COPY got MSGTYPE2 data correctly");
+	else
+		tst_res(TFAIL, "MSG_COPY got MSGTYPE2 data incorrectly");
+
+	SAFE_MSGCTL(queue_id, IPC_STAT, &buf);
+	if (buf.msg_qnum == 2)
+		tst_res(TPASS, "Two messages still in queue");
+	else
+		tst_res(TFAIL, "Expected 2 msgs in queue got %d",
+		       (int)buf.msg_qnum);
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+}
+
 static void test_zero_msgtyp(void)
 {
 	prepare_queue();
@@ -159,11 +217,17 @@ static void test_negative_msgtyp(void)
 static void setup(void)
 {
 	msgkey = GETIPCKEY();
+
+	if (tst_kvercmp(3, 8, 0) < 0) {
+		tst_res(TCONF, "MSG_COPY needs Linux 3.8 or newer");
+		return;
+	}
+	msg_copy_sup = 1;
 }
 
 static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror,
-				   test_zero_msgtyp, test_positive_msgtyp,
-				   test_negative_msgtyp};
+				   test_msg_copy, test_zero_msgtyp,
+				   test_positive_msgtyp, test_negative_msgtyp};
 
 static void verify_msgcrv(unsigned int n)
 {
-- 
2.23.0



