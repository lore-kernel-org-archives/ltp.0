From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 19 May 2016 17:55:24 +0300
Subject: [LTP] [PATCH] memcg/functional: check several times if the process
	is killed
Message-ID: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some systems it may take slightly more than one second
to kill the memcg_process. So let's check several times if the
process is alive.

Also removed sleep() before moving the process to the memory cgroup,
since this looks reduntant.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../controllers/memcg/functional/memcg_lib.sh      |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 9b9b0fd..93c61a1 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -220,14 +220,20 @@ test_proc_kill()
 
 	$TEST_PATH/memcg_process $2 -s $3 &
 	pid=$!
-	sleep 1
 	echo $pid > tasks
 
 	kill -s USR1 $pid 2> /dev/null
-	sleep 1
 
-	ps -p $pid > /dev/null 2> /dev/null
-	if [ $? -ne 0 ]; then
+	pid_exists=1
+	for tpk_iter in $(seq 5); do
+	    if ! kill $pid 2> /dev/null; then
+		pid_exists=0
+		break
+	    fi
+	    sleep 1
+	done
+
+	if [ $pid_exists -eq 0 ]; then
 		wait $pid
 		if [ $? -eq 1 ]; then
 			result $FAIL "process $pid is killed by error"
-- 
1.7.1

