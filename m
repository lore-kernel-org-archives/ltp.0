From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Mar 2016 17:34:27 +0800
Subject: [LTP] [PATCH 3/4] mm/ksm: moving the merge_across_nodes statement
	in mem.h
In-Reply-To: <1457602468-24268-2-git-send-email-liwang@redhat.com>
References: <1457602468-24268-1-git-send-email-liwang@redhat.com>
 <1457602468-24268-2-git-send-email-liwang@redhat.com>
Message-ID: <1457602468-24268-3-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The mem.c take use of this value, so that would be better to declear
it in mem.h.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/include/mem.h | 1 +
 testcases/kernel/mem/ksm/ksm01.c   | 2 --
 testcases/kernel/mem/ksm/ksm02.c   | 2 --
 testcases/kernel/mem/ksm/ksm03.c   | 2 --
 testcases/kernel/mem/ksm/ksm04.c   | 2 --
 testcases/kernel/mem/ksm/ksm06.c   | 1 -
 6 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index fbb11b2..18388ee 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -44,6 +44,7 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 
 #define PATH_KSM		"/sys/kernel/mm/ksm/"
 int max_page_sharing;
+int merge_across_nodes;
 
 void test_ksm_merge_across_nodes(unsigned long nr_pages);
 
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index a352abd..b37cfbf 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -72,8 +72,6 @@
 char *TCID = "ksm01";
 int TST_TOTAL = 1;
 
-static int merge_across_nodes;
-
 option_t ksm_options[] = {
 	{"n:", &opt_num, &opt_numstr},
 	{"s:", &opt_size, &opt_sizestr},
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 7b004b4..5429b3c 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -72,8 +72,6 @@
 char *TCID = "ksm02";
 int TST_TOTAL = 1;
 
-static int merge_across_nodes;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 option_t ksm_options[] = {
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index f909294..ab03f47 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -72,8 +72,6 @@
 char *TCID = "ksm03";
 int TST_TOTAL = 1;
 
-static int merge_across_nodes;
-
 option_t ksm_options[] = {
 	{"n:", &opt_num, &opt_numstr},
 	{"s:", &opt_size, &opt_sizestr},
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index fe8c640..4272207 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -72,8 +72,6 @@
 char *TCID = "ksm04";
 int TST_TOTAL = 1;
 
-static int merge_across_nodes;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 option_t ksm_options[] = {
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 1efb613..3adcb81 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -56,7 +56,6 @@ int TST_TOTAL = 1;
 
 static int run;
 static int sleep_millisecs;
-static int merge_across_nodes;
 static int n_flag;
 static unsigned long nr_pages;
 
-- 
1.8.3.1

