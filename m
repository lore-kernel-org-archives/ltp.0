Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XBkg6-0005fH-9X
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 13:09:22 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XBkg1-0007uI-I2
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 13:09:22 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s6SD9AVv013523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Jul 2014 13:09:11 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s6SD9929001102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Jul 2014 13:09:10 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s6SD99WT014262
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Jul 2014 13:09:09 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 28 Jul 2014 17:10:22 +0400
Message-Id: <1406553022-3436-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1406553022-3436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1406553022-3436-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] network/stress/broken_ip: move common code to
	library
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Move common code to test_net.sh (tst_lhost_hwaddr(), tst_rhost_hwaddr()),
broken_ipv4_lib.sh and broken_ipv6_lib.sh.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh                          |   50 ++++++
 .../network/stress/broken_ip/broken_ip4-checksum   |  155 +++----------------
 .../network/stress/broken_ip/broken_ip4-dstaddr    |  156 +++----------------
 .../network/stress/broken_ip/broken_ip4-fragment   |  156 +++----------------
 testcases/network/stress/broken_ip/broken_ip4-ihl  |  156 +++----------------
 .../network/stress/broken_ip/broken_ip4-protcol    |  155 +++----------------
 .../network/stress/broken_ip/broken_ip4-totlen     |  155 +++----------------
 .../network/stress/broken_ip/broken_ip4-version    |  155 +++----------------
 .../network/stress/broken_ip/broken_ip4_lib.sh     |   38 +++++
 .../network/stress/broken_ip/broken_ip6-dstaddr    |  157 +++----------------
 .../network/stress/broken_ip/broken_ip6-nexthdr    |  155 +++----------------
 testcases/network/stress/broken_ip/broken_ip6-plen |  156 +++----------------
 .../network/stress/broken_ip/broken_ip6-version    |  155 +++----------------
 .../network/stress/broken_ip/broken_ip6_lib.sh     |   37 +++++
 14 files changed, 384 insertions(+), 1452 deletions(-)
 create mode 100644 testcases/network/stress/broken_ip/broken_ip4_lib.sh
 create mode 100644 testcases/network/stress/broken_ip/broken_ip6_lib.sh

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 81cfbb7..259127c 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -86,3 +86,53 @@ tst_rhost_hwaddr()
 	echo $(tst_rhost_run -s -c "ip link show $RHOST_INTERFACE | \
 		awk 'NR==2 { print $2 }'")
 }
