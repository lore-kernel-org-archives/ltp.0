From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Thu,  3 Nov 2016 17:42:25 +0800
Subject: [LTP] [PATCH] memcg_control_test.sh:incorrect test result and a
	pipe issue
Message-ID: <1478166145-5177-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

* The test result flag FAILED_CNT is handled in a sub-shell,which will
make the test result passed even the test actually failed,update the
scripts to not running in sub-shell.
* Sometimes the mem_process process is killed after more than 5
seconds,increase the sleep time to 15 sceconds.And if the mem_process
process is killed after 5 sceconds,the pipe may blocked while writing
it(echo m > $STATUS_PIPE;echo x > $STATUS_PIPE),then the whole LTP
testing will hang.Adding a sub-shell to handle to pipe.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 .../memcg/control/memcg_control_test.sh            |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index 1d15872..668e74d 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -64,11 +64,15 @@ test_proc_kill()
 
 	#Instruct the test process to start acquiring memory
 	echo m > $STATUS_PIPE
-	sleep 5
+	sleep 15
 
 	#Check if killed
 	ps -p $! > /dev/null 2> /dev/null
 	if [ $? -eq 0 ]; then
+		(sleep 30
+		ps -p $! > /dev/null 2> /dev/null
+		[ $? -ne 0 -a -e $STATUS_PIPE ] && cat $STATUS_PIPE && \
+		rm -f $STATUS_PIPE) &
 		echo m > $STATUS_PIPE
 		echo x > $STATUS_PIPE
 	else
@@ -86,7 +90,8 @@ testcase_1()
 	echo "$TOT_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.memsw.limit_in_bytes
 
 	mkdir sub
-	(cd sub
+	basedir=$PWD
+	cd sub
 	KILLED_CNT=0
 	test_proc_kill
 
@@ -94,7 +99,8 @@ testcase_1()
 		result $FAIL "Test #1: failed"
 	else
 		result $PASS "Test #1: passed"
-	fi)
+	fi
+	cd $basedir
 	rmdir sub
 }
 
@@ -145,7 +151,8 @@ FAILED_CNT=0
 TST_NUM=1
 while [ $TST_NUM -le $TST_TOTAL ]; do
 	mkdir $TST_PATH/mnt/$TST_NUM
-	(cd $TST_PATH/mnt/$TST_NUM && testcase_$TST_NUM)
+	cd $TST_PATH/mnt/$TST_NUM && testcase_$TST_NUM
+	cd $TMP 
 	rmdir $TST_PATH/mnt/$TST_NUM
 	: $((TST_NUM += 1))
 done
-- 
1.7.7

