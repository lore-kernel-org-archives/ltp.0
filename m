Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Yn4ER-0003n7-7o
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 12:03:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yn4EM-0001ca-K6
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 12:03:19 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SC37ZC012662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Apr 2015 08:03:07 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t3SC35Ma005739
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Apr 2015 08:03:07 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Apr 2015 14:02:57 +0200
Message-Id: <6ba415ae6a98d8c0753cff24aac94dccc7ae0e61.1430222251.git.jstancek@redhat.com>
In-Reply-To: <ae191066422a60089392e92dc3bbf79b7051005c.1430222251.git.jstancek@redhat.com>
References: <ae191066422a60089392e92dc3bbf79b7051005c.1430222251.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2] cpuhotplug04: check that all but last CPU can be
	offlined
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

This testcase check looks wrong. Failing to offline CPU X
does not mean that it failed to offline CPU 0.

Change the condition to check, that all but last CPU can
be offlined.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index 6c9bb30..4fc6399 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -87,19 +87,22 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 	done
 
 	# Now offline all the CPUs
+	failed_to_offline=0
 	for i in $(get_present_cpus); do
 		if ! offline_cpu $i; then
-			if [ "x$i" != "xcpu0" ]; then
-				tst_resm TFAIL "Did not offline first CPU (offlined $i instead)"
-				tst_exit
-			fi
+			tst_resm TINFO "Failed to offline $i"
+			failed_to_offline=$((failed_to_offline + 1))
 		fi
 	done
+	if [ "$failed_to_offline" -gt 1 ]; then
+		tst_resm TFAIL "$failed_to_offline CPUs failed to offline"
+		tst_exit
+	fi
 
 	LOOP_COUNT=$((LOOP_COUNT+1))
 
 done
 
-tst_resm TPASS "Successfully offlined first CPU, $i"
+tst_resm TPASS "Successfully offlined all but last CPU"
 
 tst_exit
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
