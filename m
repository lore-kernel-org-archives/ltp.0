From: Ian May <ian.s.may@gmail.com>
Date: Wed,  4 Aug 2021 00:42:16 +0000
Subject: [LTP] [PATCH] syscalls/shmget03: Stat and skip existing shared
 segments
Message-ID: <20210804004216.2754304-1-ian.may@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Ian May <ian.s.may@gmail.com>

Run a SHM_STAT prior to the creation of the shared memory segment.
This allows for not failing unexpectedly and still exhausting the
proper max shared segments.

Signed-off-by: Ian May <ian.s.may@gmail.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget03.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index efbc465e1..fe91b6191 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -34,6 +34,7 @@ static void verify_shmget(void)
 static void setup(void)
 {
 	int res, num;
+	struct shmid_ds buf;
 
 	shmkey = GETIPCKEY();
 
@@ -41,6 +42,8 @@ static void setup(void)
 
 	queues = SAFE_MALLOC(maxshms * sizeof(int));
 	for (num = 0; num < maxshms; num++) {
+		if(shmctl(num, SHM_STAT, &buf) != -1)
+			continue;
 		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
 		if (res == -1)
 			tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
-- 
2.25.1

