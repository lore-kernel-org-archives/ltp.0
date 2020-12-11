From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 11 Dec 2020 18:20:47 +0100
Subject: [LTP] [PATCH] containers/netns: update netns shell test to new API
Message-ID: <20201211172047.26640-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 .../kernel/containers/netns/netns_breakns.sh  |  60 ++++-----
 .../kernel/containers/netns/netns_comm.sh     |  95 ++++++--------
 .../kernel/containers/netns/netns_helper.sh   |  69 +++++-----
 .../kernel/containers/netns/netns_sysfs.sh    | 118 +++++++-----------
 4 files changed, 140 insertions(+), 202 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
index c7aa2c34c..69bed757c 100755
--- a/testcases/kernel/containers/netns/netns_breakns.sh
+++ b/testcases/kernel/containers/netns/netns_breakns.sh
@@ -1,21 +1,8 @@
 #!/bin/sh
-#==============================================================================
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2020
 # Copyright (c) 2015 Red Hat, Inc.
 #
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-# Written by Matus Marhefka <mmarhefk@redhat.com>
-#
 #==============================================================================
 #
 # SYNOPSIS:
@@ -42,32 +29,29 @@
 # 2. using ioctl (ifconfig command).
 #==============================================================================
 
-TCID="netns_breakns_$1_$2_$3"
-TST_TOTAL=2
+TST_POS_ARGS=3
+TST_SETUP=do_setup
+TST_TESTFUNC=do_test
 . netns_helper.sh
 
-# SETUP
-netns_setup $1 $2 $3 "192.168.0.2" "192.168.0.3" "fd00::2" "fd00::3"
-tst_resm TINFO "NS interaction: $1 | devices setup: $3"
-
-
-# TEST CASE #1
-$NS_EXEC $NS_HANDLE0 $NS_TYPE ip address add $IP1/$NETMASK dev veth1 2>/dev/null
-if [ $? -ne 0 ]; then
-	tst_resm TPASS "controlling device over netlink"
-else
-	tst_resm TFAIL "controlling device over netlink"
-fi
+PROG=$1
+IP_VER=$2
+COM_TYPE=$3
 
+do_setup()
+{
+	netns_setup $PROG $IP_VER $COM_TYPE "192.168.0.2" "192.168.0.3" "fd00::2" "fd00::3"
+	tst_res TINFO "NS interaction: $PROG | devices setup: $COM_TYPE"
+}
 
-# TEST CASE #2
-tst_require_cmds ifconfig
-$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK 2>/dev/null
-if [ $? -ne 0 ]; then
-	tst_resm TPASS "controlling device over ioctl"
-else
-	tst_resm TFAIL "controlling device over ioctl"
-fi
+do_test()
+{
+	# TEST CASE #1
+	EXPECT_FAIL $NS_EXEC $NS_HANDLE0 $NS_TYPE ip address add $IP1/$NETMASK dev veth1
 
+	# TEST CASE #2
+	tst_require_cmds ifconfig
+	EXPECT_FAIL $NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK
+}
 
-tst_exit
+tst_run
diff --git a/testcases/kernel/containers/netns/netns_comm.sh b/testcases/kernel/containers/netns/netns_comm.sh
index 15991e2a6..77b546bbb 100755
--- a/testcases/kernel/containers/netns/netns_comm.sh
+++ b/testcases/kernel/containers/netns/netns_comm.sh
@@ -1,21 +1,8 @@
 #!/bin/sh
-#==============================================================================
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2020
 # Copyright (c) 2015 Red Hat, Inc.
 #
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-# Written by Matus Marhefka <mmarhefk@redhat.com>
-#
 #==============================================================================
 #
 # SYNOPSIS:
@@ -45,54 +32,46 @@
 #      network namespace
 #==============================================================================
 
-TCID="netns_comm_$1_$2_$3"
-TST_TOTAL=3
+TST_POS_ARGS=3
+TST_SETUP=do_setup
+TST_TESTFUNC=do_test
 . netns_helper.sh
 
