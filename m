From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 9 Sep 2020 16:27:26 +0800
Subject: [LTP] [PATCH v3 2/2] syscalls/msgrcv07: improve and short message
In-Reply-To: <1599640046-10135-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200908140838.GB17482@yuki.lan>
 <1599640046-10135-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1599640046-10135-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
index d4568956f..04257d257 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
@@ -72,9 +72,9 @@ static void test_msg_except(void)
 	}
 	tst_res(TPASS, "msgrcv(MSG_EXCEPT) succeeded");
 	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
-		tst_res(TPASS, "msgrcv(MSG_EXCEPT) excepted MSGTYPE2 and only got MSGTYPE1");
+		tst_res(TPASS, "MSG_EXCEPT excepted MSGTYPE2 and got MSGTYPE1");
 	else
-		tst_res(TFAIL, "msgrcv(MSG_EXCEPT) didn't get MSGTYPE1 message");
+		tst_res(TFAIL, "MSG_EXCEPT didn't get MSGTYPE1 message");
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
@@ -95,9 +95,9 @@ static void test_msg_noerror(void)
 	}
 	tst_res(TPASS, "msgrcv(MSG_NOERROR) succeeded");
 	if (strncmp(rcv_buf.mtext, MSG1, msg_len) == 0 && rcv_buf.type == MSGTYPE1)
-		tst_res(TPASS, "msgrcv(MSG_NOERROR) truncated message text correctly");
+		tst_res(TPASS, "MSG_NOERROR truncated message correctly");
 	else
-		tst_res(TFAIL, "msgrcv(MSG_NOERROR) truncated message text incorrectly");
+		tst_res(TFAIL, "MSG_NOERROR truncated message incorrectly");
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
@@ -167,9 +167,9 @@ static void test_zero_msgtyp(void)
 	}
 	tst_res(TPASS, "msgrcv(zero_msgtyp) succeeded");
 	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
-		tst_res(TPASS, "msgrcv(zero_msgtyp) got the first message");
+		tst_res(TPASS, "zero_msgtyp got the first message");
 	else
-		tst_res(TFAIL, "msgrcv(zero_msgtyp) didn't get the first message");
+		tst_res(TFAIL, "zero_msgtyp didn't get the first message");
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
@@ -185,11 +185,11 @@ static void test_positive_msgtyp(void)
 	}
 	tst_res(TPASS, "msgrcv(positive_msgtyp) succeeded");
 	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
-		tst_res(TPASS, "msgrcv(positive_msgtyp) got the first message"
-			       " in the queue of type msgtyp");
+		tst_res(TPASS, "positive_msgtyp got the first message "
+				"in the queue of type msgtyp");
 	else
-		tst_res(TFAIL, "msgrcv(positive_msgtyp) didn't get the first "
-			       "message in the queue of type msgtyp");
+		tst_res(TFAIL, "positive_msgtyp didn't get the first "
+				"message in the queue of type msgtyp");
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
@@ -205,15 +205,14 @@ static void test_negative_msgtyp(void)
 	}
 	tst_res(TPASS, "msgrcv(negative_msgtyp) succeeded");
 	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
-		tst_res(TPASS, "msgrcv(negative_msgtyp) got the first message"
+		tst_res(TPASS, "negative_msgtyp got the first message"
 				" in the queue with the lowest type");
 	else
-		tst_res(TFAIL, "msgrcv(negative_msgtyp) didn't get the first "
+		tst_res(TFAIL, "negative_msgtyp didn't get the first "
 				"message in the queue with the lowest type");
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
-
 static void setup(void)
 {
 	msgkey = GETIPCKEY();
-- 
2.23.0



