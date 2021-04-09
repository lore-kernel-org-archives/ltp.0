From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 9 Apr 2021 19:55:04 +0800
Subject: [LTP] [PATCH v3 2/3] tst_safe_sysv_ipc.c: Fix wrong ret_check
In-Reply-To: <1617969305-2237-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YHAoQooWArsl2rgD@yuki>
 <1617969305-2237-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1617969305-2237-2-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit e9e508aad1("lib/tst_safe_sysv_ipc.c: add other cmds in ret_check"),
we added these cmds(SHM_LOCK, SHM_UNLOCK,SETALL,SETVAL) commands into this check.

It is wrong because these flags are defined in different system headers, the same value
can represent different meaning in differnent headers. ie. SHM_LOCK is 11, GETPID is
also 11. SHM_LOCK only returns 0 and -1 but GETPID returns -1 and postive num. ret_check will
idenity it fail even we call semctl with GETPID successfully.

Fix this regression by using different ret check for msg/shm/sem.

Fixes: e9e508aad1("lib/tst_safe_sysv_ipc.c: add other cmds in ret_check")
Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 lib/tst_safe_sysv_ipc.c | 44 ++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index 012f5ba38..5eaa82539 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -13,13 +13,24 @@
 #include "lapi/sem.h"
 
 /*
- * The IPC_STAT, IPC_SET, IPC_RMID, SHM_LOCK, SHM_UNLOCK, SETALL and SETVAL
- * can return either 0 or -1.
- *
- * Linux specific cmds either returns -1 on failure or positive integer
- * either index into an kernel array or shared primitive indentifier.
+ * The IPC_STAT, IPC_SET, IPC_RMID can return either 0 or -1.
  */
-static int ret_check(int cmd, int ret)
+static int msg_ret_check(int cmd, int ret)
+{
+	switch (cmd) {
+	case IPC_STAT:
+	case IPC_SET:
+	case IPC_RMID:
+		return ret != 0;
+	default:
+		return ret < 0;
+	}
+}
+
+/*
+ * The IPC_STAT, IPC_SET, IPC_RMID, SHM_LOCK, SHM_UNLOCK can return either 0 or -1.
+ */
+static int shm_ret_check(int cmd, int ret)
 {
 	switch (cmd) {
 	case IPC_STAT:
@@ -27,6 +38,21 @@ static int ret_check(int cmd, int ret)
 	case IPC_RMID:
 	case SHM_LOCK:
 	case SHM_UNLOCK:
+		return ret != 0;
+	default:
+		return ret < 0;
+	}
+}
+
+/*
+ * The IPC_STAT, IPC_SET, IPC_RMID, SETALL, SETVAL can return either 0 or -1.
+ */
+static int sem_ret_check(int cmd, int ret)
+{
+	switch (cmd) {
+	case IPC_STAT:
+	case IPC_SET:
+	case IPC_RMID:
 	case SETALL:
 	case SETVAL:
 		return ret != 0;
@@ -103,7 +129,7 @@ int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"msgctl(%i, %i, %p) failed", msqid, cmd, buf);
-	} else if (ret_check(cmd, rval)) {
+	} else if (msg_ret_check(cmd, rval)) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid msgctl(%i, %i, %p) return value %d", msqid,
 			cmd, buf, rval);
@@ -173,7 +199,7 @@ int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"shmctl(%i, %i, %p) failed", shmid, cmd, buf);
-	} else if (ret_check(cmd, rval)) {
+	} else if (shm_ret_check(cmd, rval)) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid shmctl(%i, %i, %p) return value %d", shmid,
 			cmd, buf, rval);
@@ -219,7 +245,7 @@ int safe_semctl(const char *file, const int lineno, int semid, int semnum,
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 		"semctl(%i, %i, %i,...) failed", semid, semnum, cmd);
-	} else if (ret_check(cmd, rval)) {
+	} else if (sem_ret_check(cmd, rval)) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Invalid semctl(%i, %i, %i,...) return value %d", semid,
 			semnum, cmd, rval);
-- 
2.23.0

