From: Siliang,Yu <siliangx.yu@intel.com>
Date: Thu, 25 Jul 2019 07:45:02 +0800
Subject: [LTP] [PATCH LTP] -Cpuhotplug06:Skip the test if "htop" is used.
Message-ID: <20190724234502.105332-1-siliangx.yu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Yu,Siliang" <siliangx.yu@intel.com>

In some distro, "htop" is used instead "top", which doesn't support '-b'. Skip the test if "htop" is used.
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
index 18a11197e..ecf4eedea 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
@@ -49,6 +49,11 @@ done
 
 LOOP_COUNT=1
 
+LNTOP=$(ls -l $(which top) | cut -s -d ">" -f2)
+if [[ -n $LNTOP ]] && [[ $LNTOP != "top" ]] ; then
+	tst_brkm TCONF "Command doesn't support , Skip the test..."
+fi
+
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
-- 
2.22.0

