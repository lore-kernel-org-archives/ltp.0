From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  2 May 2017 15:33:29 +0200
Subject: [LTP] [RFC] [PATCH] syscalls/madvise09: Fix for disabled swap
	accounting
Message-ID: <20170502133329.9913-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test had to be fixed for systems with swap accounting disabled.

First there are no "memsw" prefixed tuning knobs in memcg directories if
swap accounting is disabled.

Then we had to limit the hungry child since otherwise it will be killed
only after all system swap was filled. Hence we exit the memory hungry
child once the process fills 100MB of swap. That seems to be enough to
put the cgroup into memory pressure while it limits the test runtime to
a few seconds.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 31 ++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 45a14a089..38a101fb6 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -67,6 +67,8 @@ static char memsw_limit_in_bytes_path[PATH_MAX];
 static size_t page_size;
 static int sleep_between_faults;
 
+static int swap_accounting_enabled;
+
 #define PAGES 32
 #define TOUCHED_PAGE1 0
 #define TOUCHED_PAGE2 10
@@ -84,6 +86,17 @@ static void memory_pressure_child(void)
 			ptr[i * page_size] = i % 100;
 			usleep(sleep_between_faults);
 		}
+
+		/* If swap accounting is disabled exit after process swapped out 100MB */
+		if (!swap_accounting_enabled) {
+			int swapped;
+
+			SAFE_FILE_LINES_SCANF("/proc/self/status", "VmSwap: %d", &swapped);
+
+			if (swapped > 100 * 1024)
+				exit(0);
+		}
+
 	}
 
 	abort();
@@ -187,9 +200,14 @@ static void child(void)
 	tst_res(TINFO, "Setting memory limits to %u %u", usage, 2 * usage);
 
 	SAFE_FILE_SCANF(limit_in_bytes_path, "%u", &old_limit);
-	SAFE_FILE_SCANF(memsw_limit_in_bytes_path, "%u", &old_memsw_limit);
+
+	if (swap_accounting_enabled)
+		SAFE_FILE_SCANF(memsw_limit_in_bytes_path, "%u", &old_memsw_limit);
+
 	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", usage);
-	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", 2 * usage);
+
+	if (swap_accounting_enabled)
+		SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", 2 * usage);
 
 	do {
 		sleep_between_faults++;
@@ -245,7 +263,9 @@ static void child(void)
 	else
 		tst_res(TPASS, "All pages have expected content");
 
-	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", old_memsw_limit);
+	if (swap_accounting_enabled)
+		SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", old_memsw_limit);
+
 	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", old_limit);
 
 	SAFE_MUNMAP(ptr, PAGES);
@@ -298,6 +318,11 @@ static void setup(void)
 			"' not present, CONFIG_MEMCG missing?");
 	}
 
+	if (!access(MEMCG_PATH "memory.memsw.limit_in_bytes", F_OK))
+		swap_accounting_enabled = 1;
+	else
+		tst_res(TINFO, "Swap accounting is disabled");
+
 	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapTotal: %ld", &swap_total);
 	if (swap_total <= 0)
 		tst_brk(TCONF, "MADV_FREE does not work without swap");
-- 
2.12.2

