From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Mon, 12 Jul 2021 10:52:23 +0300
Subject: [LTP] [PATCH v2 2/2] msgget03: don't depend on existed shared
 resources
In-Reply-To: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210712075223.10682-2-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's unlikely, but still possible that some of them could be
created/released during the test as well, so the patch only
checks errno.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
v2: * Move the loop to the test run function and try to get
      ENOSPC errno there.

 .../kernel/syscalls/ipc/msgget/msgget03.c     | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 76cf82cd3..1ade8f942 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -26,29 +26,30 @@ static key_t msgkey;
 
 static void verify_msgget(void)
 {
-	TST_EXP_FAIL2(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL), ENOSPC,
-		"msgget(%i, %i)", msgkey + maxmsgs, IPC_CREAT | IPC_EXCL);
+	int res = 0, num;
+
+	errno = 0;
+	for (num = 0; num <= maxmsgs; ++num) {
+		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
+		if (res == -1)
+			break;
+		queues[queue_cnt++] = res;
+	}
+
+	if (res != -1 || errno != ENOSPC)
+		tst_brk(TFAIL | TERRNO, "Failed to trigger ENOSPC error");
+
+	tst_res(TPASS, "Maximum number of queues reached (%d), used by test %d",
+		maxmsgs, queue_cnt);
 }
 
 static void setup(void)
 {
-	int res, num;
-
 	msgkey = GETIPCKEY();
 
 	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%i", &maxmsgs);
 
-	queues = SAFE_MALLOC(maxmsgs * sizeof(int));
-
-	for (num = 0; num < maxmsgs; num++) {
-		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
-		if (res == -1)
-			tst_brk(TBROK | TERRNO, "msgget failed unexpectedly");
-		queues[queue_cnt++] = res;
-	}
-
-	tst_res(TINFO, "The maximum number of message queues (%d) reached",
-		maxmsgs);
+	queues = SAFE_MALLOC((maxmsgs + 1) * sizeof(int));
 }
 
 static void cleanup(void)
-- 
2.25.1

