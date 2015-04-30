Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YnjbE-0005jp-8O
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:13:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnjbC-0007hF-8h
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:13:36 +0000
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Apr 2015 10:13:19 +0200
Message-Id: <d54e39bf8ab3b7c337629bda279a3a5b1446bcdd.1430380932.git.jstancek@redhat.com>
In-Reply-To: <cover.1430380932.git.jstancek@redhat.com>
References: <cover.1430380932.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 3/4 v3] cpu_hotplug: use hotplug/present cpus functions
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

Also, make no special treatment for cpu0.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh   |  6 +++---
 .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh   |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh   | 20 +++++++-------------
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh   |  4 ++--
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh   |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh   |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh   |  2 +-
 7 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index 52598a9..8ae1379 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -111,7 +111,7 @@ LOOP_COUNT=1
 
 tst_check_cmds perl
 
-get_cpus_num
+get_present_cpus_num
 if [ $? -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
@@ -148,7 +148,7 @@ do
 	IRQ_START=$(cat /proc/interrupts)
 
 	# Attempt to offline all CPUs
-	for cpu in $( get_all_cpus ); do
+	for cpu in $( get_hotplug_cpus ); do
 		if [ "$cpu" = "cpu0" ]; then
 			continue
 		fi
@@ -163,7 +163,7 @@ do
 	done
 
 	# Attempt to online all CPUs
-	for cpu in $( get_all_cpus ); do
+	for cpu in $( get_hotplug_cpus ); do
 		if [ "$cpu" = "cpu0" ]; then
 			continue
 		fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
index 3b33720..c42cc1b 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
@@ -54,7 +54,7 @@ done
 
 LOOP_COUNT=1
 
-get_cpus_num
+get_present_cpus_num
 if [ $? -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 817f066..3469b10 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -63,8 +63,9 @@ done
 
 LOOP_COUNT=1
 
-get_cpus_num
-if [ $? -lt 2 ]; then
+get_present_cpus_num
+cpus_num=$?
+if [ $cpus_num -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
 
@@ -82,21 +83,14 @@ TST_CLEANUP=do_clean
 cpu_states=$(get_all_cpu_states)
 
 until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
-	cpu=0
-	number_of_cpus=0
 
 	# Turns on all CPUs
-	for i in $( get_all_cpus ); do
-            if [ "$i" = "cpu0" ]; then
-                continue
-            fi
+	for i in $( get_hotplug_cpus ); do
             if ! cpu_is_online $i; then
 				if ! online_cpu $i; then
                     tst_brkm TBROK "Could not online cpu $i"
                 fi
-				cpu=$((cpu+1))
             fi
-		number_of_cpus=$((number_of_cpus+1))
 	done
 
 	if ! offline_cpu ${CPU_TO_TEST} ; then
@@ -107,11 +101,11 @@ until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 	# CPUs we have.  This is to help ensure we've got enough processes
 	# that at least one will migrate to the new CPU.  Store the PIDs
 	# so we can kill them later.
-	number_of_cpus=$((number_of_cpus*2))
-	until [ $number_of_cpus -eq 0 ]; do
+	number_of_procs=$((cpus_num*2))
+	until [ $number_of_procs -eq 0 ]; do
 		cpuhotplug_do_spin_loop > /dev/null 2>&1 &
 		echo $! >> /var/run/hotplug4_$$.pid
-		number_of_cpus=$((number_of_cpus-1))
+		number_of_procs=$((number_of_procs-1))
 	done
 
 	ps aux | head -n 1
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index ea2723b..3e025da 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -62,7 +62,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 	cpustate=1
 
 	# Online all the CPUs
-	for i in $(get_all_cpus); do
+	for i in $(get_hotplug_cpus); do
 		if [ "$i" != "cpu0" ]; then
 			if ! cpu_is_online $i; then
 				if ! online_cpu $i; then
@@ -79,7 +79,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 	done
 
 	# Now offline all the CPUs
-	for i in $(get_all_cpus); do
+	for i in $(get_hotplug_cpus); do
 		if ! offline_cpu $i; then
 			if [ "x$i" != "xcpu0" ]; then
 				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index bb0e896..79f7e90 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -54,7 +54,7 @@ LOOP_COUNT=1
 
 tst_check_cmds sar
 
-get_cpus_num
+get_present_cpus_num
 if [ $? -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index 2e48242..6710fad 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -49,7 +49,7 @@ done
 
 LOOP_COUNT=1
 
-get_cpus_num
+get_present_cpus_num
 if [ $? -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
index 723f3de..7edb3a9 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
@@ -55,7 +55,7 @@ done
 
 LOOP_COUNT=1
 
-get_cpus_num
+get_present_cpus_num
 if [ $? -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
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
