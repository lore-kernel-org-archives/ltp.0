From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Wed, 17 Feb 2016 16:22:36 +0800
Subject: [LTP] [PATCH v3] Clean up hugemmap02 testcase
Message-ID: <1455697356-4839-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

* Remove continue in the loop because it skips the cleanup

* munmap() addr2 for 32-bit

* close nfildes fd in the end of loop

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 1a44993..d31609d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -158,8 +158,6 @@ int main(int ac, char **av)
 		if (addr2 == MAP_FAILED) {
 			tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
 				 " with %s (64-bit)", TEMPFILE);
-			close(fildes);
-			continue;
 		} else {
 			tst_resm(TPASS, "huge mmap succeeded (64-bit)");
 		}
@@ -170,8 +168,6 @@ int main(int ac, char **av)
 		else if (addr2 > 0) {
 			tst_resm(TCONF,
 				 "huge mmap failed to test the scenario");
-			close(fildes);
-			continue;
 		} else if (addr == 0)
 			tst_resm(TPASS, "huge mmap succeeded (32-bit)");
 #endif
@@ -183,13 +179,12 @@ int main(int ac, char **av)
 					 "munmap of addrlist[%d] failed", i);
 		}
 
-#if __WORDSIZE == 64
 		if (munmap(addr2, map_sz) == -1)
 			tst_brkm(TFAIL | TERRNO, NULL, "huge munmap failed");
-#endif
 		if (munmap(addr, page_sz) == -1)
 			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
 
+		close(nfildes);
 		close(fildes);
 	}
 
-- 
1.7.9.5