-# SETUP
-netns_setup $1 $2 $3 "192.168.0.2" "192.168.0.3" "fd00::2" "fd00::3"
-tst_resm TINFO "NS interaction: $1 | devices setup: $3"
-
-
-# TEST CASE #1
-$NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I veth0 $IP1 1>/dev/null
-if [ $? -eq 0 ]; then
-	tst_resm TPASS "configuration and communication over veth0"
-else
-	tst_resm TFAIL "configuration and communication over veth0"
-fi
+PROG=$1
+IP_VER=$2
+COM_TYPE=$3
 
 
-# TEST CASE #2
-$NS_EXEC $NS_HANDLE1 $NS_TYPE $tping -q -c2 -I veth1 $IP0 1>/dev/null
-if [ $? -eq 0 ]; then
-	tst_resm TPASS "configuration and communication over veth1"
-else
-	tst_resm TFAIL "configuration and communication over veth1"
-fi
+do_setup()
+{
+	netns_setup $PROG $IP_VER $COM_TYPE "192.168.0.2" "192.168.0.3" "fd00::2" "fd00::3"
+	tst_res TINFO "NS interaction: $PROG | devices setup: $COM_TYPE"
+}
 
+do_test()
+{
+	# TEST CASE #1
+	EXPECT_PASS $NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I veth0 $IP1 1>/dev/null
 
-# TEST CASE #3
-case "$2" in
-ipv4) IP_LO="127.0.0.1" ;;
-ipv6) IP_LO="::1" ;;
-esac
-case "$3" in
-netlink)
-	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set dev lo up || \
-		tst_brkm TBROK "enabling lo device failed"
-	;;
-ioctl)
-	$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig lo up || \
-		tst_brkm TBROK "enabling lo device failed"
-	;;
-esac
-$NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I lo $IP_LO 1>/dev/null
-if [ $? -eq 0 ]; then
-	tst_resm TPASS "configuration and communication over localhost"
-else
-	tst_resm TFAIL "configuration and communication over localhost"
-fi
+	# TEST CASE #2
+	EXPECT_PASS $NS_EXEC $NS_HANDLE1 $NS_TYPE $tping -q -c2 -I veth1 $IP0 1>/dev/null
 
+	# TEST CASE #3
+	case "$IP_VER" in
+	ipv4) ip_lo="127.0.0.1" ;;
+	ipv6) ip_lo="::1" ;;
+	esac
+	case "$COM_TYPE" in
+	netlink)
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set dev lo up || \
+			tst_brk TBROK "enabling lo device failed"
+		;;
+	ioctl)
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig lo up || \
+			tst_brk TBROK "enabling lo device failed"
+		;;
+	esac
+	EXPECT_PASS $NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I lo $ip_lo 1>/dev/null
+}
 
-tst_exit
+tst_run
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index c765a0cb9..0201e5e51 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -17,8 +17,10 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #==============================================================================
 
-. test.sh
+. tst_test.sh
 TST_CLEANUP=netns_ns_exec_cleanup
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="ip modprobe"
 
 # Set to 1 only for test cases using ifconfig (ioctl).
 USE_IFCONFIG=0
@@ -60,7 +62,6 @@ NS_HANDLE1=""
 IFCONF_IN6_ARG=""
 ###############################################################################
 
