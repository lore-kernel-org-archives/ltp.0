Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TYXr4-0007mz-Py
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 07:57:50 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TYXr3-0001SD-Vg
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 07:57:50 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id qAE7viXJ007450
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Nov 2012 23:57:44 -0800 (PST)
From: <jin.li@windriver.com>
Date: Wed, 14 Nov 2012 15:57:35 +0800
Message-ID: <1352879855-18742-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352879855-18742-1-git-send-email-jin.li@windriver.com>
References: <1352879855-18742-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [V2] [PATCH] Fix cpuhotplug test case cpuhotplug01
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
To: jin.li@windriver.com, ltp-list@lists.sourceforge.net

From: Jin Li <jin.li@windriver.com>

Fix for case cpuhotplug01:

1. Give all available parameters to function migrate_irq.
2. Add the INFO note for the IRQ whose IRQ affinity is NOT permitted to changed.
3. Remove the variable cpustate and related code in function do_clean. The cpu,
which was off before the test start, has been closed correctly in do_clean.
4. Add test case PASS at the end of the passed case

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh   | 13 +++++--------
 testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns    | 12 ++++++++----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index acf7df1..07379dc 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -54,14 +54,12 @@ if ! cpu_is_valid "${CPU_TO_TEST}" ; then
 fi
 
 CPU_COUNT=0
-cpustate=1
 
 if ! cpu_is_online "${CPU_TO_TEST}" ; then
 	if ! online_cpu ${CPU_TO_TEST} ; then
 		tst_resm TFAIL "Could not online cpu $CPU_TO_TEST"
 		exit_clean 1
 	fi
-	cpustate=0
 fi
 
 # do_clean()
@@ -81,11 +79,6 @@ do_clean()
 		offline_cpu $offline_cpu
 		: $(( CPU_COUNT -= 1 ))
 	done
-	if [ "x${cpustate}" = x1 ]; then
-		online_cpu ${CPU_TO_TEST}
-	else
-		offline_cpu ${CPU_TO_TEST}
-	fi
 }
 
 
@@ -98,7 +91,7 @@ do_offline()
 	CPU=${1#cpu}
 	# Migrate some irq's this way first.
 	IRQS=`get_all_irqs`
-	migrate_irq ${CPU} ${IRQS}
+	migrate_irq "${CPU}" "${IRQS}"
 	offline_cpu ${CPU}
 	if [ $? -ne 0 ]; then
 		if [ "$CPU" -ne 0 ]; then
@@ -191,4 +184,8 @@ do
 
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
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
