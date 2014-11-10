Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Xnrcu-0000Ey-Jn
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 16:15:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xnrcr-0004Ik-2m
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 16:15:36 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAAGFQSk024740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 11:15:26 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id sAAGFPbe028332
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 11:15:26 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Nov 2014 17:15:23 +0100
Message-Id: <a7fbbc77524700a50177e2baadc3c03dbf1fe67b.1415635901.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2 v5] controllers/cpuset: update to use test.sh
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

Remove useless returns and ret code checking.

cpuset_memory_spread_testset.sh:
 - treat node with not enough memory as TCONF, not failure

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |   51 +++++---------------
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    2 +-
 .../cpuset_memory_spread_testset.sh                |    9 +--
 3 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 79ecdad..cd7000e 100755
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
@@ -58,32 +60,28 @@ version_check()
 {
 	tst_kvercmp 2 6 28
 	if [ $? -eq 0 ]; then
-		tst_brkm TCONF ignored "kernel is below 2.6.28"
-		return 1
+		tst_brkm TCONF "kernel is below 2.6.28"
 	fi
 }
 
 ncpus_check()
 {
 	if [ $NR_CPUS -lt $1 ]; then
-		tst_brkm TCONF ignored "The total of CPUs is less than $1"
-		return 1
+		tst_brkm TCONF "The total of CPUs is less than $1"
 	fi
 }
 
 nnodes_check()
 {
 	if [ $N_NODES -lt $1 ]; then
-		tst_brkm TCONF ignored "The total of nodes is less than $1"
-		return 1
+		tst_brkm TCONF "The total of nodes is less than $1"
 	fi
 }
 
 user_check()
 {
 	if [ $(id -u) != 0 ]; then
-		tst_brkm TCONF ignored "Test must be run as root"
-		return 1
+		tst_brkm TCONF "Test must be run as root"
 	fi
 }
 
@@ -99,8 +97,7 @@ cpuset_check()
 		fi
 	fi
 
-	tst_brkm TCONF ignored "Cpuset is not supported"
-	return 1
+	tst_brkm TCONF "Cpuset is not supported"
 }
 
 # optional parameters (pass both or none of them):
@@ -109,29 +106,14 @@ cpuset_check()
 check()
 {
 	user_check
-	if [ $? -ne 0 ]; then
-		exit 0
-	fi
 
 	cpuset_check
-	if [ $? -ne 0 ]; then
-		exit 0
-	fi
 
 	version_check
-	if [ $? -ne 0 ]; then
-		exit 0
-	fi
 
 	ncpus_check ${1:-2}
-	if [ $? -ne 0 ]; then
-		exit 0
-	fi
 
 	nnodes_check ${2:-2}
-	if [ $? -ne 0 ]; then
-		exit 0
-	fi
 
 }
 
@@ -142,20 +124,16 @@ setup()
 	if [ -e "$CPUSET" ]
 	then
 		tst_resm TWARN "$CPUSET already exist.. overwriting"
-		cleanup || {
-			tst_brkm TFAIL ignored "Can't cleanup... Exiting"
-			return 1
-		}
+		cleanup || tst_brkm TFAIL "Can't cleanup... Exiting"
 	fi
 
 	mkdir -p "$CPUSET_TMP"
 	mkdir "$CPUSET"
 	mount -t cpuset cpuset "$CPUSET" 2> /dev/null
 	if [ $? -ne 0 ]; then
-		tst_brkm TFAIL ignored "Could not mount cgroup filesystem with"\
-					" cpuset on $CPUSET..Exiting test"
 		cleanup
-		return 1
+		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
+					" cpuset on $CPUSET..Exiting test"
 	fi
 }
 
@@ -173,24 +151,21 @@ cleanup()
 		do
 			/bin/kill -9 $pid > /dev/null 2>&1
 			if [ $? -ne 0 ]; then
-				tst_brkm TFAIL ignored "Couldn't kill task - "\
+				tst_brkm TFAIL "Couldn't kill task - "\
 							"$pid in the cpuset"
-				return 1
 			fi
 		done < "$subdir/tasks"
 		rmdir "$subdir"
 		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL ignored "Couldn't remove subdir - "
+			tst_brkm TFAIL "Couldn't remove subdir - "
 						"$subdir in the cpuset"
-			return 1
 		fi
 	done
 
 	umount "$CPUSET"
 	if [ $? -ne 0 ]; then
-		tst_brkm TFAIL ignored "Couldn't umount cgroup filesystem with"\
+		tst_brkm TFAIL "Couldn't umount cgroup filesystem with"\
 					" cpuset on $CPUSET..Exiting test"
-		return 1
 	fi
 	rmdir "$CPUSET" > /dev/null 2>&1
 	rm -rf "$CPUSET_TMP" > /dev/null 2>&1
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
index ad989f3..f7d4d63 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -331,21 +331,18 @@ test_spread_page2()
 init_memsinfo_array
 freemem_check
 if [ $? -ne 0 ]; then
-	tst_brkm TFAIL ignored "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
-	exit 1
+	tst_brkm TCONF "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
 fi
 
 dd if=/dev/zero of=./DATAFILE bs=1M count=100
 if [ $? -ne 0 ]; then
-	tst_brkm TFAIL ignored "Creating DATAFILE failed."
-	exit 1
+	tst_brkm TFAIL "Creating DATAFILE failed."
 fi
 
 mkfifo $FIFO
 if [ $? -ne 0 ]; then
 	rm -f DATAFILE
-	tst_brkm TFAIL ignored "failed to mkfifo $FIFO"
-	exit 1
+	tst_brkm TFAIL "failed to mkfifo $FIFO"
 fi
 
 test_spread_page1
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
