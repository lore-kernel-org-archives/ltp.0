From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 16 Dec 2016 11:54:16 +0800
Subject: [LTP] [PATCH 1/2] ipc/libnewipc.c: add CREATE_MSG to optimize
	duplicate code
Message-ID: <1481860457-23035-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c | 14 ++++++++++++++
 testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h |  4 ++++
 testcases/kernel/syscalls/ipc/msgget/msgget02.c     |  4 +---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
index 8ea421f..9452309 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/ipc.h>
+#include <sys/msg.h>
 
 #define	TST_NO_DEFAULT_MAIN
 
@@ -79,3 +80,16 @@ int get_used_queues(const char *file, const int lineno)
 
 	return used_queues;
 }
+
+int create_msg(const char *file, const int lineno, key_t key, int msgflg)
+{
+	int rval;
+
+	rval = msgget(key, msgflg);
+	if (rval == -1) {
+		tst_brk(TBROK | TERRNO, "Can't create message queue at %s:%d",
+			file, lineno);
+	}
+
+	return rval;
+}
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
index 39148be..3c313bd 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
@@ -50,4 +50,8 @@ int get_used_queues(const char *file, const int lineno);
 #define GET_USED_QUEUES() \
 	get_used_queues(__FILE__, __LINE__)
 
+int create_msg(const char *file, const int lineno, key_t key, int msgflg);
+#define CREATE_MSG(key, msgflg) \
+	create_msg(__FILE__, __LINE__, key, msgflg)
+
 #endif /* newlibipc.h */
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index a3fcb38..1195cc9 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -96,9 +96,7 @@ static void setup(void)
 	msgkey = GETIPCKEY();
 	msgkey1 = GETIPCKEY();
 
-	queue_id = msgget(msgkey, IPC_CREAT | IPC_EXCL);
-	if (queue_id == -1)
-		tst_brk(TBROK | TERRNO, "can't create message queue");
+	queue_id = CREATE_MSG(msgkey, IPC_CREAT | IPC_EXCL);
 
 	pw = SAFE_GETPWNAM("nobody");
 }
-- 
1.8.3.1



