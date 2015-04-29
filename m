Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YnQ0T-0007QH-UV
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 11:18:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnQ0S-00011i-4W
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 11:18:21 +0000
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Apr 2015 13:18:01 +0200
Message-Id: <c572d17a0a61f532993ea65f898b8cb880d98935.1430305546.git.jstancek@redhat.com>
In-Reply-To: <cover.1430305546.git.jstancek@redhat.com>
References: <cover.1430305546.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 4/4] cpuhotplug04.sh: operate only with hotpluggable
	CPUs
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

If cpu0 is hotpluggable, then the last CPU may not be cpu0, and
there is no reason to treat cpu0 as a special case.

To make the test be more generic I'm proposing these changes:
 * Operate (offline/online) only with hotpluggable CPUs, because
   how can we enable/disable a CPU if there is no 'online' file?

 * If all CPUs in the system are hotpluggable, then we expect that
   the kernel will only refuse to offline the last CPU. And this
   last CPU may not be cpu0.

 * If only a part of CPUs in the system is hotpluggable, then we
   should be able to offline all of them

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh | 52 +++++++++++++---------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index 3e025da..58a822e 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -48,42 +48,50 @@ done
 
 LOOP_COUNT=1
 
-get_cpus_num
-if [ $? -lt 2 ]; then
+get_present_cpus_num
+cpus_num=$?
+if [ $cpus_num -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
 
+get_hotplug_cpus_num
+if [ $? -lt 1 ]; then
+	tst_brkm TCONF "system doesn't have at least one hotpluggable CPU"
+fi
+
 TST_CLEANUP=do_clean
 
 cpu_states=$(get_all_cpu_states)
 
 until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
-	cpu=0
-	cpustate=1
 
-	# Online all the CPUs
+	# Online all the hotpluggable CPUs
 	for i in $(get_hotplug_cpus); do
-		if [ "$i" != "cpu0" ]; then
-			if ! cpu_is_online $i; then
-				if ! online_cpu $i; then
-					tst_brkm TBROK "$i cannot be onlined"
-				fi
-			fi
-			cpu=$((cpu+1))
-			echo $i
-		else
-			if online_cpu $i; then
-				cpustate=0
+		if ! cpu_is_online $i; then
+			if ! online_cpu $i; then
+				tst_brkm TBROK "$i can not be onlined"
 			fi
 		fi
 	done
 
-	# Now offline all the CPUs
+	# Now offline them
+	cpu=0
 	for i in $(get_hotplug_cpus); do
-		if ! offline_cpu $i; then
-			if [ "x$i" != "xcpu0" ]; then
-				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
-				tst_exit
+		cpu=$((cpu + 1))
+
+		# If all the CPUs are hotpluggable, we expect
+		# that the kernel will refuse to offline the last CPU.
+		# If only some of the CPUs are hotpluggable,
+		# they all can be offlined.
+		if [ $cpu -eq $cpus_num ]; then
+			if offline_cpu $i 2> /dev/null; then
+				tst_brkm TFAIL "Have we just offlined the last CPU?"
+			else
+				tst_resm TPASS "System prevented us from offlining the last CPU - $i"
+			fi
+		else
+			if ! offline_cpu $i; then
+				tst_brkm TFAIL "Could not offline $i"
 			fi
 		fi
 	done
@@ -92,6 +100,6 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 
 done
 
-tst_resm TPASS "Successfully offlined first CPU, $i"
+tst_resm TPASS "Success"
 
 tst_exit
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
