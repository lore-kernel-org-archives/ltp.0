From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Sep 2020 17:15:36 +0200
Subject: [LTP] [PATCH v3 1/2] syscalls/msgrcv07: Add functional test for
 MSG_COPY flag
In-Reply-To: <1599640046-10135-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200908140838.GB17482@yuki.lan>
 <1599640046-10135-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200909151536.GC3241@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor cleanup, thanks.

The diff:

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
index d4568956f..82b119d39 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
@@ -106,9 +106,10 @@ static void test_msg_copy(void)
 	struct msqid_ds buf = {0};
 
 	if (!msg_copy_sup) {
-		tst_res(TCONF, "MSG_COPY was not supported, skip it");
+		tst_res(TCONF, "MSG_COPY not supported");
 		return;
 	}
+
 	prepare_queue();
 
 	/*
@@ -124,10 +125,11 @@ static void test_msg_copy(void)
 		} else {
 			tst_res(TFAIL | TTERRNO, "msgrcv(0, MSG_COPY) failed");
 		}
-		cleanup();
-		return;
+		goto exit;
 	}
+
 	tst_res(TPASS, "msgrcv(0, MSG_COPY) succeeded");
+
 	if (strcmp(rcv_buf.mtext, MSG1) == 0 && rcv_buf.type == MSGTYPE1)
 		tst_res(TPASS, "MSG_COPY got MSGTYPE1 data correctly");
 	else
@@ -137,21 +139,25 @@ static void test_msg_copy(void)
 	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, MSG_COPY | IPC_NOWAIT));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "msgrcv(1, MSG_COPY) failed");
-		cleanup();
-		return;
+		goto exit;
 	}
+
 	tst_res(TPASS, "msgrcv(1, MSG_COPY) succeeded");
+
 	if (strcmp(rcv_buf.mtext, MSG2) == 0 && rcv_buf.type == MSGTYPE2)
 		tst_res(TPASS, "MSG_COPY got MSGTYPE2 data correctly");
 	else
 		tst_res(TFAIL, "MSG_COPY got MSGTYPE2 data incorrectly");
 
 	SAFE_MSGCTL(queue_id, IPC_STAT, &buf);
-	if (buf.msg_qnum == 2)
+	if (buf.msg_qnum == 2) {
 		tst_res(TPASS, "Two messages still in queue");
-	else
+	} else {
 		tst_res(TFAIL, "Expected 2 msgs in queue got %d",
 		       (int)buf.msg_qnum);
+	}
+
+exit:
 	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
@@ -218,11 +224,8 @@ static void setup(void)
 {
 	msgkey = GETIPCKEY();
 
-	if (tst_kvercmp(3, 8, 0) < 0) {
-		tst_res(TCONF, "MSG_COPY needs Linux 3.8 or newer");
-		return;
-	}
-	msg_copy_sup = 1;
+	if (tst_kvercmp(3, 8, 0) >= 0)
+		msg_copy_sup = 1;
 }
 
 static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror,

-- 
Cyril Hrubis
chrubis@suse.cz
