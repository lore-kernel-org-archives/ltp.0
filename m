From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2019 17:38:57 +0800
Subject: [LTP] [PATCH RFC 2/3] min_free_kbytes: enable check_monitor in
	background
In-Reply-To: <20190319093858.584-1-liwang@redhat.com>
References: <20190319093858.584-1-liwang@redhat.com>
Message-ID: <20190319093858.584-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also:
  do i+=pagesize to make test write page faster
  cleanup work

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/mem/tunable/min_free_kbytes.c      | 30 ++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index d2378a700..2eb51bf66 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -38,7 +38,7 @@
 
 #define MAP_SIZE (1UL<<20)
 
-volatile int end;
+static volatile int end;
 static long default_tune = -1;
 static long orig_overcommit = -1;
 static unsigned long total_mem;
@@ -83,8 +83,7 @@ static void min_free_kbytes_test(void)
 
 static void test_tune(unsigned long overcommit_policy)
 {
-	int status;
-	int pid[3];
+	int status, pid;
 	int ret, i;
 	unsigned long tune, memfree, memtotal;
 
@@ -97,7 +96,7 @@ static void test_tune(unsigned long overcommit_policy)
 		/* case2 */
 		else if (i == 1) {
 			set_sys_tune("min_free_kbytes", 2 * default_tune, 1);
-			/* case3 */
+		/* case3 */
 		} else {
 			memfree = SAFE_READ_MEMINFO("MemFree:");
 			memtotal = SAFE_READ_MEMINFO("MemTotal:");
@@ -109,15 +108,13 @@ static void test_tune(unsigned long overcommit_policy)
 		}
 
 		fflush(stdout);
-		switch (pid[i] = fork()) {
-		case -1:
-			tst_brk(TBROK | TERRNO, "fork");
-		case 0:
+		pid = SAFE_FORK();
+		if (pid == 0) {
 			ret = eatup_mem(overcommit_policy);
 			exit(ret);
 		}
 
-		SAFE_WAITPID(pid[i], &status, WUNTRACED | WCONTINUED);
+		SAFE_WAITPID(pid, &status, WUNTRACED | WCONTINUED);
 
 		if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
 			tst_res(TFAIL,
@@ -141,11 +138,10 @@ static void test_tune(unsigned long overcommit_policy)
 static int eatup_mem(unsigned long overcommit_policy)
 {
 	int ret = 0;
-	unsigned long memfree;
-	void *addrs;
+	char *addrs;
+	unsigned long i, pagesz = getpagesize();
 
-	memfree = SAFE_READ_MEMINFO("MemFree:");
-	printf("memfree is %lu kB before eatup mem\n", memfree);
+	tst_res(TINFO, "memfree is %lu kB before eatup mem", SAFE_READ_MEMINFO("MemFree:"));
 	while (1) {
 		addrs = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
 			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -156,10 +152,10 @@ static int eatup_mem(unsigned long overcommit_policy)
 			}
 			break;
 		}
-		memset(addrs, 1, MAP_SIZE);
+		for (i = 0; i < MAP_SIZE; i += pagesz)
+			*(addrs + i) = 'a';
 	}
-	memfree = SAFE_READ_MEMINFO("MemFree:");
-	printf("memfree is %lu kB after eatup mem\n", memfree);
+	tst_res(TINFO, "memfree is %lu kB after eatup mem", SAFE_READ_MEMINFO("MemFree:"));
 
 	return ret;
 }
@@ -169,7 +165,7 @@ static void check_monitor(void)
 	unsigned long tune;
 	unsigned long memfree;
 
-	while (end) {
+	while (!end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
 		tune = get_sys_tune("min_free_kbytes");
 
-- 
2.20.1

