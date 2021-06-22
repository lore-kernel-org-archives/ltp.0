From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:07 +0100
Subject: [LTP] [PATCH 1/8] ipc: Fix uninitialized var error by removing
 useless arg
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 libs/libltpipc/libipc.c                         | 4 +---
 testcases/kernel/syscalls/ipc/semctl/semctl01.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/libs/libltpipc/libipc.c b/libs/libltpipc/libipc.c
index d94880f54..c2ecbf02d 100644
--- a/libs/libltpipc/libipc.c
+++ b/libs/libltpipc/libipc.c
@@ -122,13 +122,11 @@ void init_buf(MSGBUF * m_buf, int type, int size)
  */
 void rm_sema(int sem_id)
 {
-	union semun arr;
-
 	if (sem_id == -1) {	/* no semaphore to remove */
 		return;
 	}
 
-	if (semctl(sem_id, 0, IPC_RMID, arr) == -1) {
+	if (semctl(sem_id, 0, IPC_RMID) == -1) {
 		tst_resm(TINFO, "WARNING: semaphore deletion failed.");
 		tst_resm(TINFO, "This could lead to IPC resource problems.");
 		tst_resm(TINFO, "id = %d", sem_id);
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index b12385970..ff691adf8 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -196,10 +196,8 @@ static void func_sall(void)
 
 static void func_sval(void)
 {
-	int semv;
-	union semun arr;
+	int semv = SAFE_SEMCTL(sem_id, 4, GETVAL);
 
-	semv = SAFE_SEMCTL(sem_id, 4, GETVAL, arr);
 	if (semv != INCVAL)
 		tst_res(TFAIL, "semaphore value is not what was set");
 	else
-- 
2.31.1

