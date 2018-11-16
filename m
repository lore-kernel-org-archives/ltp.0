From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 16 Nov 2018 19:10:55 +0800
Subject: [LTP] [PATCH] cpu_hotplug/cpuhotplug03.sh: Accurately select
	command name by -C option
Message-ID: <1542366655-3891-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since procps v3.3.15, running cpuhotplug03.sh got the following error:
----------------------------------------------------------------------
cpuhotplug03 1 TINFO: Onlining CPU 1
cpuhotplug03 1 TBROK: No cpuhotplug_do_spin_loop processes found on any processor
----------------------------------------------------------------------

On procps v3.3.15, ps command name selection is extended to 64 characters
so procps cannot trucate normal command name to 15 characters by default.
In addition, normal command name is truncated to 16 characters and stored
in /proc/<pid>/stat and /proc/<pid>/status in kernel.(except workqueue worker
because it has been extended to 64 by kernel commit 6b59808)

References:
procps commit: bb272580a6f3c192c61e307f9e341514d892d06e
procps commit: 14005a371e5c14289e96a4927ffd1a827d3c9d85
procps commit: 2cfdbbe897f0d4e41460c7c2b92acfc5804652c8
kernel commit: 6b59808bfe482642287ddf3fe9d4cccb10756652

Note:
I think the lastest ps(1) manpage for command name length is confused
because kernel only extend workqueue worker name to 64 characters by
commit 6b59808 and still truncate normal command name to 16 characters.
e.g:
---------------------------------------------------------------------
cd /root/ltp/testcases/kernel/hotplug/cpu_hotplug/tools
PATH=$PATH:$PWD cpuhotplug_do_spin_loop &
[1] 8732
cat /proc/8732/stat
8732 (cpuhotplug_do_s) ...
cat /proc/8732/status | grep Name
Name:   cpuhotplug_do_s
---------------------------------------------------------------------

I will try to update ps(1) manpage for command name length.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh    | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
index 14ccf85..a8c76a0 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
@@ -119,12 +119,20 @@ until [ $LOOP_COUNT -gt $HOTPLUG03_LOOPS ]; do
 	sleep 1
 
 	# Verify at least one process has migrated to the new CPU
-	ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop
+	# Since procps v3.3.15, we need to accurately select command name
+	# by -C option, because procps cannot trucate normal command name
+	# to 15 characters by default).
+	# References:
+	# procps commit: bb272580a6f3c192c61e307f9e341514d892d06e
+	# procps commit: 14005a371e5c14289e96a4927ffd1a827d3c9d85
+	# procps commit: 2cfdbbe897f0d4e41460c7c2b92acfc5804652c8
+	# kernel commit: 6b59808bfe482642287ddf3fe9d4cccb10756652
+	ps -o psr -o command --no-headers -C cpuhotplug_do_s
 	if [ $? -ne 0 ]; then
 		tst_brkm TBROK "No cpuhotplug_do_spin_loop processes \
 			found on any processor"
 	fi
-	NUM=`ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop \
+	NUM=`ps -o psr -o command --no-headers -C cpuhotplug_do_s \
 		| sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" \
 		| wc -l`
 	if [ $NUM -lt 1 ]; then
-- 
1.8.3.1



