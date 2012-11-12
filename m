Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TXoXE-0007Y2-CN
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 07:34:20 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TXoXA-0000X4-EI
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 07:34:20 +0000
From: <jin.li@windriver.com>
Date: Mon, 12 Nov 2012 15:34:00 +0800
Message-ID: <1352705641-27644-3-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
References: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] Fix cpuhotplug test case cpuhotplug03
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

Fix test case cpuhotplug03 as follows:
1. Avoid to check whether the cpu0 is on.
2. Check the cpu before turn it on

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh  | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index ca636d1..516a21f 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -60,15 +60,22 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 
 	# Turns on all CPUs and saves their states
 	for i in $( get_all_cpus ); do
-		if ! online_cpu $1; then
-			: $(( cpu += 1 ))
-			eval "on_${cpu}=$i"
-		fi
+            if [ "$i" = "cpu0" ]; then
+                continue
+            fi
+            if ! cpu_is_online $i; then
+		if ! online_cpu $i; then
+                    tst_resm TFAIL "Could not online cpu $i"
+                    exit_clean 1
+                fi
+                : $(( cpu += 1 ))
+                eval "on_${cpu}=$i"
+            fi
 		: $(( number_of_cpus += 1 ))
 	done
 
 	if ! offline_cpu ${CPU_TO_TEST} ; then
-		tst_resm TBAIL "CPU${CPU_TO_TEST} cannot be offlined"
+		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be offlined"
 		exit_clean 1
 	fi
 
@@ -90,7 +97,7 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 	tst_resm TINFO "Onlining CPU ${CPU_TO_TEST}"
 	online_cpu ${CPU_TO_TEST}
 	RC=$?
-	if [ $RC -eq 0 ]; then
+	if [ $RC -ne 0 ]; then
 		tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
 		exit_clean 1
 	fi
@@ -101,7 +108,7 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
 	ps -o psr -o command --no-headers -C do_spin_loop
 	RC=$?
 	NUM=`ps -o psr -o command --no-headers -C do_spin_loop | sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | wc -l`
-	if [ $RC -eq 0 ]; then
+	if [ $RC -ne 0 ]; then
 		tst_resm TBROK "No do_spin_loop processes found on any processor"
 	elif [ $NUM -lt 1 ]; then
 		tst_resm TFAIL "No do_spin_loop processes found on CPU${CPU_TO_TEST}"
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
