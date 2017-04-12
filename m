From: Steve Ellcey <sellcey@cavium.com>
Date: Wed, 12 Apr 2017 10:33:08 -0700
Subject: [LTP] [PATCH] memcg_stress_test.sh: Reduce runtime
Message-ID: <1492018388-3968-1-git-send-email-sellcey@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change the RUN_TIME from 60 minutes to 15 minutes so the LTP suite does not
take so long.  stress_test is run twice so the overall test still takes 30
minutes (but not 2 hours).  Reduce the interval between memory touches from
10 seconds to 5 seconds so we still get a reasonable amount of activity during
the test.

Signed-off-by: Steve Ellcey <sellcey@caviumnetworks.com>
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index dc610f1..af1a708 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -37,7 +37,7 @@ if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
         exit 0
 fi
 
-RUN_TIME=$(( 60 * 60 ))
+RUN_TIME=$(( 15 * 60 ))
 
 cleanup()
 {
@@ -96,14 +96,14 @@ run_stress()
 
 testcase_1()
 {
-	run_stress 150 $(( ($mem-150) / 150 )) 10 $RUN_TIME
+	run_stress 150 $(( ($mem-150) / 150 )) 5 $RUN_TIME
 
 	tst_resm TPASS "stress test 1 passed"
 }
 
 testcase_2()
 {
-	run_stress 1 $mem 10 $RUN_TIME
+	run_stress 1 $mem 5 $RUN_TIME
 
 	tst_resm TPASS "stress test 2 passed"
 }
-- 
2.7.4