-
 tst_check_iproute()
 {
 	local cur_ipver="$(ip -V)"
@@ -69,11 +70,11 @@ tst_check_iproute()
 	cur_ipver=${cur_ipver##*s}
 
 	if [ -z $cur_ipver ] || [ -z $spe_ipver ]; then
-		tst_brkm TBROK "don't obtain valid iproute version"
+		tst_brk TBROK "don't obtain valid iproute version"
 	fi
 
 	if [ $cur_ipver -lt $spe_ipver ]; then
-		tst_brkm TCONF \
+		tst_brk TCONF \
 			"The commands in iproute tools do not support required objects"
 	fi
 }
@@ -106,11 +107,9 @@ tst_check_iproute()
 #	* IP6_VETH0, IP6_VETH1
 #		IPv6 addresses for veth0 and veth1 devices.
 #
-# On success function returns, on error tst_brkm is called and TC is terminated.
+# On success function returns, on error tst_brk is called and TC is terminated.
 netns_setup()
 {
-	tst_require_root
-	tst_require_cmds ip modprobe
 
 	modprobe veth > /dev/null 2>&1
 
@@ -118,7 +117,7 @@ netns_setup()
 	ns_exec)
 		setns_check
 		if [ $? -eq 32 ]; then
-			tst_brkm TCONF "setns not supported"
+			tst_brk TCONF "setns not supported"
 		fi
 		NS_TYPE="net"
 		netns_ns_exec_setup
@@ -129,7 +128,7 @@ netns_setup()
 		TST_CLEANUP=netns_ip_cleanup
 		;;
 	*)
-		tst_brkm TBROK \
+		tst_brk TBROK \
 		"first argument must be a program used to enter a network namespace (ns_exec|ip)"
 		;;
 	esac
@@ -142,22 +141,22 @@ netns_setup()
 		tst_require_cmds ifconfig
 		;;
 	*)
-		tst_brkm TBROK \
+		tst_brk TBROK \
 		"third argument must be a comm. type between kernel and user space (netlink|ioctl)"
 		;;
 	esac
 
 	if [ -z "$4" ]; then
-		tst_brkm TBROK "fourth argument must be the IPv4 address for veth0"
+		tst_brk TBROK "fourth argument must be the IPv4 address for veth0"
 	fi
 	if [ -z "$5" ]; then
-		tst_brkm TBROK "fifth argument must be the IPv4 address for veth1"
+		tst_brk TBROK "fifth argument must be the IPv4 address for veth1"
 	fi
 	if [ -z "$6" ]; then
-		tst_brkm TBROK "sixth argument must be the IPv6 address for veth0"
+		tst_brk TBROK "sixth argument must be the IPv6 address for veth0"
 	fi
 	if [ -z "$7" ]; then
-		tst_brkm TBROK "seventh argument must be the IPv6 address for veth1"
+		tst_brk TBROK "seventh argument must be the IPv6 address for veth1"
 	fi
 
 	case "$2" in
@@ -176,7 +175,7 @@ netns_setup()
 		NETMASK=64
 		;;
 	*)
-		tst_brkm TBROK "second argument must be an ip version (ipv4|ipv6)"
+		tst_brk TBROK "second argument must be an ip version (ipv4|ipv6)"
 		;;
 	esac
 
@@ -194,18 +193,18 @@ netns_ns_exec_setup()
 
 	NS_HANDLE0=$(ns_create $NS_TYPE)
 	if [ $? -eq 1 ]; then
-		tst_resm TINFO "$NS_HANDLE0"
-		tst_brkm TBROK "unable to create a new network namespace"
+		tst_res TINFO "$NS_HANDLE0"
+		tst_brk TBROK "unable to create a new network namespace"
 	fi
 
 	NS_HANDLE1=$(ns_create $NS_TYPE)
 	if [ $? -eq 1 ]; then
-		tst_resm TINFO "$NS_HANDLE1"
-		tst_brkm TBROK "unable to create a new network namespace"
+		tst_res TINFO "$NS_HANDLE1"
+		tst_brk TBROK "unable to create a new network namespace"
 	fi
 
 	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link add veth0 type veth peer name veth1 || \
-		tst_brkm TBROK "unable to create veth pair devices"
+		tst_brk TBROK "unable to create veth pair devices"
 
 	$NS_EXEC $NS_HANDLE0 $NS_TYPE ns_ifmove veth1 $NS_HANDLE1
 	ret=$?
@@ -214,10 +213,10 @@ netns_ns_exec_setup()
 	fi
 
 	if [ $ret -eq 32 ]; then
-		tst_brkm TCONF "IFLA_NET_NS_PID not supported"
+		tst_brk TCONF "IFLA_NET_NS_PID not supported"
 	fi
 
