From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 23 Aug 2016 14:25:55 +0300
Subject: [LTP] [PATCH V2 4/4] memcg/functional: check several times if the
	process is killed
In-Reply-To: <1471951555-4230-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1471951555-4230-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1471951555-4230-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1471951555-4230-4-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some systems it may take slightly more than one second
to kill the memcg_process. So let's check several times if the
process is alive.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
No changes since V1.

 .../controllers/memcg/functional/memcg_lib.sh      |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 8822f48..1d6e495 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -231,10 +231,19 @@ test_proc_kill()
 	echo $pid > tasks
 
 	kill -s USR1 $pid 2> /dev/null
-	sleep 1
 
-	ps -p $pid > /dev/null 2> /dev/null
-	if [ $? -ne 0 ]; then
+	tpk_pid_exists=1
+	for tpk_iter in $(seq 20); do
+		if [ ! -d "/proc/$pid" ] ||
+			grep -q 'Z (zombie)' "/proc/$pid/status"; then
+			tpk_pid_exists=0
+			break
+		fi
+
+		tst_sleep 250ms
+	done
+
+	if [ $tpk_pid_exists -eq 0 ]; then
 		wait $pid
 		ret=$?
 		if [ $ret -eq 1 ]; then
-- 
1.7.1

