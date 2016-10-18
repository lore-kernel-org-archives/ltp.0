From: James Morse <james.morse@arm.com>
Date: Tue, 18 Oct 2016 12:09:36 +0100
Subject: [LTP] [PATCH] cpuhotplug_hotplug.sh: dash's 'local' only accepts
	the first token
Message-ID: <1476788976-24585-1-git-send-email-james.morse@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

dash's 'local' only accepts the first token, the line:
> local present_cpus=$(get_present_cpus)

causes a world of problems on systems where /bin/sh is dash:
> root@juno-r1:~# /bin/sh
> # get_hotplug_cpus
> /bin/sh: 1: get_hotplug_cpus: not found
> # . /opt/ltp/testcases/bin/cpuhotplug_hotplug.sh
> # get_hotplug_cpus
> cpu0

when compared with bash:
> root@juno-r1:~# get_hotplug_cpus
> get_hotplug_cpus: command not found
> root@juno-r1:~# . /opt/ltp/testcases/bin/cpuhotplug_hotplug.sh
> root@juno-r1:~# get_hotplug_cpus
> cpu0 cpu1 cpu2 cpu3 cpu4 cpu5

This causes the cpuhotplug tests to behave really strangely....

Quoting the assignment fixes the issue:
root@juno-r1:~# /bin/sh
> # get_hotplug_cpus
> /bin/sh: 1: get_hotplug_cpus: not found
> # . /opt/ltp/testcases/bin/cpuhotplug_hotplug.sh
> # get_hotplug_cpus
> cpu0 cpu1 cpu2 cpu3 cpu4 cpu5

Signed-off-by: James Morse <james.morse@arm.com>
---
 testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
index 3967937..9165d3c 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
@@ -214,7 +214,7 @@ get_present_cpus_num()
 #
 get_hotplug_cpus()
 {
-    local present_cpus=$(get_present_cpus)
+    local present_cpus="$(get_present_cpus)"
     local hotplug_cpus=""
 
     for cpu in $present_cpus; do
-- 
2.8.0.rc3

