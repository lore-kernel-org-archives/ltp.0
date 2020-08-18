From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 18 Aug 2020 13:18:44 +0800
Subject: [LTP] [PATCH v2] syscalls/msgrcv07: Add functional test for
 MSG_COPY flag
In-Reply-To: <20200814132855.GC5559@yuki.lan>
References: <20200814132855.GC5559@yuki.lan>
Message-ID: <1597727924-4969-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When specifying MSG_COPY flag, we can read the msg but don't destory
it in msg queue and mtype is interpreted as number of the message to
copy. We check the read data whether correctly and use msgctl to
check whether we still have 2 msg in msg queue after msgrcv(MSG_COPY).

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v1->v2:
1.add missing return when not support MSG_COPY flag
2.modify the test order(also rebase this patch)
 .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     | 71 +++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
index 8005a9acd..3e8b382a9 100644
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
@@ -97,6 +101,46 @@ static void test_msg_noerror(void)
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
+static void test_msg_copy(void)
+{
+	struct msqid_ds buf = {0};
+
+	if (!msg_copy_sup) {
+		tst_res(TCONF, "kernel doesn't support MSG_COPY flag, skip it");
+		return;
+	}
+	prepare_queue();
+
+	/*
+	 * If MSG_COPY flag was specified, then mtype is interpreted as number
+	 * of the message to copy.
+	 */
+	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 0, MSG_COPY | IPC_NOWAIT);
+	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
+		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
+			" correctly");
+	else
+		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE1 msg data"
+			" incorrectly");
+
+	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, 1, MSG_COPY | IPC_NOWAIT);
+	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
+		tst_res(TPASS, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
+			" correctly");
+	else
+		tst_res(TFAIL, "msgrcv(MSG_COPY) got MSGTYPE2 msg data"
+			" incorrectly");
+
+	SAFE_MSGCTL(queue_id, IPC_STAT, &buf);
+	if (buf.msg_qnum == 2)
+		tst_res(TPASS, "msgrcv(MSG_COPY) succeeded, msg queue "
+			"still has 2 msg");
+	else
+		tst_res(TFAIL, "msgrcv(MSG_COPY) msg queue expected 2 msg num,"
+			" but only got %d", (int)buf.msg_qnum);
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+}
+
 static void test_zero_msgtyp(void)
 {
 	prepare_queue();
@@ -159,11 +203,28 @@ static void test_negative_msgtyp(void)
 static void setup(void)
 {
 	msgkey = GETIPCKEY();
+	prepare_queue();
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, MSGTYPE1, MSG_COPY));
+	if (TST_RET != -1)
+		tst_res(TINFO, "msgrcv succeeded unexpectedly, kernel doesn't"
+			" support MSG_COPY flag");
+
+	if (TST_ERR == EINVAL) {
+		tst_res(TINFO, "msgrcv failed as expected when not using"
+			" MSG_COPY and IPC_NOWAIT concurrently");
+		msg_copy_sup = 1;
+	} else if (TST_ERR == ENOSYS) {
+		tst_res(TINFO, "kernel doesn't enable CONFIG_CHECKPOINT_RESTORE");
+	} else {
+		tst_res(TINFO | TTERRNO, "msgrcv failed when not using MSG_COPY"
+			"and IPC_NOWAIT concurrently, expected EINVAL but got");
+	}
+	cleanup();
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



