From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Jun 2021 09:40:18 +0800
Subject: [LTP] [PATCH v2] ipc/msgget03: Make sure we get ENOSPC error after
 creating MSGMNI message queues
In-Reply-To: <CAEemH2eJLd5cSHZLUyXCYBhr643noDPT4RrMb8YBxrE_M3d1gA@mail.gmail.com>
References: <CAEemH2eJLd5cSHZLUyXCYBhr643noDPT4RrMb8YBxrE_M3d1gA@mail.gmail.com>
Message-ID: <1624930818-31474-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Even msgget() failed, this for loop in setup phase still continues. So we can't know
whether system creates actual MSGMNI message queues and then fail with ENOSPC. Fix this by
reporting fail if msgget failed in setup.

Also make use of TST_EXP_FAIL2 macro. It has been introduced in the previous commit
95f518efe ("include/tst_test_macro.h: Add TST_EXP_FAIL2 macros").

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v1->v2: Remove check for -1 and pre-initialize the array
 .../kernel/syscalls/ipc/msgget/msgget03.c     | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 8fa620855..76cf82cd3 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -20,22 +20,14 @@
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
-static int maxmsgs;
+static int maxmsgs, queue_cnt;
 static int *queues;
 static key_t msgkey;
 
 static void verify_msgget(void)
 {
-	TEST(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL));
-	if (TST_RET != -1)
-		tst_res(TFAIL, "msgget() succeeded unexpectedly");
-
-	if (TST_ERR == ENOSPC) {
-		tst_res(TPASS | TTERRNO, "msgget() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO, "msgget() failed unexpectedly,"
-			" expected ENOSPC");
-	}
+	TST_EXP_FAIL2(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL), ENOSPC,
+		"msgget(%i, %i)", msgkey + maxmsgs, IPC_CREAT | IPC_EXCL);
 }
 
 static void setup(void)
@@ -49,11 +41,10 @@ static void setup(void)
 	queues = SAFE_MALLOC(maxmsgs * sizeof(int));
 
 	for (num = 0; num < maxmsgs; num++) {
-		queues[num] = -1;
-
 		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
-		if (res != -1)
-			queues[num] = res;
+		if (res == -1)
+			tst_brk(TBROK | TERRNO, "msgget failed unexpectedly");
+		queues[queue_cnt++] = res;
 	}
 
 	tst_res(TINFO, "The maximum number of message queues (%d) reached",
@@ -67,10 +58,8 @@ static void cleanup(void)
 	if (!queues)
 		return;
 
-	for (num = 0; num < maxmsgs; num++) {
-		if (queues[num] != -1)
-			SAFE_MSGCTL(queues[num], IPC_RMID, NULL);
-	}
+	for (num = 0; num < queue_cnt; num++)
+		SAFE_MSGCTL(queues[num], IPC_RMID, NULL);
 
 	free(queues);
 }
-- 
2.23.0

