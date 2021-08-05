From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 5 Aug 2021 11:48:42 +0800
Subject: [LTP] [PATCH v1 2/3] syscalls/shmget03: Create shared memory
 segment dynamically instead of hardcode
In-Reply-To: <1628135323-3722-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1628135323-3722-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1628135323-3722-2-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before this patch, we don't consider this situation that system has consumed shared memory
segments. So we hit the ENOSPC error unexpectedly in setup.

Use GET_USED_SEGMENTS() to get the used shared memory segments, so we can trigger the
ENOSPC error correctly(just hit the limit) even current environment has consumed some
shared memory segments.

I don't use this api in verify function since we don't support run cases in parallel and
we should assume this situation that this case is the only case to use(free or alloc) sysv
ipc resource at that time.

Fixes: #842
Fixes: 4dc493b44 ("syscalls/shmget*: Convert into new api")
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget03.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index efbc465e1..8b157e439 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -22,7 +22,7 @@
 #include "libnewipc.h"
 
 static int *queues;
-static int maxshms, queue_cnt;
+static int maxshms, queue_cnt, used_cnt;
 static key_t shmkey;
 
 static void verify_shmget(void)
@@ -36,11 +36,13 @@ static void setup(void)
 	int res, num;
 
 	shmkey = GETIPCKEY();
-
+	used_cnt = GET_USED_SEGMENTS();
+	tst_res(TINFO, "Current environment %d shared memory segments are already in use",
+		used_cnt);
 	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i", &maxshms);
 
-	queues = SAFE_MALLOC(maxshms * sizeof(int));
-	for (num = 0; num < maxshms; num++) {
+	queues = SAFE_MALLOC((maxshms - used_cnt) * sizeof(int));
+	for (num = 0; num < maxshms - used_cnt; num++) {
 		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
 		if (res == -1)
 			tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
-- 
2.23.0

