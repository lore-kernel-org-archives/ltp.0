Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XS3K2-0003GK-E9
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 12:17:58 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XS3Jv-0006ps-GJ
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 12:17:58 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8BCHp2K013588
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 20:17:51 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu, 11 Sep 2014 20:15:27 +0800
Message-ID: <1410437727-14764-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] hotplug/cpu_hotplug: add it to run default
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
To: ltp-list@lists.sourceforge.net

Fix test cases' exit status with TCONF on single cpu
machine, and add it to run default.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 scenario_groups/default                                      |  1 +
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh    |  7 ++++---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh    |  9 +++++++--
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh    |  9 +++++++--
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh    |  5 +++++
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh    |  9 +++++++--
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh    |  7 ++++++-
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh    | 10 ++++++++++
 .../kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh | 12 ++++++++++++
 9 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/scenario_groups/default b/scenario_groups/default
index 00da222..3a55702 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -31,3 +31,4 @@ pipes
 dma_thread_diotest
 cpuacct
 can
+cpuhotplug
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index e1a1855..f91cf88 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -116,7 +116,8 @@ LOOP_COUNT=1
 
 tst_check_cmds perl
 
-if ! get_all_cpus >/dev/null 2>&1; then
+get_cpus_num
+if [ $? -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
 
@@ -124,9 +125,9 @@ if [ -z "${CPU_TO_TEST}" ]; then
 	tst_brkm TBROK "usage: ${0##*/} <CPU to online>"
 fi
 
-# Validate the specified CPU exists
+# Validate the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_brkm TBROK "cpu${CPU_TO_TEST} not found"
+	tst_brkm TCONF "cpu${CPU_TO_TEST} doesn't support hotplug"
 fi
 
 if ! cpu_is_online "${CPU_TO_TEST}" ; then
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
index edfdd35..3b33720 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
@@ -54,13 +54,18 @@ done
 
 LOOP_COUNT=1
 
+get_cpus_num
+if [ $? -lt 2 ]; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+fi
+
 if [ -z "${CPU_TO_TEST}" ]; then
 	tst_brkm TBROK "usage: ${0##*/} <CPU to online>"
 fi
 
-# Validate the specified CPU exists
+# Validate the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_brkm TBROK "cpu${CPU_TO_TEST} not found"
+	tst_brkm TCONF "cpu${CPU_TO_TEST} doesn't support hotplug"
 fi
 
 # Validate the specified CPU is online; if not, online it
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 61c7ba5..8176fb3 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -66,13 +66,18 @@ done
 
 LOOP_COUNT=1
 
+get_cpus_num
+if [ $? -lt 2 ]; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+fi
+
 if [ -z $CPU_TO_TEST ]; then
 	tst_brkm TBROK "usage: ${0##*} <CPU to online>"
 fi
 
-# Verify the specified CPU exists
+# Validate the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_brkm TBROK "CPU${CPU_TO_TEST} not found"
+	tst_brkm TCONF "cpu${CPU_TO_TEST} doesn't support hotplug"
 fi
 
 TST_CLEANUP=do_clean
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index 0e3d5f4..72fbc6e 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -57,6 +57,11 @@ done
 
 LOOP_COUNT=1
 
+get_cpus_num
+if [ $? -lt 2 ]; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+fi
+
 TST_CLEANUP=do_clean
 
 until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 34b160a..bb0e896 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -54,13 +54,18 @@ LOOP_COUNT=1
 
 tst_check_cmds sar
 
+get_cpus_num
+if [ $? -lt 2 ]; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+fi
+
 if [ -z "$CPU_TO_TEST" ]; then
 	tst_brkm TBROK "usage: ${0##*} <CPU to offline>"
 fi
 
-# Verify the specified CPU is available
+# Validate the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_brkm TBROK "CPU${CPU_TO_TEST} not found"
+	tst_brkm TCONF "cpu${CPU_TO_TEST} doesn't support hotplug"
 fi
 
 # Check that the specified CPU is offline; if not, offline it
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index d382fc8..2e48242 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -49,13 +49,18 @@ done
 
 LOOP_COUNT=1
 
+get_cpus_num
+if [ $? -lt 2 ]; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+fi
+
 if [ -z "$CPU_TO_TEST" ]; then
 	tst_brkm TBROK "Usage: ${0##*/} <CPU to offline>"
 fi
 
 # Verify that the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
-	tst_brkm TBROK "CPU${CPU_TO_TEST} not found"
+	tst_brkm TCONF "cpu${CPU_TO_TEST} doesn't support hotplug"
 fi
 
 # Check that the specified CPU is online; if not, online it
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
index 32bbf1c..723f3de 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
@@ -55,6 +55,11 @@ done
 
 LOOP_COUNT=1
 
+get_cpus_num
+if [ $? -lt 2 ]; then
+	tst_brkm TCONF "system doesn't have required CPU hotplug support"
+fi
+
 if [ ! -d "${KERNEL_DIR}" ]; then
 	tst_brkm TCONF "kernel directory - $KERNEL_DIR - does not exist"
 fi
@@ -64,6 +69,11 @@ if [ -z "${CPU_TO_TEST}" ]; then
 		source code directory>"
 fi
 
+# Validate the specified CPU is available
+if ! cpu_is_valid "${CPU_TO_TEST}" ; then
+	tst_brkm TCONF "cpu${CPU_TO_TEST} doesn't support hotplug"
+fi
+
 if ! cpu_is_online ${CPU_TO_TEST}; then
 	if ! online_cpu ${CPU_TO_TEST}; then
 		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index 8ded6bb..dd8472f 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -97,6 +97,18 @@ offline_cpu()
     return $RC
 }
 
+# get_cpus_num()
+#
+#  Prints the number of all available CPUs, regardless of whether they're
+#  currently online or offline.
+#
+get_cpus_num()
+{
+	[ -d /sys/devices/system/cpu/cpu0 ] || return -1
+	NUM=`ls /sys/devices/system/cpu/ \
+			| grep -c "cpu[0-9][0-9]*"`
+	return $NUM
+}
 
 # get_all_cpus()
 #
-- 
1.9.3


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
