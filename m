From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Sep 2021 17:25:33 +0200
Subject: [LTP] [PATCH] syscalls/shmctl05: Remove shm segment only when
 created
Message-ID: <20210915152533.20902-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We cannot remove the shm segment unconditionally. On kernels without
SysV IPC support compiled in the test fails with following:

shmctl05.c:50: TCONF: syscall(396) __NR_shmctl not supported
shmctl05.c:96: TWARN: shmget(61455, 4096, 0) failed: ENOENT (2)
shmctl05.c:97: TWARN: shmctl(-1, 0, (nil)) failed: EINVAL (22)

Fixes: 48d382e8daf2 (syscalls/shmctl05.c: Fix leak of shared memory segment)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index ea7eef6f1..8569322dc 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -92,8 +92,16 @@ static void do_test(void)
 static void cleanup(void)
 {
 	int id;
+
 	tst_fzsync_pair_cleanup(&fzsync_pair);
-	id = SAFE_SHMGET(0xF00F, 4096, 0);
+
+	id = shmget(0xF00F, 4096, 0);
+	if (id == -1) {
+		if (errno != ENOENT)
+			tst_res(TWARN | TERRNO, "shmget()");
+		return;
+	}
+
 	SAFE_SHMCTL(id, IPC_RMID, NULL);
 }
 
-- 
2.32.0

