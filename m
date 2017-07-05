From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  5 Jul 2017 17:34:17 +0300
Subject: [LTP] [PATCH 1/2] cpuhotplug05.sh: call sar -P  $CPU_TO_TEST
Message-ID: <1499265258-25521-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On our systems the test regularly fails with:

<<<test_output>>>
Name:   cpuhotplug05
Date:   Fri Jun 30 07:44:15 PDT 2017
Desc:   Does sar behave properly during CPU hotplug events?

CPU is 1
0.00
cpuhotplug05 1 TBROK : no CPUs found offline
134451 ?        00:00:00 sar
<<<execution_status>>>

or with:

<<<test_output>>>
Name:   cpuhotplug05
Date:   Fri Jun 30 01:22:35 PDT 2017
Desc:   Does sar behave properly during CPU hotplug events?

CPU is 1
cpuhotplug05 1 TBROK : CPU1 Not Found on SAR!
 314000 ?        00:00:00 sar
<<<execution_status>>>

It seems that the program tests the following scenario:

1. It puts a CPU offline and starts SAR. SAR is expected to have '0.00' in
all the CPU statistics fields:

05:47:44        CPU     %user     %nice   %system   %iowait    %steal     %idle
05:47:45          1      0.00      0.00      0.00      0.00      0.00      0.00

2. Then it brings up the CPU and expects that SAR will start collecting
statistics.

05:48:14          1     93.89      0.18      5.93      0.00      0.00      0.00
05:48:15          1      0.00      0.00      0.00      0.00      0.00    100.00
05:48:16          1      0.00      0.00      0.00      0.00      0.00    100.00

I find that the current algorithm is volatile. For example, the output from 'date'
is used to grep the log file.

In order to reduce these false alarms I changed the main criteria. If 'sar'
reports all CPU statistics fields as '0.00', then it it treats the CPU as
an offline one. And when we put the CPU online, we expect that at least
one of the fields will change its value from the one it had in the offline case.
This change lets us call 'sar' to collect statistics only for $CPU_TO_TEST,
i.e. simplifies the parsing procedure.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh |   60 ++++++++++++--------
 1 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 32a35ad..731144c 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -38,6 +38,11 @@ do_clean()
 	pid_is_valid ${SAR_PID} && kill_pid ${SAR_PID}
 }
 
+get_field()
+{
+	echo "$1" | awk "{print \$$2}"
+}
+
 while getopts c:l:d: OPTION; do
 	case $OPTION in
 	c)
@@ -77,6 +82,8 @@ fi
 
 TST_CLEANUP=do_clean
 
+LOG_FILE="$TMP/log_$$"
+
 until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 
 	# Start up SAR and give it a couple cycles to run
@@ -86,42 +93,49 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 	# after that use "sar 1" instead of. Use 'ps -C sar' to check.
 	if ps -C sar >/dev/null 2>&1; then
 		pkill sar
-		sar -P ALL 1 0 > $TMP/log_$$ &
+		sar -P "$CPU_TO_TEST" 1 0 > "$LOG_FILE" &
 	else
-		sar -P ALL 1 > $TMP/log_$$ &
+		sar -P "$CPU_TO_TEST" 1 > "$LOG_FILE" &
 	fi
 	sleep 2
 	SAR_PID=$!
 
-	# Verify that SAR has correctly listed the missing CPU
-	while ! awk '{print $8}' $TMP/log_$$ | grep -i "^0.00"; do
-		tst_brkm TBROK "CPU${CPU_TO_TEST} Not Found on SAR!"
-	done
-	time=`date +%X`
-	sleep .5
-
-	# Verify that at least some of the CPUs are offline
-	NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | awk '{print $8}' \
-		|grep -i "^0.00" | wc -l)
-	if [ ${NUMBER_CPU_OFF} -eq 0 ]; then
-		tst_brkm TBROK "no CPUs found offline"
+	# Since the CPU is offline, SAR should display all the 6 fields
+	# of CPU statistics as '0.00'
+	offline_status=$(tail -n 1 "$LOG_FILE")
+	if [ -z "$offline_status" ]; then
+		tst_brkm TBROK "SAR output file is empty"
 	fi
 
+	for i in $(seq 3 8); do
+		field=$(get_field "$offline_status" "$i")
+		if [ "$field" != "0.00" ]; then
+			tst_brkm TBROK "Field $i is '$field', '0.00' expected"
+		fi
+	done
+
 	# Online the CPU
 	if ! online_cpu ${CPU_TO_TEST}; then
-		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined line"
+		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
 	fi
 
 	sleep 2
-	time=$(date +%T)
-	sleep .5
 
 	# Check that SAR registered the change in CPU online/offline states
-	NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$|awk '{print $8}' \
-		| grep -i "^0.00"| wc -l)
-	NUMBER_CPU_OFF=$((NUMBER_CPU_OFF-1))
-	if [ "$NUMBER_CPU_OFF" != "$NEW_NUMBER_CPU_OFF" ]; then
-		tst_resm TFAIL "no change in number of offline CPUs was found."
+	online_status=$(tail -n 1 "$LOG_FILE")
+	check_passed=0
+	for i in $(seq 3 8); do
+		field_offline=$(get_field "$offline_status" "$i")
+		field_online=$(get_field "$online_status" "$i")
+
+		if [ "$field_online" != "$field_offline" ]; then
+			check_passed=1
+			break
+		fi
+	done
+
+	if [ $check_passed -eq 0 ]; then
+		tst_resm TFAIL "No change in the CPU statistics"
 		tst_exit
 	fi
 
@@ -132,6 +146,6 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
 
 done
 
-tst_resm TPASS "CPU was found after turned on."
+tst_resm TPASS "SAR updated statistics after the CPU was turned on."
 
 tst_exit
-- 
1.7.1

