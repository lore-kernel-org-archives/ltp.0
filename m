From: Li Wang <liwang@redhat.com>
Date: Mon,  1 Aug 2016 16:28:55 +0800
Subject: [LTP] [PATCH v2] swapping: replace mem_free by mem_available
Message-ID: <1470040135-26072-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some ppc64 systems, there free memory are larger than available memory, but
total swap size is very small. Then this swapping01 easily get failures like:

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

In this patch:
  * replace the free memory by available
  * compare total swap with mem_over_max
  * take new method to monitor swap usage

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 56 ++++++++++++++++++------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index b530ee2..20bd254 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -68,8 +68,9 @@ static void init_meminfo(void);
 static void do_alloc(void);
 static void check_swapping(void);
 
-static long mem_free_init;
+static long mem_available_init;
 static long swap_free_init;
+static long swap_total;
 static long mem_over;
 static long mem_over_max;
 static pid_t pid;
@@ -107,20 +108,21 @@ int main(int argc, char *argv[])
 
 static void init_meminfo(void)
 {
+	swap_total = read_meminfo("SwapTotal:");
 	swap_free_init = read_meminfo("SwapFree:");
-	mem_free_init = read_meminfo("MemFree:");
-	mem_over = mem_free_init * COE_SLIGHT_OVER;
-	mem_over_max = mem_free_init * COE_DELTA;
-
-	/* at least 10MB free physical memory needed */
-	if (mem_free_init < 10240) {
-		sleep(5);
-		if (mem_free_init < 10240)
+	if (FILE_LINES_SCANF(cleanup, "/proc/meminfo", "MemAvailable: %ld",
+				&mem_available_init))
+		mem_available_init = read_meminfo("MemFree:") + read_meminfo("Cached:");
+	mem_over = mem_available_init * COE_SLIGHT_OVER;
+	mem_over_max = mem_available_init * COE_DELTA;
+
+	/*@least 10MB available physical memory needed */
+	if (mem_available_init < 10240)
 			tst_brkm(TCONF, cleanup,
-				 "Not enough free memory to test.");
-	}
-	if (swap_free_init < mem_over)
-		tst_brkm(TCONF, cleanup, "Not enough swap space to test.");
+				 "Not enough avalable memory to test.");
+
+	if (swap_total < mem_over_max)
+		tst_brkm(TCONF, cleanup, "swap size is not fit to test");
 }
 
 static void do_alloc(void)
@@ -128,8 +130,8 @@ static void do_alloc(void)
 	long mem_count;
 	void *s;
 
-	tst_resm(TINFO, "free physical memory: %ld MB", mem_free_init / 1024);
-	mem_count = mem_free_init + mem_over;
+	tst_resm(TINFO, "available physical memory: %ld MB", mem_available_init / 1024);
+	mem_count = mem_available_init + mem_over;
 	tst_resm(TINFO, "try to allocate: %ld MB", mem_count / 1024);
 	s = malloc(mem_count * 1024);
 	if (s == NULL)
@@ -144,7 +146,7 @@ static void do_alloc(void)
 static void check_swapping(void)
 {
 	int status, i;
-	long swapped;
+	long swap_free_now, swapped;
 
 	/* wait child stop */
 	if (waitpid(pid, &status, WUNTRACED) == -1)
@@ -153,15 +155,23 @@ static void check_swapping(void)
 		tst_brkm(TBROK, cleanup, "child was not stopped.");
 
 	/* Still occupying memory, loop for a while */
-	for (i = 0; i < 10; i++) {
-		swapped = swap_free_init - read_meminfo("SwapFree:");
-		if (swapped > mem_over_max) {
-			kill(pid, SIGCONT);
-			tst_brkm(TFAIL, cleanup, "heavy swapping detected: "
-				 "%ld MB swapped.", swapped / 1024);
-		}
+	i = 0;
+	while (i < 10) {
+		swap_free_now = read_meminfo("SwapFree:");
 		sleep(1);
+		if (abs(swap_free_now - read_meminfo("SwapFree:")) < 512)
+			break;
+
+		i++;
 	}
+
+	swapped = swap_free_init - swap_free_now;
+	if (swapped > mem_over_max) {
+		kill(pid, SIGCONT);
+		tst_brkm(TFAIL, cleanup, "heavy swapping detected: "
+				"%ld MB swapped.", swapped / 1024);
+	}
+
 	tst_resm(TPASS, "no heavy swapping detected, %ld MB swapped.",
 		 swapped / 1024);
 	kill(pid, SIGCONT);
-- 
1.8.3.1