+
+tst_set_ipv4_addr()
+{
+	# Initialize test interfaces
+	# The number of the test link where tests run
+	LINK_NUM=${LINK_NUM:-0}
+
+	initialize_if lhost ${LINK_NUM}
+	initialize_if rhost ${LINK_NUM}
+
+	# Netmask of the IPv4 network
+	network_mask=24
+
+	tst_resm TINFO "set remote ipv4 addr '$IPV4_NETWORK $RHOST_IPV4_HOST'"
+	# Set IPv4 addresses to the interfaces
+	set_ipv4addr rhost $LINK_NUM $IPV4_NETWORK $RHOST_IPV4_HOST
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Failed to add any IP address at the remote host"
+	fi
+
+	tst_resm TINFO "set local ipv4 addr '$IPV4_NETWORK $LHOST_IPV4_HOST'"
+	set_ipv4addr lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Failed to add any IP address at the local host"
+	fi
+}
+
+tst_set_ipv6_addr()
+{
+	# Initialize test interfaces
+	# The number of the test link where tests run
+	LINK_NUM=${LINK_NUM:-0}
+
+	initialize_if lhost ${LINK_NUM}
+	initialize_if rhost ${LINK_NUM}
+
+	# Netmask of the IPv6 network
+	network_mask=64
+
+	add_ipv6addr rhost $LINK_NUM $IPV6_NETWORK $RHOST_IPV6_HOST
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Failed to add any IP address at the remote host"
+	fi
+
+	# Set IPv6 addresses to the interfaces
+	add_ipv6addr lhost $LINK_NUM $IPV6_NETWORK $LHOST_IPV6_HOST
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "Failed to add any IP address at the local host"
+	fi
+}
diff --git a/testcases/network/stress/broken_ip/broken_ip4-checksum b/testcases/network/stress/broken_ip/broken_ip4-checksum
index f492e77..a7cf643 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-checksum
+++ b/testcases/network/stress/broken_ip/broken_ip4-checksum
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip4-checksum
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,21 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip4-checksum01}
+TCID=broken_ip4-checksum01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv4 packets that have wrong value in the checksum field"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip4_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv4 packets that have wrong value in the checksum field"
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv4 address
-network_part=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-network_mask=24
-
-# Host portion of the IPv4 address
-lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Set IPv4 addresses to the interfaces
-set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv4 address of the local/remote host
-lhost_addr="${network_part}.${lhost_host_part}"
-rhost_addr="${network_part}.${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv4 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv4_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -c"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv4_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -c
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-dstaddr b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
index 7e137bf..7826642 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip4-dstaddr
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -44,123 +37,22 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip4-dstaddr01}
+TCID=broken_ip4-dstaddr01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv4 packets whose destination address is wrong (destination MAC address is correct)"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip4_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv4 packets whose destination address is wrong \
+(destination MAC address is correct)"
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv4 address
-network_part=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-network_mask=24
-
-# Host portion of the IPv4 address
-lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Set IPv4 addresses to the interfaces
-set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv4 address of the local/remote host
-lhost_addr="${network_part}.${lhost_host_part}"
-rhost_addr="${network_part}.${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv4 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv4_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -i"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv4_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -i
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-fragment b/testcases/network/stress/broken_ip/broken_ip4-fragment
index 0f94c97..ad35d3e 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-fragment
+++ b/testcases/network/stress/broken_ip/broken_ip4-fragment
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip4-fragment
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,22 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip4-fragment01}
+TCID=broken_ip4-fragment01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv4 packets that have wrong fragment information"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip4_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv4 address
-network_part=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-network_mask=24
-
-# Host portion of the IPv4 address
-lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Set IPv4 addresses to the interfaces
-set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv4 address of the local/remote host
-lhost_addr="${network_part}.${lhost_host_part}"
-rhost_addr="${network_part}.${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv4 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv4_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -f"
+# Test description
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv4 packets that have wrong fragment information"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv4_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -f
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-ihl b/testcases/network/stress/broken_ip/broken_ip4-ihl
index 1e1e491..82faf49 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-ihl
+++ b/testcases/network/stress/broken_ip/broken_ip4-ihl
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip4-ihl
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,22 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip4-ihl01}
+TCID=broken_ip4-ihl01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv4 packets that have wrong value in the header length field."
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip4_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv4 packets that have wrong value in the header \
+length field."
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv4 address
-network_part=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-network_mask=24
-
-# Host portion of the IPv4 address
-lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Set IPv4 addresses to the interfaces
-set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv4 address of the local/remote host
-lhost_addr="${network_part}.${lhost_host_part}"
-rhost_addr="${network_part}.${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv4 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv4_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -l"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv4_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -l
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-protcol b/testcases/network/stress/broken_ip/broken_ip4-protcol
index 4b86f66..3275228 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-protcol
+++ b/testcases/network/stress/broken_ip/broken_ip4-protcol
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip4-protocol
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,21 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip4-protocol01}
+TCID=broken_ip4-protocol01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv4 packets that have wrong value in the protocol field"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip4_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv4 packets that have wrong value in the protocol field"
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv4 address
-network_part=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-network_mask=24
-
-# Host portion of the IPv4 address
-lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Set IPv4 addresses to the interfaces
-set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv4 address of the local/remote host
-lhost_addr="${network_part}.${lhost_host_part}"
-rhost_addr="${network_part}.${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv4 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv4_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -p"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv4_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -p
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-totlen b/testcases/network/stress/broken_ip/broken_ip4-totlen
index 3ee18b8..0bfe509 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-totlen
+++ b/testcases/network/stress/broken_ip/broken_ip4-totlen
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip4-totlen
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,21 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip4-totlen01}
+TCID=broken_ip4-totlen01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv4 packets that have wrong value in the total length field."
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip4_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv4 packets that have wrong value in the total length field."
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv4 address
-network_part=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-network_mask=24
-
-# Host portion of the IPv4 address
-lhost_host_part=${LHOST_IPV4_HOST:-"2"}     # local host
-rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Set IPv4 addresses to the interfaces
-set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv4 address of the local/remote host
-lhost_addr="${network_part}.${lhost_host_part}"
-rhost_addr="${network_part}.${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv4 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv4_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -L"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv4_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -L
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-version b/testcases/network/stress/broken_ip/broken_ip4-version
index 66f6b8a..8dfef2b 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-version
+++ b/testcases/network/stress/broken_ip/broken_ip4-version
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip4-version
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,21 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip4-version01}
+TCID=broken_ip4-version01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv4 packets that have wrong value in version field."
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip4_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv4 packets that have wrong value in version field."
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv4 address
-network_part=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of the IPv4 network
-network_mask=24
-
-# Host portion of the IPv4 address
-lhost_host_part=${LHOST_IPV4_HOST:-"2"}    # local host
-rhost_host_part=${RHOST_IPV4_HOST:-"1"}     # remote host
-
-# Set IPv4 addresses to the interfaces
-set_ipv4addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-set_ipv4addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv4 address of the local/remote host
-lhost_addr="${network_part}.${lhost_host_part}"
-rhost_addr="${network_part}.${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv4 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv4_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -v"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv4_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -v
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4_lib.sh b/testcases/network/stress/broken_ip/broken_ip4_lib.sh
new file mode 100644
index 0000000..aafabd4
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip4_lib.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+. test_net.sh
+
+# Output the informaion
+tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
+
+tst_set_ipv4_addr
+
+# IPv4 address of the local/remote host
+lhost_addr=$IPV4_NETWORK.$LHOST_IPV4_HOST
+rhost_addr=$IPV4_NETWORK.$RHOST_IPV4_HOST
+
+ret=$($LTP_RSH $RHOST check_icmpv4_connectivity \
+	$RHOST_INTERFACE $lhost_addr; echo $?)
+
+if [ "$ret" -ne 0 ]; then
+	tst_brkm TBROK "There is no IPv4 connectivity."
+else
+	tst_resm TINFO "There is IPv4 connectivity."
+fi
diff --git a/testcases/network/stress/broken_ip/broken_ip6-dstaddr b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
index 79fcc5f..c5c93ed 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip6-dstaddr
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -44,123 +37,23 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip6-dstaddr01}
+TCID=broken_ip6-dstaddr01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv6 packets whose destination address is wrong (destination MAC address is correct)"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip6_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv6 address
-network_part="fd00:1:1:1"
-
-# Netmask of the IPv6 network
-network_mask=64
-
-# Host portion of the IPv6 address
-lhost_host_part=":2"     # local host
-rhost_host_part=":1"     # remote host
-
-# Set IPv6 addresses to the interfaces
-add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv6 address of the local/remote host
-lhost_addr="${network_part}:${lhost_host_part}"
-rhost_addr="${network_part}:${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv6 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -i"
+# Test description
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv6 packets whose destination address is wrong \
+(destination MAC address is correct)"
 
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv6_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -i
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-nexthdr b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
index 81b158d..f6671fb 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-nexthdr
+++ b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip6-nexthdr
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,21 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip6-nexthdr01}
+TCID=broken_ip6-nexthdr01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv6 packets that have wrong value in the next header field."
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip6_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv6 packets that have wrong value in the next header field."
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv6 address
-network_part="fd00:1:1:1"
-
-# Netmask of the IPv6 network
-network_mask=64
-
-# Host portion of the IPv6 address
-lhost_host_part=":2"     # local host
-rhost_host_part=":1"     # remote host
-
-# Set IPv6 addresses to the interfaces
-add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv6 address of the local/remote host
-lhost_addr="${network_part}:${lhost_host_part}"
-rhost_addr="${network_part}:${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv6 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -n"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv6_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -n
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-plen b/testcases/network/stress/broken_ip/broken_ip6-plen
index b62e751..421c503 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-plen
+++ b/testcases/network/stress/broken_ip/broken_ip6-plen
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip6-plen
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,22 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip6-plen01}
+TCID=broken_ip6-plen01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv6 packets that have wrong value in the payload length field."
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip6_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv6 packets that have wrong value in the payload \
+length field."
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv6 address
-network_part="fd00:1:1:1"
-
-# Netmask of the IPv6 network
-network_mask=64
-
-# Host portion of the IPv6 address
-lhost_host_part=":2"     # local host
-rhost_host_part=":1"     # remote host
-
-# Set IPv6 addresses to the interfaces
-add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv6 address of the local/remote host
-lhost_addr="${network_part}:${lhost_host_part}"
-rhost_addr="${network_part}:${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv6 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -L"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv6_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -L
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-version b/testcases/network/stress/broken_ip/broken_ip6-version
index 3ebfbfe..1b5e8ac 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-version
+++ b/testcases/network/stress/broken_ip/broken_ip6-version
@@ -1,28 +1,21 @@
 #!/bin/sh
 
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
 #
