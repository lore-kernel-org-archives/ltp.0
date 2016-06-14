From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 14 Jun 2016 18:24:52 +0300
Subject: [LTP] [PATCH 3/4] memcg/functional: use checkpoints
In-Reply-To: <1465917893-32074-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1465917893-32074-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1465917893-32074-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1465917893-32074-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch implements the idea proposed in [1], [2], that
we use the checkpoint interface to let memcg_process inform
the parent process that it's ready.

In my enviroment it saves ~50 secs of time.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../memcg/functional/memcg_function_test.sh        |    4 ++--
 .../controllers/memcg/functional/memcg_lib.sh      |   15 ++++++++-------
 .../controllers/memcg/functional/memcg_process.c   |    6 ++++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 38fb311..b94e940 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -214,7 +214,7 @@ testcase_29()
 {
 	memcg_process --mmap-anon -s $PAGESIZE &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
@@ -235,7 +235,7 @@ testcase_30()
 {
 	memcg_process --mmap-lock2 -s $PAGESIZE &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 5e42fac..b191ea6 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -22,6 +22,7 @@
 ##                                                                            ##
 ################################################################################
 
+TST_NEEDS_CHECKPOINTS=1
 . test.sh
 
 if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
@@ -137,7 +138,7 @@ test_mem_stat()
 {
 	tst_resm TINFO "Running memcg_process $1 -s $2"
 	memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -170,7 +171,7 @@ test_max_usage_in_bytes()
 {
 	tst_resm TINFO "Running memcg_process $1 -s $2"
 	memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -201,7 +202,7 @@ malloc_free_memory()
 {
 	tst_resm TINFO "Running memcg_process $1 -s $2"
 	memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	echo $! > tasks
 	kill -s USR1 $! 2> /dev/null
@@ -246,7 +247,7 @@ test_proc_kill()
 
 	memcg_process $2 -s $3 &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 
 	kill -s USR1 $pid 2> /dev/null
@@ -315,7 +316,7 @@ test_hugepage()
 	echo $1 > /proc/sys/vm/nr_hugepages
 
 	memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	kill -s USR1 $! 2> /dev/null
 	sleep 1
@@ -363,7 +364,7 @@ test_subgroup()
 
 	tst_resm TINFO "Running memcg_process --mmap-anon -s $PAGESIZE"
 	memcg_process --mmap-anon -s $PAGESIZE &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -399,7 +400,7 @@ test_move_charge()
 
 	tst_resm TINFO "Running memcg_process $1 -s $2"
 	memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	warmup $!
 	if [ $? -ne 0 ]; then
 		rmdir subgroup_a
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index 4ad2d6f..fbb76e2 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -34,6 +34,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
 
 static int fd;
 
@@ -315,6 +317,10 @@ int main(int argc, char *argv[])
 
 	process_options(argc, argv);
 
+	tst_reinit();
+
+	TST_CHECKPOINT_WAKE(0);
+
 	while (!flag_exit)
 		sleep(1);
 
-- 
1.7.1

