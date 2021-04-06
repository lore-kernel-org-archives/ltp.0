From: Zou Wei <zou_wei@huawei.com>
Date: Tue, 6 Apr 2021 17:27:29 +0800
Subject: [LTP] [PATCH] cpuset_hotplug_test/cpuset_hotplug: Fix bug for
 obtaining task_cpus value in root_cpu_hotplug_test
Message-ID: <1617701249-62196-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

--------------------------

1. The method of obtaining $task_cpus from root_cpu_hotplug_test is
incorrect, because the value of Cpus_allowed_list is related 
to /sys/devices/system/cpu/possible and 
/sys/devices/system/cpu/isolated.

2. If isolcpus is configured in cmdline, the value of
Cpus_allowed_list is equal to /sys/devices/system/cpu/possible minus
/sys/devices/system/cpu/isolated. In this case, $task_cpus is inconsistent
with $expect_task_cpus, test will be failed.

3. Need to change the method of obtaining $task_cpu
from /sys/devices/system/cpu/present.

4. The description of cpu_present_mask:
   Bitmap of CPUs currently present in the system. 
   Not all of them may be online. When physical hotplug is processed
   by the relevant subsystem (e.g ACPI) can change and new bit either be
   added or removed from the map depending on the event is
   hot-add/hot-remove. There are currently no locking rules as of now.
   Typical usage is to init topology during boot,
   at which time hotplug is disabled.

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 .../controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh      | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index 155e536..2c6993a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -93,8 +93,7 @@ root_cpu_hotplug_test()
 
 	root_cpus="`cat $CPUSET/cpuset.cpus`"
 
-	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
-	task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
+	task_cpus="`cat /sys/devices/system/cpu/present`"
 
 	check_result "$root_cpus" "$expect_cpus"
 	ret=$?
-- 
2.6.2

