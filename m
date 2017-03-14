From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Mar 2017 16:15:45 +0100
Subject: [LTP] [COMMITTED] [PATCH] syscalls/madvise06: Fix cleanup()
Message-ID: <20170314151545.9137-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If there not enough system RAM/swap the test produced warnings in
cleanup:

...
madvise06.c:71: CONF: System RAM is too small, skip test
safe_file_ops.c:283: WARN: Failed to open FILE 'memory/tasks' for writing at madvise06.c:96: ENOENT
safe_macros.c:184: WARN: madvise06.c:97: rmdir(memory/madvise06) failed: ENOENT
safe_macros.c:724: WARN: madvise06.c:98: umount(memory) failed: ENOENT

Which is because we attempted to umount and remove memory cgroup that
wasn't mounted at all. Now attempt the cleanup only if the directory
exitsts and if it's mounted (the tasks file exists).

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 7e75f14..9b3e1f0 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -67,10 +67,14 @@ static void setup(void)
 	SAFE_FILE_PRINTF(drop_caches_fname, "3");
 
 	sysinfo(&sys_buf_start);
-	if (sys_buf_start.freeram < 2 * CHUNK_SZ)
-		tst_brk(TCONF, "System RAM is too small, skip test");
-	if (sys_buf_start.freeswap < 2 * CHUNK_SZ)
-		tst_brk(TCONF, "System swap is too small");
+	if (sys_buf_start.freeram < 2 * CHUNK_SZ) {
+		tst_brk(TCONF, "System RAM is too small (%li bytes needed)",
+			2 * CHUNK_SZ);
+	}
+	if (sys_buf_start.freeswap < 2 * CHUNK_SZ) {
+		tst_brk(TCONF, "System swap is too small (%li bytes needed)",
+			2 * CHUNK_SZ);
+	}
 
 	SAFE_MKDIR(MNT_NAME, 0700);
 	if (mount("memory", MNT_NAME, "cgroup", 0, "memory") == -1) {
@@ -93,9 +97,11 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_FILE_PRINTF(MNT_NAME"/tasks", "%d\n", getpid());
-	SAFE_RMDIR(MNT_NAME"/"GROUP_NAME);
-	SAFE_UMOUNT(MNT_NAME);
+	if (!access(MNT_NAME"/tasks", F_OK)) {
+		SAFE_FILE_PRINTF(MNT_NAME"/tasks", "%d\n", getpid());
+		SAFE_RMDIR(MNT_NAME"/"GROUP_NAME);
+		SAFE_UMOUNT(MNT_NAME);
+	}
 }
 
 static void dirty_pages(char *ptr, long size)
-- 
2.10.2

