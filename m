From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 15 Jan 2021 16:19:10 +0100
Subject: [LTP] [PATCH] semctl09: Fix heap smash
Message-ID: <20210115151910.3592-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

semctl() expects pointer to a buffer as its fourth argument, not pointer
to a pointer. Passing &un.buf results in heap smash that corrupts internal
LTP data structures on some archs.

CC: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ipc/semctl/semctl09.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index 131bfbc07..d36ba62e5 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -51,11 +51,15 @@ static union semun un;
  */
 static inline int do_semctl(int semid, int semnum, int cmd)
 {
+	struct semid_ds info;
+
+	un.buf = &info;
+
 	switch (tst_variant) {
 	case 0:
-		return tst_syscall(__NR_semctl, semid, semnum, cmd, &un.buf);
+		return tst_syscall(__NR_semctl, semid, semnum, cmd, un);
 	case 1:
-		return semctl(semid, semnum, cmd, &un.buf);
+		return semctl(semid, semnum, cmd, un);
 	}
 	return -1;
 }
-- 
2.29.2

