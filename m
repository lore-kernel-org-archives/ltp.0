From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 31 Aug 2017 10:59:39 +0800
Subject: [LTP] [PATCH] hugemmap/hugemmap05.c: fix warnings in cleanup()
Message-ID: <1504148379-8552-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) We only destroy the shared memory segment if it was still created.
2) We only close and delete the test file if it was still created and opened.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 90389dd..c73a975 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -178,9 +178,10 @@ static void test_overcommit(void)
 
 static void cleanup(void)
 {
-	if (opt_shmid) {
+	if (opt_shmid && shmid != -1)
 		SAFE_SHMCTL(shmid, IPC_RMID, NULL);
-	} else {
+
+	if (!opt_shmid && fd != -1) {
 		SAFE_CLOSE(fd);
 		SAFE_UNLINK(TEST_FILE);
 	}
-- 
1.8.3.1