-	tst_brkm TBROK "unable to add device veth1 to the separate network namespace"
+	tst_brk TBROK "unable to add device veth1 to the separate network namespace"
 }
 
 ##
@@ -236,15 +235,15 @@ netns_ip_setup()
 	ip netns del $NS_HANDLE1 2>/dev/null
 
 	ip netns add $NS_HANDLE0 || \
-		tst_brkm TBROK "unable to create a new network namespace"
+		tst_brk TBROK "unable to create a new network namespace"
 	ip netns add $NS_HANDLE1 || \
-		tst_brkm TBROK "unable to create a new network namespace"
+		tst_brk TBROK "unable to create a new network namespace"
 
 	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1 || \
-		tst_brkm TBROK "unable to create veth pair devices"
+		tst_brk TBROK "unable to create veth pair devices"
 
 	$NS_EXEC $NS_HANDLE0 ip link set veth1 netns $NS_HANDLE1 || \
-		tst_brkm TBROK "unable to add device veth1 to the separate network namespace"
+		tst_brk TBROK "unable to add device veth1 to the separate network namespace"
 }
 
 ##
@@ -253,7 +252,7 @@ netns_ip_setup()
 netns_set_ip()
 {
 	if [ -z "$NS_EXEC" ]; then
-		tst_brkm TBROK "netns_setup() function must be called first"
+		tst_brk TBROK "netns_setup() function must be called first"
 	fi
 
 	# This applies only for ipv6 variant:
@@ -273,23 +272,23 @@ netns_set_ip()
 	case $USE_IFCONFIG in
 	1)
 		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 $IFCONF_IN6_ARG $IP0/$NETMASK ||
-			tst_brkm TBROK "adding address to veth0 failed"
+			tst_brk TBROK "adding address to veth0 failed"
 		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK ||
-			tst_brkm TBROK "adding address to veth1 failed"
+			tst_brk TBROK "adding address to veth1 failed"
 		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 up ||
-			tst_brkm TBROK "enabling veth0 device failed"
+			tst_brk TBROK "enabling veth0 device failed"
 		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 up ||
-			tst_brkm TBROK "enabling veth1 device failed"
+			tst_brk TBROK "enabling veth1 device failed"
 		;;
 	*)
 		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip address add $IP0/$NETMASK dev veth0 ||
-			tst_brkm TBROK "adding address to veth0 failed"
+			tst_brk TBROK "adding address to veth0 failed"
 		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip address add $IP1/$NETMASK dev veth1 ||
-			tst_brkm TBROK "adding address to veth1 failed"
+			tst_brk TBROK "adding address to veth1 failed"
 		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set veth0 up ||
-			tst_brkm TBROK "enabling veth0 device failed"
+			tst_brk TBROK "enabling veth0 device failed"
 		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip link set veth1 up ||
-			tst_brkm TBROK "enabling veth1 device failed"
+			tst_brk TBROK "enabling veth1 device failed"
 		;;
 	esac
 }
diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index 944a4c152..b1660b196 100644
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -1,93 +1,69 @@
 #!/bin/sh
-#==============================================================================
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2020
 # Copyright (c) 2015 Red Hat, Inc.
 #
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of version 2 the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-# Written by Matus Marhefka <mmarhefk@redhat.com>
-#
 #==============================================================================
 #
 # Tests that a separate network namespace cannot affect sysfs contents
 # of the main namespace.
 #==============================================================================
 
-TCID="netns_sysfs"
-TST_TOTAL=3
-NS_TYPE="net,mnt"
-DUMMYDEV_HOST="dummy_test0"
-DUMMYDEV="dummy_test1"
-. test.sh
+TST_NEEDS_DRIVERS="dummy"
+TST_CLEANUP=do_cleanup
+TST_SETUP=do_setup
+TST_TESTFUNC=do_test
+TST_NEEDS_TMPDIR=1
+. tst_test.sh
 
