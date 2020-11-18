From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 18 Nov 2020 14:00:23 +0800
Subject: [LTP] [PATCH] syscalls/madvise06: Add check for
 /proc/sys/vm/stat_refresh file
Message-ID: <1605679223-6665-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On older kernel(ie centos 7.8ga), when we write 1 to /proc/sys/vm/stat_refresh,
it failed to write because this file[1] was not introdued into centos7 kernel.
It triggers a warnging. So do_exit() in tst_test.c will report TWARN(4) to ltp-pan and
ltp-pan think this case failed.

......
safe_file_ops.c:238: TWARN: Failed to open FILE '/proc/sys/vm/stat_refresh' at madvise06.c:78
......
Summary:
passed   2
failed   0
skipped  0
warnings 7
<<<execution_status>>>
initiation_status="ok"
duration=6 termination_type=exited termination_id=4 corefile=no
cutime=4 cstime=66
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL

I don't want to modify do_exit() logic(such as use "if (results->warning && !results->passed)" for TWARN)
because TWARN indeeds reports something goes wrong. So just add a check for this stat_refresh file
before write.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52b6f46bc

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 7e9e9ef84..962554163 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -54,7 +54,7 @@
 #define GROUP_NAME "madvise06"
 
 static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
-static int pg_sz;
+static int pg_sz, stat_refresh_sup;
 
 static long init_swap, init_swap_cached, init_cached;
 
@@ -75,7 +75,9 @@ static void meminfo_diag(const char *point)
 {
 	long rval;
 
-	FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
+	if (stat_refresh_sup)
+		SAFE_FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
+
 	tst_res(TINFO, "%s", point);
 	tst_res(TINFO, "\tSwap: %ld Kb",
 		SAFE_READ_MEMINFO("SwapTotal:") - SAFE_READ_MEMINFO("SwapFree:") - init_swap);
@@ -143,6 +145,9 @@ static void setup(void)
 	init_swap_cached = SAFE_READ_MEMINFO("SwapCached:");
 	init_cached = SAFE_READ_MEMINFO("Cached:");
 
+	if (!access("/proc/sys/vm/stat_refresh", W_OK))
+		stat_refresh_sup = 1;
+
 	tst_res(TINFO, "mapping %ld Kb (%ld pages), limit %ld Kb, pass threshold %ld Kb",
 		CHUNK_SZ / 1024, CHUNK_SZ / pg_sz, MEM_LIMIT / 1024, PASS_THRESHOLD_KB);
 }
@@ -203,7 +208,8 @@ static void test_advice_willneed(void)
 	do {
 		loops--;
 		usleep(100000);
-		FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
+		if (stat_refresh_sup)
+			SAFE_FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
 		SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
 			&swapcached);
 	} while (swapcached < swapcached_start + PASS_THRESHOLD_KB && loops > 0);
-- 
2.23.0



