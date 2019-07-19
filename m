From: Siliang,Yu <siliangx.yu@intel.com>
Date: Fri, 19 Jul 2019 12:06:55 +0800
Subject: [LTP] [PATCH LTP] - cpuhotplug06.sh:Add judgment for command "top".
Message-ID: <20190719040655.54345-1-siliangx.yu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Yu,Siliang" <siliangx.yu@intel.com>

Only on clear linux OS,"top" is a link file.
If it's clear linux,skip the test.

Signed-off-by: Yu,Siliang <siliangx.yu@intel.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index 18a11197e..d5877d085 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -49,6 +49,10 @@ done
 
 LOOP_COUNT=1
 
+if [[ -L "/usr/bin/top" ]];then
+        tst_brkm TCONF "Invalid argument on Clear Linux Skip the test..."
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
-- 
2.22.0

