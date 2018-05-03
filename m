From: Li Wang <liwang@redhat.com>
Date: Thu,  3 May 2018 15:12:38 +0800
Subject: [LTP] [PATCH] move_pages: fix integer overflow in memfree
Message-ID: <20180503071238.29890-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move_page12 get integer overflow failure on large RAM machine as:
  move_pages12.c:198: INFO: Free RAM -127127648 kB
  move_pages12.c:201: BROK: Not enough free RAM

My test box:
  # cat /proc/meminfo |grep -i memfree
  MemFree:        21348021204 kB

Here changing the memfree type from 'int' to 'long' to avoid the problem.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 4c37bfe..5e6245d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -180,7 +180,8 @@ static void alloc_free_huge_on_node(unsigned int node, size_t size)
 
 static void setup(void)
 {
-	int memfree, ret;
+	int ret;
+	long memfree;
 
 	check_config(TEST_NODES);
 
@@ -194,8 +195,8 @@ static void setup(void)
 	pgsz = (int)get_page_size();
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
 
-	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %d", &memfree);
-	tst_res(TINFO, "Free RAM %d kB", memfree);
+	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %ld", &memfree);
+	tst_res(TINFO, "Free RAM %ld kB", memfree);
 
 	if (4 * hpsz > memfree)
 		tst_brk(TBROK, "Not enough free RAM");
-- 
2.9.5

