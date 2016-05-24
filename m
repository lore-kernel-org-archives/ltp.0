From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 24 May 2016 11:52:18 +0300
Subject: [LTP] [PATCH V2] memcg/functional: check several times if the
	process is killed
In-Reply-To: <57434132.4040100@oracle.com>
References: <57434132.4040100@oracle.com>
Message-ID: <1464079938-32392-1-git-send-email-stanislav.kholmanskikh@oracle.com>
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
Changes since V1:
 * now we verify wheter the process was killed by checking the output
   from 'ps'. If it reports no pid or the pid is a zombie, we treat it
   as the fact that the process was killed by OOM-killer.
 * pid_exists -> tpk_pid_exists


 .../controllers/memcg/functional/memcg_lib.sh      |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 9b9b0fd..5662312 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -220,14 +220,21 @@ test_proc_kill()
 
 	$TEST_PATH/memcg_process $2 -s $3 &
 	pid=$!
-	sleep 1
 	echo $pid > tasks
 
 	kill -s USR1 $pid 2> /dev/null
-	sleep 1
 
-	ps -p $pid > /dev/null 2> /dev/null
-	if [ $? -ne 0 ]; then
+	tpk_pid_exists=1
+	for tpk_iter in $(seq 5); do
+		tpk_state=$(ps -o state= -p $pid)
+		if [ -z "$tpk_state" ] || echo "$tpk_state" | grep -q Z; then
+			tpk_pid_exists=0
+			break
+		fi
+		sleep 1
+	done
+
+	if [ $tpk_pid_exists -eq 0 ]; then
 		wait $pid
 		if [ $? -eq 1 ]; then
 			result $FAIL "process $pid is killed by error"
-- 
1.7.1

