From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jul 2016 13:51:19 +0800
Subject: [LTP] [PATCH] swapping: replace mem_free by mem_available
Message-ID: <1468302679-29651-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some ppc64 systems, there free memory are larger than available memory, and
swap size is very small. Then this swapping01 easily get failures like:

swapping01    0  TINFO  :  free physical memory: 14651 MB
swapping01    0  TINFO  :  try to allocate: 19046 MB
swapping01    1  TBROK  :  swapping01.c:134: malloc: errno=ENOMEM(12): Cannot allocate memory
swapping01    2  TBROK  :  swapping01.c:134: Remaining cases broken
swapping01    1  TBROK  :  swapping01.c:151: child was not stopped.
swapping01    2  TBROK  :  swapping01.c:151: Remaining cases broken

 # free -m
               total        used        free      shared  buff/cache   available
 Mem:          15316         238       14651           0         427       14478
 Swap:          4607         202        4405

That's because 14478(available_mem) + 4405(swap_free) < 19046(expected: 14651(free_mem) * 1.3),
so we get malloc ENOMEM errors.

This patch replaces the free memory by available, and clean up some code.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index b530ee2..aabb784 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -68,7 +68,7 @@ static void init_meminfo(void);
 static void do_alloc(void);
 static void check_swapping(void);
 
-static long mem_free_init;
+static long mem_available_init;
 static long swap_free_init;
 static long mem_over;
 static long mem_over_max;
@@ -108,17 +108,15 @@ int main(int argc, char *argv[])
 static void init_meminfo(void)
 {
 	swap_free_init = read_meminfo("SwapFree:");
-	mem_free_init = read_meminfo("MemFree:");
-	mem_over = mem_free_init * COE_SLIGHT_OVER;
-	mem_over_max = mem_free_init * COE_DELTA;
-
-	/* at least 10MB free physical memory needed */
-	if (mem_free_init < 10240) {
-		sleep(5);
-		if (mem_free_init < 10240)
+	mem_available_init = read_meminfo("MemAvailable:");
+	mem_over = mem_available_init * COE_SLIGHT_OVER;
+	mem_over_max = mem_available_init * COE_DELTA;
+
+	/*@least 10MB available physical memory needed */
+	if (mem_available_init < 10240)
 			tst_brkm(TCONF, cleanup,
-				 "Not enough free memory to test.");
-	}
+				 "Not enough avalable memory to test.");
+
 	if (swap_free_init < mem_over)
 		tst_brkm(TCONF, cleanup, "Not enough swap space to test.");
 }
@@ -128,8 +126,8 @@ static void do_alloc(void)
 	long mem_count;
 	void *s;
 
-	tst_resm(TINFO, "free physical memory: %ld MB", mem_free_init / 1024);
-	mem_count = mem_free_init + mem_over;
+	tst_resm(TINFO, "available physical memory: %ld MB", mem_available_init / 1024);
+	mem_count = mem_available_init + mem_over;
 	tst_resm(TINFO, "try to allocate: %ld MB", mem_count / 1024);
 	s = malloc(mem_count * 1024);
 	if (s == NULL)
@@ -160,7 +158,7 @@ static void check_swapping(void)
 			tst_brkm(TFAIL, cleanup, "heavy swapping detected: "
 				 "%ld MB swapped.", swapped / 1024);
 		}
-		sleep(1);
+		usleep(100000);
 	}
 	tst_resm(TPASS, "no heavy swapping detected, %ld MB swapped.",
 		 swapped / 1024);
-- 
1.8.3.1

