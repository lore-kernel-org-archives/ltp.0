Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Yn4EP-0000Ju-5H
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 12:03:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yn4EL-0000DP-2j
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 12:03:17 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id CC03D41
	for <ltp-list@lists.sourceforge.net>;
	Tue, 28 Apr 2015 12:03:06 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t3SC35MZ005739
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Apr 2015 08:03:06 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Apr 2015 14:02:56 +0200
Message-Id: <ae191066422a60089392e92dc3bbf79b7051005c.1430222251.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2] cpu_hotplug: use present rather than all CPUs
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

Testcases trying to offline/online not present CPUs
currently fail on powerpc with IBM PowerVM hypervisor.

In this setup, Linux guest usually sees all CPUs host has,
but most of them are not present (usable by guest). Attempt
to bring them online fails (presumably because lpar config
does not allow to do so).

Add get_present_cpus function and try to online/offline only
CPUs linux guest sees as 'present'. Very old kernels which
do not provide present cpu mask will try to use all CPUs.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh |  4 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh |  4 +-
 .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 50 ++++++++++++++++++----
 4 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index f91cf88..2cff3ba 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -151,7 +151,7 @@ do
 	IRQ_START=$(cat /proc/interrupts)
 
 	# Attempt to offline all CPUs
-	for cpu in $( get_all_cpus ); do
+	for cpu in $( get_present_cpus ); do
 		if [ "$cpu" = "cpu0" ]; then
 			continue
 		fi
@@ -166,7 +166,7 @@ do
 	done
 
 	# Attempt to online all CPUs
-	for cpu in $( get_all_cpus ); do
+	for cpu in $( get_present_cpus ); do
 		if [ "$cpu" = "cpu0" ]; then
 			continue
 		fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 8176fb3..7830f35 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -87,7 +87,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 	number_of_cpus=0
 
 	# Turns on all CPUs and saves their states
-	for i in $( get_all_cpus ); do
+	for i in $( get_present_cpus ); do
             if [ "$i" = "cpu0" ]; then
                 continue
             fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index 72fbc6e..6c9bb30 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -69,7 +69,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 	cpustate=1
 
 	# Online all the CPUs' keep track of which were already on
-	for i in $(get_all_cpus); do
+	for i in $(get_present_cpus); do
 		if [ "$i" != "cpu0" ]; then
 			if ! cpu_is_online $i; then
 				if ! online_cpu $i; then
@@ -87,7 +87,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 	done
 
 	# Now offline all the CPUs
-	for i in $(get_all_cpus); do
+	for i in $(get_present_cpus); do
 		if ! offline_cpu $i; then
 			if [ "x$i" != "xcpu0" ]; then
 				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index dd8472f..297724a 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -99,32 +99,64 @@ offline_cpu()
 
 # get_cpus_num()
 #
-#  Prints the number of all available CPUs, regardless of whether they're
+#  Prints the number of all present CPUs, regardless of whether they're
 #  currently online or offline.
 #
 get_cpus_num()
 {
-	[ -d /sys/devices/system/cpu/cpu0 ] || return -1
-	NUM=`ls /sys/devices/system/cpu/ \
-			| grep -c "cpu[0-9][0-9]*"`
-	return $NUM
+    local num=$(get_present_cpus | wc -w)
+    return $num
 }
 
 # get_all_cpus()
 #
 #  Prints a list of all available CPUs, regardless of whether they're
-#  currently online or offline.
+#  present.
 #
 #  This routine will work even if the CPUs are not hotpluggable, however
 #  it requires you have sysfs enabled in the kernel.
 #
 get_all_cpus()
 {
-    [ -d /sys/devices/system/cpu/cpu0 ] || return 1
-    ls -dr /sys/devices/system/cpu/cpu[0-9]* | \
-        sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
+    [ -d /sys/devices/system/cpu ] || return 1
+    (cd /sys/devices/system/cpu; ls -d cpu[0-9]*)
 }
 
+# get_present_cpus()
+#
+#  Prints a list of present CPUs, regardless of whether they're
+#  currently online or offline.
+#
+#  This routine will work even if the CPUs are not hotpluggable, however
+#  it requires you have sysfs enabled in the kernel.
+#
+get_present_cpus()
+{
+    # if sysfs present mask is missing, assume all cpu are present
+    if [ ! -e /sys/devices/system/cpu/present ]; then
+        get_all_cpus
+        return
+    fi
+
+    local present_mask="/sys/devices/system/cpu/present"
+    local present_cpus=""
+
+    for part in $(cat $present_mask | tr "," " "); do
+        if echo $part | grep -q "-"; then
+            range_low=$(echo $part | cut -d - -f 1)
+            range_high=$(echo $part | cut -d - -f 2)
+        else
+            range_low=$(part)
+            range_high=$(part)
+        fi
+        for cpu in $(seq $range_low $range_high); do
+            if [ -e /sys/devices/system/cpu/cpu$cpu ]; then
+                present_cpus="$present_cpus cpu$cpu"
+            fi
+        done
+    done
+    echo $present_cpus
+}
 
 # get_all_cpu_states()
 #
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
