From: Luo Fenglin <luofenglin1@huawei.com>
Date: Tue, 1 Dec 2020 19:49:24 +0800
Subject: [LTP] [PATCH 1/3] sched/sched_stress: Modify sched driver param to
 run long term testcases
Message-ID: <1606823366-121520-1-git-send-email-luofenglin1@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: luofenglin <luofenglin1@huawei.com>

Add sched_driver process slots param to 10, then long term testcases can run.
Additionally, add sched_driver run time 0.05 hour, long term testcases
run 1/5 of total time.

Signed-off-by: luofenglin <luofenglin1@huawei.com>
---
 testcases/kernel/sched/sched_stress/sched_driver.c  | 6 +++++-
 testcases/kernel/sched/sched_stress/sched_stress.sh | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/sched_stress/sched_driver.c b/testcases/kernel/sched/sched_stress/sched_driver.c
index 61573d788..1bee9d130 100644
--- a/testcases/kernel/sched/sched_stress/sched_driver.c
+++ b/testcases/kernel/sched/sched_stress/sched_driver.c
@@ -202,8 +202,12 @@ int main(int argc, char **argv)

 	/*
 	 * Start the long-term testcases running
+	 * Run time set 1/5 of total
 	 */
-	start_long_term_testcases(long_term_slot_total, argv[2]);
+	char run_long_term_time[20];
+	int runlongtime = runseconds / 5;
+	sprintf(run_long_term_time, "%d", runlongtime);
+	start_long_term_testcases(long_term_slot_total, run_long_term_time);
 	short_term_slot_total = workslots / 2;
 	fflush(stdout);

diff --git a/testcases/kernel/sched/sched_stress/sched_stress.sh b/testcases/kernel/sched/sched_stress/sched_stress.sh
index 797d0601b..0205446a7 100755
--- a/testcases/kernel/sched/sched_stress/sched_stress.sh
+++ b/testcases/kernel/sched/sched_stress/sched_stress.sh
@@ -30,6 +30,7 @@ export KERNEL=./sched_datafile
 touch $KERNEL
 echo 0.000000 > sch.measure
 export RAWDEV=`df / | grep dev | awk {'print $1'}`
-sched_driver -s 0.9 -t 0.02 -p 2 > /tmp/tmp$$
+echo "Result file: /tmp/tmp$$"
+sched_driver -s 0.9 -t 0.05 -p 10 -d > /tmp/tmp$$
 tail -n 5 /tmp/tmp$$
 rm -rf /tmp/tmp$$ ./sched_datafile sch.measure
--
2.17.1

