From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 13 Apr 2016 18:27:58 +0800
Subject: [LTP] [PATCH v2] syscalls/msgctl13: fix error when run on the new
 system
In-Reply-To: <20160411165848.GA3466@rei.lan>
References: <1460187421-2578-1-git-send-email-cuibixuan@huawei.com>
 <20160411165848.GA3466@rei.lan>
Message-ID: <570E1F2E.6060403@huawei.com>
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

Use msgctl with IPC_STAT to check it.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl13.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
index e170d6b..50d48d4 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl13.c
@@ -28,6 +28,8 @@

 char *TCID = "msgctl13";
 int TST_TOTAL = 1;
+static struct msqid_ds buf;
+
 static void msgctl_verify(void);

 int main(int argc, char *argv[])
@@ -72,8 +74,8 @@ static void msgctl_verify(void)
 		return;
 	}

-	TEST(msgget(msg_q, MSG_RW));
-	if (TEST_ERRNO == ENOENT)
+	TEST(msgctl(msg_q, IPC_STAT, &buf));
+	if (TEST_ERRNO == EINVAL)
 		tst_resm(TPASS, "msgctl() test IPC_RMID succeeded");
 	else
 		tst_resm(TFAIL, "msgctl() test IPC_RMID failed unexpectedly");
-- 
1.8.3.4
