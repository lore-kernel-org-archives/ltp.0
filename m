From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 5 Jul 2018 17:37:18 +0800
Subject: [LTP] [PATCH] memcg/memcg_subgroup_charge: Fix out of memory
Message-ID: <1530783438-9860-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit f0b9d18, memcg_process maps 33 pages for a process, but
memory.limit_in_bytes is still restricted to 1 page, so that moving
the process into group or subgroup results in oom.

Fixes: f0b9d18 ("memcg/functional: 4.16 kernel updates stat counter in a batch of 33 pages")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/controllers/memcg/functional/memcg_subgroup_charge.sh    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 6b97407..9b11f7b 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -33,17 +33,17 @@ TST_TOTAL=3
 # Test that group and subgroup have no relationship
 testcase_1()
 {
-	test_subgroup $PAGESIZE $((2*PAGESIZE))
+	test_subgroup $PAGESIZES $((2*PAGESIZES))
 }
 
 testcase_2()
 {
-	test_subgroup $PAGESIZE $PAGESIZE
+	test_subgroup $PAGESIZES $PAGESIZES
 }
 
 testcase_3()
 {
-	test_subgroup $PAGESIZE 0
+	test_subgroup $PAGESIZES 0
 }
 
 run_tests
-- 
1.8.3.1



