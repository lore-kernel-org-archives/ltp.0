Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XD7sn-0001w1-QW
	for ltp-list@lists.sourceforge.net; Fri, 01 Aug 2014 08:08:09 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XD7sm-0002Qu-On
	for ltp-list@lists.sourceforge.net; Fri, 01 Aug 2014 08:08:09 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s7187xk1020301
	for <ltp-list@lists.sourceforge.net>; Fri, 1 Aug 2014 16:07:59 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 1 Aug 2014 16:06:20 +0800
Message-ID: <1406880380-29383-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuacct/run_cpuacct_test.sh: fix the order of cleanup
	and task_kill
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

When there are running tasks in the child group of cgroup, the child
group can't be removed. So fix the order of cleanup and task_kill in
run_cpuacct_test.sh.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 .../kernel/controllers/cpuacct/run_cpuacct_test.sh    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh b/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
index 88425f8..b31aa45 100755
--- a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
+++ b/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
@@ -236,16 +236,16 @@ case ${TEST_NUM} in
 	mkdir $cg_path/group_1/group_11/ 2> /dev/null
 	if [ $? -ne 0 ]; then
 		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
-		cleanup
 		task_kill 2> /dev/null
+		cleanup
 		exit 1
 	fi
 	echo $pid > $cg_path/group_1/group_11/tasks 2> /dev/null
 	if [ $? -ne 0 ]; then
 		echo "TFAIL Not able to move a task to the cgroup"
 		echo "Exiting Test"
-		cleanup 2> /dev/null
 		task_kill 2> /dev/null
+		cleanup
 		exit 1
 	fi
 	sleep 5
@@ -262,13 +262,14 @@ case ${TEST_NUM} in
 	if [ $status -eq 0 ]; then
 		echo
 		tst_resm TPASS "$mes test executed successfully"
-		cleanup 2> /dev/null
 		task_kill 2> /dev/null
+		cleanup
 		exit 0
 	else
 		echo
 		tst_resm TFAIL "$mes test execution Failed"
-		cleanup 2> /dev/null
+		task_kill 2> /dev/null
+		cleanup
 		exit 1
 	fi
 	;;
@@ -279,8 +280,8 @@ case ${TEST_NUM} in
 	mkdir $cg_path/group_1/group_12 2> /dev/null
 	if [ $? -ne 0 ]; then
 		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
-		cleanup 2> /dev/null
 		task_kill 2> /dev/null
+		cleanup
 		exit 1
 	fi
 
@@ -292,8 +293,8 @@ case ${TEST_NUM} in
 		if [ $? -ne 0 ]; then
 			echo "TFAIL Not able to move task to cgroup"
 			echo "Exiting Test"
-			cleanup 2> /dev/null
 			task_kill 2> /dev/null
+			cleanup
 			exit 1
 		fi
 		nr_tasks
@@ -301,8 +302,8 @@ case ${TEST_NUM} in
 		if [ $? -ne 0 ]; then
 			echo "TFAIL Not able to move task to cgroup"
 			echo "Exiting Test"
-			cleanup 2> /dev/null
 			task_kill 2> /dev/null
+			cleanup
 			exit 1
 		fi
 		sleep 2
@@ -321,14 +322,14 @@ case ${TEST_NUM} in
 	if [ $status -eq 0 ]; then
 		echo
 		tst_resm TPASS "$mes test executed successfully"
-		cleanup 2> /dev/null
 		task_kill 2> /dev/null
+		cleanup
 		exit 0
 	else
 		echo
 		tst_resm TFAIL "$mes test execution Failed"
-		cleanup 2> /dev/null
 		task_kill 2> /dev/null
+		cleanup
 		exit 1
 	fi
 	;;
-- 
1.9.3


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
