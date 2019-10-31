From: Eric Lin <tesheng@andestech.com>
Date: Thu, 31 Oct 2019 14:44:51 +0800
Subject: [LTP] [PATCH] hugetlb: Initialize orig_shmmax and orig_shmmni value
Message-ID: <20191031064451.14966-1-tesheng@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When doing save_nr_hugepages() in setup() and there
is no Huge page support in system, it will call
cleanup() and write wrong orig_shmmax and orig_shmmni
value back to file.

To fix it, we initialize the orig_shmmax and
orig_shmmni to -1 and check it in cleanup().

Signed-off-by: Eric Lin <tesheng@andestech.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c   | 5 +++--
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index d375810cb..c76e4167f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -38,7 +38,7 @@
 static long huge_free;
 static long huge_free2;
 static long hugepages;
-static long orig_shmmax, new_shmmax;
+static long orig_shmmax = -1, new_shmmax;
 
 static void shared_hugepage(void);
 
@@ -106,7 +106,8 @@ static void setup(void)
 static void cleanup(void)
 {
 	restore_nr_hugepages();
-	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
+	if (orig_shmmax != -1)
+		SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index d5255228b..f2ecc465d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -39,7 +39,7 @@ static int num_shms;
 static int shm_id_arr[MAXIDS];
 
 static long hugepages = 128;
-static long orig_shmmni;
+static long orig_shmmni = -1;
 static struct tst_option options[] = {
 	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
@@ -105,7 +105,8 @@ static void cleanup(void)
 	for (i = 0; i < num_shms; i++)
 		rm_shm(shm_id_arr[i]);
 
-	FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
+	if (orig_shmmni != -1)
+		FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
 	restore_nr_hugepages();
 }
 
-- 
2.17.0

