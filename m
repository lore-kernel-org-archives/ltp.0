From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Wed, 13 Jan 2016 12:32:58 +0800
Subject: [LTP] [PATCH v2] Clean up hugemmap02 testcase
Message-ID: <1452659578-3706-1-git-send-email-shuang.qiu@oracle.com>
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
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 1a44993..39032f5 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -155,24 +155,20 @@ int main(int ac, char **av)
 		addr2 = mmap((void *)low_addr2, map_sz, PROT_READ | PROT_WRITE,
 			     MAP_SHARED, fildes, 0);
 #if __WORDSIZE == 64		/* 64-bit process */
-		if (addr2 == MAP_FAILED) {
+		if (addr2 == MAP_FAILED)
 			tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
 				 " with %s (64-bit)", TEMPFILE);
-			close(fildes);
-			continue;
-		} else {
+		else {
 			tst_resm(TPASS, "huge mmap succeeded (64-bit)");
 		}
 #else /* 32-bit process */
 		if (addr2 == MAP_FAILED)
 			tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
 				 " with %s (32-bit)", TEMPFILE);
-		else if (addr2 > 0) {
+		else if (addr2 > 0)
 			tst_resm(TCONF,
 				 "huge mmap failed to test the scenario");
-			close(fildes);
-			continue;
-		} else if (addr == 0)
+		else if (addr == 0)
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

