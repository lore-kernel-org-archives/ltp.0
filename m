From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Aug 2018 10:55:19 +0200
Subject: [LTP] [PATCH v4 2/2] move_pages12: end early if runtime gets close
	to test time
In-Reply-To: <5ad739995335bda348f07fc4d3faeec501e00b19.1535618962.git.jstancek@redhat.com>
References: <5ad739995335bda348f07fc4d3faeec501e00b19.1535618962.git.jstancek@redhat.com>
Message-ID: <229505f08227865b5f14db37495760aedb2dfb88.1535618962.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Most systems can complete this reproducer in standard test time.
Small groups of systems (e.g. aarch64 with 512M hugepages) are hitting
a timeout.

Add a check for elapsed time and end test early if we are getting close (80%).

Fixes: #387

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
Changes in v4:
- don't start variable with underscore

 testcases/kernel/syscalls/move_pages/move_pages12.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 43acb42aabb1..04fda8beffc1 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -101,6 +101,7 @@ static void do_test(void)
 	int i;
 	pid_t cpid = -1;
 	int status;
+	unsigned int twenty_percent = (tst_timeout_remaining() / 5);
 
 	addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz, PROT_READ | PROT_WRITE,
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
@@ -123,14 +124,15 @@ static void do_test(void)
 		memset(addr, 0, TEST_PAGES * hpsz);
 
 		SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
-	}
 
-	if (i == LOOPS) {
-		SAFE_KILL(cpid, SIGKILL);
-		SAFE_WAITPID(cpid, &status, 0);
-		if (!WIFEXITED(status))
-			tst_res(TPASS, "Bug not reproduced");
+		if (tst_timeout_remaining() < twenty_percent)
+			break;
 	}
+
+	SAFE_KILL(cpid, SIGKILL);
+	SAFE_WAITPID(cpid, &status, 0);
+	if (!WIFEXITED(status))
+		tst_res(TPASS, "Bug not reproduced");
 }
 
 static void alloc_free_huge_on_node(unsigned int node, size_t size)
-- 
1.8.3.1

