Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TXoX9-0007XG-EM
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 07:34:15 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TXoX8-0005vu-Mv
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 07:34:15 +0000
From: <jin.li@windriver.com>
Date: Mon, 12 Nov 2012 15:33:59 +0800
Message-ID: <1352705641-27644-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
References: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] Fix cpuhotplug test case cpuhotplug01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: jin.li@windriver.com, gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net

From: Jin Li <jin.li@windriver.com>

Fix for case cpuhotplug01:

1. Give all available parameters to function migrate_irq.
2. Add the INFO note for the IRQ whose IRQ affinity is NOT permitted to changed.
3. Remove the variable cpustate and related code in function do_clean. The cpu,
which was off before the test start, has been closed correctly in do_clean.
4. Add test case PASS at the end of the passed case

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh    | 11 +++++------
 testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns     | 12 ++++++++----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index acf7df1..995c21b 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -81,11 +81,6 @@ do_clean()
 		offline_cpu $offline_cpu
 		: $(( CPU_COUNT -= 1 ))
 	done
-	if [ "x${cpustate}" = x1 ]; then
-		online_cpu ${CPU_TO_TEST}
-	else
-		offline_cpu ${CPU_TO_TEST}
-	fi
 }
 
 
@@ -98,7 +93,7 @@ do_offline()
 	CPU=${1#cpu}
 	# Migrate some irq's this way first.
 	IRQS=`get_all_irqs`
-	migrate_irq ${CPU} ${IRQS}
+	migrate_irq "${CPU}" "${IRQS}"
 	offline_cpu ${CPU}
 	if [ $? -ne 0 ]; then
 		if [ "$CPU" -ne 0 ]; then
@@ -191,4 +186,8 @@ do
 
 done
 
+if [ "$RC" -eq 0 ];then
+        tst_resm TPASS "online and offline cpu${CPU} when writing disk"
+fi
+
 exit_clean $RC
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns b/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
index 8a7cc32..6b3c933 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 # hotplug.fns - Collection of functions for hotplugging
 # operations.
 
@@ -27,7 +29,8 @@ migrate_irq()
     IRQS=$2
     for irq in ${IRQS}
       do
-      echo $MASK > /proc/irq/${irq}/smp_affinity
+      echo $MASK > /proc/irq/${irq}/smp_affinity || \
+        tst_resm TINFO "It is NOT permitted to change the IRQ $irq smp_affinity"
     done
 }
 
@@ -106,7 +109,8 @@ offline_cpu()
 get_all_cpus()
 {
     [ -d /sys/devices/system/cpu/cpu0 ] || return 1
-    ls -dr /sys/devices/system/cpu/cpu[0-9]* || return 2
+    ls -dr /sys/devices/system/cpu/cpu[0-9]* | \
+        sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
 }
 
 
@@ -183,8 +187,8 @@ cpu_is_valid()
 
 # cpu_is_online(CPU)
 #
-#  Returns a true value if the given CPU number is currently online,
-#  false otherwise.  This function requires the system's CPUs have
+#  Returns a 0 value if the given CPU number is currently online,
+#  1 otherwise.  This function requires the system's CPUs have
 #  hotplug capabilities.
 #
 cpu_is_online()
-- 
1.7.11


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
