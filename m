Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XnqKq-0008CA-Mh
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 14:52:52 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XnqKp-0000HR-0s
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 14:52:52 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAAEqhGF016425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 09:52:43 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id sAAEqfv3008892
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 09:52:42 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Nov 2014 15:52:27 +0100
Message-Id: <83f98a9de7c4e97c958bd7f9c33610898b998e29.1415630966.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2 v4] controllers/cpuset: update to use test.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |   22 ++++++++++---------
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    2 +-
 .../cpuset_memory_spread_testset.sh                |    6 ++--
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 79ecdad..2898f19 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -24,6 +24,8 @@
 ##                                                                            ##
 ################################################################################
 
+. test.sh
+
 NR_CPUS=`tst_ncpus`
 if [ -f "/sys/devices/system/node/has_high_memory" ]; then
 	N_NODES="`cat /sys/devices/system/node/has_high_memory`"
@@ -58,7 +60,7 @@ version_check()
 {
 	tst_kvercmp 2 6 28
 	if [ $? -eq 0 ]; then
-		tst_brkm TCONF ignored "kernel is below 2.6.28"
+		tst_brkm TCONF "kernel is below 2.6.28"
 		return 1
 	fi
 }
@@ -66,7 +68,7 @@ version_check()
 ncpus_check()
 {
 	if [ $NR_CPUS -lt $1 ]; then
-		tst_brkm TCONF ignored "The total of CPUs is less than $1"
+		tst_brkm TCONF "The total of CPUs is less than $1"
 		return 1
 	fi
 }
@@ -74,7 +76,7 @@ ncpus_check()
 nnodes_check()
 {
 	if [ $N_NODES -lt $1 ]; then
-		tst_brkm TCONF ignored "The total of nodes is less than $1"
+		tst_brkm TCONF "The total of nodes is less than $1"
 		return 1
 	fi
 }
@@ -82,7 +84,7 @@ nnodes_check()
 user_check()
 {
 	if [ $(id -u) != 0 ]; then
-		tst_brkm TCONF ignored "Test must be run as root"
+		tst_brkm TCONF "Test must be run as root"
 		return 1
 	fi
 }
@@ -99,7 +101,7 @@ cpuset_check()
 		fi
 	fi
 
-	tst_brkm TCONF ignored "Cpuset is not supported"
+	tst_brkm TCONF "Cpuset is not supported"
 	return 1
 }
 
@@ -143,7 +145,7 @@ setup()
 	then
 		tst_resm TWARN "$CPUSET already exist.. overwriting"
 		cleanup || {
-			tst_brkm TFAIL ignored "Can't cleanup... Exiting"
+			tst_brkm TFAIL "Can't cleanup... Exiting"
 			return 1
 		}
 	fi
@@ -152,7 +154,7 @@ setup()
 	mkdir "$CPUSET"
 	mount -t cpuset cpuset "$CPUSET" 2> /dev/null
 	if [ $? -ne 0 ]; then
-		tst_brkm TFAIL ignored "Could not mount cgroup filesystem with"\
+		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
 					" cpuset on $CPUSET..Exiting test"
 		cleanup
 		return 1
@@ -173,14 +175,14 @@ cleanup()
 		do
 			/bin/kill -9 $pid > /dev/null 2>&1
 			if [ $? -ne 0 ]; then
-				tst_brkm TFAIL ignored "Couldn't kill task - "\
+				tst_brkm TFAIL "Couldn't kill task - "\
 							"$pid in the cpuset"
 				return 1
 			fi
 		done < "$subdir/tasks"
 		rmdir "$subdir"
 		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL ignored "Couldn't remove subdir - "
+			tst_brkm TFAIL "Couldn't remove subdir - "
 						"$subdir in the cpuset"
 			return 1
 		fi
@@ -188,7 +190,7 @@ cleanup()
 
 	umount "$CPUSET"
 	if [ $? -ne 0 ]; then
-		tst_brkm TFAIL ignored "Couldn't umount cgroup filesystem with"\
+		tst_brkm TFAIL "Couldn't umount cgroup filesystem with"\
 					" cpuset on $CPUSET..Exiting test"
 		return 1
 	fi
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index 611ea62..05a9ea6 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -150,7 +150,7 @@ general_cpu_hotplug_test()
 	cpu_hotplug $HOTPLUG_CPU $cpuhotplug 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
-		tst_resm TFAIL ignored "$cpuoffline CPU#$HOTPLUG_CPU failed."
+		tst_resm TFAIL "$cpuoffline CPU#$HOTPLUG_CPU failed."
 		/bin/kill -s SIGKILL $tst_pid
 		return 1
 	fi
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index ad989f3..99d4c8e 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -331,20 +331,20 @@ test_spread_page2()
 init_memsinfo_array
 freemem_check
 if [ $? -ne 0 ]; then
-	tst_brkm TFAIL ignored "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
+	tst_brkm TFAIL "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
 	exit 1
 fi
 
 dd if=/dev/zero of=./DATAFILE bs=1M count=100
 if [ $? -ne 0 ]; then
-	tst_brkm TFAIL ignored "Creating DATAFILE failed."
+	tst_brkm TFAIL "Creating DATAFILE failed."
 	exit 1
 fi
 
 mkfifo $FIFO
 if [ $? -ne 0 ]; then
 	rm -f DATAFILE
-	tst_brkm TFAIL ignored "failed to mkfifo $FIFO"
+	tst_brkm TFAIL "failed to mkfifo $FIFO"
 	exit 1
 fi
 
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
