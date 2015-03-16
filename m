Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YXR1p-0000CX-Q5
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:41 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXR1n-0001ZW-Sv
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:41 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2G98YaA000901
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Mar 2015 17:08:35 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 16 Mar 2015 17:05:02 +0800
Message-ID: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v4 1/9] kernel/power_management: fix no_of_cpus error
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
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
