From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Sep 2017 18:52:54 +0200
Subject: [LTP] [PATCH v3 1/1] network/stress: Fix and cleanup part of
	multicast group tests
Message-ID: <20170925165254.20595-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Fix test for SSH and netns based testing.
* Remove hardcoded rsh dependency.
* Create shell library mcast-lib.sh (multicast specific) to reduce
  duplicity in tests. Library uses test_stress_net.sh (and therefore
  test_net.sh).
* Merged IPv4 and IPv6 group tests into one file.
* Renamed test names and files (readability).
* Cleanup code + fixed typos.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* Remove *_BASE variables and use -f argument for pkill.
Although I consider -x argument slightly safer, it shouldn't do any harm
here, so I adjusted it according your suggestions.
---
 runtest/net_stress.multicast                       |  16 +-
 .../multicast/grp-operation/00_Descriptions.txt    |  16 +-
 .../grp-operation/mcast-group-multiple-socket      |  39 ++++
 .../multicast/grp-operation/mcast-group-same-group |  28 +++
 .../grp-operation/mcast-group-single-socket        |  28 +++
 .../grp-operation/mcast-group-source-filter        |  28 +++
 .../stress/multicast/grp-operation/mcast-lib.sh    | 154 ++++++++++++++
 .../stress/multicast/grp-operation/mcast4-grpope01 | 211 -------------------
 .../stress/multicast/grp-operation/mcast4-grpope02 | 220 --------------------
 .../stress/multicast/grp-operation/mcast4-grpope03 | 207 -------------------
 .../stress/multicast/grp-operation/mcast4-grpope04 | 226 ---------------------
 .../stress/multicast/grp-operation/mcast6-grpope01 | 208 -------------------
 .../stress/multicast/grp-operation/mcast6-grpope02 | 217 --------------------
 .../stress/multicast/grp-operation/mcast6-grpope03 | 204 -------------------
 .../stress/multicast/grp-operation/mcast6-grpope04 | 222 --------------------
 .../network/stress/ns-tools/test_net_stress.sh     |   9 +-
 16 files changed, 298 insertions(+), 1735 deletions(-)
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-same-group
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast-lib.sh
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope01
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope02
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope03
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-grpope04
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope01
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope02
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope03
 delete mode 100644 testcases/network/stress/multicast/grp-operation/mcast6-grpope04

diff --git a/runtest/net_stress.multicast b/runtest/net_stress.multicast
index 445b08fe8..d2288df62 100644
--- a/runtest/net_stress.multicast
+++ b/runtest/net_stress.multicast
@@ -2,10 +2,10 @@
 # Stress test for TCP/IP protocol stack (Multicast)
 #
 
-mcast4-grpope01 mcast4-grpope01
-mcast4-grpope02 mcast4-grpope02
-mcast4-grpope03 mcast4-grpope03
-mcast4-grpope04 mcast4-grpope04
+mcast4-group-single-socket mcast-group-single-socket
+mcast4-group-multiple-socket mcast-group-multiple-socket
+mcast4-group-same-group mcast-group-same-group
+mcast4-group-source-filter mcast-group-source-filter
 mcast4-pktfld01 mcast4-pktfld01
 mcast4-pktfld02 mcast4-pktfld02
 mcast4-queryfld01 mcast4-queryfld01
@@ -15,10 +15,10 @@ mcast4-queryfld04 mcast4-queryfld04
 mcast4-queryfld05 mcast4-queryfld05
 mcast4-queryfld06 mcast4-queryfld06
 
-mcast6-grpope01 mcast6-grpope01
-mcast6-grpope02 mcast6-grpope02
-mcast6-grpope03 mcast6-grpope03
-mcast6-grpope04 mcast6-grpope04
+mcast6-group-single-socket mcast-group-single-socket -6
+mcast6-group-multiple-socket mcast-group-multiple-socket -6
+mcast6-group-same-group mcast-group-same-group -6
+mcast6-group-source-filter mcast-group-source-filter -6
 mcast6-pktfld01 mcast6-pktfld01
 mcast6-pktfld02 mcast6-pktfld02
 mcast6-queryfld01 mcast6-queryfld01
