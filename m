Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Qj9QU-0001nA-8w
	for ltp-list@lists.sourceforge.net; Tue, 19 Jul 2011 12:29:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Qj9QO-0004E5-6T
	for ltp-list@lists.sourceforge.net; Tue, 19 Jul 2011 12:29:26 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6JCTEux003157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Jul 2011 08:29:14 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id p6JCTBZc031005
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Jul 2011 08:29:12 -0400
Message-ID: <4E257897.1080707@redhat.com>
Date: Tue, 19 Jul 2011 14:29:11 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040804070603010603040502"
Subject: [LTP] [PATCH v2] cgroups/cgroup_regression_test: fix sporadic
	failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040804070603010603040502
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


This patch fixes some failures caused by missing cleanup,
leaving groups behind after some stress tests.
Some stress tests failed to complete upon receiving SIGUSR1.

1. dmesg can rotate and number of found bugs can actually go down
clear the buffer before test to avoid this

2. test_5: test should mount 2 subsystems, but mount command
says "$subsys" instead of "$subsys2"

3. test_6: test may leave groups behind, fix rmdir
to match test_6_1.sh

4. test_7_2: mounts whole cgroup not $subsys

5. test_10: can leave cgroups umounted before cleanup
make sure cgroups are mounted before doing cleanup

6. test_*.sh scripts use trap in loop, which may cause bash
to miss signal, see
https://bugzilla.redhat.com/show_bug.cgi?id=695656
move trap outside loop to avoid it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  .../controllers/cgroup/cgroup_regression_test.sh   |   15 ++++++++++-----
  testcases/kernel/controllers/cgroup/test_10_1.sh   |    3 +--
  testcases/kernel/controllers/cgroup/test_10_2.sh   |    3 +--
  testcases/kernel/controllers/cgroup/test_3_1.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_3_2.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_6_1.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_9_1.sh    |    3 +--
  testcases/kernel/controllers/cgroup/test_9_2.sh    |    3 +--
  8 files changed, 17 insertions(+), 19 deletions(-)



--------------040804070603010603040502
Content-Type: text/x-patch;
	name="0001-cgroups-cgroup_regression_test-fix-sporadic-failures.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-cgroups-cgroup_regression_test-fix-sporadic-failures.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 878f91a..577c792 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -40,6 +40,7 @@ elif [ "x$(id -ru)" != x0 ]; then
 	exit 0
 fi
 
+dmesg -c > /dev/null
 nr_bug=`dmesg | grep -c "kernel BUG"`
 nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
 nr_warning=`dmesg | grep -c "^WARNING"`
@@ -78,6 +79,8 @@ check_kernel_bug()
 	nr_warning=$new_warning
 	nr_lockdep=$new_lockdep
 
+	echo "check_kernel_bug found something!"
+	dmesg
 	failed=1
 	return 0
 }
@@ -254,7 +257,7 @@ test_5()
 	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
 
-	mount -t cgroup -o $subsys1,$subsys xxx cgroup/
+	mount -t cgroup -o $subsys1,$subsys2 xxx cgroup/
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
 		failed=1
@@ -325,7 +328,7 @@ test_6()
 
 	# clean up
 	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
-	rmdir cgroup/[1-9] > /dev/null 2>&1
+	rmdir cgroup/[1-9]* > /dev/null 2>&1
 	umount cgroup/
 }
 
@@ -362,7 +365,7 @@ test_7_2()
 {
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount $subsys"
+		tst_resm TFAIL "failed to mount cgroup"
 		failed=1
 		return
 	fi
@@ -499,8 +502,9 @@ test_10()
 	wait $pid1
 	wait $pid2
 
-	rmdir cgroup/0 2> /dev/null
-	umount cgroup/ 2> /dev/null
+	mount -t cgroup none cgroup 2> /dev/null
+	rmdir cgroup/0
+	umount cgroup/
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
@@ -510,6 +514,7 @@ test_10()
 
 # main
 
+failed=0
 mkdir cgroup/
 
 for ((cur = 1; cur <= $TST_TOTAL; cur++))
diff --git a/testcases/kernel/controllers/cgroup/test_10_1.sh b/testcases/kernel/controllers/cgroup/test_10_1.sh
index 6284722..ffa0d5f 100755
--- a/testcases/kernel/controllers/cgroup/test_10_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_10_1.sh
@@ -22,13 +22,12 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	mkdir cgroup/0 > /dev/null 2>&1
 	rmdir cgroup/0 > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_10_2.sh b/testcases/kernel/controllers/cgroup/test_10_2.sh
index 82b91e3..f811bbd 100755
--- a/testcases/kernel/controllers/cgroup/test_10_2.sh
+++ b/testcases/kernel/controllers/cgroup/test_10_2.sh
@@ -22,11 +22,10 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_3_1.sh b/testcases/kernel/controllers/cgroup/test_3_1.sh
index 86627d4..507a2c4 100755
--- a/testcases/kernel/controllers/cgroup/test_3_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_3_1.sh
@@ -22,11 +22,10 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mkdir cgroup/0
 	rmdir cgroup/0
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_3_2.sh b/testcases/kernel/controllers/cgroup/test_3_2.sh
index c942969..9f83d9d 100755
--- a/testcases/kernel/controllers/cgroup/test_3_2.sh
+++ b/testcases/kernel/controllers/cgroup/test_3_2.sh
@@ -22,10 +22,9 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	cat /proc/sched_debug > /dev/null
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_6_1.sh b/testcases/kernel/controllers/cgroup/test_6_1.sh
index ff70677..e91e794 100755
--- a/testcases/kernel/controllers/cgroup/test_6_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_6_1.sh
@@ -22,12 +22,11 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
 	rmdir cgroup/[1-9]* > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_9_1.sh b/testcases/kernel/controllers/cgroup/test_9_1.sh
index 24a1524..c6e8f6f 100755
--- a/testcases/kernel/controllers/cgroup/test_9_1.sh
+++ b/testcases/kernel/controllers/cgroup/test_9_1.sh
@@ -22,13 +22,12 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 #	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	cat cgroup/release_agent > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 
diff --git a/testcases/kernel/controllers/cgroup/test_9_2.sh b/testcases/kernel/controllers/cgroup/test_9_2.sh
index 654df4d..f8e1c61 100755
--- a/testcases/kernel/controllers/cgroup/test_9_2.sh
+++ b/testcases/kernel/controllers/cgroup/test_9_2.sh
@@ -22,12 +22,11 @@
 ##                                                                            ##
 ################################################################################
 
+trap exit SIGUSR1
 for ((; ;))
 {
 #	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
 	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
 	umount cgroup/ > /dev/null 2>&1
-
-	trap exit SIGUSR1
 }
 


--------------040804070603010603040502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Magic Quadrant for Content-Aware Data Loss Prevention
Research study explores the data loss prevention market. Includes in-depth
analysis on the changes within the DLP market, and the criteria used to
evaluate the strengths and weaknesses of these DLP solutions.
http://www.accelacomm.com/jaw/sfnl/114/51385063/
--------------040804070603010603040502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040804070603010603040502--

