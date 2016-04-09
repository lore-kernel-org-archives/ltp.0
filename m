From: Cui Bixuan <cuibixuan@huawei.com>
Date: Sat, 9 Apr 2016 07:37:01 +0000
Subject: [LTP] [PATCH] syscalls/msgctl13: fix error when run on the new
	system
Message-ID: <1460187421-2578-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The msqid is 0 when a new message queue is created by msgget()
on the new system. Then 'TEST(msgget(msg_q, MSG_RW))' succeed
unexpectedly.

Run 'msg_q = msgget(IPC_PRIVATE, MSG_RW)', we get:
	msgget(IPC_PRIVATE, 0600)               = 0
The msg_q is 0 when create it on the new system.Next:
	msgctl(0, IPC_RMID, 0)                  = 0
	msgget(IPC_PRIVATE, 0600)               = 32768

The msg_q is equal to IPC_PRIVATE which is defined at kernel,
So msgget() will create a new message queue again and return
success unexpectedly.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
index e170d6b..721dd88 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
@@ -60,9 +60,11 @@ static void msgctl_verify(void)
 {
 	int msg_q;
 
-	msg_q = msgget(IPC_PRIVATE, MSG_RW);
-	if (msg_q == -1)
-		tst_brkm(TBROK, cleanup, "Can't create message queue");
+	do {
+		msg_q = msgget(IPC_PRIVATE, MSG_RW);
+		if (msg_q == -1)
+			tst_brkm(TBROK, cleanup, "Can't create message queue");
+	} while (!msg_q);
 
 	TEST(msgctl(msg_q, IPC_RMID, NULL));
 
-- 
1.8.3.4

