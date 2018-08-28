From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 16:40:07 +0200
Subject: [LTP] [PATCH RFC v3 3/3] move_pages12: end early if runtime gets
	close to test time
In-Reply-To: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
References: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
Message-ID: <fdf611134b15684031f7bd3e2d5fe86d49124b26.1535466715.git.jstancek@redhat.com>
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
 testcases/kernel/syscalls/move_pages/move_pages12.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 43acb42aabb1..3f60c0ca47fc 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -101,6 +101,7 @@ static void do_test(void)
 	int i;
 	pid_t cpid = -1;
 	int status;
+	unsigned int _20_percent = (tst_timeout_remaining() / 5);
 
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
+		if (tst_timeout_remaining() < _20_percent)
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

