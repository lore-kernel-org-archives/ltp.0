From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Tue, 22 Dec 2020 03:48:26 -0500
Subject: [LTP] [PATCH 1/3] Add SAFE_SEMCTL() and SAFE_SEMGET() macro
Message-ID: <1608626908-8117-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 include/tst_safe_sysv_ipc.h | 14 +++++++++++++
 lib/tst_safe_sysv_ipc.c     | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/tst_safe_sysv_ipc.h b/include/tst_safe_sysv_ipc.h
index 3e0e50e..bb65326 100644
--- a/include/tst_safe_sysv_ipc.h
+++ b/include/tst_safe_sysv_ipc.h
@@ -9,6 +9,7 @@
 #include <sys/ipc.h>
 #include <sys/msg.h>
 #include <sys/shm.h>
+#include <sys/sem.h>
 
 int safe_msgget(const char *file, const int lineno, key_t key, int msgflg);
 #define SAFE_MSGGET(key, msgflg) \
@@ -51,4 +52,17 @@ int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
 	(shmid) = ((cmd) == IPC_RMID ? -1 : (shmid)); \
 	tst_ret_;})
 
+int safe_semget(const char *file, const int lineno, key_t key, int nsems,
+		int semflg);
+#define SAFE_SEMGET(key, nsems, semflg) \
+	safe_semget(__FILE__, __LINE__, (key), (nsems), (semflg))
+
+int safe_semctl(const char *file, const int lineno, int semid, int semnum,
+		int cmd, ...);
+#define SAFE_SEMCTL(semid, semnum, cmd, ...) ({ \
+	int tst_ret_ = safe_semctl(__FILE__, __LINE__, (semid), (semnum), \
+				(cmd), ##__VA_ARGS__); \
+	(semid) = ((cmd) == IPC_RMID ? -1 : (semid)); \
+	tst_ret_; })
+
 #endif /* TST_SAFE_SYSV_IPC_H__ */
diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index 155e03b..3bad219 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -7,9 +7,11 @@
 #include <sys/ipc.h>
 #include <sys/msg.h>
 #include <sys/shm.h>
+#include <sys/sem.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
+#include "lapi/semun.h"
 
 /*
  * The IPC_STAT, IPC_SET and IPC_RMID can return either 0 or -1.
@@ -175,3 +177,49 @@ int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
 
 	return rval;
 }
+
+int safe_semget(const char *file, const int lineno, key_t key, int nsems,
+		int semflg)
+{
+	int rval;
+
+	rval = semget(key, nsems, semflg);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"semget(%i, %i, %x) failed", (int)key, nsems, semflg);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid semget(%i, %i, %x) return value %d",
+			(int)key, nsems, semflg, rval);
+	}
+
+	return rval;
+}
+
+int safe_semctl(const char *file, const int lineno, int semid, int semnum,
+		int cmd, ...)
+{
+	int rval;
+	va_list va;
+	union semun un;
+
+	va_start(va, cmd);
+
+	un = va_arg(va, union semun);
+
+	va_end(va);
+
+	rval = semctl(semid, semnum, cmd, un);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+		"semctl(%i, %i, %i,...) failed", semid, semnum, cmd);
+	} else if (ret_check(cmd, rval)) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid semctl(%i, %i, %i,...) return value %d", semid,
+			semnum, cmd, rval);
+	}
+
+	return rval;
+}
-- 
1.8.3.1



