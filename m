Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzY-0005Pe-4l
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:04 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzR-0004W9-DZ
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:04 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4o25032649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4oOh023322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:50 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t1DC4ohm024149
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:50 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:06:59 +0300
Message-Id: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/11] network/stress/interface: rename if4-* tests
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if-addr-adddel  |  326 +++++++++++++
 .../network/stress/interface/if-addr-addlarge      |  481 ++++++++++++++++++++
 testcases/network/stress/interface/if-mtu-change   |  264 +++++++++++
 testcases/network/stress/interface/if-route-adddel |  293 ++++++++++++
 .../network/stress/interface/if-route-addlarge     |  292 ++++++++++++
 testcases/network/stress/interface/if-updown       |  258 +++++++++++
 .../network/stress/interface/if4-alias-adddel      |  326 -------------
 .../network/stress/interface/if4-alias-addlarge    |  481 --------------------
 testcases/network/stress/interface/if4-mtu-change  |  264 -----------
 .../network/stress/interface/if4-route-adddel      |  293 ------------
 .../network/stress/interface/if4-route-addlarge    |  292 ------------
 testcases/network/stress/interface/if4-updown      |  258 -----------
 12 files changed, 1914 insertions(+), 1914 deletions(-)
 create mode 100644 testcases/network/stress/interface/if-addr-adddel
 create mode 100644 testcases/network/stress/interface/if-addr-addlarge
 create mode 100644 testcases/network/stress/interface/if-mtu-change
 create mode 100644 testcases/network/stress/interface/if-route-adddel
 create mode 100644 testcases/network/stress/interface/if-route-addlarge
 create mode 100644 testcases/network/stress/interface/if-updown
 delete mode 100644 testcases/network/stress/interface/if4-alias-adddel
 delete mode 100644 testcases/network/stress/interface/if4-alias-addlarge
 delete mode 100644 testcases/network/stress/interface/if4-mtu-change
 delete mode 100644 testcases/network/stress/interface/if4-route-adddel
 delete mode 100644 testcases/network/stress/interface/if4-route-addlarge
 delete mode 100644 testcases/network/stress/interface/if4-updown

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
new file mode 100644
index 0000000..4e6e4d6
--- /dev/null
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -0,0 +1,326 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2005                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+##                                                                            ##
+################################################################################
+#
+# File:
+#   if4-alias-adddel
+#
+# Description:
+#   Verify the IPv4 connectivity isn't broken with adding and deleting an
+#   IPv4 alias many times
+#    test01 - by `ifconfig add' style
+#    test02 - by `ifconfig ethn:n' style
+#    test03 - by ip command
+#
+# Setup:
+#   See ltp-yyyymmdd/testcases/network/stress/README
+#
+# Author:
+#   Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# History:
+#	Oct 19 2005 - Created (Mitsuru Chinen)
+#
+#-----------------------------------------------------------------------
+# Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+# Total number of the test case
+TST_TOTAL=3
+export TST_TOTAL
+
+# Default of the test case ID and the test case count
+TCID=if4-alias-adddel
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable
+. check_envval || exit $TST_TOTAL
+
+# The number of the add/delete IPv4 alias
+NS_TIMES=${NS_TIMES:-10000}
+
+# The interval of the check interface activity
+CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $NS_TIMES \/ 100`}
+
+# The number of the test link where tests run
+LINK_NUM=0
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+
+# Netmask of for the tested network
+IPV4_NETMASK="255.255.255.0"
+IPV4_NETMASK_NUM=24
+
+# Broadcast address of the tested network
+IPV4_BROADCAST=${IPV4_NETWORK}.255
+
+# Host portion of the IPv4 address of the remote host
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+
+# Host portion of the non-alias
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"254"}
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_setup
+#
+# DESCRIPTION:
+#   Make a IPv4 connectivity
+#
+# SET VALUES:
+#   rhost_ipv4addr	- IPv4 Address of the remote host
+#   lhost_ifname	- Interface name of the local host
+#   rhost_ifname	- Interface name of the remote host
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    TCID=if4-alias-adddel
+    TST_COUNT=0
+
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Configure the interface at the remote host
+    initialize_if rhost ${LINK_NUM}
+    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to initialize the interface at the remote host"
+	exit $TST_TOTAL
+    fi
+
+    # IPv4 address of the remote host
+    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+
+    # Get the Interface name of local host
+    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+
+    # Get the Interface name of remote host
+    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the remote host"
+	exit $TST_TOTAL
+    fi
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_cleanup
+#
+# DESCRIPTION:
+#   Recover the tested interfaces
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test_body
+#
+# DESCRIPTION:
+#   main code of the test
+#
+# Arguments:
+#   $1: define the test type
+#	1 - `ifconfig add' style
+#	2 - `ifconfig ethn:n' style
+#	3 - ip command
+#
+#-----------------------------------------------------------------------
+test_body()
+{
+    test_type=$1
+
+    TCID=if4-alias-adddel0${test_type}
+    TST_COUNT=$test_type
+
+    case $test_type in
+	1)	# Case of ifconfig add
+	command_style="'ifconfig add'"
+	;;
+	2)	# Case of ifconfig ethn:n
+	command_style="'ifconfig ethn:n'"
+	;;
+	3)	# Case of ip command
+	command_style="ip command"
+	;;
+	*)
+	tst_resm TBROK "unspecified case"
+	return 1
+	;;
+    esac
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when $command_style adds, then deletes an IPv4 alias $NS_TIMES times"
+
+    # Make sure that no alias exists.
+    initialize_if lhost ${LINK_NUM}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to initialize the interface at the local host"
+	return 1
+    fi
+
+    # Set the non-alias address
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to assign an IPv4 address to the interface at the local host"
+	return 1
+    fi
+    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+
+    # Check the connctivity
+    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
+    if [ $ret -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
+	return 1
+    fi
+
+    # IPv4 alias address of the localhost
+    lhost_ipv4_alias_ip=${IPV4_NETWORK}.${test_type}${test_type}
+
+    # The interface alias of local host
+    case $test_type in
+	1)	# Case of ifconfig add
+	lhost_ifalias=${lhost_ifname}:0
+	;;
+	2)	# Case of ifconfig ethn:n
+	lhost_ifalias=${lhost_ifname}:1
+	;;
+	# interface alias doesn't exist at ip command case.
+    esac
+
+    # Make a background TCP traffic from the non-alias address
+    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+
+    # Start the loop
+    cnt=0
+    while [ $cnt -lt $NS_TIMES ]; do
+	# Create
+	case $test_type in
+	    1)		# Case of ifconfig add
+	    ifconfig $lhost_ifname add ${lhost_ipv4_alias_ip} netmask ${IPV4_NETMASK} broadcast ${IPV4_BROADCAST}
+	    ;;
+	    2)		# Case of ifconfig ethn:n
+	    ifconfig $lhost_ifalias ${lhost_ipv4_alias_ip} netmask ${IPV4_NETMASK} broadcast ${IPV4_BROADCAST}
+	    ;;
+	    3)		# Case of ip command
+	    ip addr add ${lhost_ipv4_alias_ip}/${IPV4_NETMASK_NUM} broadcast ${IPV4_BROADCAST} dev ${lhost_ifname}
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Failed to add ${lhost_ipv4_alias_ip}".
+	    return 1
+	fi
+
+	# Check the connectivity
+	cnt=`expr $cnt + 1`
+	if [ $CHECK_INTERVAL -ne 0 ]; then
+	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
+		if [ $test_type -ne 3 ]; then
+		    # Case of ifconfig add / ifconfig ethn:n
+		    check_icmpv4_connectivity $lhost_ifalias $rhost_ipv4addr
+		else
+		    # Case of ip command
+		    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+		fi
+		if [ $? -ne 0 ]; then
+		    tst_resm TFAIL "$lhost_ifname is broken."
+		    return 1
+		fi
+	    fi
+	fi
+
+	# Check the background TCP traffic
+	bg_tcp_traffic check $server_pid
+	if [ $? -ne 0 ]; then
+	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	fi
+
+	# Delete
+	case $test_type in
+	    1)		# Case of ifconfig add
+	    ifconfig $lhost_ifalias del ${lhost_ipv4_alias_ip}
+	    ;;
+	    2)		# Case of ifconfig ethn:n
+	    ifconfig ${lhost_ifalias} down
+	    ;;
+	    3)		# Case of ip command
+	    ip addr del ${lhost_ipv4_alias_ip}/${IPV4_NETMASK_NUM} broadcast ${IPV4_BROADCAST} dev ${lhost_ifname}
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Failed to delete ${lhost_ipv4_alias_ip}".
+	    return 1
+	fi
+    done
+
+    # Stop the background TCP traffic
+    bg_tcp_traffic killall
+
+    tst_resm TPASS "Test is finished correctly."
+    return 0
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Main
+#
+# Exit Value:
+#   The number of the failure
+#
+#-----------------------------------------------------------------------
+
+RC=0
+do_setup
+test_body 1 || RC=`expr $RC + 1`	# Case of ifconfig add
+test_body 2 || RC=`expr $RC + 1`	# Case of ifconfig ethn:n
+test_body 3 || RC=`expr $RC + 1`	# Case of ip command
+do_cleanup
+
+exit $RC
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
new file mode 100644
index 0000000..13efe84
--- /dev/null
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -0,0 +1,481 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2005                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+##                                                                            ##
+################################################################################
+#
+# File:
+#   if4-alias-addlarge
+#
+# Description:
+#   Verify the IPv4 connectivity isn't broken with creating a large number
+#   of IPv4-aliases
+#    test01 - by `ifconfig add' style
+#    test02 - by `ifconfig ethn:n' style
+#    test03 - by ip command
+#
+# Setup:
+#   See ltp-yyyymmdd/testcases/network/stress/README
+#
+# Author:
+#   Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# History:
+#	Oct 19 2005 - Created (Mitsuru Chinen)
+#
+#-----------------------------------------------------------------------
+# Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+# Total number of the test case
+TST_TOTAL=3
+export TST_TOTAL
+
+# Default of the test case ID and the test case count
+TCID=if4-alias-addlarge
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable
+. check_envval || exit $TST_TOTAL
+
+# The number of the add IPv4 alias
+IP_TOTAL=${IP_TOTAL:-10000}
+
+# The interval of the check interface activity
+CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $IP_TOTAL \/ 100`}
+
+# The number of the test link where tests run
+LINK_NUM=0
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-"10"}
+
+# Netmask of for the tested network
+IPV4_NETMASK="255.0.0.0"
+IPV4_NETMASK_NUM=8
+
+# Broadcast address of the tested network
+IPV4_BROADCAST=${IPV4_NETWORK}.255.255.255
+
+# Host portion of the IPv4 address
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"0.0.2"}
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"0.0.1"}
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_setup
+#
+# DESCRIPTION:
+#   Make a IPv4 connectivity
+#
+# SET VALUES:
+#   lhost_ifname	- Interface name of the local host
+#   rhost_ifname	- Interface name of the local host
+#   rhost_ipv4addr	- IP address of the remote host
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    TCID=if4-alias-addlarge
+    TST_COUNT=0
+
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Initialize the interface at the remote host
+    initialize_if rhost ${LINK_NUM}
+
+    # Set IPv4 address to the interface at the remote host
+    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to add an IPv4 address at the remote host"
+	exit $TST_TOTAL
+    fi
+
+    # Get the Interface names
+    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the remote host"
+	exit $TST_TOTAL
+    fi
+
+    # IPv4 address of the remote host
+    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_cleanup
+#
+# DESCRIPTION:
+#   Recover the tested interfaces
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test01
+#
+# DESCRIPTION:
+#   Creating a large number of IPv4-aliases by `ifconfig add'
+#
+#-----------------------------------------------------------------------
+test01()
+{
+    TCID=if4-alias-addlarge01
+    TST_COUNT=1
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when 'ifconifg add' creates $IP_TOTAL IPv4-aliases."
+
+    # Make sure that no alias exists.
+    initialize_if lhost ${LINK_NUM}
+
+    # Set the non-alias address
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to add IPv4 address to the interface at the local host"
+	return 1
+    fi
+    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+
+    # Check the connctivity
+    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
+    if [ $ret -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
+	return 1
+    fi
+
+    # Set up for the loop
+    # Note: 2 colon aliases are added by `ifconfig ethn:x:y'
+    #       `ifconfig ethn:x:y:... add ' runs 4 times per a pair of x,y
+    cnt=0
+    x=1 ; y=1 ; xymax=99
+    a=1 ; amax=3
+    ifalias="${lhost_ifname}:${x}:${y}"
+    ifconfig $ifalias ${IPV4_NETWORK}.${x}.${y}.${a} \
+	    netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
+
+    # Make a background TCP traffic from the non-alias address
+   server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+
+    # Start the loop
+    while [ $cnt -lt $IP_TOTAL ]; do
+	if [ $a -gt $amax ]; then
+	    a=1
+	    y=`expr $y + 1`
+	    if [ $y -gt $xymax ]; then
+		y=1
+		x=`expr $x + 1`
+		if [ $x -gt $xymax ]; then
+		    tst_resm TINFO "No more address could be assigned by this script. Finished $cnt times."
+		    break
+		fi
+	    fi
+	    ifalias="${lhost_ifname}:${x}:${y}"
+	    ifconfig $ifalias ${IPV4_NETWORK}.${x}.${y}.${a} \
+			netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
+	fi
+
+	# Create
+	a=`expr $a + 1`
+	ifconfig $ifalias add ${IPV4_NETWORK}.${x}.${y}.${a} \
+		    netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
+	if [ $? -ne 0 ]; then
+	    tst_resm TINFO "It seems $cnt is limit."
+	    break
+	fi
+	ifalias="${ifalias}:0"
+
+	# Check
+	cnt=`expr $cnt + 1`
+	if [ $CHECK_INTERVAL -ne 0 ]; then
+	    if [ `expr $cnt % $CHECK_INTERVAL` -eq 0 ]; then
+		# Check the connectivity from the remote host to
+		# the local host alias.
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname ${IPV4_NETWORK}.${x}.${y}.${a}' ; echo $?'`
+		if [ $ret -ne 0 ]; then
+		    tst_resm TFAIL "The interface ${lhost_ifname} is broken."
+		    return 1
+		fi
+	    fi
+	fi
+
+	# Check the background TCP traffic
+	bg_tcp_traffic check $server_pid
+	if [ $? -ne 0 ]; then
+	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	fi
+    done
+
+    # Stop the background TCP traffic
+    bg_tcp_traffic killall
+
+    # Check the connecitivy from the interface (non-alias)
+    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    if [ $? -ne 0 ]; then
+	tst_resm TFAIL "The interface ${lhost_ifname} is broken."
+	return 1
+    fi
+
+    tst_resm TPASS "Test is finished correctly."
+    return 0
+}
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test02
+#
+# DESCRIPTION:
+#   Creating a large number of IPv4-aliases by `ifconfig ethn:n'
+#
+#-----------------------------------------------------------------------
+test02()
+{
+    TCID=if4-alias-addlarge02
+    TST_COUNT=2
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when 'ifconfig ethn:n' creates $IP_TOTAL IPv4-aliases'"
+
+    # Make sure that no alias exists.
+    initialize_if lhost ${LINK_NUM}
+
+    # Set the non-alias address
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to initialize the interface at the local host"
+	return 1
+    fi
+    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+
+    # Check the connctivity
+    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
+    if [ $ret -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
+	return 1
+    fi
+
+    # Make a background TCP traffic from the non-alias address
+    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+
+    # Start the loop
+    cnt=0
+    x=1 ; y=1 ; xymax=254
+    while [ $cnt -lt $IP_TOTAL ]; do
+	# Create
+	ifalias="${lhost_ifname}:${x}:${y}"
+	ifconfig $ifalias ${IPV4_NETWORK}.0.${x}.${y} \
+		netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
+	if [ $? -ne 0 ]; then
+	    tst_resm TINFO "It seems $cnt is limit."
+	    break
+	fi
+
+
+	# Check the connectivity
+	cnt=`expr $cnt + 1`
+	if [ $CHECK_INTERVAL -ne 0 ]; then
+	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
+		# Check the connectivity from the remote host to
+		# the local host alias.
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname ${IPV4_NETWORK}.0.${x}.${y}'; echo $?'`
+		if [ $ret -ne 0 ]; then
+		    tst_resm TFAIL "The interface ${lhost_ifname} is broken."
+		    return 1
+		fi
+	    fi
+	fi
+
+	# Check the background TCP traffic
+	bg_tcp_traffic check $server_pid
+	if [ $? -ne 0 ]; then
+	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	fi
+
+	# Define next IP and alias
+	y=`expr $y + 1`
+	if [ $y -gt $xymax ]; then
+	    y=1
+	    x=`expr $x + 1`
+	    if [ $x -gt $xymax ]; then
+		tst_resm TINFO "No more address could be assigned by this script. Finished $cnt times."
+		break
+	    fi
+	fi
+    done
+
+    # Stop the background TCP traffic
+    bg_tcp_traffic killall
+
+    # Check the connecitivy from the interface (non-alias)
+    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    if [ $? -ne 0 ]; then
+	tst_resm TFAIL "The interface ${lhost_ifname} is broken."
+	return 1
+    fi
+
+    tst_resm TPASS "Test is finished correctly."
+    return 0
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test03
+#
+# DESCRIPTION:
+#   Creating a large number of IPv4-aliases by ip command
+#
+#-----------------------------------------------------------------------
+test03()
+{
+    TCID=if4-alias-addlarge03
+    TST_COUNT=3
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when ip command creates $IP_TOTAL IPv4-aliases"
+
+    # Make sure that no alias exists.
+    initialize_if lhost ${LINK_NUM}
+
+    # Set the non-alias address
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to initialize the interface at the local host"
+	return 1
+    fi
+    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+
+    # Check the connctivity
+    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
+    if [ $ret -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
+	return 1
+    fi
+
+    # Make a background TCP traffic from the non-alias address
+    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+
+    # Start the loop
+    cnt=0
+    x=1 ; y=1 ; xymax=254
+    while [ $cnt -lt $IP_TOTAL ]; do
+	# Create
+	ip addr add ${IPV4_NETWORK}.1.${x}.${y}/${IPV4_NETMASK_NUM} \
+		broadcast $IPV4_BROADCAST dev ${lhost_ifname}
+	if [ $? -ne 0 ]; then
+	    tst_resm TINFO "It seems $cnt is limit."
+	    break
+	fi
+
+	# Check the connectivity
+	cnt=`expr $cnt + 1`
+	if [ $CHECK_INTERVAL -ne 0 ]; then
+	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
+		# Check the connectivity from the remote host to
+		# the local host alias.
+		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname ${IPV4_NETWORK}.1.${x}.${y}' ; echo $?'`
+		if [ $ret -ne 0 ]; then
+		    tst_resm TFAIL "The interface ${lhost_ifname} is broken."
+		    return 1
+		fi
+	    fi
+	fi
+
+	# Check the background TCP traffic
+	bg_tcp_traffic check $server_pid
+	if [ $? -ne 0 ]; then
+	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	fi
+
+	# Define next IP and alias
+	y=`expr $y + 1`
+	if [ $y -gt $xymax ]; then
+	    y=1
+	    x=`expr $x + 1`
+	    if [ $x -gt $xymax ]; then
+		tst_resm TINFO "No more address could be assigned by this script. Finished $cnt times."
+		break
+	    fi
+	fi
+    done
+
+    # Check the connecitivy from the interface (non-alias)
+    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    if [ $? -ne 0 ]; then
+	tst_resm TFAIL "The interface ${lhost_ifname} is broken."
+	return 1
+    fi
+
+    # Stop the background TCP traffic
+    bg_tcp_traffic killall
+
+    tst_resm TPASS "Test is finished correctly."
+    return 0
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# Main
+#
+# Exit Value:
+#   The number of the failure
+#
+#-----------------------------------------------------------------------
+
+RC=0
+do_setup
+test01 || RC=`expr $RC + 1`
+test02 || RC=`expr $RC + 1`
+test03 || RC=`expr $RC + 1`
+do_cleanup
+
+exit $RC
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
new file mode 100644
index 0000000..f272ebd
--- /dev/null
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -0,0 +1,264 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2005                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+##                                                                            ##
+################################################################################
+#
+# File:
+#   if4-mtu-change
+#
+# Description:
+#   Verify the IPv4 connectivity isn't broken with changing MTU many times
+#    test01 - by ifconfig command
+#    test02 - by ip command
+#
+# Setup:
+#   See ltp-yyyymmdd/testcases/network/stress/README
+#
+# Author:
+#   Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# History:
+#	Oct 19 2005 - Created (Mitsuru Chinen)
+#
+#-----------------------------------------------------------------------
+# Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+# Total number of the test case
+TST_TOTAL=2
+export TST_TOTAL
+
+# Default of the test case ID and the test case count
+TCID=if4-mtu-change
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable for the test
+. check_envval || exit $TST_TOTAL
+
+# The number of the change of the MTU
+MTU_CHANGE_TIMES=${MTU_CHANGE_TIMES:-1000}
+
+# The interval of the change [second]
+CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
+
+# The array of the value which MTU is changed into sequentially
+CHANGE_VALUES="784 1142 426 1500 68 1500 68 748 68 1142 1500"
+
+# The number of the test link where tests run
+LINK_NUM=0
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+
+# Host portion of the IPv4 address
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# local host
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# remote host
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_setup
+#
+# DESCRIPTION:
+#   Make a IPv4 connectivity
+#
+# SET VALUES:
+#   lhost_ipv4addr	- IPv4 Address of the local host
+#   rhost_ipv4addr	- IPv4 Address of the remote host
+#   lhost_ifname	- Interface name of the localhost
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    TCID=if4-mtu-change
+    TST_COUNT=0
+
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Set IPv4 address to the interfaces
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to set an IPv4 address at the local host"
+	exit $TST_TOTAL
+    fi
+    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
+	exit $TST_TOTAL
+    fi
+
+    # IPv4 address of the local and remote host
+    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+
+    # Get the Interface name of local host
+    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+}
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_cleanup
+#
+# DESCRIPTION:
+#   Recover the tested interfaces
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+}
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test_body
+#
+# DESCRIPTION:
+#   main code of the test
+#
+# Arguments:
+#   $1:	define the test type
+#	1 - ifconfig command case
+#	2 - ip command case
+#
+#-----------------------------------------------------------------------
+test_body()
+{
+    test_type=$1
+
+    TCID=if4-mtu-change0${test_type}
+    TST_COUNT=${test_type}
+
+    case $test_type in
+	1)
+	test_command="ifconfig"
+	;;
+	2)
+	test_command="ip"
+	;;
+	*)
+	tst_resm TBROK "unspecified case"
+	return 1
+	;;
+    esac
+
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when $test_command command changes MTU $MTU_CHANGE_TIMES times every $CHANGE_INTERVAL seconds"
+
+    # Check the connctivity
+    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
+	return 1
+    fi
+
+    # Make a background TCP traffic
+    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+
+    # Start the loop
+    mtu_array_len=`echo $CHANGE_VALUES | wc -w`
+    cnt=0
+    while [ $cnt -lt $MTU_CHANGE_TIMES ]; do
+	# Wait CHANGE_INTERVAL seconds
+	sleep $CHANGE_INTERVAL
+
+	# Change
+	nth=`expr $cnt % $mtu_array_len`
+	field=`expr $nth + 1`
+	mtu=`echo $CHANGE_VALUES | cut -d ' ' -f $field`
+
+	case $test_type in
+	    1)
+	    ifconfig $lhost_ifname mtu $mtu
+	    ;;
+	    2)
+	    ip link set $lhost_ifname mtu $mtu
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Failed to change the mtu at $cnt time"
+	    return 1
+	fi
+
+	# Check the background TCP traffic
+	bg_tcp_traffic check $server_pid
+	if [ $? -ne 0 ]; then
+	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	fi
+
+	cnt=`expr $cnt + 1`
+    done
+
+    # Stop the background TCP traffic
+    bg_tcp_traffic killall
+
+    # Check the connectivity again
+    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    if [ $? -ne 0 ]; then
+	tst_resm TFAIL "$lhost_ifname is broken."
+	return 1
+    fi
+    tst_resm TPASS "Test is finished correctly."
+    return 0
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Main
+#
+# Exit Value:
+#   The number of the failure
+#
+#-----------------------------------------------------------------------
+
+RC=0
+do_setup
+test_body 1 || RC=`expr $RC + 1`	# Case of ifconfig command
+test_body 2 || RC=`expr $RC + 1`	# Case of ip command
+do_cleanup
+
+exit $RC
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
new file mode 100644
index 0000000..8adf24f
--- /dev/null
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -0,0 +1,293 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2005                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+##                                                                            ##
+################################################################################
+#
+# File:
+#   if4-route-adddel
+#
+# Description:
+#   Verify the IPv4 connectivity is not broken with adding and deleting
+#   an IPv4 route many times
+#    test01 - by route command
+#    test02 - by ip command
+#
+# Setup:
+#   See ltp-yyyymmdd/testcases/network/stress/README
+#
+# Author:
+#   Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# History:
+#	Oct 19 2005 - Created (Mitsuru Chinen)
+#
+#-----------------------------------------------------------------------
+# Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+# Total number of the test case
+TST_TOTAL=2
+export TST_TOTAL
+
+# Default of the test case ID and the test case count
+TCID=if4-route-adddel
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable
+. check_envval || exit $TST_TOTAL
+
+# The number of the add/delete IPv4 alias
+NS_TIMES=${NS_TIMES:-10000}
+
+# The interval of the check interface activity
+CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $NS_TIMES \/ 100`}
+
+# The number of the test link where tests run
+LINK_NUM=0
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+
+# Netmask of for the tested network
+IPV4_NETMASK="255.255.255.0"
+IPV4_NETMASK_NUM=24
+
+# Broadcast address of the tested network
+IPV4_BROADCAST=${IPV4_NETWORK}.255
+
+# Host portion of the IPv4 address
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+
+# The destination network to add and delete
+ADDDEL_ROUTE="10.10.10.0"
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_setup
+#
+# DESCRIPTION:
+#   Make a IPv4 connectivity
+#
+# SET VALUES:
+#   rhost_ipv4addr	- IPv4 Address of the remote host
+#   lhost_ifname	- Interface name of the local host
+#   rhost_ifname	- Interface name of the remote host
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    TCID=if4-route-adddel
+    TST_COUNT=0
+
+    # Initialize the interfaces of the remote host
+    initialize_if rhost ${LINK_NUM}
+
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Set IPv4 address to the interfaces
+    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to add an IPv4 address the remote host"
+	exit $TST_TOTAL
+    fi
+
+    # IPv4 address of the remote host
+    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+
+    # Get the Interface name of local host
+    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+
+    # Get the Interface name of remote host
+    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the remote host"
+	exit $TST_TOTAL
+    fi
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_cleanup
+#
+# DESCRIPTION:
+#   Recover the tested interfaces
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+}
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test_body
+#
+# DESCRIPTION:
+#   main code of the test
+#
+# Arguments:
+#   $1: define the test type
+#       1 - route command case
+#       2 - ip command case
+#
+#-----------------------------------------------------------------------
+test_body()
+{
+    test_type=$1
+
+    TCID=if4-route-adddel0${test_type}
+    TST_COUNT=$test_type
+
+    case $test_type in
+	1)
+	test_command="route"
+	;;
+	2)
+	test_command="ip"
+	;;
+	*)
+	tst_resm TBROK "unspecified case"
+	return 1
+	;;
+    esac
+
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command adds, then and deletes an IPv4 route $NS_TIMES times"
+
+    # Initialize the interface of the local host
+    initialize_if lhost ${LINK_NUM}
+
+    # Assign IPv4 address to the interface of the local host
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
+	return 1
+    fi
+    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+
+    # Check the connctivity
+    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
+    if [ $ret -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
+	return 1
+    fi
+
+    # Make a background TCP traffic from the non-alias address
+    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+
+    # Start the loop
+    cnt=0
+    while [ $cnt -lt $NS_TIMES ]; do
+	# Add the route
+	case $test_type in
+	    1)
+	    route add -net $ADDDEL_ROUTE netmask $IPV4_NETMASK dev $lhost_ifname
+	    ;;
+	    2)
+	    ip route add ${ADDDEL_ROUTE}/${IPV4_NETMASK_NUM} dev $lhost_ifname
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Failed to add the route to ${ADDDEL_ROUTE}"
+	    return 1
+	fi
+
+	# Check the connectivity
+	cnt=`expr $cnt + 1`
+	if [ $CHECK_INTERVAL -ne 0 ]; then
+	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
+		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+		if [ $? -ne 0 ]; then
+		    tst_resm TFAIL "The route is broken at ${cnt} time"
+		    return 1
+		fi
+	    fi
+	fi
+
+	# Check the background TCP traffic
+	bg_tcp_traffic check $server_pid
+	if [ $? -ne 0 ]; then
+	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	fi
+
+	# Delete the route
+	case $test_type in
+	    1)
+	    route del -net $ADDDEL_ROUTE netmask $IPV4_NETMASK dev $lhost_ifname
+	    ;;
+	    2)
+	    ip route del ${ADDDEL_ROUTE}/${IPV4_NETMASK_NUM} dev $lhost_ifname
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Cannot delte the route to ${ADDDEL_ROUTE}"
+	    return 1
+	fi
+    done
+
+    # Stop the background TCP traffic
+    bg_tcp_traffic killall
+
+    tst_resm TPASS "Test is finished correctly."
+    return 0
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Main
+#
+# Exit Value:
+#   The number of the failure
+#
+#-----------------------------------------------------------------------
+
+RC=0
+do_setup
+test_body 1 || RC=`expr $RC + 1`      # Case of route command
+test_body 2 || RC=`expr $RC + 1`      # Case of ip command
+do_cleanup
+
+exit $RC
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
new file mode 100644
index 0000000..f78a6d6
--- /dev/null
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -0,0 +1,292 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2005                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+##                                                                            ##
+################################################################################
+#
+# File:
+#   if4-route-addlarge
+#
+# Description:
+#   Verify the IPv4 connectivity is not broken with adding a large
+#   number of IPv4 routes
+#     test01 - by route command
+#     test02 - by ip command
+#
+# Setup:
+#   See ltp-yyyymmdd/testcases/network/stress/README
+#
+# Author:
+#   Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# History:
+#	Oct 19 2005 - Created (Mitsuru Chinen)
+#
+#-----------------------------------------------------------------------
+# Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+# Total number of the test case
+TST_TOTAL=2
+export TST_TOTAL
+
+# Default of the test case ID and the test case count
+TCID=if4-route-addlarge
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable
+. check_envval || exit $TST_TOTAL
+
+# The number of the add/delete IPv4 alias
+ROUTE_TOTAL=${ROUTE_TOTAL:-10000}
+
+# The interval of the check interface activity
+CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $ROUTE_TOTAL \/ 100`}
+
+# The number of the test link where tests run
+LINK_NUM=0
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+
+# Netmask of for the tested network
+IPV4_NETMASK="255.255.255.0"
+IPV4_NETMASK_NUM=24
+
+# Network Address of the tested netwrok
+IPV4_NETWORK_ADDR=${IPV4_NETWORK}.0
+
+# Broadcast address of the tested network
+IPV4_BROADCAST=${IPV4_NETWORK}.255
+
+# Host portion of the IPv4 address
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_setup
+#
+# DESCRIPTION:
+#   Make a IPv4 connectivity
+#
+# SET VALUES:
+#   rhost_ipv4addr	- IPv4 Address of the remote host
+#   lhost_ifname	- Interface name of the local host
+#   rhost_ifname	- Interface name of the remote host
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    TCID=if4-route-addlarge
+    TST_COUNT=0
+
+    # Initialize the interfaces of the remote host
+    initialize_if rhost ${LINK_NUM}
+
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Set IPv4 address to the interfaces
+    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
+	exit $TST_TOTAL
+    fi
+
+    # IPv4 address of the remote host
+    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+
+    # Get the Interface name of local host
+    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+
+    # Get the Interface name of remote host
+    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the remote host"
+	exit $TST_TOTAL
+    fi
+}
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_cleanup
+#
+# DESCRIPTION:
+#   Recover the tested interfaces
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Make sure the TCP traffic server/client doesn't run
+    bg_tcp_traffic killall
+
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+}
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test_body
+#
+# DESCRIPTION:
+#   main code of the test
+#
+# Arguments:
+#   $1: define the test type
+#       1 - route command case
+#       2 - ip command case
+#
+#-----------------------------------------------------------------------
+test_body()
+{
+    test_type=$1
+
+    TCID=if4-route-addlarge0${test_type}
+    TST_COUNT=${test_type}
+
+    case $test_type in
+	1)
+	test_command="route"
+	;;
+	2)
+	test_command="ip"
+	;;
+	*)
+	tst_resm TBROK "unspecified case"
+	return 1
+	;;
+    esac
+
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command adds $ROUTE_TOTAL IPv4 routes"
+
+    # Initialize the interface of the local host
+    initialize_if lhost ${LINK_NUM}
+
+    # Assign IPv4 address to the interface of the local host
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	 tst_resm TBROK "Failed to add IPv4 address at the local host"
+	return 1
+    fi
+    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+
+    # Check the connctivity
+    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
+    if [ $ret -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
+	return 1
+    fi
+
+    # Make a background TCP traffic from the non-alias address
+    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+
+    # Start the loop
+    cnt=0
+    x=0 ; y=1 ; xymax=255
+    while [ $cnt -lt $ROUTE_TOTAL ]; do
+	# Add the route
+	case $test_type in
+	    1)
+	    route add -net 10.${x}.${y}.0 netmask 255.255.255.0 dev $lhost_ifname
+	    ;;
+	    2)
+	    ip route add 10.${x}.${y}.0/24 dev $lhost_ifname
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Failed to add a route at $cnt times"
+	    return 1
+	fi
+
+	# Check the connectivity
+	cnt=`expr $cnt + 1`
+	if [ $CHECK_INTERVAL -ne 0 ]; then
+	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
+		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+		if [ $? -ne 0 ]; then
+		    tst_resm TFAIL "The route is broken at ${cnt} time"
+		    return 1
+		fi
+	    fi
+	fi
+
+	# Check the background TCP traffic
+	bg_tcp_traffic check $server_pid
+	if [ $? -ne 0 ]; then
+	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	fi
+
+	# Define the next network address
+	y=`expr $y + 1`
+	if [ $y -gt $xymax ]; then
+	    y=0
+	    x=`expr $x + 1`
+	    if [ $x -gt $xymax ]; then
+		tst_resm INFO "Too large times. Finished $cnt times."
+		break
+	    fi
+	fi
+    done
+
+    # Stop the background TCP traffic
+    bg_tcp_traffic killall
+
+    tst_resm TPASS "Test is finished correctly."
+    return 0
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Main
+#
+# Exit Value:
+#   The number of the failure
+#
+#-----------------------------------------------------------------------
+
+RC=0
+do_setup
+test_body 1 || RC=`expr $RC + 1`	# Case of route command
+test_body 2 || RC=`expr $RC + 1`	# Case of ip command
+do_cleanup
+
+exit $RC
diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
new file mode 100644
index 0000000..90bffaa
--- /dev/null
+++ b/testcases/network/stress/interface/if-updown
@@ -0,0 +1,258 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2005                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+##                                                                            ##
+################################################################################
+#
+# File:
+#   if4-updown
+#
+# Description:
+#   Verify the IPv4 connectivity isn't broken with upping and downing
+#   an interface many times
+#    test01 - by ifconfig command
+#    test02 - by ip command
+#
+# Setup:
+#   See ltp-yyyymmdd/testcases/network/stress/README
+#
+# Author:
+#   Mitsuru Chinen <mitch@jp.ibm.com>
+#
+# History:
+#	Oct 19 2005 - Created (Mitsuru Chinen)
+#
+#-----------------------------------------------------------------------
+# Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+# Total number of the test case
+TST_TOTAL=2
+export TST_TOTAL
+
+# Default of the test case ID and the test case count
+TCID=if4-updown
+TST_COUNT=0
+export TCID
+export TST_COUNT
+
+# Check the environmanet variable
+. check_envval || exit $TST_TOTAL
+
+# The number of the interface up/down in each test case
+IF_UPDOWN_TIMES=${IF_UPDOWN_TIMES:-10000}
+
+# The interval of the check interface activity
+CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $IF_UPDOWN_TIMES \/ 100`}
+
+# The number of the test link where tests run
+LINK_NUM=0
+
+# Network portion of the IPv4 address
+IPV4_NETWORK=${IPV4_NETWORK:-10.0.0}
+
+# Host portion of the IPv4 address
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-2}	# local host
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-1}	# remote host
+
+
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_setup
+#
+# DESCRIPTION:
+#   Make a IPv4 connectivity
+#
+# SET VALUES:
+#   rhost_ipv4addr	- IPv4 Address of the remote host
+#   lhost_ifname	- Interface name of the localhost
+#
+#-----------------------------------------------------------------------
+do_setup()
+{
+    TCID=if4-updown
+    TST_COUNT=0
+
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+
+    # Set IPv4 address to the interfaces
+    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to set an IPv4 address at the local host"
+	exit $TST_TOTAL
+    fi
+    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
+	exit $TST_TOTAL
+    fi
+
+    # IPv4 address of the remote host
+    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+
+    # Get the Interface name of local host
+    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Failed to get the interface name at the local host"
+	exit $TST_TOTAL
+    fi
+}
+
+#-----------------------------------------------------------------------
+#
+# NAME:
+#   do_cleanup
+#
+# DESCRIPTION:
+#   Recover the tested interfaces
+#
+#-----------------------------------------------------------------------
+do_cleanup()
+{
+    # Initialize the interfaces
+    initialize_if lhost ${LINK_NUM}
+    initialize_if rhost ${LINK_NUM}
+}
+
+
+#-----------------------------------------------------------------------
+#
+# FUNCTION:
+#   test_body
+#
+# DESCRIPTION:
+#   main code of the test
+#
+# Arguments:
+#   $1: define the test type
+#       1 - ifconfig command case
+#       2 - ip command case
+#
+#-----------------------------------------------------------------------
+test_body()
+{
+    test_type=$1
+
+    TCID=if4-updown0$test_type
+    TST_COUNT=$test_type
+
+    case $test_type in
+	1)
+	test_command="ifconfig"
+	;;
+	2)
+	test_command="ip"
+	;;
+	*)
+	tst_resm TBROK "unspecified case"
+	return 1
+	;;
+    esac
+
+    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command ups, then downs an interface $IF_UPDOWN_TIMES times"
+
+    # Check the connctivity
+    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    if [ $? -ne 0 ]; then
+	tst_resm TBROK "Test Link $LINK_NUM is something wrong."
+	return 1
+    fi
+
+    # Start the loop
+    cnt=0
+    while [ $cnt -lt $IF_UPDOWN_TIMES ]; do
+	# Down
+	case $test_type in
+	    1)
+	    ifconfig $lhost_ifname down
+	    ;;
+	    2)
+	    ip link set $lhost_ifname down
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Failed to down $lhost_ifname"
+	    return 1
+	fi
+
+	# Up
+	case $test_type in
+	    1)
+	    ifconfig $lhost_ifname up
+	    ;;
+	    2)
+	    ip link set $lhost_ifname up
+	    ;;
+	esac
+	if [ $? -ne 0 ]; then
+	    tst_resm TFAIL "Failed to up $lhost_ifname"
+	    return 1
+	fi
+
+	# Check the connectivity every CHECK_INTERVAL time
+	cnt=`expr $cnt + 1`
+	if [ $CHECK_INTERVAL -ne 0 ]; then
+	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
+		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+		if [ $? -ne 0 ]; then
+		    tst_resm TFAIL "$lhost_ifname is broken at ${cnt} time"
+		    return 1
+		fi
+	    fi
+	fi
+    done
+
+    # Check the connectivity again
+    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+    if [ $? -ne 0 ]; then
+	tst_resm TFAIL "$lhost_ifname is broken."
+	return 1
+    fi
+    tst_resm TPASS "Test is finished successfully."
+
+    return 0
+}
+
+
+#-----------------------------------------------------------------------
+#
+# Main
+#
+# Exit Value:
+#   The number of the failure
+#
+#-----------------------------------------------------------------------
+
+RC=0
+do_setup
+test_body 1 || RC=`expr $RC + 1`      # Case of ifconfig command
+test_body 2 || RC=`expr $RC + 1`      # Case of ip command
+do_cleanup
+
+exit $RC
diff --git a/testcases/network/stress/interface/if4-alias-adddel b/testcases/network/stress/interface/if4-alias-adddel
deleted file mode 100644
index 4e6e4d6..0000000
--- a/testcases/network/stress/interface/if4-alias-adddel
+++ /dev/null
@@ -1,326 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
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
-#   if4-alias-adddel
-#
-# Description:
-#   Verify the IPv4 connectivity isn't broken with adding and deleting an
-#   IPv4 alias many times
-#    test01 - by `ifconfig add' style
-#    test02 - by `ifconfig ethn:n' style
-#    test03 - by ip command
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=3
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=if4-alias-adddel
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of the add/delete IPv4 alias
-NS_TIMES=${NS_TIMES:-10000}
-
-# The interval of the check interface activity
-CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $NS_TIMES \/ 100`}
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of for the tested network
-IPV4_NETMASK="255.255.255.0"
-IPV4_NETMASK_NUM=24
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
-# Host portion of the IPv4 address of the remote host
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-
-# Host portion of the non-alias
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"254"}
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=if4-alias-adddel
-    TST_COUNT=0
-
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Configure the interface at the remote host
-    initialize_if rhost ${LINK_NUM}
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to initialize the interface at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the remote host
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#	1 - `ifconfig add' style
-#	2 - `ifconfig ethn:n' style
-#	3 - ip command
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=if4-alias-adddel0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)	# Case of ifconfig add
-	command_style="'ifconfig add'"
-	;;
-	2)	# Case of ifconfig ethn:n
-	command_style="'ifconfig ethn:n'"
-	;;
-	3)	# Case of ip command
-	command_style="ip command"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when $command_style adds, then deletes an IPv4 alias $NS_TIMES times"
-
-    # Make sure that no alias exists.
-    initialize_if lhost ${LINK_NUM}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to initialize the interface at the local host"
-	return 1
-    fi
-
-    # Set the non-alias address
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address to the interface at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # IPv4 alias address of the localhost
-    lhost_ipv4_alias_ip=${IPV4_NETWORK}.${test_type}${test_type}
-
-    # The interface alias of local host
-    case $test_type in
-	1)	# Case of ifconfig add
-	lhost_ifalias=${lhost_ifname}:0
-	;;
-	2)	# Case of ifconfig ethn:n
-	lhost_ifalias=${lhost_ifname}:1
-	;;
-	# interface alias doesn't exist at ip command case.
-    esac
-
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Create
-	case $test_type in
-	    1)		# Case of ifconfig add
-	    ifconfig $lhost_ifname add ${lhost_ipv4_alias_ip} netmask ${IPV4_NETMASK} broadcast ${IPV4_BROADCAST}
-	    ;;
-	    2)		# Case of ifconfig ethn:n
-	    ifconfig $lhost_ifalias ${lhost_ipv4_alias_ip} netmask ${IPV4_NETMASK} broadcast ${IPV4_BROADCAST}
-	    ;;
-	    3)		# Case of ip command
-	    ip addr add ${lhost_ipv4_alias_ip}/${IPV4_NETMASK_NUM} broadcast ${IPV4_BROADCAST} dev ${lhost_ifname}
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to add ${lhost_ipv4_alias_ip}".
-	    return 1
-	fi
-
-	# Check the connectivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		if [ $test_type -ne 3 ]; then
-		    # Case of ifconfig add / ifconfig ethn:n
-		    check_icmpv4_connectivity $lhost_ifalias $rhost_ipv4addr
-		else
-		    # Case of ip command
-		    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-		fi
-		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "$lhost_ifname is broken."
-		    return 1
-		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
-
-	# Delete
-	case $test_type in
-	    1)		# Case of ifconfig add
-	    ifconfig $lhost_ifalias del ${lhost_ipv4_alias_ip}
-	    ;;
-	    2)		# Case of ifconfig ethn:n
-	    ifconfig ${lhost_ifalias} down
-	    ;;
-	    3)		# Case of ip command
-	    ip addr del ${lhost_ipv4_alias_ip}/${IPV4_NETMASK_NUM} broadcast ${IPV4_BROADCAST} dev ${lhost_ifname}
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to delete ${lhost_ipv4_alias_ip}".
-	    return 1
-	fi
-    done
-
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`	# Case of ifconfig add
-test_body 2 || RC=`expr $RC + 1`	# Case of ifconfig ethn:n
-test_body 3 || RC=`expr $RC + 1`	# Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/interface/if4-alias-addlarge b/testcases/network/stress/interface/if4-alias-addlarge
deleted file mode 100644
index 13efe84..0000000
--- a/testcases/network/stress/interface/if4-alias-addlarge
+++ /dev/null
@@ -1,481 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
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
-#   if4-alias-addlarge
-#
-# Description:
-#   Verify the IPv4 connectivity isn't broken with creating a large number
-#   of IPv4-aliases
-#    test01 - by `ifconfig add' style
-#    test02 - by `ifconfig ethn:n' style
-#    test03 - by ip command
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=3
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=if4-alias-addlarge
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of the add IPv4 alias
-IP_TOTAL=${IP_TOTAL:-10000}
-
-# The interval of the check interface activity
-CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $IP_TOTAL \/ 100`}
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10"}
-
-# Netmask of for the tested network
-IPV4_NETMASK="255.0.0.0"
-IPV4_NETMASK_NUM=8
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255.255.255
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"0.0.2"}
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"0.0.1"}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the local host
-#   rhost_ipv4addr	- IP address of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=if4-alias-addlarge
-    TST_COUNT=0
-
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Initialize the interface at the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv4 address to the interface at the remote host
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv4 address at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface names
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the remote host
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test01
-#
-# DESCRIPTION:
-#   Creating a large number of IPv4-aliases by `ifconfig add'
-#
-#-----------------------------------------------------------------------
-test01()
-{
-    TCID=if4-alias-addlarge01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when 'ifconifg add' creates $IP_TOTAL IPv4-aliases."
-
-    # Make sure that no alias exists.
-    initialize_if lhost ${LINK_NUM}
-
-    # Set the non-alias address
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add IPv4 address to the interface at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Set up for the loop
-    # Note: 2 colon aliases are added by `ifconfig ethn:x:y'
-    #       `ifconfig ethn:x:y:... add ' runs 4 times per a pair of x,y
-    cnt=0
-    x=1 ; y=1 ; xymax=99
-    a=1 ; amax=3
-    ifalias="${lhost_ifname}:${x}:${y}"
-    ifconfig $ifalias ${IPV4_NETWORK}.${x}.${y}.${a} \
-	    netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
-
-    # Make a background TCP traffic from the non-alias address
-   server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-
-    # Start the loop
-    while [ $cnt -lt $IP_TOTAL ]; do
-	if [ $a -gt $amax ]; then
-	    a=1
-	    y=`expr $y + 1`
-	    if [ $y -gt $xymax ]; then
-		y=1
-		x=`expr $x + 1`
-		if [ $x -gt $xymax ]; then
-		    tst_resm TINFO "No more address could be assigned by this script. Finished $cnt times."
-		    break
-		fi
-	    fi
-	    ifalias="${lhost_ifname}:${x}:${y}"
-	    ifconfig $ifalias ${IPV4_NETWORK}.${x}.${y}.${a} \
-			netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
-	fi
-
-	# Create
-	a=`expr $a + 1`
-	ifconfig $ifalias add ${IPV4_NETWORK}.${x}.${y}.${a} \
-		    netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
-	if [ $? -ne 0 ]; then
-	    tst_resm TINFO "It seems $cnt is limit."
-	    break
-	fi
-	ifalias="${ifalias}:0"
-
-	# Check
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % $CHECK_INTERVAL` -eq 0 ]; then
-		# Check the connectivity from the remote host to
-		# the local host alias.
-		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname ${IPV4_NETWORK}.${x}.${y}.${a}' ; echo $?'`
-		if [ $ret -ne 0 ]; then
-		    tst_resm TFAIL "The interface ${lhost_ifname} is broken."
-		    return 1
-		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
-    done
-
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
-
-    # Check the connecitivy from the interface (non-alias)
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "The interface ${lhost_ifname} is broken."
-	return 1
-    fi
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test02
-#
-# DESCRIPTION:
-#   Creating a large number of IPv4-aliases by `ifconfig ethn:n'
-#
-#-----------------------------------------------------------------------
-test02()
-{
-    TCID=if4-alias-addlarge02
-    TST_COUNT=2
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when 'ifconfig ethn:n' creates $IP_TOTAL IPv4-aliases'"
-
-    # Make sure that no alias exists.
-    initialize_if lhost ${LINK_NUM}
-
-    # Set the non-alias address
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to initialize the interface at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-
-    # Start the loop
-    cnt=0
-    x=1 ; y=1 ; xymax=254
-    while [ $cnt -lt $IP_TOTAL ]; do
-	# Create
-	ifalias="${lhost_ifname}:${x}:${y}"
-	ifconfig $ifalias ${IPV4_NETWORK}.0.${x}.${y} \
-		netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
-	if [ $? -ne 0 ]; then
-	    tst_resm TINFO "It seems $cnt is limit."
-	    break
-	fi
-
-
-	# Check the connectivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		# Check the connectivity from the remote host to
-		# the local host alias.
-		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname ${IPV4_NETWORK}.0.${x}.${y}'; echo $?'`
-		if [ $ret -ne 0 ]; then
-		    tst_resm TFAIL "The interface ${lhost_ifname} is broken."
-		    return 1
-		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
-
-	# Define next IP and alias
-	y=`expr $y + 1`
-	if [ $y -gt $xymax ]; then
-	    y=1
-	    x=`expr $x + 1`
-	    if [ $x -gt $xymax ]; then
-		tst_resm TINFO "No more address could be assigned by this script. Finished $cnt times."
-		break
-	    fi
-	fi
-    done
-
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
-
-    # Check the connecitivy from the interface (non-alias)
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "The interface ${lhost_ifname} is broken."
-	return 1
-    fi
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test03
-#
-# DESCRIPTION:
-#   Creating a large number of IPv4-aliases by ip command
-#
-#-----------------------------------------------------------------------
-test03()
-{
-    TCID=if4-alias-addlarge03
-    TST_COUNT=3
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when ip command creates $IP_TOTAL IPv4-aliases"
-
-    # Make sure that no alias exists.
-    initialize_if lhost ${LINK_NUM}
-
-    # Set the non-alias address
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to initialize the interface at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-
-    # Start the loop
-    cnt=0
-    x=1 ; y=1 ; xymax=254
-    while [ $cnt -lt $IP_TOTAL ]; do
-	# Create
-	ip addr add ${IPV4_NETWORK}.1.${x}.${y}/${IPV4_NETMASK_NUM} \
-		broadcast $IPV4_BROADCAST dev ${lhost_ifname}
-	if [ $? -ne 0 ]; then
-	    tst_resm TINFO "It seems $cnt is limit."
-	    break
-	fi
-
-	# Check the connectivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		# Check the connectivity from the remote host to
-		# the local host alias.
-		ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname ${IPV4_NETWORK}.1.${x}.${y}' ; echo $?'`
-		if [ $ret -ne 0 ]; then
-		    tst_resm TFAIL "The interface ${lhost_ifname} is broken."
-		    return 1
-		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
-
-	# Define next IP and alias
-	y=`expr $y + 1`
-	if [ $y -gt $xymax ]; then
-	    y=1
-	    x=`expr $x + 1`
-	    if [ $x -gt $xymax ]; then
-		tst_resm TINFO "No more address could be assigned by this script. Finished $cnt times."
-		break
-	    fi
-	fi
-    done
-
-    # Check the connecitivy from the interface (non-alias)
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "The interface ${lhost_ifname} is broken."
-	return 1
-    fi
-
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test01 || RC=`expr $RC + 1`
-test02 || RC=`expr $RC + 1`
-test03 || RC=`expr $RC + 1`
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/interface/if4-mtu-change b/testcases/network/stress/interface/if4-mtu-change
deleted file mode 100644
index f272ebd..0000000
--- a/testcases/network/stress/interface/if4-mtu-change
+++ /dev/null
@@ -1,264 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
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
-#   if4-mtu-change
-#
-# Description:
-#   Verify the IPv4 connectivity isn't broken with changing MTU many times
-#    test01 - by ifconfig command
-#    test02 - by ip command
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=if4-mtu-change
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable for the test
-. check_envval || exit $TST_TOTAL
-
-# The number of the change of the MTU
-MTU_CHANGE_TIMES=${MTU_CHANGE_TIMES:-1000}
-
-# The interval of the change [second]
-CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
-
-# The array of the value which MTU is changed into sequentially
-CHANGE_VALUES="784 1142 426 1500 68 1500 68 748 68 1142 1500"
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}	# local host
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}	# remote host
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   lhost_ipv4addr	- IPv4 Address of the local host
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the localhost
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=if4-mtu-change
-    TST_COUNT=0
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set an IPv4 address at the local host"
-	exit $TST_TOTAL
-    fi
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the local and remote host
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1:	define the test type
-#	1 - ifconfig command case
-#	2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=if4-mtu-change0${test_type}
-    TST_COUNT=${test_type}
-
-    case $test_type in
-	1)
-	test_command="ifconfig"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when $test_command command changes MTU $MTU_CHANGE_TIMES times every $CHANGE_INTERVAL seconds"
-
-    # Check the connctivity
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Make a background TCP traffic
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-
-    # Start the loop
-    mtu_array_len=`echo $CHANGE_VALUES | wc -w`
-    cnt=0
-    while [ $cnt -lt $MTU_CHANGE_TIMES ]; do
-	# Wait CHANGE_INTERVAL seconds
-	sleep $CHANGE_INTERVAL
-
-	# Change
-	nth=`expr $cnt % $mtu_array_len`
-	field=`expr $nth + 1`
-	mtu=`echo $CHANGE_VALUES | cut -d ' ' -f $field`
-
-	case $test_type in
-	    1)
-	    ifconfig $lhost_ifname mtu $mtu
-	    ;;
-	    2)
-	    ip link set $lhost_ifname mtu $mtu
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to change the mtu at $cnt time"
-	    return 1
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
-
-	cnt=`expr $cnt + 1`
-    done
-
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
-
-    # Check the connectivity again
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "$lhost_ifname is broken."
-	return 1
-    fi
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`	# Case of ifconfig command
-test_body 2 || RC=`expr $RC + 1`	# Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/interface/if4-route-adddel b/testcases/network/stress/interface/if4-route-adddel
deleted file mode 100644
index 8adf24f..0000000
--- a/testcases/network/stress/interface/if4-route-adddel
+++ /dev/null
@@ -1,293 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
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
-#   if4-route-adddel
-#
-# Description:
-#   Verify the IPv4 connectivity is not broken with adding and deleting
-#   an IPv4 route many times
-#    test01 - by route command
-#    test02 - by ip command
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=if4-route-adddel
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of the add/delete IPv4 alias
-NS_TIMES=${NS_TIMES:-10000}
-
-# The interval of the check interface activity
-CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $NS_TIMES \/ 100`}
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of for the tested network
-IPV4_NETMASK="255.255.255.0"
-IPV4_NETMASK_NUM=24
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-
-# The destination network to add and delete
-ADDDEL_ROUTE="10.10.10.0"
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=if4-route-adddel
-    TST_COUNT=0
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add an IPv4 address the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the remote host
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=if4-route-adddel0${test_type}
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command adds, then and deletes an IPv4 route $NS_TIMES times"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Add the route
-	case $test_type in
-	    1)
-	    route add -net $ADDDEL_ROUTE netmask $IPV4_NETMASK dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route add ${ADDDEL_ROUTE}/${IPV4_NETMASK_NUM} dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to add the route to ${ADDDEL_ROUTE}"
-	    return 1
-	fi
-
-	# Check the connectivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "The route is broken at ${cnt} time"
-		    return 1
-		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
-
-	# Delete the route
-	case $test_type in
-	    1)
-	    route del -net $ADDDEL_ROUTE netmask $IPV4_NETMASK dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route del ${ADDDEL_ROUTE}/${IPV4_NETMASK_NUM} dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delte the route to ${ADDDEL_ROUTE}"
-	    return 1
-	fi
-    done
-
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/interface/if4-route-addlarge b/testcases/network/stress/interface/if4-route-addlarge
deleted file mode 100644
index f78a6d6..0000000
--- a/testcases/network/stress/interface/if4-route-addlarge
+++ /dev/null
@@ -1,292 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
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
-#   if4-route-addlarge
-#
-# Description:
-#   Verify the IPv4 connectivity is not broken with adding a large
-#   number of IPv4 routes
-#     test01 - by route command
-#     test02 - by ip command
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=if4-route-addlarge
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of the add/delete IPv4 alias
-ROUTE_TOTAL=${ROUTE_TOTAL:-10000}
-
-# The interval of the check interface activity
-CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $ROUTE_TOTAL \/ 100`}
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-
-# Netmask of for the tested network
-IPV4_NETMASK="255.255.255.0"
-IPV4_NETMASK_NUM=24
-
-# Network Address of the tested netwrok
-IPV4_NETWORK_ADDR=${IPV4_NETWORK}.0
-
-# Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the local host
-#   rhost_ifname	- Interface name of the remote host
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=if4-route-addlarge
-    TST_COUNT=0
-
-    # Initialize the interfaces of the remote host
-    initialize_if rhost ${LINK_NUM}
-
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the remote host
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-
-    # Get the Interface name of remote host
-    rhost_ifname=`get_ifname rhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the remote host"
-	exit $TST_TOTAL
-    fi
-}
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - route command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=if4-route-addlarge0${test_type}
-    TST_COUNT=${test_type}
-
-    case $test_type in
-	1)
-	test_command="route"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command adds $ROUTE_TOTAL IPv4 routes"
-
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
-
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	 tst_resm TBROK "Failed to add IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
-
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-
-    # Start the loop
-    cnt=0
-    x=0 ; y=1 ; xymax=255
-    while [ $cnt -lt $ROUTE_TOTAL ]; do
-	# Add the route
-	case $test_type in
-	    1)
-	    route add -net 10.${x}.${y}.0 netmask 255.255.255.0 dev $lhost_ifname
-	    ;;
-	    2)
-	    ip route add 10.${x}.${y}.0/24 dev $lhost_ifname
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to add a route at $cnt times"
-	    return 1
-	fi
-
-	# Check the connectivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "The route is broken at ${cnt} time"
-		    return 1
-		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
-
-	# Define the next network address
-	y=`expr $y + 1`
-	if [ $y -gt $xymax ]; then
-	    y=0
-	    x=`expr $x + 1`
-	    if [ $x -gt $xymax ]; then
-		tst_resm INFO "Too large times. Finished $cnt times."
-		break
-	    fi
-	fi
-    done
-
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
-
-    tst_resm TPASS "Test is finished correctly."
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`	# Case of route command
-test_body 2 || RC=`expr $RC + 1`	# Case of ip command
-do_cleanup
-
-exit $RC
diff --git a/testcases/network/stress/interface/if4-updown b/testcases/network/stress/interface/if4-updown
deleted file mode 100644
index 90bffaa..0000000
--- a/testcases/network/stress/interface/if4-updown
+++ /dev/null
@@ -1,258 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
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
-#   if4-updown
-#
-# Description:
-#   Verify the IPv4 connectivity isn't broken with upping and downing
-#   an interface many times
-#    test01 - by ifconfig command
-#    test02 - by ip command
-#
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
-TST_TOTAL=2
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
-TCID=if4-updown
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# The number of the interface up/down in each test case
-IF_UPDOWN_TIMES=${IF_UPDOWN_TIMES:-10000}
-
-# The interval of the check interface activity
-CHECK_INTERVAL=${CHECK_INTERVAL:-`expr $IF_UPDOWN_TIMES \/ 100`}
-
-# The number of the test link where tests run
-LINK_NUM=0
-
-# Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-10.0.0}
-
-# Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-2}	# local host
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-1}	# remote host
-
-
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the localhost
-#
-#-----------------------------------------------------------------------
-do_setup()
-{
-    TCID=if4-updown
-    TST_COUNT=0
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set an IPv4 address at the local host"
-	exit $TST_TOTAL
-    fi
-    set_ipv4addr rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to set an IPv4 address at the remote host"
-	exit $TST_TOTAL
-    fi
-
-    # IPv4 address of the remote host
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
-
-    # Get the Interface name of local host
-    lhost_ifname=`get_ifname lhost ${LINK_NUM}`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to get the interface name at the local host"
-	exit $TST_TOTAL
-    fi
-}
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_cleanup
-#
-# DESCRIPTION:
-#   Recover the tested interfaces
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test_body
-#
-# DESCRIPTION:
-#   main code of the test
-#
-# Arguments:
-#   $1: define the test type
-#       1 - ifconfig command case
-#       2 - ip command case
-#
-#-----------------------------------------------------------------------
-test_body()
-{
-    test_type=$1
-
-    TCID=if4-updown0$test_type
-    TST_COUNT=$test_type
-
-    case $test_type in
-	1)
-	test_command="ifconfig"
-	;;
-	2)
-	test_command="ip"
-	;;
-	*)
-	tst_resm TBROK "unspecified case"
-	return 1
-	;;
-    esac
-
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command ups, then downs an interface $IF_UPDOWN_TIMES times"
-
-    # Check the connctivity
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is something wrong."
-	return 1
-    fi
-
-    # Start the loop
-    cnt=0
-    while [ $cnt -lt $IF_UPDOWN_TIMES ]; do
-	# Down
-	case $test_type in
-	    1)
-	    ifconfig $lhost_ifname down
-	    ;;
-	    2)
-	    ip link set $lhost_ifname down
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to down $lhost_ifname"
-	    return 1
-	fi
-
-	# Up
-	case $test_type in
-	    1)
-	    ifconfig $lhost_ifname up
-	    ;;
-	    2)
-	    ip link set $lhost_ifname up
-	    ;;
-	esac
-	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Failed to up $lhost_ifname"
-	    return 1
-	fi
-
-	# Check the connectivity every CHECK_INTERVAL time
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "$lhost_ifname is broken at ${cnt} time"
-		    return 1
-		fi
-	    fi
-	fi
-    done
-
-    # Check the connectivity again
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "$lhost_ifname is broken."
-	return 1
-    fi
-    tst_resm TPASS "Test is finished successfully."
-
-    return 0
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
-
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of ifconfig command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
-
-exit $RC
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
