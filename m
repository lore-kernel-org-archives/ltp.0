From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 6 Dec 2018 17:05:08 +0800
Subject: [LTP] [PATCH] controllers/cpuacct.sh: Fix timeout for cpuacct.sh
Message-ID: <1544087108-5717-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With commit fbea02a, cpuacct.sh always gets timeout because wait
command tries to wait all background processes including the timeout
process.  We should just wait the processes created for test.

e.g. running cpuacct_1_1 gets the following timeout:
-----------------------------------------------------------
cpuacct 1 TINFO: timeout per run is 0h 5m 0s
cpuacct 1 TINFO: cpuacct:
cpuacct 1 TINFO: Creating 1 subgroups each with 1 processes
cpuacct 1 TBROK: test killed, timeout!
-----------------------------------------------------------

Fixes: fbea02a("lib/tst_test.sh: setup timeout per test run for the shell tests")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index edd4a98..5e90b05 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -41,6 +41,7 @@ TST_TESTFUNC=do_test
 TST_POS_ARGS=2
 TST_USAGE=usage
 TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 
 . tst_test.sh
 
@@ -114,10 +115,12 @@ do_test()
 	for i in `seq 1 $max`; do
 		for j in `seq 1 $nbprocess`; do
 			cpuacct_task $testpath/subgroup_$i/tasks &
+			echo $! >> task_pids
 		done
 	done
 
-	wait
+	for pid in $(cat task_pids); do wait $pid; done
+	rm -f task_pids
 
 	acc=0
 	fails=0
-- 
1.8.3.1



