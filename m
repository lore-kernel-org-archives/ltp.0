From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 11 Mar 2020 18:15:12 +0800
Subject: [LTP] [PATCH 3/3] hugetlb: remove useless function
In-Reply-To: <1583921712-9008-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583921712-9008-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1583921712-9008-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After using .request_hugepages api, cases in hugetlb don't call
these functions. So remove them.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/mem/hugetlb/lib/hugetlb.c | 43 ----------------------
 testcases/kernel/mem/hugetlb/lib/hugetlb.h |  4 --
 2 files changed, 47 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 83b85f325..cd1b27eb3 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -39,49 +39,6 @@
 #include <pwd.h>
 #include "hugetlb.h"
 
-static long orig_hugepages = -1;
-
-long save_nr_hugepages(void)
-{
-	check_hugepage();
-
-	orig_hugepages = get_sys_tune("nr_hugepages");
-
-	return orig_hugepages;
-}
-
-void restore_nr_hugepages(void)
-{
-	if (orig_hugepages != -1)
-		set_sys_tune("nr_hugepages", orig_hugepages, 0);
-}
-
-void limit_hugepages(long *hpages)
-{
-	long mem_avail, max_hpages;
-
-	if (FILE_LINES_SCANF("/proc/meminfo",
-			"MemAvailable: %ld", &mem_avail)) {
-		/*
-		 * Dropping caches and using "MemFree:" on kernel
-		 * that doesn't have "MemAvailable:" in Meminfo
-		 */
-		tst_res(TINFO, "MemAvailable: not found in /proc/meminfo");
-
-		SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
-		mem_avail = SAFE_READ_MEMINFO("MemFree:");
-	}
-
-	max_hpages = mem_avail / SAFE_READ_MEMINFO("Hugepagesize:");
-
-	if (*hpages > max_hpages) {
-		tst_res(TINFO, "Requested number of hugepages too large, "
-				"limiting to 80%% of the max hugepage count %ld",
-				max_hpages);
-		*hpages = max_hpages * 0.8;
-	}
-}
-
 /*
  * getipckey() - generates and returns a message key used by the "get"
  *		 calls to create an IPC resource.
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 66ad324ab..7c03a317c 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -42,9 +42,5 @@ void rm_shm(int shm_id);
 
 char *nr_opt;
 char *Hopt;
-void check_hugepage(void);
-long save_nr_hugepages(void);
-void restore_nr_hugepages(void);
-void limit_hugepages(long *hpages);
 
 #endif /* hugetlb.h */
-- 
2.18.0