diff --git a/testcases/network/stress/multicast/grp-operation/00_Descriptions.txt b/testcases/network/stress/multicast/grp-operation/00_Descriptions.txt
index 9d73372c4..22177fda3 100644
--- a/testcases/network/stress/multicast/grp-operation/00_Descriptions.txt
+++ b/testcases/network/stress/multicast/grp-operation/00_Descriptions.txt
@@ -1,33 +1,33 @@
-mcast4-grpope01
+mcast4-group-single-socket
 	Verify that the kernel is not crashed when joining lots of IPv4
 	multicast groups on a single socket
 
-mcast4-grpope02
+mcast4-group-multiple-socket
 	Verify that the kernel is not crashed when joining lots of IPv4
 	multicast groups on lots of sockets
 
-mcast4-grpope03
+mcast4-group-same-group
 	Verify that the kernel is not crashed when joining and leaving the same
 	IPv4 multicast group on multiple sockets lots of times
 
-mcast4-grpope04
+mcast4-group-source-filter
 	Verify that the kernel is not crashed when joining and leaving the same
 	IPv4 multicast group with the different source filter on multiple
 	sockets lots of times
 
-mcast6-grpope01
+mcast6-group-single-socket
 	Verify that the kernel is not crashed when joining lots of IPv6
 	multicast groups on a single socket
 
-mcast6-grpope02
+mcast6-group-multiple-socket
 	Verify that the kernel is not crashed when joining lots of IPv6
 	multicast groups on lots of sockets
 
-mcast6-grpope03
+mcast6-group-same-group
 	Verify that the kernel is not crashed when joining and leaving the same
 	IPv6 multicast group on multiple sockets lots of times
 
