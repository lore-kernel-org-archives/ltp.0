From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Aug 2017 18:44:32 +0200
Subject: [LTP] [RFC PATCH v8 06/11] network/stress: Fix and cleanup part of
	multicast IPv4 tests
In-Reply-To: <20170818164437.13556-1-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
Message-ID: <20170818164437.13556-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Fix test for SSH and netns based testing.
* Remove hardcoded rsh dependency.
* Create shell library mcast4-lib.sh (multicast IPv4 specific)
  to reduce duplicity in tests. Library uses test_stress_net.sh
  (and therefore test_net.sh).
* Cleanup code + fixed typos.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../stress/multicast/grp-operation/mcast4-grpope01 | 221 ++-----------------
 .../stress/multicast/grp-operation/mcast4-grpope02 | 230 ++------------------
 .../stress/multicast/grp-operation/mcast4-grpope03 | 217 ++-----------------
 .../stress/multicast/grp-operation/mcast4-grpope04 | 236 ++-------------------
 .../stress/multicast/grp-operation/mcast4-lib.sh   | 118 +++++++++++
 5 files changed, 196 insertions(+), 826 deletions(-)
 create mode 100644 testcases/network/stress/multicast/grp-operation/mcast4-lib.sh

diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope01 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope01
index b03ff626b..086ecb1f9 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope01
+++ b/testcases/network/stress/multicast/grp-operation/mcast4-grpope01
@@ -1,211 +1,32 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# Function: do_cleanup
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
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
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Function: do_setup
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 # Description:
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
+# Verify that the kernel is not crashed when joining lots of IPv4 multicast
+# groups on a single socket.
 #
-# Clean up
+# Setup: testcases/network/stress/README
 #
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-while true ; do
-    ps auxw | grep -v grep | grep ns-mcast_join > /dev/null
-    if [ $? -ne 0 ] ; then
-  	break
-    fi
-done
+. mcast4-lib.sh
 
-tst_resm TPASS "Test is finished successfully."
+tst_resm TINFO "joining $MCASTNUM_HEAVY IPv4 multicast groups on a single socket"
 
-exit 0
+mcast_setup $MCASTNUM_HEAVY
+do_multicast_test_multiple_join $MCASTNUM_HEAVY
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope02 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope02
index 67efac73c..73d244f2a 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope02
+++ b/testcases/network/stress/multicast/grp-operation/mcast4-grpope02
@@ -1,220 +1,28 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# Main
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
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
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# Clean up
+# Setup: testcases/network/stress/README
 #
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-killall -SIGHUP ns-mcast_join >/dev/null 2>&1
-while true ; do
-    ps auxw | grep -v grep | grep ns-mcast_join > /dev/null
-    if [ $? -ne 0 ] ; then
-	break
-    fi
-done
+. mcast4-lib.sh
 
-tst_resm TPASS "Test is finished successfully."
+tst_resm TINFO "joining $MCASTNUM_HEAVY IPv4 multicast groups on separate sockets"
 
-exit 0
+mcast_setup $MCASTNUM_HEAVY true
+do_multicast_test_multiple_join $MCASTNUM_HEAVY true
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope03 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope03
index c44ec2170..15e6d4a2f 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope03
+++ b/testcases/network/stress/multicast/grp-operation/mcast4-grpope03
@@ -1,207 +1,28 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# Function: do_setup
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
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
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Main
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
+# Setup: testcases/network/stress/README
 #
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
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
+. mcast4-lib.sh
 
-tst_resm TPASS "Test is finished successfully."
+tst_resm TINFO "joining and leaving the same IPv4 multicast group on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
 
-exit 0
+mcast_setup $MCASTNUM_NORMAL
+do_multicast_test_join_leave
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-grpope04 b/testcases/network/stress/multicast/grp-operation/mcast4-grpope04
index 8783928f3..56a066ba4 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast4-grpope04
+++ b/testcases/network/stress/multicast/grp-operation/mcast4-grpope04
@@ -1,226 +1,28 @@
 #!/bin/sh
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
+# Copyright (c) International Business Machines  Corp., 2006
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
 #
-# Description:
-#   Recover the system configuration
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
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
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Function: do_setup
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-# Description:
-#   Configure the ssystem for the test
+# Setup: testcases/network/stress/README
 #
