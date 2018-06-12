From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:24 +0200
Subject: [LTP] [RFC PATCH 2/9] tst_safe_sysv_ipc: SAFE_{SHMCTL,
	MSGCTL} return retval
In-Reply-To: <20180612154631.435-1-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
Message-ID: <20180612154631.435-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These calls do return index into kernel internal array or IPC id for
Linux specific cmds, hence we need to propagate the return value.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_sysv_ipc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/tst_safe_sysv_ipc.h b/include/tst_safe_sysv_ipc.h
index e01957f75..4c7500531 100644
--- a/include/tst_safe_sysv_ipc.h
+++ b/include/tst_safe_sysv_ipc.h
@@ -39,10 +39,10 @@ ssize_t safe_msgrcv(const char *file, const int lineno, int msqid, void *msgp,
 
 int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
 		struct msqid_ds *buf);
-#define SAFE_MSGCTL(msqid, cmd, buf) do { \
-	safe_msgctl(__FILE__, __LINE__, (msqid), (cmd), (buf)); \
+#define SAFE_MSGCTL(msqid, cmd, buf) ({ \
+	int tst_ret_ = safe_msgctl(__FILE__, __LINE__, (msqid), (cmd), (buf)); \
 	(msqid) = ((cmd) == IPC_RMID ? -1 : (msqid)); \
-	} while (0)
+	tst_ret_;})
 
 int safe_shmget(const char *file, const int lineno, key_t key, size_t size,
 		int shmflg);
@@ -59,9 +59,9 @@ int safe_shmdt(const char *file, const int lineno, const void *shmaddr);
 
 int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
 		struct shmid_ds *buf);
-#define SAFE_SHMCTL(shmid, cmd, buf) do { \
-	safe_shmctl(__FILE__, __LINE__, (shmid), (cmd), (buf)); \
+#define SAFE_SHMCTL(shmid, cmd, buf) ({ \
+	int tst_ret_ = safe_shmctl(__FILE__, __LINE__, (shmid), (cmd), (buf)); \
 	(shmid) = ((cmd) == IPC_RMID ? -1 : (shmid)); \
-	} while (0)
+	tst_ret_;})
 
 #endif /* TST_SAFE_SYSV_IPC_H__ */
-- 
2.13.6

