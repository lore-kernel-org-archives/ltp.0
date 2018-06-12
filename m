From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:23 +0200
Subject: [LTP] [RFC PATCH 1/9] tst_safe_sysv_ipc: Make safe_shmctl() and
	safe_msgctl() safer
In-Reply-To: <20180612154631.435-1-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
Message-ID: <20180612154631.435-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We recently had a regression in Sys V IPC when IPC_STAT returned
non-zero integer on success wrongly, which wasn't caught by LTP test but
breaks software in the wild.

This commit changes safe_shmctl() and safe_msgctl() to check the return
value with != 0 for IPC_STAT, IPC_SET and IPC_RMID and with == -1
otherwise.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_safe_sysv_ipc.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index ff53a2420..86f2d934b 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -23,6 +23,24 @@
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 
+/*
+ * The IPC_STAT, IPC_SET and IPC_RMID can return either 0 or -1.
+ *
+ * Linux specific cmds either returns -1 on failure or positive integer
+ * either index into an kernel array or shared primitive indentifier.
+ */
+static int ret_check(int cmd, int ret)
+{
+	switch (cmd) {
+	case IPC_STAT:
+	case IPC_SET:
+	case IPC_RMID:
+		return ret != 0;
+	default:
+		return ret == -1;
+	}
+}
+
 int safe_msgget(const char *file, const int lineno, key_t key, int msgflg)
 {
 	int rval;
@@ -72,11 +90,13 @@ int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
 	int rval;
 
 	rval = msgctl(msqid, cmd, buf);
-	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: msgctl(%i, %i, %p) failed",
-			file, lineno, msqid, cmd, buf);
+	if (ret_check(cmd, rval)) {
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: msgctl(%i, %i, %p) = %i failed",
+			file, lineno, msqid, cmd, buf, rval);
 	}
 
+
 	return rval;
 }
 
@@ -127,9 +147,10 @@ int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
 	int rval;
 
 	rval = shmctl(shmid, cmd, buf);
-	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: shmctl(%i, %i, %p) failed",
-			file, lineno, shmid, cmd, buf);
+	if (ret_check(cmd, rval)) {
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: shmctl(%i, %i, %p) = %i failed",
+			file, lineno, shmid, cmd, buf, rval);
 	}
 
 	return rval;
-- 
2.13.6

