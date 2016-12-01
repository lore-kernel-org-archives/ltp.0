From: Han, NingX <ningx.han@intel.com>
Date: Thu, 1 Dec 2016 06:57:01 +0000
Subject: [LTP] [PATCH ltp] cpuhotplug_hotplug.sh: 'part' here is a variable
Message-ID: <AAAF599D7BFC7245B4AE22D9263FF7FB36C977B4@shsmsx102.ccr.corp.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Here 'part' is not a command or a function, just a variable, should not  add ()

Signed-off-by: Ning Han <ningx.han@intel.com<mailto:ningx.han@intel.com>>
---
testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index 91d2a19..9f856e5 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -150,8 +150,8 @@ get_present_cpus()
             range_low=$(echo $part | cut -d - -f 1)
             range_high=$(echo $part | cut -d - -f 2)
         else
-            range_low=$(part)
-            range_high=$(part)
+            range_low=$part
+            range_high=$part
         fi
         for cpu in $(seq $range_low $range_high); do
             if [ -e /sys/devices/system/cpu/cpu$cpu ]; then
--
2.7.4

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161201/177382be/attachment-0001.html>
