From: Gou Hao <gouhao@uniontech.com>
Date: Mon, 28 Jun 2021 09:15:38 +0800
Subject: [LTP] [PATCH] fix cpuhotplug04 check last cpu error
Message-ID: <20210628011538.10060-1-gouhao@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: gouhao <gouhao@uniontech.com>

Cpuhotplug04 uses get_hotplug_cpus when traversing, 
get_hotplug_cpus will filter out cpu without online files, 
and $cpus_num will be used to determine the last cpu num??? 
If some cpu do not have an online file, 
it will lead to an error in the judgment of the last cpu.

Signed-off-by: gouhao <gouhao@uniontech.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
index 72bd98037..64a2b8dc5 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
@@ -57,7 +57,8 @@ if [ $cpus_num -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
 fi
 
-if [ $(get_hotplug_cpus_num) -lt 1 ]; then
+hotplug_cpus_num=$(get_hotplug_cpus_num)
+if [ $hotplug_cpus_num -lt 1 ]; then
 	tst_brkm TCONF "system doesn't have at least one hotpluggable CPU"
 fi
 
@@ -85,7 +86,7 @@ until [ $LOOP_COUNT -gt $HOTPLUG04_LOOPS ]; do
 		# that the kernel will refuse to offline the last CPU.
 		# If only some of the CPUs are hotpluggable,
 		# they all can be offlined.
-		if [ $cpu -eq $cpus_num ]; then
+		if [ $cpu -eq $hotplug_cpus_num ]; then
 			if offline_cpu $i 2> /dev/null; then
 				tst_brkm TFAIL "Have we just offlined the last CPU?"
 			else
-- 
2.20.1



