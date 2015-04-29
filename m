Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YnQ0S-00017D-SW
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 11:18:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnQ0Q-00011Y-9r
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 11:18:20 +0000
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Apr 2015 13:17:58 +0200
Message-Id: <58431a1d13093ed8a7a8564fb632b22f7378212f.1430305546.git.jstancek@redhat.com>
In-Reply-To: <cover.1430305546.git.jstancek@redhat.com>
References: <cover.1430305546.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/4] cpuhotplug: use cpu states in cleanup
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

From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

There is a couple of good functions:
 * get_all_cpu_states
 * set_all_cpu_states
which can help to avoid unnecessary cleanup logic in test cases.

So let's use them.

Also modified offline_cpu and online_cpu, so now they do nothing if
the cpu is already in the desired state.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Reviewed-by: Jan Stancek <jstancek@redhat.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh     | 11 ++++-------
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh     | 12 +++++-------
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh     | 18 +++++-------------
 .../hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh  | 16 ++++++++++------
 4 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index f91cf88..52598a9 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -45,13 +45,8 @@ do_clean()
 {
 	kill_pid ${WRL_ID}
 
-	# Turns off the cpus that were off before the test start
-	until [ $CPU_COUNT -eq 0 ]; do
-		offline_cpu=$(eval "echo \$OFFLINE_CPU_${CPU_COUNT}")
-		tst_resm TINFO "CPU = $CPU_COUNT @on = $offline_cpu"
-		offline_cpu $offline_cpu
-		CPU_COUNT=$((CPU_COUNT-1))
-	done
+	# Restore CPU states
+	set_all_cpu_states "$cpu_states"
 }
 
 
@@ -138,6 +133,8 @@ fi
 
 TST_CLEANUP=do_clean
 
+cpu_states=$(get_all_cpu_states)
+
 CPU_COUNT=0
 
 # Start up a process that writes to disk; keep track of its PID
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 8176fb3..817f066 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -46,11 +46,8 @@ do_clean()
 		rm /var/run/hotplug4_$$.pid
 	fi
 
-	# Turn off the CPUs that were off before the test start
-	until [ $cpu -eq 0 ];do
-		offline_cpu $(eval "echo \$on_${cpu}")
-		cpu=$((cpu-1))
-	done
+	# Restore CPU states
+	set_all_cpu_states "$cpu_states"
 }
 
 while getopts c:l: OPTION; do
@@ -82,11 +79,13 @@ fi
 
 TST_CLEANUP=do_clean
 
+cpu_states=$(get_all_cpu_states)
+
 until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 	cpu=0
 	number_of_cpus=0
 
-	# Turns on all CPUs and saves their states
+	# Turns on all CPUs
 	for i in $( get_all_cpus ); do
             if [ "$i" = "cpu0" ]; then
                 continue
@@ -96,7 +95,6 @@ until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
                     tst_brkm TBROK "Could not online cpu $i"
                 fi
 				cpu=$((cpu+1))
-                eval "on_${cpu}=$i"
             fi
 		number_of_cpus=$((number_of_cpus+1))
 	done
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index 72fbc6e..ea2723b 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -33,17 +33,8 @@ EOF
 do_clean()
 {
 	# Online the ones that were on initially
-	until [ $cpu -eq 0 ]; do
-		online_cpu $(eval "echo \$on_${cpu}")
-		cpu=$((cpu-1))
-	done
-
-	# Return CPU 0 to its initial state
-	if [ $cpustate = 1 ]; then
-		online_cpu 0
-	else
-		offline_cpu 0
-	fi
+	# Restore CPU states
+	set_all_cpu_states "$cpu_states"
 }
 
 while getopts l: OPTION; do
@@ -64,11 +55,13 @@ fi
 
 TST_CLEANUP=do_clean
 
+cpu_states=$(get_all_cpu_states)
+
 until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 	cpu=0
 	cpustate=1
 
-	# Online all the CPUs' keep track of which were already on
+	# Online all the CPUs
 	for i in $(get_all_cpus); do
 		if [ "$i" != "cpu0" ]; then
 			if ! cpu_is_online $i; then
@@ -77,7 +70,6 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 				fi
 			fi
 			cpu=$((cpu+1))
-			eval "on_${cpu}=$i"
 			echo $i
 		else
 			if online_cpu $i; then
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index dd8472f..f553d0c 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -73,6 +73,9 @@ online_cpu()
     if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
         return 1
     fi
+
+    cpu_is_online ${CPU} && return 0
+
     $TIME echo 1 > /sys/devices/system/cpu/cpu${CPU}/online
     RC=$?
     report_timing "Online cpu ${CPU}"
@@ -91,6 +94,9 @@ offline_cpu()
     if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
         return 1
     fi
+
+    ! cpu_is_online ${CPU} && return 0
+
     $TIME echo 0 > /sys/devices/system/cpu/cpu${CPU}/online
     RC=$?
     report_timing "Offline cpu ${CPU}"
@@ -141,20 +147,18 @@ get_all_cpu_states()
 
 # set_all_cpu_states(STATES)
 #
-#  Sets all of the CPU states according to $STATE, which must be
+#  Sets all of the CPU states according to STATES, which must be
 #  of the form "cpuX:Y", where X is the CPU number and Y its state.
 #  Each must be on a separate line.
 #
 set_all_cpu_states()
 {
-    for cpu_state in $STATE; do
-        cpu=`echo $c | cut -d: -f 1`
-        state=`echo $c | cut -d: -f 1`
+    for cpu_state in $1; do
+        cpu=`echo $cpu_state | cut -d: -f 1`
+        state=`echo $cpu_state | cut -d: -f 2`
         if [ $state = 1 ]; then
-            echo "# Re-onlining $cpu"
             online_cpu $cpu
         else
-            echo "# Re-offlining $cpu"
             offline_cpu $cpu
         fi
     done
-- 
1.8.3.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
