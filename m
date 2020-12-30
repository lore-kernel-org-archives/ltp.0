From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 30 Dec 2020 17:25:24 +0800
Subject: [LTP] [PATCH] lib/tst_safe_sysv_ipc.c: add other cmds in ret_check
Message-ID: <1609320324-8405-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From semctl and shmctl manpage, these cmds(SHM_LOCK, SHM_UNLOCK,
SETALL,SETVAL) also return 0 on success, so add them in ret_check function.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 lib/tst_safe_sysv_ipc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index 70f2568cb..e72985d61 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -13,7 +13,8 @@
 #include "lapi/sem.h"
 
 /*
- * The IPC_STAT, IPC_SET and IPC_RMID can return either 0 or -1.
+ * The IPC_STAT, IPC_SET, IPC_RMID, SHM_LOCK, SHM_UNLOCK, SETALL and SETVAL
+ * can return either 0 or -1.
  *
  * Linux specific cmds either returns -1 on failure or positive integer
  * either index into an kernel array or shared primitive indentifier.
@@ -24,6 +25,10 @@ static int ret_check(int cmd, int ret)
 	case IPC_STAT:
 	case IPC_SET:
 	case IPC_RMID:
+	case SHM_LOCK:
+	case SHM_UNLOCK:
+	case SETALL:
+	case SETVAL:
 		return ret != 0;
 	default:
 		return ret < 0;
-- 
2.23.0



