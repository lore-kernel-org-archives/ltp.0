From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 13:07:51 +0200
Subject: [LTP] [PATCH v2 2/2] move_pages12: end early if runtime gets close
	to test time
In-Reply-To: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
References: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
Message-ID: <58d20bf71d2f56126b7386b32d19a3a1382cc029.1535454204.git.jstancek@redhat.com>
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
 testcases/kernel/syscalls/move_pages/move_pages12.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 43acb42aabb1..284be957148f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -40,6 +40,7 @@
 #include <sys/wait.h>
 
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "move_pages_support.h"
 #include "lapi/mmap.h"
 
@@ -101,6 +102,9 @@ static void do_test(void)
 	int i;
 	pid_t cpid = -1;
 	int status;
+	unsigned int test_time = (tst_get_timeout() / 5) * 4;
+
+	tst_timer_start(CLOCK_MONOTONIC);
 
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
+		if (tst_timer_expired_ms(test_time))
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
-- 
1.8.3.1

