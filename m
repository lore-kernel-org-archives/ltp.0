From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Nov 2015 15:39:07 +0800
Subject: [LTP] [PATCH] hugeshmat: do cleanup for hugeshmat04.c
Message-ID: <1447745947-13228-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

there is no need to check the number of system hugepages again, because
funciton 'set_sys_tune("nr_hugepages", hugepages, 1);' has already done
that before.

so, I propose to remove these redundant codes.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 9e8ffa6..f631a0a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -54,7 +54,6 @@
 char *TCID = "hugeshmat04";
 int TST_TOTAL = 3;
 
-static long huge_total;
 static long huge_free;
 static long huge_free2;
 static long hugepages;
@@ -145,11 +144,6 @@ void setup(void)
 	hugepages = (orig_hugepages * hpage_size + SIZE) / hpage_size;
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
-	huge_total = read_meminfo("HugePages_Total:");
-	if (huge_total != hugepages)
-		tst_brkm(TCONF, cleanup,
-			"Maybe huge pages not enough for test.");
-
 	TEST_PAUSE;
 }
 
-- 
1.8.3.1

