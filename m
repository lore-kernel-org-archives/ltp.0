From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Jun 2021 18:44:46 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/ipc: Make use of TST_EXP_FAIL or
 TST_EXP_FAIL2 macro
In-Reply-To: <1624963486-6614-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YNHCQ8qWSBdHIAra@yuki>
 <1624963486-6614-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1624963486-6614-2-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/msgget/msgget02.c | 15 ++-------------
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c | 14 ++------------
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c | 17 ++---------------
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c | 12 ++----------
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c | 11 ++---------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c | 14 ++------------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c | 14 ++------------
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c | 14 ++------------
 8 files changed, 16 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index a8fac930b..de139790b 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -46,19 +46,8 @@ static struct tcase {
 
 static void verify_msgget(struct tcase *tc)
 {
-	TEST(msgget(*tc->key, tc->flags));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "msgget() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == tc->exp_err) {
-		tst_res(TPASS | TTERRNO, "msgget() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO, "msgget() failed unexpectedly,"
-			" expected %s", tst_strerrno(tc->exp_err));
-	}
+	TST_EXP_FAIL(msgget(*tc->key, tc->flags), tc->exp_err, "msgget(%i, %i)",
+		*tc->key, tc->flags);
 }
 
 static void do_test(unsigned int n)
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
index 8dd28116a..cfb7d7446 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
@@ -59,18 +59,8 @@ static struct tcase {
 
 static void verify_msgrcv(struct tcase *tc)
 {
-	TEST(msgrcv(*tc->id, tc->buffer, tc->msgsz, tc->msgtyp, tc->msgflag));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "smgrcv() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == tc->exp_err) {
-		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO, "msgrcv() failed unexpectedly,"
-			" expected %s but got", tst_strerrno(tc->exp_err));
-	}
+	TST_EXP_FAIL2(msgrcv(*tc->id, tc->buffer, tc->msgsz, tc->msgtyp, tc->msgflag), tc->exp_err,
+		"msgrcv(%i, %p, %i, %ld, %i)", *tc->id, tc->buffer, tc->msgsz, tc->msgtyp, tc->msgflag);
 }
 
 static void do_test(unsigned int n)
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
index b578e2810..ebc583b3e 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
@@ -59,21 +59,8 @@ static void verify_msgrcv(unsigned int n)
 
 	tst_res(TINFO, "%s", tc->message);
 
-	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, tc->msg_type, MSG_COPY | tc->msg_flag));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "msgrcv() succeeded unexpectedly");
-		SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
-		return;
-	}
-
-	if (TST_ERR == tc->exp_err) {
-		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
-		return;
-	}
-
-	tst_res(TFAIL | TTERRNO,
-		"msgrcv() failed unexpectedly, expected %s got",
-		tst_strerrno(tc->exp_err));
+	TST_EXP_FAIL2(msgrcv(queue_id, &rcv_buf, MSGSIZE, tc->msg_type, MSG_COPY | tc->msg_flag), tc->exp_err,
+		"msgrcv(%i, %p, %i, %i, %i)", queue_id, &rcv_buf, MSGSIZE, tc->msg_type, MSG_COPY | tc->msg_flag);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
index 43581896a..cc385ee6e 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
@@ -30,16 +30,8 @@ static void sighandler(int sig)
 
 static void verify_msgrcv(void)
 {
-	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "msgrcv() succeeded unexpectedly");
-		return;
-	}
-	if (TST_ERR == EINTR)
-		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
-	else
-		tst_res(TFAIL | TTERRNO, "msgrcv() failed expected EINTR but got");
+	TST_EXP_FAIL2(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0), EINTR,
+		"msgrcv(%i, %p, %d, 1, 0)", queue_id, &rcv_buf, MSGSIZE);
 }
 
 static void do_test(void)
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
index 283b4af1d..f14526df9 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
@@ -24,15 +24,8 @@ static struct buf {
 
 static void verify_msgrcv(void)
 {
-	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "msgrcv() succeeded unexpectedly");
-		return;
-	}
-	if (TST_ERR == EIDRM)
-		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
-	else
-		tst_res(TFAIL | TTERRNO, "msgrcv() failed expected EIDRM but got");
+	TST_EXP_FAIL2(msgrcv(queue_id, &rcv_buf, MSGSIZE, 1, 0), EIDRM,
+		"msgrcv(%i, %p, %d, 1, 0)", queue_id, &rcv_buf, MSGSIZE);
 }
 
 static void do_test(void)
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index 24ef6c562..eca660605 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -61,18 +61,8 @@ static struct tcase {
 
 static void verify_msgsnd(struct tcase *tc)
 {
-	TEST(msgsnd(*tc->id, tc->buffer, tc->msgsz, 0));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "smgsnd() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == tc->exp_err) {
-		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO, "msgsnd() failed unexpectedly,"
-			" expected %s", tst_strerrno(tc->exp_err));
-	}
+	TST_EXP_FAIL(msgsnd(*tc->id, tc->buffer, tc->msgsz, 0), tc->exp_err,
+		"msgsnd(%i, %p, %i, 0)", *tc->id, tc->buffer, tc->msgsz);
 }
 
 static void do_test(unsigned int n)
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index ace32cdaa..f048fa698 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -41,18 +41,8 @@ static struct tcase {
 
 static void verify_msgsnd(struct tcase *tc)
 {
-	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, tc->flag));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "msgsnd() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == tc->exp_err) {
-		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO, "msgsnd() failed unexpectedly,"
-			" expected %s", tst_strerrno(tc->exp_err));
-	}
+	TST_EXP_FAIL(msgsnd(queue_id, &snd_buf, MSGSIZE, tc->flag), tc->exp_err,
+		"msgsnd(%i, %p, %i, %i)", queue_id, &snd_buf, MSGSIZE, tc->flag);
 }
 
 static void sighandler(int sig)
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
index 9f462b672..8fc665e68 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
@@ -28,18 +28,8 @@ static struct buf {
 
 static void verify_msgsnd(void)
 {
-	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "msgsnd() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == EIDRM) {
-		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO,
-			"msgsnd() failed unexpectedly, expected EIDRM");
-	}
+	TST_EXP_FAIL(msgsnd(queue_id, &snd_buf, MSGSIZE, 0), EIDRM,
+		"msgsnd(%i, %p, %i, 0)", queue_id, &snd_buf, MSGSIZE);
 }
 
 static void do_test(void)
-- 
2.23.0

