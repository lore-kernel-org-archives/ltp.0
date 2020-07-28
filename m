From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 28 Jul 2020 12:40:23 +0800
Subject: [LTP] [PATCH v1 1/2] libs/libltpnewipc: Use safe macros
Message-ID: <1595911224-12470-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 libs/libltpnewipc/libnewipc.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/libs/libltpnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
index b909cb7e6..3734040b7 100644
--- a/libs/libltpnewipc/libnewipc.c
+++ b/libs/libltpnewipc/libnewipc.c
@@ -21,6 +21,8 @@
 
 #include "tst_test.h"
 #include "libnewipc.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_sysv_ipc.h"
 
 #define BUFSIZE 1024
 
@@ -31,7 +33,7 @@ key_t getipckey(const char *file, const int lineno)
 	int id;
 	static int count;
 
-	SAFE_GETCWD(buf, BUFSIZE);
+	safe_getcwd(file, lineno, NULL, buf, BUFSIZE);
 
 	id = count % 26 + (int) 'a';
 	count++;
@@ -51,11 +53,7 @@ int get_used_queues(const char *file, const int lineno)
 	int used_queues = -1;
 	char buf[BUFSIZE];
 
-	fp = fopen("/proc/sysvipc/msg", "r");
-	if (fp == NULL) {
-		tst_brk(TBROK | TERRNO,
-			"fopen() failed at %s:%d", file, lineno);
-	}
+	fp = safe_fopen(file, lineno, NULL, "/proc/sysvipc/msg", "r");
 
 	while (fgets(buf, BUFSIZE, fp) != NULL)
 		used_queues++;
@@ -78,19 +76,11 @@ void *probe_free_addr(const char *file, const int lineno)
 
 	probe_key = GETIPCKEY();
 
-	shm_id = shmget(probe_key, SHMLBA * 2, SHM_RW | IPC_CREAT | IPC_EXCL);
-	if (shm_id == -1)
-		tst_brk(TBROK, "probe: shmget() failed at %s:%d", file, lineno);
-
-	addr = shmat(shm_id, NULL, 0);
-	if (addr == (void *) -1)
-		tst_brk(TBROK, "probe: shmat() failed at %s:%d", file, lineno);
-
-	if (shmdt(addr) == -1)
-		tst_brk(TBROK, "probe: shmdt() failed at %s:%d", file, lineno);
-
-	if (shmctl(shm_id, IPC_RMID, NULL) == -1)
-		tst_brk(TBROK, "probe: shmctl() failed at %s:%d", file, lineno);
+	shm_id = safe_shmget(file, lineno, probe_key, SHMLBA * 2,
+			     SHM_RW | IPC_CREAT | IPC_EXCL);
+	addr = safe_shmat(file, lineno, shm_id, NULL, 0);
+	safe_shmdt(file, lineno, addr);
+	safe_shmctl(file, lineno, shm_id, IPC_RMID, NULL);
 
 	addr = (void *)(((unsigned long)(addr) + (SHMLBA - 1)) & ~(SHMLBA - 1));
 
-- 
2.23.0



