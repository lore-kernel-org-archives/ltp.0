Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chase.qi@linaro.org>) id 1YfooA-0002L7-CR
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 12:10:14 +0000
Received: from mail-pd0-f172.google.com ([209.85.192.172])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yfoo9-0002Ao-0E
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 12:10:14 +0000
Received: by pdea3 with SMTP id a3so113508637pde.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Apr 2015 05:10:07 -0700 (PDT)
From: Chase Qi <chase.qi@linaro.org>
Date: Wed,  8 Apr 2015 19:44:09 +0800
Message-Id: <1428493449-9784-1-git-send-email-chase.qi@linaro.org>
Subject: [LTP] [PATCH] cpuhotplug05.sh: fix invalid usage of sar
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
To: ltp-list@lists.sourceforge.net, milosz.wasilewski@linaro.org, naresh.kamboju@linaro.org

Use 24-hour time to unify time format.

Fix invalid usage of sar.

Increase the sleep time after online_cpu to
adapt embedded hardware.

Signed-off-by: Chase Qi <chase.qi@linaro.org>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh   | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index bb0e896..f088d25 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -5,6 +5,7 @@
 
 export TCID="cpuhotplug05"
 export TST_TOTAL=1
+export LC_TIME="POSIX"
 
 # Includes:
 . test.sh
@@ -80,11 +81,11 @@ TST_CLEANUP=do_clean
 until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 
 	# Start up SAR and give it a couple cycles to run
-	sar 1 0 &>/dev/null &
+	sar 1 &>/dev/null &
 	sleep 2
 	if ps -C sar &>/dev/null; then
 		pkill sar
-		sar -P ALL 1 0 > $TMP/log_$$ &
+		sar -P ALL 1 > $TMP/log_$$ &
 	else
 		sar -P ALL 1 > $TMP/log_$$ &
 	fi
@@ -92,14 +93,14 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 	SAR_PID=$!
 
 	# Verify that SAR has correctly listed the missing CPU
-	while ! awk '{print $9}' $TMP/log_$$ | grep -i "^0.00"; do
+	while ! awk '{print $8}' $TMP/log_$$ | grep -i "^0.00"; do
 		tst_brkm TBROK "CPU${CPU_TO_TEST} Not Found on SAR!"
 	done
 	time=`date +%X`
 	sleep .5
 
 	# Verify that at least some of the CPUs are offline
-	NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | awk '{print $9}' \
+	NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | awk '{print $8}' \
 		|grep -i "^0.00" | wc -l)
 	if [ ${NUMBER_CPU_OFF} -eq 0 ]; then
 		tst_brkm TBROK "no CPUs found offline"
@@ -110,12 +111,12 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined line"
 	fi
 
-	sleep 1
+	sleep 2
 	time=$(date +%T)
 	sleep .5
 
 	# Check that SAR registered the change in CPU online/offline states
-	NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$|awk '{print $9}' \
+	NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$|awk '{print $8}' \
 		| grep -i "^0.00"| wc -l)
 	NUMBER_CPU_OFF=$((NUMBER_CPU_OFF-1))
 	if [ "$NUMBER_CPU_OFF" != "$NEW_NUMBER_CPU_OFF" ]; then
-- 
1.9.1


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
