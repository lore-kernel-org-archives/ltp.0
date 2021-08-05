From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 5 Aug 2021 11:48:43 +0800
Subject: [LTP] [PATCH v1 3/3] syscalls/msgget03: Create message queues
 dynamically instead of hardcode
In-Reply-To: <1628135323-3722-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1628135323-3722-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1628135323-3722-3-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is the same problem as shmget03. Use the same way to fix this problem
that hit the ENOSPC problem unexpectedly in setup.

Fixes: #842
Fixes: 19a07c445 ("ipc/msgget03: Make sure we get ENOSPC error after..")
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/msgget/msgget03.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index ab5714cdc..711886e17 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -21,7 +21,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
-static int maxmsgs, queue_cnt;
+static int maxmsgs, queue_cnt, used_cnt;
 static int *queues;
 static key_t msgkey;
 
@@ -37,11 +37,15 @@ static void setup(void)
 
 	msgkey = GETIPCKEY();
 
+	used_cnt = GET_USED_QUEUES();
+	tst_res(TINFO, "Current environment %d message queues are already in use",
+		used_cnt);
+
 	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%i", &maxmsgs);
 
-	queues = SAFE_MALLOC(maxmsgs * sizeof(int));
+	queues = SAFE_MALLOC((maxmsgs - used_cnt) * sizeof(int));
 
-	for (num = 0; num < maxmsgs; num++) {
+	for (num = 0; num < maxmsgs - used_cnt; num++) {
 		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
 		if (res == -1)
 			tst_brk(TBROK | TERRNO, "msgget failed unexpectedly");
-- 
2.23.0

