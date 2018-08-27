From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 27 Aug 2018 16:06:44 +0200
Subject: [LTP] [PATCH] move_pages12: end early if runtime gets close to test
	time
Message-ID: <5b181737029c9687f7cc7c49a9d15b415e62a1bc.1535378672.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Most systems can complete this reproducer in standard test time.
Small groups of systems (e.g. aarch64 with 512M hugepages) can hit
a timeout.

Add a check for elapsed time and end test early if we are getting close (80%).

Fixes: #387

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index c0ff27114110..2813097871e4 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -40,6 +40,7 @@
 #include <sys/wait.h>
 
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "move_pages_support.h"
 #include "lapi/mmap.h"
 
@@ -51,6 +52,7 @@
 #define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 #define TEST_PAGES	2
 #define TEST_NODES	2
+#define TEST_TIMEOUT	300
 
 static int pgsz, hpsz;
 static long orig_hugepages = -1;
@@ -102,6 +104,8 @@ static void do_test(void)
 	pid_t cpid = -1;
 	int status;
 
+	tst_timer_start(CLOCK_MONOTONIC);
+
 	addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz, PROT_READ | PROT_WRITE,
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
 
@@ -123,14 +127,15 @@ static void do_test(void)
 		memset(addr, 0, TEST_PAGES * hpsz);
 
 		SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
-	}
 
-	if (i == LOOPS) {
-		SAFE_KILL(cpid, SIGKILL);
-		SAFE_WAITPID(cpid, &status, 0);
-		if (!WIFEXITED(status))
-			tst_res(TPASS, "Bug not reproduced");
+		if (tst_timer_expired_ms(TEST_TIMEOUT))
+			break;
 	}
+
+	SAFE_KILL(cpid, SIGKILL);
+	SAFE_WAITPID(cpid, &status, 0);
+	if (!WIFEXITED(status))
+		tst_res(TPASS, "Bug not reproduced");
 }
 
 static void alloc_free_huge_on_node(unsigned int node, size_t size)
@@ -183,6 +188,8 @@ static void setup(void)
 	int ret;
 	long memfree;
 
+	tst_timer_check(CLOCK_MONOTONIC);
+
 	check_config(TEST_NODES);
 
 	if (access(PATH_HUGEPAGES, F_OK))
@@ -265,6 +272,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_test,
+	.timeout = (TEST_TIMEOUT / 5) * 6,
 };
 
 #else
-- 
1.8.3.1

