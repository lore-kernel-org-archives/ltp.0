Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YnjbC-0005jc-Ad
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:13:34 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnjbB-0001Qc-HF
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:13:34 +0000
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Apr 2015 10:13:18 +0200
Message-Id: <62582378d072a7154607bdb97ee95319e30f2fb0.1430380932.git.jstancek@redhat.com>
In-Reply-To: <cover.1430380932.git.jstancek@redhat.com>
References: <cover.1430380932.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/4 v3] cpu_hotplug: add get_hotplug_cpus,
	get_present_cpus
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 73 +++++++++++++++++++++-
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index f553d0c..6920393 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -126,11 +126,78 @@ get_cpus_num()
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
+get_present_cpus()
+{
+    local present_mask="/sys/devices/system/cpu/present"
+    local present_cpus=""
+
+    # if sysfs present mask is missing, assume all cpu are present
+    if [ ! -e "$present_mask" ]; then
+        get_all_cpus
+        return
+    fi
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
+
+# get_present_cpus_num()
+#
+#  Prints the number of present CPUs
+#
+get_present_cpus_num()
+{
+    return $(get_present_cpus | wc -w)
+}
+
+# get_hotplug_cpus()
+#
+#  Prints a list of present hotpluggable CPUs, regardless of whether they're
+#  currently online or offline.
+#
+get_hotplug_cpus()
+{
+    local present_cpus=$(get_present_cpus)
+    local hotplug_cpus=""
+
+    for cpu in $present_cpus; do
+        if [ -e /sys/devices/system/cpu/$cpu/online ]; then
+            hotplug_cpus="$hotplug_cpus $cpu"
+	fi
+    done
+    echo $hotplug_cpus
+}
+
+# get_hotplug_cpus_num()
+#
+#  Prints the number of hotpluggable CPUs
+#
+get_hotplug_cpus_num()
+{
+    return $(get_hotplug_cpus | wc -w)
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
