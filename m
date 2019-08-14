From: SiliangYu <siliangx.yu@intel.com>
Date: Wed, 14 Aug 2019 09:15:45 +0000
Subject: [LTP] [PATCH v3 LTP] Skip the test if "htop" is used.
Message-ID: <20190814091545.147098-1-siliangx.yu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Yu,Siliang" <siliangx.yu@intel.com>

In clear linux os, "htop" is used instead "top", which doesn't support '-b'. Skip the test on clear linux.

Signed-off-by: Yu,Siliang <siliangx.yu@intel.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index 18a11197e..da7a4df73 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -49,6 +49,10 @@ done
 
 LOOP_COUNT=1
 
+if top -v | grep -q htop; then
+	tst_brkm TCONF "htop is used instead of top, Skip the test..."
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
-- 
2.22.0