-# File:
-#   broken_ip6-version
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 # Description:
 #   Verify that the kernel is not crashed with receiving a large number of
@@ -43,123 +36,21 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-broken_ip6-version01}
+TCID=broken_ip6-version01
 TST_TOTAL=1
 TST_COUNT=1
 export TCID
 export TST_COUNT
 export TST_TOTAL
 
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving a large number of IPv6 packets that have wrong value in version field."
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
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
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-# Get the MAC address of the interface at the local host
-field=`expr $LINK_NUM + 1`
-lhost_hwaddr=`echo $LHOST_HWADDRS | cut -d ' ' -f $field`
-if [ x${lhost_hwaddr} = x ]; then
-    tst_resm TBROK "Failed to get the MAC address name at the local host"
-    exit $TST_TOTAL
-fi
+. broken_ip6_lib.sh
 
-# Get the name of the interface at the remote host
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
+tst_resm TINFO "Verify that the kernel is not crashed with receiving \
+a large number of IPv6 packets that have wrong value in version field."
 
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Network portion of the IPv6 address
-network_part="fd00:1:1:1"
-
-# Netmask of the IPv6 network
-network_mask=64
-
-# Host portion of the IPv6 address
-lhost_host_part=":2"     # local host
-rhost_host_part=":1"     # remote host
-
-# Set IPv6 addresses to the interfaces
-add_ipv6addr lhost $LINK_NUM $network_part $lhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the local host"
-    exit 1
-fi
-
-add_ipv6addr rhost $LINK_NUM $network_part $rhost_host_part
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to add any IP address at the remote host"
-    exit 1
-fi
-
-# IPv6 address of the local/remote host
-lhost_addr="${network_part}:${lhost_host_part}"
-rhost_addr="${network_part}:${rhost_host_part}"
-
-# Make sure the connectvity
-ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-if [ $ret -ne 0 ]; then
-    tst_resm TBROK "There is no IPv6 connectivity."
-    exit 1
-fi
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Run a client
-$LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-icmpv6_sender -I $rhost_ifname -S $rhost_addr -M $lhost_hwaddr -D $lhost_addr -s 56 -t $NS_DURATION -v"
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
+$LTP_RSH $RHOST ns-icmpv6_sender -I $RHOST_INTERFACE -S $rhost_addr \
+-M $LHOST_HWADDRS -D $lhost_addr -s 56 -t $NS_DURATION -v
 
 tst_resm TPASS "Test is finished successfully."
-exit 0
+
+tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6_lib.sh b/testcases/network/stress/broken_ip/broken_ip6_lib.sh
new file mode 100644
index 0000000..5457c19
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip6_lib.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+. test_net.sh
+
+# Output the informaion
+tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
+
+tst_set_ipv6_addr
+
+# IPv6 address of the local/remote host
+lhost_addr="$IPV6_NETWORK:$LHOST_IPV6_HOST"
+rhost_addr="$IPV6_NETWORK:$RHOST_IPV6_HOST"
+
+# Make sure the connectvity
+ret=$($LTP_RSH $RHOST check_icmpv6_connectivity \
+	$RHOST_INTERFACE $lhost_addr; echo $?)
+
+if [ $ret -ne 0 ]; then
+    tst_brkm TBROK "There is no IPv6 connectivity."
+fi
-- 
1.7.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
