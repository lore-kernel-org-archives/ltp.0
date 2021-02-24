From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Feb 2021 08:25:00 +0000
Subject: [LTP] [PATCH v2] swapping01: check memory swap usage per process
Message-ID: <20210224082500.18106-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Issue:

Currently test swapping01 read the system FreeSwap for counting usage of
swap-size, that's not precise on system especially with eating-memory daemon
in the background.

Improvement:

Considering that swap out unreferenced pages also could be occurred in a
single process. So that we encapsulate all of the means in a single process
to avoid involving the whole system swap-counting. Then only try to check the
'VmSwap' in proc/PID/status?per process, to get rid of?the potential influence
from?other processes?which easily leads to false positive.  e.g.

Child:
         touch unreferenced pages (via alloc&write&free 1.3*MemAvailable) [1]
         alloc&wirte 1.3*MemAvailable
         raise(SIGSTOP)
         ...
Parent:
         waiting for child suspension
         check child's VmSwap to see if heavy-swap occurs in a process
         ...

[1] As to perform alloc&write&free, the system pages will go through a
completed life cycle from buddy-system to active-list to inactive-list
then back to buddy-system, which reflect to a page status is theoretically like:
"inactive,unreferenced -> active,referenced -> ... ->inactive,unreferenced"
so that will helpful to produce what the kernel target commit fixed situation.

New reproducer works well with unfix-kernel:

  # uname  -r
  2.6.39

  # ./swapping01
  tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
  swapping01.c:110: TINFO: available physical memory: 1896 MB
  swapping01.c:113: TINFO: try to allocate: 2466 MB
  swapping01.c:148: TFAIL: heavy swapping detected: 1905 MB swapped.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 23 ++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 8106f6466..66fc65cbe 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -53,7 +53,7 @@
 #define COE_SLIGHT_OVER 0.3
 
 static void init_meminfo(void);
-static void do_alloc(void);
+static void do_alloc(int allow_raise);
 static void check_swapping(void);
 
 static long mem_available_init;
@@ -72,7 +72,8 @@ static void test_swapping(void)
 
 	switch (pid = SAFE_FORK()) {
 		case 0:
-			do_alloc();
+			do_alloc(0);
+			do_alloc(1);
 			exit(0);
 		default:
 			check_swapping();
@@ -99,20 +100,23 @@ static void init_meminfo(void)
 				swap_free_init, mem_over_max);
 }
 
-static void do_alloc(void)
+static void do_alloc(int allow_raise)
 {
 	long mem_count;
 	void *s;
 
-	tst_res(TINFO, "available physical memory: %ld MB",
-		mem_available_init / 1024);
+	if (allow_raise == 1)
+		tst_res(TINFO, "available physical memory: %ld MB",
+				mem_available_init / 1024);
 	mem_count = mem_available_init + mem_over;
-	tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
+	if (allow_raise == 1)
+		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
 	s = SAFE_MALLOC(mem_count * 1024);
 	memset(s, 1, mem_count * 1024);
-	tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);
-	if (raise(SIGSTOP) == -1)
+	if ((allow_raise == 1) && (raise(SIGSTOP) == -1)) {
+		tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);
 		tst_brk(TBROK | TERRNO, "kill");
+	}
 	free(s);
 }
 
@@ -137,8 +141,7 @@ static void check_swapping(void)
 		i++;
 	}
 
-	swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
-	swapped = swap_free_init - swap_free_now;
+	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
 	if (swapped > mem_over_max) {
 		kill(pid, SIGCONT);
 		tst_brk(TFAIL, "heavy swapping detected: "
-- 
2.21.3

