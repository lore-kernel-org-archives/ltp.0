From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 23 Aug 2016 14:25:54 +0300
Subject: [LTP] [PATCH V2 3/4] memcg/functional: use checkpoints
In-Reply-To: <1471951555-4230-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1471951555-4230-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1471951555-4230-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch implements the idea proposed in [1], [2], that
we use the checkpoint interface to let memcg_process inform
the parent process that it's ready.

In my enviroment it saves ~50 secs of time.

[1] http://lists.linux.it/pipermail/ltp/2016-May/001841.html
[2] http://lists.linux.it/pipermail/ltp/2016-May/001846.html

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * Added necessary links for [1], [2] in the commit message

 .../memcg/functional/memcg_function_test.sh        |    4 ++--
 .../controllers/memcg/functional/memcg_lib.sh      |   15 ++++++++-------
 .../controllers/memcg/functional/memcg_process.c   |    6 ++++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 24d02ae..cd32cf2 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -209,7 +209,7 @@ testcase_29()
 {
 	memcg_process --mmap-anon -s $PAGESIZE &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
@@ -225,7 +225,7 @@ testcase_30()
 {
 	memcg_process --mmap-lock2 -s $PAGESIZE &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 46e6c7f..8822f48 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -22,6 +22,7 @@
 ##                                                                            ##
 ################################################################################
 
+TST_NEEDS_CHECKPOINTS=1
 . test.sh
 
 if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
@@ -119,7 +120,7 @@ test_mem_stat()
 {
 	tst_resm TINFO "Running memcg_process $1 -s $2"
 	memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -152,7 +153,7 @@ test_max_usage_in_bytes()
 {
 	tst_resm TINFO "Running memcg_process $1 -s $2"
 	memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -183,7 +184,7 @@ malloc_free_memory()
 {
 	tst_resm TINFO "Running memcg_process $1 -s $2"
 	memcg_process $1 -s $2 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	echo $! > tasks
 	kill -s USR1 $! 2> /dev/null
@@ -226,7 +227,7 @@ test_proc_kill()
 
 	memcg_process $2 -s $3 &
 	pid=$!
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 
 	kill -s USR1 $pid 2> /dev/null
@@ -295,7 +296,7 @@ test_hugepage()
 	echo $1 > /proc/sys/vm/nr_hugepages
 
 	memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	kill -s USR1 $! 2> /dev/null
 	sleep 1
@@ -343,7 +344,7 @@ test_subgroup()
 
 	tst_resm TINFO "Running memcg_process --mmap-anon -s $PAGESIZE"
 	memcg_process --mmap-anon -s $PAGESIZE &
-	sleep 1
+	TST_CHECKPOINT_WAIT 0
 
 	warmup $!
 	if [ $? -ne 0 ]; then
@@ -379,7 +380,7 @@ test_move_charge()
 
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

