Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YftrL-00071Q-22
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 17:33:51 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YftrK-0006SC-2X
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 17:33:51 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t38HXiP2032199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t38HXhuu020480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:43 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t38HXhBW025318
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:43 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  8 Apr 2015 20:33:28 +0300
Message-Id: <1428514408-8763-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1428514408-8763-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1428514408-8763-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/3] cpuhotplug04.sh: operate only with hotpluggable
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
Cc: vasily.isaenko@oracle.com

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
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh |   56 +++++++++++--------
 1 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index ea2723b..7dcb91b 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -49,41 +49,49 @@ done
 LOOP_COUNT=1
 
 get_cpus_num
-if [ $? -lt 2 ]; then
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
-
-	# Online all the CPUs
-	for i in $(get_all_cpus); do
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
+
+	# Online all the hotpluggable CPUs
+	for i in $(get_hotplug_cpus); do
+		if ! cpu_is_online $i; then
+			if ! online_cpu $i; then
+				tst_brkm TBROK "$i can not be onlined"
 			fi
 		fi
 	done
 
-	# Now offline all the CPUs
-	for i in $(get_all_cpus); do
-		if ! offline_cpu $i; then
-			if [ "x$i" != "xcpu0" ]; then
-				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
-				tst_exit
+	# Now offline them
+	cpu=0
+	for i in $(get_hotplug_cpus); do
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
1.7.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
