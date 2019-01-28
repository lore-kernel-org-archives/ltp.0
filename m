From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 28 Jan 2019 13:54:11 +0800
Subject: [LTP] [PATCH 2/2] syscalls/madvise09.c: Use library functions to
	check specified cgroup subsystem
In-Reply-To: <1548654851-19112-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1548654851-19112-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1548654851-19112-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Apply tst_set_cgroup_mntpoint() and tst_umount_cgroup().
2) Remove redundant '/'.
3) Add and use dir_cleanup() in run().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index f744405..4aaf1db 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -56,8 +56,9 @@
 
 #include "tst_test.h"
 #include "lapi/mmap.h"
+#include "tst_cgroups.h"
 
-#define MEMCG_PATH "/sys/fs/cgroup/memory/"
+#define MEMCG_PATH "test_memcg"
 
 static char cgroup_path[PATH_MAX];
 static char tasks_path[PATH_MAX];
@@ -105,7 +106,7 @@ static void memory_pressure_child(void)
 static void setup_cgroup_paths(int pid)
 {
 	snprintf(cgroup_path, sizeof(cgroup_path),
-		 MEMCG_PATH "ltp_madvise09_%i/", pid);
+		 MEMCG_PATH "/ltp_madvise09_%i", pid);
 	snprintf(tasks_path, sizeof(tasks_path), "%s/tasks", cgroup_path);
 	snprintf(limit_in_bytes_path, sizeof(limit_in_bytes_path),
 		 "%s/memory.limit_in_bytes", cgroup_path);
@@ -273,12 +274,19 @@ static void child(void)
 	exit(0);
 }
 
-static void cleanup(void)
+static void dir_cleanup(void)
 {
 	if (cgroup_path[0] && !access(cgroup_path, F_OK))
 		rmdir(cgroup_path);
 }
 
+static void cleanup(void)
+{
+	dir_cleanup();
+
+	tst_umount_cgroup(MEMCG_PATH);
+}
+
 static void run(void)
 {
 	pid_t pid;
@@ -294,7 +302,7 @@ retry:
 
 	setup_cgroup_paths(pid);
 	SAFE_WAIT(&status);
-	cleanup();
+	dir_cleanup();
 
 	/*
 	 * Rarely cgroup OOM kills both children not only the one that allocates
@@ -316,10 +324,7 @@ static void setup(void)
 {
 	long int swap_total;
 
-	if (access(MEMCG_PATH, F_OK)) {
-		tst_brk(TCONF, "'" MEMCG_PATH
-			"' not present, CONFIG_MEMCG missing?");
-	}
+	tst_set_cgroup_mntpoint("memory", MEMCG_PATH);
 
 	if (!access(MEMCG_PATH "memory.memsw.limit_in_bytes", F_OK))
 		swap_accounting_enabled = 1;
@@ -339,4 +344,5 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
+	.needs_tmpdir = 1,
 };
-- 
1.8.3.1



