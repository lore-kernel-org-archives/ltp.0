From: Sheng Yong <shengyong1@huawei.com>
Date: Wed, 25 Nov 2015 12:20:42 +0000
Subject: [LTP] [PATCH] hugemmap05: close the temporary file before cleaning
	up
Message-ID: <1448454042-185697-1-git-send-email-shengyong1@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If mmap() fails, we cannot umount and clean the temporary directory since
a file is still open in it. So close the file before doing cleanup.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 8dac97a..b68c981 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -162,8 +162,10 @@ static void overcommit(void)
 			tst_brkm(TBROK | TERRNO, cleanup, "open");
 		addr = mmap(ADDR, (long)(length / 2 * hugepagesize), PROTECTION,
 			    FLAGS, fd, 0);
-		if (addr == MAP_FAILED)
+		if (addr == MAP_FAILED) {
+			close(fd);
 			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
+		}
 	}
 
 	if (opt_sysfs) {
-- 
1.8.3.4

