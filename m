From: xiao yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 27 Dec 2017 15:40:04 +0800
Subject: [LTP] [PATCH] syscalls/madvise09.c: Use custom mount point instead
	of /sys/fs/cgroup/memory
Message-ID: <1514360404-12151-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) on some distros(e.g. RHEL6), memory cgroup was supported and
   mounted on /cgroup/memory by default, but the test was skipped
   if /sys/fs/cgroup/memory did not exist.

2) We got the following error if memory cgroup wasn't mounted
   on /sys/fs/cgroup/memory:
------------------------------------------------------------
safe_macros.c:169: BROK: madvise09.c:175: mkdir(/sys/fs/cgroup/memory/ltp_madvise09_16386/,0777) failed: EROFS
------------------------------------------------------------

We use custom mount point and mount memory cgroup on it manually
to fix these issues.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 29 +++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index f744405..ef0fa3b 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -53,12 +53,14 @@
 #include <errno.h>
 #include <stdio.h>
 #include <ctype.h>
+#include <sys/mount.h>
 
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
-#define MEMCG_PATH "/sys/fs/cgroup/memory/"
+#define MEMCG_PATH "/dev/memcg_madvise09/"
 
+static int memcg_mounted;
 static char cgroup_path[PATH_MAX];
 static char tasks_path[PATH_MAX];
 static char limit_in_bytes_path[PATH_MAX];
@@ -277,6 +279,15 @@ static void cleanup(void)
 {
 	if (cgroup_path[0] && !access(cgroup_path, F_OK))
 		rmdir(cgroup_path);
+
+	if (memcg_mounted) {
+		tst_res(TINFO, "Umount memory cgroup after testing");
+		SAFE_UMOUNT(MEMCG_PATH);
+		memcg_mounted = 0;
+	}
+
+	if (!access(MEMCG_PATH, F_OK) && rmdir(MEMCG_PATH))
+		tst_res(TWARN | TERRNO, "Rmdir %s failed", MEMCG_PATH);
 }
 
 static void run(void)
@@ -316,10 +327,20 @@ static void setup(void)
 {
 	long int swap_total;
 
-	if (access(MEMCG_PATH, F_OK)) {
-		tst_brk(TCONF, "'" MEMCG_PATH
-			"' not present, CONFIG_MEMCG missing?");
+	SAFE_MKDIR(MEMCG_PATH, 0777);
+
+	tst_res(TINFO, "Mount memory cgroup on %s", MEMCG_PATH);
+	if (mount("memcg", MEMCG_PATH, "cgroup", 0, "memory") == -1) {
+		if (errno == ENODEV) {
+			if (rmdir(MEMCG_PATH) == -1)
+				tst_res(TWARN | TERRNO, "Rmdir %s failed",
+					 MEMCG_PATH);
+			tst_brk(TCONF,
+				 "Memory cgroup was not configured in kernel");
+		}
+		tst_brk(TBROK | TERRNO, "Failed to mount memory cgroup");
 	}
+	memcg_mounted = 1;
 
 	if (!access(MEMCG_PATH "memory.memsw.limit_in_bytes", F_OK))
 		swap_accounting_enabled = 1;
-- 
1.8.3.1



