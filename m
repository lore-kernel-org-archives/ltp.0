From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue,  6 Jul 2021 13:57:58 +0300
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
Message-ID: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's unlikely, but still possible that some of them could be
created during the test as well, so the patch only checks
errno.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget03.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index efbc465e1..6796efc91 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -42,13 +42,17 @@ static void setup(void)
 	queues = SAFE_MALLOC(maxshms * sizeof(int));
 	for (num = 0; num < maxshms; num++) {
 		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
-		if (res == -1)
-			tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
+		if (res == -1) {
+			if (errno == ENOSPC)
+				break;
+			tst_brk(TBROK | TERRNO,
+				"shmget failed unexpectedly, num %d", num);
+		}
 
 		queues[queue_cnt++] = res;
 	}
-	tst_res(TINFO, "The maximum number of memory segments (%d) has been reached",
-		maxshms);
+	tst_res(TINFO, "The max number of memory segments (%d) has been reached, used by test %d",
+		maxshms, queue_cnt);
 }
 
 static void cleanup(void)
-- 
2.25.1