-mcast6-grpope04
+mcast6-group-source-filter
 	Verify that the kernel is not crashed when joining and leaving the same
 	IPv6 multicast group with the different source filter on multiple
 	sockets lots of times
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
new file mode 100644
index 000000000..84700a5d8
--- /dev/null
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket
@@ -0,0 +1,39 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Setup: testcases/network/stress/README
+#
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+. mcast-lib.sh
+
+tst_resm TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on multiple sockets"
+
+do_setup()
+{
+	# Increase the maximum number of open file descriptors
+	if [ $(ulimit -n) -lt $MCASTNUM_HEAVY ]; then
+		ulimit -n $MCASTNUM_HEAVY || tst_brkm TCONF \
+			"Failed to set the maximum number of open file descriptors to $MCASTNUM_HEAVY"
+	fi
+
+	mcast_setup $MCASTNUM_HEAVY
+}
+
+do_setup
+do_multicast_test_multiple_join $MCASTNUM_HEAVY true
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
new file mode 100644
index 000000000..876c395bb
--- /dev/null
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group
@@ -0,0 +1,28 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Setup: testcases/network/stress/README
+#
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+. mcast-lib.sh
+
+tst_resm TINFO "joining and leaving the same IPv$ipver multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+
+mcast_setup $MCASTNUM_NORMAL
+do_multicast_test_join_leave $MCASTNUM_NORMAL
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
new file mode 100644
index 000000000..d6b3363db
--- /dev/null
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket
@@ -0,0 +1,28 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Setup: testcases/network/stress/README
+#
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+. mcast-lib.sh
+
+tst_resm TINFO "joining $MCASTNUM_HEAVY IPv$ipver multicast groups on a single socket"
+
+mcast_setup $MCASTNUM_HEAVY
+do_multicast_test_multiple_join $MCASTNUM_HEAVY
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
new file mode 100644
index 000000000..34ed143af
--- /dev/null
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter
@@ -0,0 +1,28 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Setup: testcases/network/stress/README
+#
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+. mcast-lib.sh
+
+tst_resm TINFO "joining and leaving the same IPv$ipver multicast group with a different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
+
+mcast_setup $MCASTNUM_NORMAL
+do_multicast_test_join_leave $MCASTNUM_NORMAL true
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
new file mode 100644
index 000000000..6cc2922f2
--- /dev/null
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Petr Vorel <pvorel@suse.cz>
+#
+# Setup script for multicast stress tests.
+
+TST_TOTAL=1
+TST_CLEANUP="mcast_cleanup"
+
+. test_net_stress.sh
+
+MCAST_LCMD="ns-mcast_join -f $ipver -I $(tst_iface)"
+
+MCAST_RCMD="ns-igmp_querier"
+[ "$TST_IPV6" ] && MCAST_RCMD="ns-icmpv6_sender"
+MCAST_RCMD="$MCAST_RCMD -I $(tst_iface rhost)"
+
+mcast_setup4()
+{
+	local igmp_max_memberships="$1"
+
+	SYSFS_IGMP_MAX_MEMBERSHIPS=$(sysctl -b net.ipv4.igmp_max_memberships)
+	SYSFS_IGMP_MAX_MSF=$(sysctl -b net.ipv4.igmp_max_msf)
+	SYSFS_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.$(tst_iface).force_igmp_version)
+	SYSFS_ALL_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.all.force_igmp_version)
+
+	[ "$igmp_max_memberships" -gt 5459 ] && tst_resm TWARN \
+		"\$1 shouldn't be set higher than 5459 as it's used to set /proc/sys/net/ipv4/igmp_max_memberships"
+
+	ROD sysctl -qw net.ipv4.igmp_max_memberships=$igmp_max_memberships
+	ROD sysctl -qw net.ipv4.igmp_max_msf=10
+	ROD sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=0
+	ROD sysctl -qw net.ipv4.conf.all.force_igmp_version=0
+}
+
+mcast_setup6()
+{
+	local default_mld_max_msf=64
+	tst_kvcmp -lt '2.6.15' && default_mld_max_msf=10
+
+	SYSCTL_ALL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.all.force_mld_version)
+	SYSCTL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.$(tst_iface).force_mld_version)
+	SYSCTL_MLD_MAX_MSF=$(sysctl -b net.ipv6.mld_max_msf)
+
+	ROD sysctl -qw net.ipv6.conf.all.force_mld_version=0
+	ROD sysctl -qw net.ipv6.conf.$(tst_iface).force_mld_version=0
+	ROD sysctl -qw net.ipv6.mld_max_msf=$default_mld_max_msf
+}
+
+mcast_setup()
+{
+	local max="$1"
+
+	netstress_setup
+	tst_tmpdir
+
+	[ "$TST_IPV6" ] && mcast_setup6 || mcast_setup4 $max
+}
+
+mcast_cleanup4()
+{
+	[ -n "$SYSFS_IGMP_MAX_MEMBERSHIPS" ] && sysctl -qw net.ipv4.igmp_max_memberships=$SYSFS_IGMP_MAX_MEMBERSHIPS
+	[ -n "$SYSFS_IGMP_MAX_MSF" ] && sysctl -qw net.ipv4.igmp_max_msf=$SYSFS_IGMP_MAX_MSF
+	[ -n "$SYSFS_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=$SYSFS_FORCE_IGMP_VERSION
+	[ -n "$SYSFS_ALL_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.all.force_igmp_version=$SYSFS_ALL_FORCE_IGMP_VERSION
+}
+
+mcast_cleanup6()
+{
+	[ -n "$SYSCTL_ALL_FORCE_MLD_VERSION" ] && sysctl -qw net.ipv6.conf.all.force_mld_version=$SYSCTL_ALL_FORCE_MLD_VERSION
+	[ -n "$SYSCTL_FORCE_MLD_VERSION" ] && sysctl -qw net.ipv6.conf.$(tst_iface).force_mld_version=$SYSCTL_FORCE_MLD_VERSION
+	[ -n "$SYSCTL_MLD_MAX_MSF" ] && sysctl -qw net.ipv6.mld_max_msf=$SYSCTL_MLD_MAX_MSF
+}
+
+mcast_cleanup()
+{
+	[ "$TST_IPV6" ] && mcast_cleanup6 || mcast_cleanup4
+
+	pkill -SIGHUP -f "$MCAST_LCMD"
+	tst_sleep 10ms
+	pkill -9 -f "$MCAST_LCMD"
+
+	tst_rhost_run -c "pkill -SIGHUP -f '$MCAST_RCMD'"
+}
+
+do_multicast_test_multiple_join()
+{
+	local num="$1"
+	local mprefix="$MCAST_IPV4_ADDR_PREFIX"
+	local param_multi_socket ret tmpfile
+
+	[ "${2:-}" = true ] && param_multi_socket="-m"
+	[ "$TST_IPV6" ] && mprefix="$MCAST_IPV6_ADDR_PREFIX"
+
+	# Run a multicast join tool
+	tmpfile=$$
+	EXPECT_PASS $MCAST_LCMD $param_multi_socket -n $num -p $mprefix \> $tmpfile
+	tst_resm TINFO "joined $(grep groups $tmpfile)"
+
+	# Send MLD / IGMP General Query from the remote host
+	if [ "$TST_IPV6" ]; then
+		EXPECT_RHOST_PASS $MCAST_RCMD -S $(tst_ipaddr) -m -o
+	else
+		EXPECT_RHOST_PASS $MCAST_RCMD -o -r 1 -m $MCAST_IPV4_ADDR
+	fi
+}
+
+do_multicast_test_join_leave()
+{
+	local cnt define_src_addr filter params ret
+	local max="$1"
+	local maddr="$MCAST_IPV4_ADDR"
+	[ "$TST_IPV6" ] && maddr="$MCAST_IPV6_ADDR"
+
+	[ "$2" = true ] && define_src_addr=true
+
+	# Send MLD / IGMP General Query from the remote host
+	if [ "$TST_IPV6" ]; then
+		tst_rhost_run -s -c "$MCAST_RCMD -S $(tst_ipaddr) -m -w 1000000000 -r 1000 -b"
+	else
+		tst_rhost_run -s -c "$MCAST_RCMD -i 1000000000 -r 1 -b"
+	fi
+
+	# Run a multicast join tool
+	cnt=0
+	while [ $cnt -lt $max ]; do
+		if [ "$define_src_addr" ]; then
+			[ $((cnt % 5)) -ne 2 ] && filter="include" || filter="exclude"
+			params="-F $filter -s $(tst_ipaddr_un -c$cnt)"
+		fi
+
+		$MCAST_LCMD -l $NS_TIMES -a $maddr $params &
+		cnt=$((cnt + 1))
+	done
+
+	wait
+
+	tst_resm TPASS "test is finished successfully"
+}
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope01 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope01
deleted file mode 100644
index b03ff626b..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope01
+++ /dev/null
@@ -1,211 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast4-grpope01
-#
-# Description:
-#   Verify that the kernel is not crashed when joining lots of IPv4 multicast
-#   groups on a single socket
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 1 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-grpope01
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the group
-MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-40000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-NETWORK_PART=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-NETWORK_MASK=24
-
-# Host portion of the IPv4 address
-LHOST_HOST_PART=${LHOST_IPV4_HOST:-"2"}     # local host
-RHOST_HOST_PART=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Prefix of the Multicast Address
-MCAST_ADDR_PREFIX=224.10
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    set_ipv4addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${NETWORK_PART}.${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}.${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv4_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv4.igmp_max_memberships=$MCASTNUM_HEAVY >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
-    sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_HEAVY IPv4 multicast groups on a single socket"
-
-do_setup
-
-# Run a multicast join tool
-tmpfile=$TMPDIR/ns-mcast_join.$$
-ns-mcast_join -f 4 -I $lhost_ifname -n $MCASTNUM_HEAVY -p $MCAST_ADDR_PREFIX > $tmpfile
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    rm -f $tmpfile
-    exit 1
-fi
-msg=`cat $tmpfile | grep groups`
-tst_resm TINFO "Joined $msg"
-rm -f $tmpfile
-
-# Send IGMP General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -o -r 1' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-while true ; do
-    ps auxw | grep -v grep | grep ns-mcast_join > /dev/null
-    if [ $? -ne 0 ] ; then
-  	break
-    fi
-done
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope02 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope02
deleted file mode 100644
index 67efac73c..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope02
+++ /dev/null
@@ -1,220 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast4-grpope02
-#
-# Description:
-#   Verify that the kernel is not crashed when joining lots of IPv4 multicast
-#   groups on lots of sockets
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 1 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-grpope02
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the group
-MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-40000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-NETWORK_PART=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-NETWORK_MASK=24
-
-# Host portion of the IPv4 address
-LHOST_HOST_PART=${LHOST_IPV4_HOST:-"2"}     # local host
-RHOST_HOST_PART=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Prefix of the Multicast Address
-MCAST_ADDR_PREFIX=224.10
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # Increase the maximum number of open file descriptors
-    fd_num=`ulimit -n`
-    if [ $fd_num -lt $MCASTNUM_HEAVY ]; then
-	ulimit -n $MCASTNUM_HEAVY
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "$MCASTNUM_HEAVY is too many for the file descriptor"
-	fi
-    fi
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    set_ipv4addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${NETWORK_PART}.${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}.${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv4_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv4.igmp_max_memberships=$MCASTNUM_HEAVY >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
-    sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_HEAVY IPv4 multicast groups on separate sockets"
-
-do_setup
-
-# Run a multicast join tool
-tmpfile=$TMPDIR/ns-mcast_join.$$
-ns-mcast_join -m -f 4 -I $lhost_ifname -n $MCASTNUM_HEAVY -p $MCAST_ADDR_PREFIX > $tmpfile
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    rm -f $tmpfile
-    exit 1
-fi
-msg=`cat $tmpfile | grep groups`
-tst_resm TINFO "Joined $msg"
-rm -f $tmpfile
-
-# Send IGMP General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -o -r 1' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-while true ; do
-    ps auxw | grep -v grep | grep ns-mcast_join > /dev/null
-    if [ $? -ne 0 ] ; then
-	break
-    fi
-done
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope03 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope03
deleted file mode 100644
index c44ec2170..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope03
+++ /dev/null
@@ -1,207 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast4-grpope03
-#
-# Description:
-#   Verify that the kernel is not crashed when joining and leaving the same
-#   IPv4 multicast group on multiple sockets lots of times
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 2 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-grpope03
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the socket
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
-# The number of the join/leave groups
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-NETWORK_PART=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-NETWORK_MASK=24
-
-# Host portion of the IPv4 address
-LHOST_HOST_PART=${LHOST_IPV4_HOST:-"2"}     # local host
-RHOST_HOST_PART=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Multicast Address
-MCAST_ADDR=224.10.10.1
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    set_ipv4addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${NETWORK_PART}.${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}.${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv4_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv4.igmp_max_memberships=$MCASTNUM_NORMAL >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
-    sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining and leaving the same IPv4 multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
-
-do_setup
-
-# Send IGMP General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -i 1000000000 -r 1 -b' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
-
-# Run a multicast join tool
-num=0
-while [ $num -lt $MCASTNUM_NORMAL ]; do
-    ns-mcast_join -f 4 -I $lhost_ifname -l $NS_TIMES -a $MCAST_ADDR &
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-	exit 1
-    fi
-    num=`expr $num + 1`
-done
-
-wait
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope04 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope04
deleted file mode 100644
index 8783928f3..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope04
+++ /dev/null
@@ -1,226 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast4-grpope04
-#
-# Description:
-#   Verify that the kernel is not crashed when joining and leaving the same
-#   IPv4 multicast group with the different source filter on multiple sockets
-#   lots of times
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 2 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast4-grpope04
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the socket
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
-# The number of the join/leave groups
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv4 address
-NETWORK_PART=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-NETWORK_MASK=24
-
-# Host portion of the IPv4 address
-LHOST_HOST_PART=${LHOST_IPV4_HOST:-"2"}     # local host
-RHOST_HOST_PART=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Multicast Address
-MCAST_ADDR=224.10.10.1
-
-# Prefix of the filter souce adddress
-SOURCE_ADDR_PREFIX="10.10"	# 10.10.x.y
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-igmp_querier >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv4 addresses to the interfaces
-    set_ipv4addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    set_ipv4addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv4 address of the local/remote host
-    lhost_addr="${NETWORK_PART}.${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}.${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv4_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv4 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv4.igmp_max_memberships=$MCASTNUM_NORMAL >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv4.igmp_max_msf=10 >/dev/null
-    sysctl -w net.ipv4.conf.${lhost_ifname}.force_igmp_version=0 >/dev/null
-    sysctl -w net.ipv4.conf.all.force_igmp_version=0 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining and leaving ame IPv4 multicast group with different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
-
-do_setup
-
-# Send IGMP General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-igmp_querier -I $rhost_ifname -i 1000000000 -r 1 -b' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start IGMP querier"
-    exit 1
-fi
-
-# Run a multicast join tool
-num=0
-while [ $num -lt $MCASTNUM_NORMAL ]; do
-    # Define the source address
-    x=`expr $num \/ 254`
-    y=`expr $num % 254 + 1`
-    if [ $x -gt 254 ]; then
-	tst_resm TINFO "The number of the connection is less than $num"
-	break
-    fi
-    source_addr="${SOURCE_ADDR_PREFIX}.${x}.${y}"
-
-    if [ `expr $num % 5` -ne 2 ]; then
-	filter="include"
-    else
-	filter="exclude"
-    fi
-
-    ns-mcast_join -f 4 -I $lhost_ifname -l $NS_TIMES -a $MCAST_ADDR -F $filter -s $source_addr &
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-	exit 1
-    fi
-    num=`expr $num + 1`
-done
-
-wait
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/multicast/grp-operation/mcast6-grpope01 b/testcases/network/stress/multicast/grp-operation/mcast6-grpope01
deleted file mode 100644
index e73951617..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast6-grpope01
+++ /dev/null
@@ -1,208 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast6-grpope01
-#
-# Description:
-#   Verify that the kernel is not crashed when joining lots of IPv6 multicast
-#   groups on a single socket
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 6 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-grpope01
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the group
-MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-40000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"	# local host
-RHOST_HOST_PART=":1"	# remote host
-
-# Prefix of the Multicast Address
-MCAST_ADDR_PREFIX=ff0e::1111
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${NETWORK_PART}:${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}:${RHOST_HOST_PART}"
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv6_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
-    sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_HEAVY IPv6 multicast groups on a single socket"
-
-do_setup
-
-# Run a multicast join tool
-tmpfile=$TMPDIR/ns-mcast_join.$$
-ns-mcast_join -f 6 -I $lhost_ifname -n $MCASTNUM_HEAVY -p $MCAST_ADDR_PREFIX > $tmpfile
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    rm -f $tmpfile
-    exit 1
-fi
-msg=`cat $tmpfile | grep groups`
-tst_resm TINFO "Joined $msg"
-rm -f $tmpfile
-
-# Send MLD General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -o' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-while true ; do
-    ps auxw | grep -v grep | grep ns-mcast_join > /dev/null
-    if [ $? -ne 0 ] ; then
-	break
-    fi
-done
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/multicast/grp-operation/mcast6-grpope02 b/testcases/network/stress/multicast/grp-operation/mcast6-grpope02
deleted file mode 100644
index d8b5d63d6..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast6-grpope02
+++ /dev/null
@@ -1,217 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast6-grpope02
-#
-# Description:
-#   Verify that the kernel is not crashed when joining lots of IPv6 multicast
-#   groups on lots of sockets
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 6 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-grpope02
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the group
-MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-40000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"     # local host
-RHOST_HOST_PART=":1"     # remote host
-
-# Prefix of the Multicast Address
-MCAST_ADDR_PREFIX=ff0e::1111
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # Increase the maximum number of open file descriptors
-    fd_num=`ulimit -n`
-    if [ $fd_num -lt $MCASTNUM_HEAVY ]; then
-	ulimit -n $MCASTNUM_HEAVY
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "$MCASTNUM_HEAVY is too many for the file descriptor"
-	fi
-    fi
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${NETWORK_PART}:${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}:${RHOST_HOST_PART}"
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv6_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
-    sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining $MCASTNUM_HEAVY IPv6 multicast groups on separate sockets"
-
-do_setup
-
-# Run a multicast join tool
-tmpfile=$TMPDIR/ns-mcast_join.$$
-ns-mcast_join -m -f 6 -I $lhost_ifname -n $MCASTNUM_HEAVY -p $MCAST_ADDR_PREFIX > $tmpfile
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-    rm -f $tmpfile
-    exit 1
-fi
-msg=`cat $tmpfile | grep groups`
-tst_resm TINFO "Joined $msg"
-rm -f $tmpfile
-
-# Send MLD General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -o' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-while true ; do
-    ps auxw | grep -v grep | grep ns-mcast_join > /dev/null
-    if [ $? -ne 0 ] ; then
-	break
-    fi
-done
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/multicast/grp-operation/mcast6-grpope03 b/testcases/network/stress/multicast/grp-operation/mcast6-grpope03
deleted file mode 100644
index 51c6e46e3..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast6-grpope03
+++ /dev/null
@@ -1,204 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast6-grpope03
-#
-# Description:
-#   Verify that the kernel is not crashed when joining and leaving the same
-#   IPv6 multicast group on multiple sockets lots of times
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 6 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-grpope03
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the socket
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
-# The number of the join/leave groups
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"     # local host
-RHOST_HOST_PART=":1"     # remote host
-
-# Multicast Address
-MCAST_ADDR=ff0e::1111:1
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${NETWORK_PART}:${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}:${RHOST_HOST_PART}"
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv6_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
-    sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining and leaving the same IPv6 multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
-
-do_setup
-
-# Send MLD General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -w 1000000000 -r 1000 -b' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
-
-# Run a multicast join tool
-num=0
-while [ $num -lt $MCASTNUM_NORMAL ]; do
-    ns-mcast_join -f 6 -I $lhost_ifname -l $NS_TIMES -a $MCAST_ADDR &
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-	exit 1
-    fi
-    num=`expr $num + 1`
-done
-
-wait
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/multicast/grp-operation/mcast6-grpope04 b/testcases/network/stress/multicast/grp-operation/mcast6-grpope04
deleted file mode 100644
index 7d864e935..000000000
--- a/testcases/network/stress/multicast/grp-operation/mcast6-grpope04
+++ /dev/null
@@ -1,222 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2006                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   mcast6-grpope04
-#
-# Description:
-#   Verify that the kernel is not crashed when joining and leaving the same
-#   IPv6 multicast group with the different source filter on multiple sockets
-#   lots of times
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	May 6 2006 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=mcast6-grpope04
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Number of the socket
-MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-20}
-
-# The number of the join/leave groups
-NS_TIMES=${NS_TIMES:-10000}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# Network portion of the IPv6 address
-NETWORK_PART="fec0:1:1:1"
-
-# Host portion of the IPv6 address
-LHOST_HOST_PART=":2"	# local host
-RHOST_HOST_PART=":1"	# remote host
-
-# Multicast Address
-MCAST_ADDR=ff0e::1111:1
-
-# Prefix of the filter souce adddress
-SOURCE_ADDR_PREFIX="fec0:100:100:100"
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure to kill the multicast receiver and sender
-    killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-    $LTP_RSH $RHOST killall -SIGHUP ns-icmpv6_sender >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_setup
-#
-# Description:
-#   Configure the ssystem for the test
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
-
-    # Call do_cleanup function before exit
-    trap do_cleanup 0
-
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    rhost_ifname=`get_ifname rhost $LINK_NUM`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Set IPv6 addresses to the interfaces
-    add_ipv6addr lhost $LINK_NUM $NETWORK_PART $LHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the local host"
-	exit 1
-    fi
-
-    add_ipv6addr rhost $LINK_NUM $NETWORK_PART $RHOST_HOST_PART
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add any IP address at the remote host"
-	exit 1
-    fi
-
-    # IPv6 address of the local/remote host
-    lhost_addr="${NETWORK_PART}:${LHOST_HOST_PART}"
-    rhost_addr="${NETWORK_PART}:${RHOST_HOST_PART}"
-    rhost_linklocal="fe80:${RHOST_HOST_PART}"
-
-    # Make sure the connectvity
-    check_icmpv6_connectivity $lhost_ifname $rhost_addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "There is no IPv6 connectivity."
-	exit 1
-    fi
-
-    # Make sure the sysctl values
-    sysctl -w net.ipv6.conf.all.force_mld_version=0 >/dev/null
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set the sysctl value regarding multicast"
-	exit $TST_TOTAL
-    fi
-
-    sysctl -w net.ipv6.conf.${lhost_ifname}.force_mld_version=0 >/dev/null
-    sysctl -w net.ipv6.mld_max_msf=10 >/dev/null
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed when joining and leaving ame IPv6 multicast group with different source filters on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
-
-do_setup
-
-# Send MLD General Query from the remote host
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_linklocal -m -w 1000000000 -r 1000 -b' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "Failed to start MLD querier"
-    exit 1
-fi
-
-# Run a multicast join tool
-num=0
-while [ $num -lt $MCASTNUM_NORMAL ]; do
-    # Define the source address
-    if [ $num -gt 65535 ]; then
-	tst_resm TINFO "The number of the connection is less than 65535"
-	break
-    fi
-    num_hex=`printf "%x" $num`
-    source_addr="${SOURCE_ADDR_PREFIX}::${num_hex}"
-
-    if [ `expr $num % 5` -ne 2 ]; then
-	filter="include"
-    else
-	filter="exclude"
-    fi
-
-    ns-mcast_join -f 6 -I $lhost_ifname -l $NS_TIMES -a $MCAST_ADDR -F $filter -s $source_addr &
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to start multicast joining tool Please check the environment"
-	exit 1
-    fi
-    num=`expr $num + 1`
-done
-
-wait
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-
-exit 0
diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/test_net_stress.sh
index 18e7a7173..77f5797df 100644
--- a/testcases/network/stress/ns-tools/test_net_stress.sh
+++ b/testcases/network/stress/ns-tools/test_net_stress.sh
@@ -25,18 +25,19 @@
 
 export TCID="${TCID:-$(basename $0)}"
 
-# using variables IPV4_NET16_UNUSED and various functions
 . test_net.sh
 
+ipver=${TST_IPV6:-4}
+
 # Netmask of for the tested network
 IPV4_NETMASK="255.255.255.0"
 IPV4_NETMASK_NUM=24
 
-# Prefix of the Multicast Address
+# Multicast address and it's prefix
 MCAST_IPV4_ADDR_PREFIX="224.10"
-# Multicast Address
 MCAST_IPV4_ADDR="${MCAST_IPV4_ADDR_PREFIX}.10.1"
-ipver=${TST_IPV6:-4}
+MCAST_IPV6_ADDR_PREFIX="ff0e::1111"
+MCAST_IPV6_ADDR="${MCAST_IPV6_ADDR_PREFIX}:1"
 
 # Setup for tests using netstress.
 netstress_setup()
-- 
2.14.1