-#-----------------------------------------------------------------------
-do_setup()
-{
-    # Initialize the system configuration
-    do_cleanup
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
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
+. mcast4-lib.sh
 
-tst_resm TPASS "Test is finished successfully."
+tst_resm TINFO "joining and leaving the same IPv4 multicast group with a different source filter on $MCASTNUM_NORMAL sockets in $NS_TIMES times"
 
-exit 0
+mcast_setup $MCASTNUM_NORMAL
+do_multicast_test_join_leave true
+tst_exit
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
new file mode 100644
index 000000000..0c74969cf
--- /dev/null
+++ b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
@@ -0,0 +1,118 @@
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
+# Setup script for mcast4-grpope* tests.
+
+TST_TOTAL=1
+TST_CLEANUP="mcast_cleanup"
+
+. test_net_stress.sh
+
+mcast_setup()
+{
+	local igmp_max_memberships="$1"
+	local increase_max="${2:-}"
+
+	netstress_setup
+	tst_tmpdir
+
+	SYSFS_IGMP_MAX_MEMBERSHIPS=$(sysctl -b net.ipv4.igmp_max_memberships)
+	SYSFS_IGMP_MAX_MSF=$(sysctl -b net.ipv4.igmp_max_msf)
+	SYSFS_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.$(tst_iface).force_igmp_version)
+	SYSFS_ALL_FORCE_IGMP_VERSION=$(sysctl -b net.ipv4.conf.all.force_igmp_version)
+
+	if [ "$increase_max" ]; then
+		# Increase the maximum number of open file descriptors
+		[ `ulimit -n` -lt $igmp_max_memberships ] && ROD ulimit -n $igmp_max_memberships
+	fi
+
+	ROD sysctl -qw net.ipv4.igmp_max_memberships=$igmp_max_memberships
+	ROD sysctl -qw net.ipv4.igmp_max_msf=10
+	ROD sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=0
+	ROD sysctl -qw net.ipv4.conf.all.force_igmp_version=0
+}
+
+mcast_cleanup()
+{
+	[ -n "$SYSFS_IGMP_MAX_MEMBERSHIPS" ] && sysctl -qw net.ipv4.igmp_max_memberships=$SYSFS_IGMP_MAX_MEMBERSHIPS
+	[ -n "$SYSFS_IGMP_MAX_MSF" ] && sysctl -qw net.ipv4.igmp_max_msf=$SYSFS_IGMP_MAX_MSF
+	[ -n "$SYSFS_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=$SYSFS_FORCE_IGMP_VERSION
+	[ -n "$SYSFS_ALL_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.all.force_igmp_version=$SYSFS_ALL_FORCE_IGMP_VERSION
+
+	pkill -SIGHUP -x ns-mcast_join
+	tst_sleep 10ms
+	pkill -9 -x ns-mcast_join
+
+	tst_rhost_run -c "pkill -SIGHUP -x ns-igmp_querier"
+
+	restore_ipaddr
+	restore_ipaddr rhost
+}
+
+do_multicast_test_multiple_join()
+{
+	local igmp_max_memberships="$1"
+	local param_multi_socket ret tmpfile
+
+	[ "${2:-}" = true ] && param_multi_socket="-m"
+
+	# Run a multicast join tool
+	tmpfile=ns-mcast_join.$$
+
+	EXPECT_PASS ns-mcast_join $param_multi_socket -f 4 -I $(tst_iface) -n $igmp_max_memberships -p $MCAST_IPV4_ADDR_PREFIX \> $tmpfile
+
+	tst_resm TINFO "joined $(grep groups $tmpfile)"
+
+	# Send IGMP General Query from the remote host
+	EXPECT_RHOST_PASS ns-igmp_querier -I $(tst_iface rhost) -o -r 1 -m $MCAST_IPV4_ADDR
+}
+
+do_multicast_test_join_leave()
+{
+	local define_source_address filter num ret source_addr x y
+
+	[ "$1" = true ] && define_source_address=true
+
+	# Send IGMP General Query from the remote host
+	tst_rhost_run -s -c "ns-igmp_querier -I $(tst_iface rhost) -i 1000000000 -r 1 -b"
+
+	# Run a multicast join tool
+	num=0
+	while [ $num -lt $MCASTNUM_NORMAL ]; do
+		if [ "$define_source_address" ]; then
+			x=$(($num / 254))
+			y=$(($num % 254 + 1))
+			if [ $x -gt 254 ]; then
+				tst_resm TINFO "the number of the connection is less than $num"
+				break
+			fi
+			source_addr="${IPV4_NET16_UNUSED}.${x}.${y}"
+
+			[ $(($num % 5)) -ne 2 ] && filter="include" || filter="exclude"
+			params="-F $filter -s $source_addr"
+		fi
+
+		ns-mcast_join -f 4 -I $(tst_iface) -l $NS_TIMES -a $MCAST_IPV4_ADDR $params &
+		num=$(($num + 1))
+	done
+
+	wait
+
+	tst_resm TPASS "test is finished successfully"
+}
-- 
2.13.2

