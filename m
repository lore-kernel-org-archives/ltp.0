From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 2 Nov 2017 17:34:57 +0800
Subject: [LTP] [PATCH] commands/unshare: Add new testcase to test unshare(1)
Message-ID: <1509615297-2798-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test unshare(1) command with some basic options.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/commands                        |   1 +
 testcases/commands/unshare/Makefile     |  22 +++++
 testcases/commands/unshare/unshare01.sh | 150 ++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 testcases/commands/unshare/Makefile
 create mode 100755 testcases/commands/unshare/unshare01.sh

diff --git a/runtest/commands b/runtest/commands
index 00ae0d2..92df3af 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -43,3 +43,4 @@ insmod01 insmod01.sh
 wc01 wc01.sh
 keyctl01 keyctl01.sh
 gdb01 gdb01.sh
+unshare01 unshare01.sh
diff --git a/testcases/commands/unshare/Makefile b/testcases/commands/unshare/Makefile
new file mode 100644
index 0000000..a175291
--- /dev/null
+++ b/testcases/commands/unshare/Makefile
@@ -0,0 +1,22 @@
+#
+# Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= unshare01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/unshare/unshare01.sh b/testcases/commands/unshare/unshare01.sh
new file mode 100755
index 0000000..ba379df
--- /dev/null
+++ b/testcases/commands/unshare/unshare01.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+# the GNU General Public License for more details.
+#
+# Test unshare command with some basic options.
+# 1) If we run unshare with "--user", UID in the newly created user namespace
+#    is set to 65534.
+# 2) If we run unshare with "--user", GID in the newly created user namespace
+#    is set to 65534.
+# 3) If we run with "--user --map-root-user", UID in the newly created user
+#    namespace is set to 0.
+# 4) If we run with "--user --map-root-user", GID in the newly created user
+#    is set to 0.
+# 5) If we run with "--mount", mount and unmount events do not propagate to
+#    its parent mount namespace.
+# 6) If we run with "--mount --propagation shared", mount and unmount events
+#    propagate to its parent mount namespace.
+# 7) If we run with "--user --map-root-user --mount", mount and unmount events
+#    do not propagate to its parent mount namespace.
+# 8) Even if we run with "--user --map-root-user --mount --propagation shared",
+#    mount and unmount events do not propagate to its parent mount namespace
+#    because the shared mount is reduced to a slave mount.
+#
+#    Please see the following URL for detailed information:
+#    http://man7.org/linux/man-pages/man7/user_namespaces.7.html
+#    http://man7.org/linux/man-pages/man7/mount_namespaces.7.html
+#
+
+TST_CNT=8
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_TESTFUNC=do_test
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="unshare id mount umount"
+. tst_test.sh
+
+max_userns_path="/proc/sys/user/max_user_namespaces"
+max_mntns_path="/proc/sys/user/max_mnt_namespaces"
+max_userns_zero=0
+max_mntns_zero=0
+
+setup()
+{
+	# On some distributions(e.g RHEL7.4), the default value of
+	# max_user_namespaces or max_mnt_namespaces is set to 0.
+	# We need to change the default value to run unshare command.
+	if [ -f "${max_userns_path}" ]; then
+		if [ $(cat "${max_userns_path}") -eq 0 ]; then
+			echo 1024 > "${max_userns_path}"
+			max_userns_zero=1
+		fi
+	fi
+
+	if [ -f "${max_mntns_path}" ]; then
+		if [ $(cat "${max_mntns_path}") -eq 0 ]; then
+			echo 1024 > "${max_mntns_path}"
+			max_mntns_zero=1
+		fi
+	fi
+
+	mkdir -p test_A test_B
+	touch test_A/A test_B/B
+}
+
+cleanup()
+{
+	# Restore the default value to 0.
+	[ ${max_userns_zero} -eq 1 ] && echo 0 > "${max_userns_path}"
+	[ ${max_mntns_zero} -eq 1 ] && echo 0 > "${max_mntns_zero}"
+}
+
+unshare_test()
+{
+	local unshare_opts=$1
+	local verify_cmd=$2
+	local exp_result=$3
+
+	local unshare_cmd="unshare ${unshare_opts} ${verify_cmd}"
+
+	eval ${unshare_cmd} > temp 2>&1
+	if [ $? -ne 0 ]; then
+		# unrecognized option or invalid option is returned if the
+		# option is not supported by unshare command(e.g. RHEL6).
+		# Invalid argument or Operation not permitted is returned
+		# if the feature is not supported by kernel(e.g. RHEL7).
+		grep -q -E "unrecognized option|invalid option|Invalid argument|Operation not permitted" temp
+		if [ $? -eq 0 ]; then
+			tst_res TCONF "${unshare_cmd} not supported."
+		else
+			tst_res TFAIL "${unshare_cmd} failed."
+		fi
+		return
+	fi
+
+	if [[ "${verify_cmd}" =~ 'id' ]]; then
+		if [ $(cat temp) -ne ${exp_result} ]; then
+			tst_res TFAIL "${unshare_cmd} got wrong uid/gid"
+			return
+		fi
+	fi
+
+	if [[ "${verify_cmd}" =~ 'mount' ]]; then
+		if [ "${exp_result}" = "unmounted" ]; then
+			if ls test_B | grep -q 'A'; then
+				tst_res TFAIL "${unshare_cmd} got bind info"
+				umount test_B
+				return
+			fi
+		else
+			if ! ls test_B | grep -q 'A'; then
+				tst_res TFAIL "${unshare_cmd} did not get bind info"
+				return
+			fi
+			umount test_B
+		fi
+	fi
+
+	tst_res TPASS "${unshare_cmd} succeeded as expected"
+}
+
+do_test()
+{
+	case $1 in
+	1) unshare_test "--user" "id -u" "65534";;
+	2) unshare_test "--user" "id -g" "65534";;
+	3) unshare_test "--user --map-root-user" "id -u" "0";;
+	4) unshare_test "--user --map-root-user" "id -g" "0";;
+	5) unshare_test "--mount" "mount --bind test_A test_B" "unmounted";;
+	6) unshare_test "--mount --propagation shared" \
+			"mount --bind test_A test_B" "mounted";;
+	7) unshare_test "--user --map-root-user --mount" \
+			"mount --bind test_A test_B" "unmounted";;
+	8) unshare_test "--user --map-root-user --mount --propagation shared" \
+			"mount --bind test_A test_B" "unmounted";;
+	esac
+}
+
+tst_run
-- 
1.8.3.1



