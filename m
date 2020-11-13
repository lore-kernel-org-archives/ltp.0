From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Nov 2020 11:44:25 +0100
Subject: [LTP] [PATCH v2 1/7] Unify error handling in lib/tst_safe_sysv_ipc.c
Message-ID: <20201113104431.17808-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line locations
- Pedantically check for invalid syscall return values, don't ignore silently

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Added missing "else" keyword

 lib/tst_safe_sysv_ipc.c | 80 ++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index 30b5f6ec7..155e03b5e 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -25,7 +25,7 @@ static int ret_check(int cmd, int ret)
 	case IPC_RMID:
 		return ret != 0;
 	default:
-		return ret == -1;
+		return ret < 0;
 	}
 }
 
@@ -34,9 +34,14 @@ int safe_msgget(const char *file, const int lineno, key_t key, int msgflg)
 	int rval;
 
 	rval = msgget(key, msgflg);
+
 	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: msgget(%i, %x) failed",
-			file, lineno, (int)key, msgflg);
+		tst_brk_(file, lineno, TBROK | TERRNO, "msgget(%i, %x) failed",
+			(int)key, msgflg);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid msgget(%i, %x) return value %d", (int)key,
+			msgflg, rval);
 	}
 
 	return rval;
@@ -48,10 +53,15 @@ int safe_msgsnd(const char *file, const int lineno, int msqid, const void *msgp,
 	int rval;
 
 	rval = msgsnd(msqid, msgp, msgsz, msgflg);
+
 	if (rval == -1) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: msgsnd(%i, %p, %zu, %x) failed",
-			file, lineno, msqid, msgp, msgsz, msgflg);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"msgsnd(%i, %p, %zu, %x) failed", msqid, msgp, msgsz,
+			msgflg);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid msgsnd(%i, %p, %zu, %x) return value %d",
+			msqid, msgp, msgsz, msgflg, rval);
 	}
 
 	return rval;
@@ -63,10 +73,15 @@ ssize_t safe_msgrcv(const char *file, const int lineno, int msqid, void *msgp,
 	ssize_t rval;
 
 	rval = msgrcv(msqid, msgp, msgsz, msgtyp, msgflg);
+
 	if (rval == -1) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: msgrcv(%i, %p, %zu, %li, %x) failed",
-			file, lineno, msqid, msgp, msgsz, msgtyp, msgflg);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"msgrcv(%i, %p, %zu, %li, %x) failed",
+			msqid, msgp, msgsz, msgtyp, msgflg);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid msgrcv(%i, %p, %zu, %li, %x) return value %ld",
+			msqid, msgp, msgsz, msgtyp, msgflg, rval);
 	}
 
 	return rval;
@@ -78,12 +93,15 @@ int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
 	int rval;
 
 	rval = msgctl(msqid, cmd, buf);
-	if (ret_check(cmd, rval)) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: msgctl(%i, %i, %p) = %i failed",
-			file, lineno, msqid, cmd, buf, rval);
-	}
 
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"msgctl(%i, %i, %p) failed", msqid, cmd, buf);
+	} else if (ret_check(cmd, rval)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid msgctl(%i, %i, %p) return value %d", msqid,
+			cmd, buf, rval);
+	}
 
 	return rval;
 }
@@ -94,9 +112,14 @@ int safe_shmget(const char *file, const int lineno, key_t key, size_t size,
 	int rval;
 
 	rval = shmget(key, size, shmflg);
+
 	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: shmget(%i, %zu, %x) failed",
-			file, lineno, (int)key, size, shmflg);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"shmget(%i, %zu, %x) failed", (int)key, size, shmflg);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid shmget(%i, %zu, %x) return value %d",
+			(int)key, size, shmflg, rval);
 	}
 
 	return rval;
@@ -108,9 +131,10 @@ void *safe_shmat(const char *file, const int lineno, int shmid,
 	void *rval;
 
 	rval = shmat(shmid, shmaddr, shmflg);
+
 	if (rval == (void *)-1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: shmat(%i, %p, %x) failed",
-			file, lineno, shmid, shmaddr, shmflg);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"shmat(%i, %p, %x) failed", shmid, shmaddr, shmflg);
 	}
 
 	return rval;
@@ -121,9 +145,13 @@ int safe_shmdt(const char *file, const int lineno, const void *shmaddr)
 	int rval;
 
 	rval = shmdt(shmaddr);
+
 	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: shmdt(%p) failed",
-			file, lineno, shmaddr);
+		tst_brk_(file, lineno, TBROK | TERRNO, "shmdt(%p) failed",
+			shmaddr);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid shmdt(%p) return value %d", shmaddr, rval);
 	}
 
 	return rval;
@@ -135,10 +163,14 @@ int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
 	int rval;
 
 	rval = shmctl(shmid, cmd, buf);
-	if (ret_check(cmd, rval)) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: shmctl(%i, %i, %p) = %i failed",
-			file, lineno, shmid, cmd, buf, rval);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"shmctl(%i, %i, %p) failed", shmid, cmd, buf);
+	} else if (ret_check(cmd, rval)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid shmctl(%i, %i, %p) return value %d", shmid,
+			cmd, buf, rval);
 	}
 
 	return rval;
-- 
2.28.0

