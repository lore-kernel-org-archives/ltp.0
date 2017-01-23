From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 23 Jan 2017 18:31:15 +0800
Subject: [LTP] [PATCH v2 2/3] ipc/msgget0*: Make use of IPC related macros
In-Reply-To: <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170119143903.GC9193@rei.lan>
 <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1485167476-18151-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/msgget/msgget01.c | 6 ++----
 testcases/kernel/syscalls/ipc/msgget/msgget02.c | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
index 8d2db4d..e19e0da 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
@@ -48,11 +48,9 @@ static void verify_msgget(void)
 
 	queue_id = TEST_RETURN;
 
-	if (msgsnd(queue_id, &snd_buf, MSGSIZE, 0) == -1)
-		tst_brk(TBROK | TERRNO, "msgsnd() failed");
+	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
 
-	if (msgrcv(queue_id, &rcv_buf, MSGSIZE, MSGTYPE, IPC_NOWAIT) == -1)
-		tst_brk(TBROK | TERRNO, "msgrcv() failed");
+	SAFE_MSGRCV(queue_id, &rcv_buf, MSGSIZE, MSGTYPE, IPC_NOWAIT);
 
 	if (strcmp(snd_buf.text, rcv_buf.text) == 0)
 		tst_res(TPASS, "message received = message sent");
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index a3fcb38..d5e2820 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -96,9 +96,7 @@ static void setup(void)
 	msgkey = GETIPCKEY();
 	msgkey1 = GETIPCKEY();
 
-	queue_id = msgget(msgkey, IPC_CREAT | IPC_EXCL);
-	if (queue_id == -1)
-		tst_brk(TBROK | TERRNO, "can't create message queue");
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL);
 
 	pw = SAFE_GETPWNAM("nobody");
 }
-- 
1.8.3.1



