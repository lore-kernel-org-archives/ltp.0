From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 25 Jan 2021 12:41:21 +0100
Subject: [LTP] [PATCH] semctl09: Fix EPERM warning in cleanup()
Message-ID: <20210125114121.1368-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If semctl09 failed in one of the SAFE_*() functions during unprivileged user
test case, SAFE_SEMCTL() in cleanup() would fail with EPERM because the sem_id
is owned by root. Make sure that cleanup() always runs with root EUID.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ipc/semctl/semctl09.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index d36ba62e5..f0c757cdd 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -187,6 +187,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	SAFE_SETEUID(root_uid);
+
 	if (sem_id >= 0)
 		SAFE_SEMCTL(sem_id, 0, IPC_RMID);
 }
-- 
2.29.2

