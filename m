From: SiliangYu <siliangx.yu@intel.com>
Date: Tue, 10 Sep 2019 16:23:37 +0000
Subject: [LTP] [PATCH v4 LTP] Skip the test if "htop" is used.
Message-ID: <20190910162337.60664-1-siliangx.yu@intel.com>
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
index 18a11197e..74a3dd2b1 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -49,6 +49,10 @@ done
 
 LOOP_COUNT=1
 
+if top -v | grep -q htop; then
+	tst_brkm TCONF "htop is used instead of top, Skip the test(workaround: alias top='/path/to/real/top')"
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
-- 
2.23.0

