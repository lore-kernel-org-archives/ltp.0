From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Mon, 12 Jul 2021 10:52:22 +0300
Subject: [LTP] [PATCH v2 1/2] shmget03: don't depend on existed shared
 resources
Message-ID: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's unlikely, but still possible that some of them could be
created/released during the test as well, so the patch only
checks errno.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
v2: * Move the loop to the test run function and try to get
      ENOSPC errno there.
    * Rename queues* to segments*

 .../kernel/syscalls/ipc/shmget/shmget03.c     | 42 ++++++++++---------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index efbc465e1..5dc5d55fd 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -21,47 +21,49 @@
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
-static int *queues;
-static int maxshms, queue_cnt;
+static int *segments;
+static int maxshms, segments_cnt;
 static key_t shmkey;
 
 static void verify_shmget(void)
 {
-	TST_EXP_FAIL2(shmget(shmkey + maxshms, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW), ENOSPC,
-		"shmget(%i, %i, %i)", shmkey + maxshms, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
+	int res = 0, num;
+
+	errno = 0;
+	for (num = 0; num <= maxshms; ++num) {
+		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
+		if (res == -1)
+			break;
+		segments[segments_cnt++] = res;
+	}
+
+	if (res != -1 || errno != ENOSPC)
+		tst_brk(TFAIL | TERRNO, "Failed to trigger ENOSPC error");
+
+	tst_res(TPASS, "Maximum number of segments reached (%d), used by test %d",
+		maxshms, segments_cnt);
 }
 
 static void setup(void)
 {
-	int res, num;
-
 	shmkey = GETIPCKEY();
 
 	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i", &maxshms);
 
-	queues = SAFE_MALLOC(maxshms * sizeof(int));
-	for (num = 0; num < maxshms; num++) {
-		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
-		if (res == -1)
-			tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
-
-		queues[queue_cnt++] = res;
-	}
-	tst_res(TINFO, "The maximum number of memory segments (%d) has been reached",
-		maxshms);
+	segments = SAFE_MALLOC((maxshms + 1) * sizeof(int));
 }
 
 static void cleanup(void)
 {
 	int num;
 
-	if (!queues)
+	if (!segments)
 		return;
 
-	for (num = 0; num < queue_cnt; num++)
-		SAFE_SHMCTL(queues[num], IPC_RMID, NULL);
+	for (num = 0; num < segments_cnt; num++)
+		SAFE_SHMCTL(segments[num], IPC_RMID, NULL);
 
-	free(queues);
+	free(segments);
 }
 
 static struct tst_test test = {
-- 
2.25.1