-if tst_kvcmp -lt "2.6.35"; then
-	tst_brkm TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
-fi
-
-setns_check
-if [ $? -eq 32 ]; then
-	tst_brkm TCONF "setns not supported"
-fi
-
-cleanup()
+do_setup()
 {
-	tst_rmdir
-	ip link del $DUMMYDEV_HOST 2>/dev/null
-	ip link del $DUMMYDEV 2>/dev/null
-	kill -9 $NS_HANDLE 2>/dev/null
-}
+	NS_TYPE="net,mnt"
+	DUMMYDEV_HOST="dummy_test0"
+	DUMMYDEV="dummy_test1"
 
-tst_tmpdir
-NS_HANDLE=$(ns_create $NS_TYPE)
-if [ $? -eq 1 ]; then
-	tst_resm TINFO "$NS_HANDLE"
-	tst_brkm TBROK "unable to create a new network namespace"
-fi
-TST_CLEANUP=cleanup
+	if tst_kvcmp -lt "2.6.35"; then
+		tst_brk TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
+	fi
 
-ip link add $DUMMYDEV_HOST type dummy || \
-	tst_brkm TBROK "failed to add a new (host) dummy device"
+	setns_check
+	if [ $? -eq 32 ]; then
+		tst_brk TCONF "setns not supported"
+	fi
 
-ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
-ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
-	tst_brkm TBROK "failed to add a new dummy device"
-ns_exec $NS_HANDLE $NS_TYPE mount -t sysfs none /sys 2>/dev/null
+	NS_HANDLE=$(ns_create $NS_TYPE)
+	if [ $? -eq 1 ]; then
+		tst_res TINFO "$NS_HANDLE"
+		tst_brk TBROK "unable to create a new network namespace"
+	fi
 
+	ip link add $DUMMYDEV_HOST type dummy || \
+		tst_brk TBROK "failed to add a new (host) dummy device"
 
-# TEST CASE #1
-ns_exec $NS_HANDLE $NS_TYPE test -e /sys/class/net/$DUMMYDEV
-if [ $? -eq 0 ]; then
-	tst_resm TPASS "sysfs in new namespace has $DUMMYDEV interface"
-else
-	tst_resm TFAIL "sysfs in new namespace does not have $DUMMYDEV interface"
-fi
+	ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
+	ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
+		tst_brk TBROK "failed to add a new dummy device"
+	ns_exec $NS_HANDLE $NS_TYPE mount -t sysfs none /sys 2>/dev/null
+}
 
+do_cleanup()
+{
+	ip link del $DUMMYDEV_HOST 2>/dev/null
+	ip link del $DUMMYDEV 2>/dev/null
+	kill -9 $NS_HANDLE 2>/dev/null
+}
 
-# TEST CASE #2
-ns_exec $NS_HANDLE $NS_TYPE test -e /sys/class/net/$DUMMYDEV_HOST
-if [ $? -ne 0 ]; then
-	tst_resm TPASS "sysfs in new namespace does not have $DUMMYDEV_HOST interface"
-else
-	tst_resm TFAIL "sysfs in new namespace contains $DUMMYDEV_HOST interface"
-fi
 
+do_test()
+{
+	# TEST CASE #1
+	EXPECT_PASS ns_exec $NS_HANDLE $NS_TYPE test -e /sys/class/net/$DUMMYDEV
 
-# TEST CASE #3
-test -e /sys/class/net/$DUMMYDEV
-if [ $? -ne 0 ]; then
-	tst_resm TPASS "sysfs not affected by a separate namespace"
-else
-	tst_resm TFAIL "sysfs affected by a separate namespace"
-fi
+	# TEST CASE #2
+	EXPECT_FAIL ns_exec $NS_HANDLE $NS_TYPE test -e /sys/class/net/$DUMMYDEV_HOST
 
+	# TEST CASE #3
+	EXPECT_FAIL test -e /sys/class/net/$DUMMYDEV
+}
 
-tst_exit
+tst_run
-- 
2.17.1

