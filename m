Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YftrL-0006jc-Gz
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 17:33:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YftrK-0001xs-JB
	for ltp-list@lists.sourceforge.net; Wed, 08 Apr 2015 17:33:51 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t38HXiSR028334
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t38HXgt1028738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:43 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t38HXg5n025299
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Apr 2015 17:33:42 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  8 Apr 2015 20:33:27 +0300
Message-Id: <1428514408-8763-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1428514408-8763-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1428514408-8763-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/3] cpu_hotplug: added get_hotplug_cpus,
	get_hotplug_cpus_num
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpu_hotplug/include/cpuhotplug_hotplug.sh      |   22 ++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index f553d0c..558ef12 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -131,6 +131,28 @@ get_all_cpus()
         sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
 }
 
+# get_hotplug_cpus()
+#
+#  Prints a list of all hotpluggable CPUs
+#
+get_hotplug_cpus()
+{
+    ls /sys/devices/system/cpu/cpu[0-9]*/online 2> /dev/null | \
+        sed "s/\/sys\/devices\/system\/cpu\/\(cpu[0-9]*\)\/online/\1/g" || return 2
+}
+
+# get_hotplug_cpus_num()
+#
+#  Prints the number of hotpluggable CPUs
+#
+get_hotplug_cpus_num()
+{
+    hotplug_cpus=$(get_hotplug_cpus)
+    ret=$?
+    [ $ret -ne 0 ] && return 0
+
+    return $(echo "$hotplug_cpus" | grep -c 'cpu')
+}
 
 # get_all_cpu_states()
 #
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
