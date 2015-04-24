Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YlU19-00016k-Td
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:03 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlU18-0004ar-Ph
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:03 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O39f1d031033
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 11:09:42 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 11:06:02 +0800
Message-ID: <1429844769-7113-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 1/8] kernel/power_management: fix no_of_cpus error
	of change_govr.sh etc.
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

The function "no_of_cpus" doesn't exist, which is used in change_freq.sh,
change_govr.sh and check_cpufreq_sysfs_files.sh. Use "tst_ncpus" instead
of "no_of_cpus".

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/power_management/change_freq.sh               | 2 +-
 testcases/kernel/power_management/change_govr.sh               | 2 +-
 testcases/kernel/power_management/check_cpufreq_sysfs_files.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/power_management/change_freq.sh b/testcases/kernel/power_management/change_freq.sh
index 204e21f..3a971d2 100755
--- a/testcases/kernel/power_management/change_freq.sh
+++ b/testcases/kernel/power_management/change_freq.sh
@@ -5,7 +5,7 @@ available_freq=$(get_supporting_freq)
 available_govr=$(get_supporting_govr)
 RC=0
 
-total_cpus=$(no_of_cpus)
+total_cpus=$(tst_ncpus)
 (( total_cpus-=1 ))
 
 if ( echo ${available_govr} | grep -i "userspace" 2>&1 >/dev/null ) ; then
diff --git a/testcases/kernel/power_management/change_govr.sh b/testcases/kernel/power_management/change_govr.sh
index 4c2546e..bfe6c5b 100755
--- a/testcases/kernel/power_management/change_govr.sh
+++ b/testcases/kernel/power_management/change_govr.sh
@@ -3,7 +3,7 @@
 . pm_include.sh
 available_govr=$(get_supporting_govr)
 
-total_cpus=$(no_of_cpus)
+total_cpus=$(tst_ncpus)
 (( total_cpus-=1 ))
 RC=0
 
diff --git a/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh b/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
index cb51aa0..dcf8a1d 100755
--- a/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
+++ b/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh
@@ -2,7 +2,7 @@
 
 . pm_include.sh
 
-total_cpus=$(no_of_cpus)
+total_cpus=$(tst_ncpus)
 (( total_cpus-=1 ))
 RC=0
 
-- 
1.9.3


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
