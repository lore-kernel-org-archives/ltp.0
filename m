Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YlU1E-0005i8-FF
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:08 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlU1D-0004aw-Cu
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:08 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O39qtO031052
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 11:09:52 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 11:06:06 +0800
Message-ID: <1429844769-7113-5-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1429844769-7113-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1429844769-7113-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 5/8] power_management: delete unused files
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

There are some files that are not used by this
testsuit. Delete them.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/power_management/check_config.sh | 32 -----------------------
 testcases/kernel/power_management/config_cpu_freq |  7 -----
 testcases/kernel/power_management/config_cpu_idle |  3 ---
 testcases/kernel/power_management/config_sched_mc |  1 -
 4 files changed, 43 deletions(-)
 delete mode 100755 testcases/kernel/power_management/check_config.sh
 delete mode 100644 testcases/kernel/power_management/config_cpu_freq
 delete mode 100644 testcases/kernel/power_management/config_cpu_idle
 delete mode 100644 testcases/kernel/power_management/config_sched_mc

diff --git a/testcases/kernel/power_management/check_config.sh b/testcases/kernel/power_management/check_config.sh
deleted file mode 100755
index 4eeac4e..0000000
--- a/testcases/kernel/power_management/check_config.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/bash
-
-. pm_include.sh
-
-if [ $# -lt 1 ] ; then
-	echo "Usage: ${0} <filename>"
-	RC=1
-	return ${RC}
-fi
-filename=${1}
-
-RC=0
-grep_command=grep
-config_file=/boot/config-$(uname -r)
-if [ ! -f ${config_file} ]; then
-	echo "MISSING_FILE: can't find the required config file at /boot/config-$(uname -r)"
-	echo "Trying for alternate file at /proc/config.gz"
-	config_file=/proc/config.gz
-fi
-if [ ! -f ${config_file} ]; then
-	echo "MISSING_FILE: can't find the required config file at /proc/config.gz"
-	RC=1
-fi
-if [ "${config_file}" = "/proc/config.gz" ] ; then
-	grep_command=zgrep
-fi
-
-while read config_option
-do
-	check_config_options "${config_option}=*" ${config_file} ${grep_command}
-done < ${filename}
-exit $RC
diff --git a/testcases/kernel/power_management/config_cpu_freq b/testcases/kernel/power_management/config_cpu_freq
deleted file mode 100644
index 76401e6..0000000
--- a/testcases/kernel/power_management/config_cpu_freq
+++ /dev/null
@@ -1,7 +0,0 @@
-CONFIG_CPU_FREQ
-CONFIG_CPU_FREQ_TABLE
-CONFIG_CPU_FREQ_DEBUG
-CONFIG_CPU_FREQ_STAT
-CONFIG_CPU_FREQ_STAT_DETAILS
-CONFIG_CPU_FREQ_DEFAULT_GOV_*
-CONFIG_CPU_FREQ_GOV_*
diff --git a/testcases/kernel/power_management/config_cpu_idle b/testcases/kernel/power_management/config_cpu_idle
deleted file mode 100644
index f899fae..0000000
--- a/testcases/kernel/power_management/config_cpu_idle
+++ /dev/null
@@ -1,3 +0,0 @@
-CONFIG_CPU_IDLE
-CONFIG_CPU_IDLE_GOV_LADDER
-CONFIG_CPU_IDLE_GOV_MENU
diff --git a/testcases/kernel/power_management/config_sched_mc b/testcases/kernel/power_management/config_sched_mc
deleted file mode 100644
index 30d0f97..0000000
--- a/testcases/kernel/power_management/config_sched_mc
+++ /dev/null
@@ -1 +0,0 @@
-CONFIG_SCHED_MC
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
