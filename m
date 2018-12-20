From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 20 Dec 2018 18:21:48 +0000
Subject: [LTP] [PATCH v2 3/4]  cgroup_regression_test.sh: added helper
In-Reply-To: <20181220182149.48326-1-cristian.marussi@arm.com>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
Message-ID: <20181220182149.48326-4-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A common function 'get_cgroup_mountpoint' is added to help
parse /proc/mounts in search of specific cgroup subsystems
mountpoints. It is added as part of a common cgroup_lib.sh.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../cgroup/cgroup_regression_test.sh          | 17 +++++++---
 testcases/kernel/controllers/cgroup_lib.sh    | 33 +++++++++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/controllers/cgroup_lib.sh

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 4e702f2f9..a66ed71e1 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -30,6 +30,7 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="dmesg mountpoint mount umount cat kill find mkdir rmdir grep"
 
 . tst_test.sh
+. cgroup_lib.sh
 
 do_setup()
 {
@@ -190,7 +191,7 @@ test_3()
 	fi
 
 	if grep -q -w "cpu" /proc/cgroups ; then
-		cpu_subsys_path=$(grep -w cpu /proc/mounts | awk '{ print $2 }')
+		cpu_subsys_path=$(get_cgroup_mountpoint "cpu")
 	else
 		tst_res TCONF "CONFIG_CGROUP_SCHED is not enabled"
 		return
@@ -292,8 +293,8 @@ test_5()
 	# $failing params to be used in the following expected-to-fail
 	# mount action. Note that the subsysN name itself will be listed
 	# amongst mounts options.
-	cat /proc/mounts | grep cgroup | grep -q $subsys1 && mounted=$subsys1
-	[ -z "$mounted" ] && cat /proc/mounts | grep cgroup | grep -q $subsys2 && mounted=$subsys2
+	get_cgroup_mountpoint $subsys1 >/dev/null && mounted=$subsys1
+	[ -z "$mounted" ] && get_cgroup_mountpoint $subsys2 >/dev/null && mounted=$subsys2
 	if [ -z "$mounted" ]; then
 		mntpoint=cgroup
 		failing=$subsys1
@@ -306,7 +307,7 @@ test_5()
 		# Use the pre-esistent mountpoint as $mntpoint and use a
 		# co-mount with $failing: this way the 2nd mount will
 		# also fail (as expected) in this 'mirrored' configuration.
-		mntpoint=$(cat /proc/mounts | grep cgroup | grep $mounted | awk '{ print $2 }')
+		mntpoint=$(get_cgroup_mountpoint $mounted)
 		failing=$subsys1,$subsys2
 	fi
 
@@ -390,7 +391,13 @@ test_6()
 test_7_1()
 {
 	local subsys=$1
-	local subsys_path=$(grep -w $subsys /proc/mounts | cut -d ' ' -f 2)
+	# we should be careful to select a $subsys_path which is related to
+	# cgroup only: if cgroup debugging is enabled a 'debug' $subsys
+	# could be passed here as params and this will lead to ambiguity and
+	# errors when grepping simply for 'debug' in /proc/mounts since we'll
+	# find also /sys/kernel/debug. Helper takes care of this.
+	local subsys_path=$(get_cgroup_mountpoint $subsys)
+
 	if [ -z "$subsys_path" ]; then
 		mount -t cgroup -o $subsys xxx cgroup/
 		if [ $? -ne 0 ]; then
diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
new file mode 100644
index 000000000..5cdf55363
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+
+#
+# Helper to parse /proc/mounts to find the mountpoints (if any)
+# associated with the cgroup subsystem passed as param.
+#
+# It expects as single argument the cgroup subsytem for
+# which to search in /proc/mounts the mountpoint (if any).
+#
+# - returns true|false depending if any mountpoint has been found.
+# - echos back the mountpoint itself if any found
+#
+get_cgroup_mountpoint()
+{
+	local mntpoint
+	local line
+	local ret=1
+	local subsystem=$1
+
+	# fail straight away with no args
+	[ $# -eq 0 ] && return $ret
+
+	line=$(grep cgroup /proc/mounts | grep -w $subsystem)
+	ret=$?
+	# extract mountpoint if any exist
+	[ $ret = 0 ] && mntpoint=$(echo $line | awk '{ print $2 }') && echo $mntpoint
+
+	return $ret
+}
+
-- 
2.17.1

