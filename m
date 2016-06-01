From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  1 Jun 2016 17:34:53 +0300
Subject: [LTP] [RFC PATCH 2/2] An example of usage of tst_checkpoint shell
	wrappers
In-Reply-To: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1464791693-10249-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../memcg/functional/memcg_function_test.sh        |   27 +++++++++++---------
 .../controllers/memcg/functional/memcg_lib.sh      |   16 +++++------
 .../controllers/memcg/functional/memcg_process.c   |    6 ++++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 2c2f32a..efafad5 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -25,12 +25,19 @@
 ##                                                                            ##
 ################################################################################
 
-export TCID="memcg_function_test"
-export TST_TOTAL=38
-export TST_COUNT=0
-
+TCID="memcg_function_test"
+TST_TOTAL=38
+. test.sh
 . memcg_lib.sh || exit 1
 
+my_cleanup()
+{
+	TST_CHECKPOINT_CLEANUP
+}
+
+TST_CLEANUP=my_cleanup
+TST_CHECKPOINT_SETUP
+
 # Case 1 - 10: Test the management and counting of memory
 testcase_1()
 {
@@ -207,7 +214,7 @@ testcase_29()
 {
 	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
@@ -228,7 +235,7 @@ testcase_30()
 {
 	$TEST_PATH/memcg_process --mmap-lock2 -s $PAGESIZE &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
@@ -299,7 +306,6 @@ fi
 # Run all the test cases
 for i in $(seq 1 $TST_TOTAL)
 do
-	export TST_COUNT=$(( $TST_COUNT + 1 ))
 	cur_id=$i
 
 	do_mount
@@ -325,8 +331,5 @@ done
 
 echo $shmmax > /proc/sys/kernel/shmmax
 
-if [ $failed -ne 0 ]; then
-	exit $failed
-else
-	exit 0
-fi
+tst_exit
+
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 9b9b0fd..b3e6157 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -41,7 +41,6 @@ FAIL=1
 orig_memory_use_hierarchy=""
 
 cur_id=0
-failed=0
 
 # Record the test result of a test case
 # $1 - The result of the test case, $PASS or $FAIL
@@ -55,7 +54,6 @@ result()
 		tst_resm TPASS "$info"
 	else
 		tst_resm TFAIL "$info"
-		: $(( failed += 1 ))
 	fi
 }
 
@@ -111,7 +109,7 @@ test_mem_stat()
 {
 	echo "Running $TEST_PATH/memcg_process $1 -s $2"
 	$TEST_PATH/memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -144,7 +142,7 @@ test_max_usage_in_bytes()
 {
 	echo "Running $TEST_PATH/memcg_process $1 -s $2"
 	$TEST_PATH/memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -175,7 +173,7 @@ malloc_free_memory()
 {
 	echo "Running $TEST_PATH/memcg_process $1 -s $2"
 	$TEST_PATH/memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	echo $! > tasks
 	kill -s USR1 $! 2> /dev/null
@@ -220,7 +218,7 @@ test_proc_kill()
 
 	$TEST_PATH/memcg_process $2 -s $3 &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 
 	kill -s USR1 $pid 2> /dev/null
@@ -284,7 +282,7 @@ test_hugepage()
 	echo $1 > /proc/sys/vm/nr_hugepages
 
 	$TEST_PATH/memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	kill -s USR1 $! 2> /dev/null
 	sleep 1
@@ -332,7 +330,7 @@ test_subgroup()
 
 	echo "Running $TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE"
 	$TEST_PATH/memcg_process --mmap-anon -s $PAGESIZE &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -367,7 +365,7 @@ test_move_charge()
 	mkdir subgroup_a
 
 	$TEST_PATH/memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	warmup $!
 	if [ $? -ne 0 ]; then
 		rmdir subgroup_a
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index 3d34394..95e947f 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -34,6 +34,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
 
 int fd;
 
@@ -310,6 +312,10 @@ int main(int argc, char *argv[])
 
 	process_options(argc, argv);
 
+	tst_reinit();
+
+	TST_CHECKPOINT_WAKE(0);
+
 	while (!flag_exit)
 		sleep(1);
 
-- 
1.7.1

