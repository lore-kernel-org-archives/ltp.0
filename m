Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzd-0004cq-RZ
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:09 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzb-0004mU-PH
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:09 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC51eU000356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:05:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC508v001694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:05:00 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t1DC50eu024172
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:05:00 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:07 +0300
Message-Id: <1423829229-28963-9-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 9/11] network/stress/interface: cleanup 'route' group
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

* use if-lib.sh, test_net.sh libraries;
* add routes from IPV4_NET16_UNUSED, IPV6_NET32_UNUSED networks

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if-route-adddel |  330 ++++---------------
 .../network/stress/interface/if-route-addlarge     |  339 +++++---------------
 2 files changed, 149 insertions(+), 520 deletions(-)

diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index 8adf24f..650ab22 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -1,293 +1,99 @@
 #!/bin/sh
 
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
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2005
 #
-# File:
-#   if4-route-adddel
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the IPv4 connectivity is not broken with adding and deleting
-#   an IPv4 route many times
-#    test01 - by route command
-#    test02 - by ip command
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
 TST_TOTAL=2
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
+TCID=if-route-adddel
 
+. if-lib.sh
 
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 100))}
 
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
 test_body()
 {
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
+	local cmd_type=$1
 
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command adds, then and deletes an IPv4 route $NS_TIMES times"
+	case $cmd_type in
+	rt_cmd) local cmd_name='route' ;;
+	ip_cmd) local cmd_name='ip' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	esac
 
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
+	local iface=$(tst_iface)
+	local inet="inet$TST_IPV6"
+	local new_rt=
+	local opt_rt=
+	if [ "$TST_IPV6" ]; then
+		new_rt=${IPV6_NET32_UNUSED}::
+		opt_rt="/64"
+	else
+		new_rt="${IPV4_NET16_UNUSED}.23.0"
+		case $cmd_type in
+		rt_cmd) ;;
+		ip_cmd) opt_rt='/24' ;;
+		esac
+	fi
 
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+	tst_resm TINFO "'$cmd_name' add/del ${new_rt}${opt_rt} $NS_TIMES times"
 
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
+	tst_restore_ipaddr || \
+		tst_resm TBROK "Failed to set default IP addresses"
 
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	make_background_tcp_traffic
 
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
+	local cnt=1
+	while [ $cnt -le $NS_TIMES ]; do
+		case $cmd_type in
+		rt_cmd) route -A $inet add ${new_rt}${opt_rt} dev $iface ;;
+		ip_cmd) ip route add ${new_rt}${opt_rt} dev $iface ;;
+		esac
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "Can't add route $new_rt to $iface"
+			return
+		fi
 
-	# Check the connectivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+		case $cmd_type in
+		rt_cmd) route -A $inet del ${new_rt}${opt_rt} dev $iface ;;
+		ip_cmd) ip route del ${new_rt}${opt_rt} dev $iface ;;
+		esac
 		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "The route is broken at ${cnt} time"
-		    return 1
+			tst_resm TFAIL "Can't del route $new_rt from $iface"
+			return
 		fi
-	    fi
-	fi
 
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
+		check_connectivity $cnt || return
 
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
+		# Check the background TCP traffic
+		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
 
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
+		cnt=$(($cnt + 1))
+	done
 
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	tst_resm TPASS "Test is finished correctly"
 }
 
+setup
 
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
+tst_check_cmds route
 
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`      # Case of route command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
-do_cleanup
+test_body 'rt_cmd'
+test_body 'ip_cmd'
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index f78a6d6..678a6a5 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -1,292 +1,115 @@
 #!/bin/sh
 
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
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2005
 #
-# File:
-#   if4-route-addlarge
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the IPv4 connectivity is not broken with adding a large
-#   number of IPv4 routes
-#     test01 - by route command
-#     test02 - by ip command
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Setup:
-#   See ltp-yyyymmdd/testcases/network/stress/README
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
-
-# Total number of the test case
 TST_TOTAL=2
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
+TCID=if-route-addlarge
+TST_CLEANUP="cleanup"
 
+. if-lib.sh
 
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
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 100))}
 
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
 test_body()
 {
-    test_type=$1
+	local cmd_type=$1
 
-    TCID=if4-route-addlarge0${test_type}
-    TST_COUNT=${test_type}
+	case $cmd_type in
+	rt_cmd) local cmd_name='route' ;;
+	ip_cmd) local cmd_name='ip' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	esac
 
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
+	local iface=$(tst_iface)
+	local inet="inet$TST_IPV6"
+	local opt_rt=
+	if [ "$TST_IPV6" ]; then
+		opt_rt="/64"
+	else
+		case $cmd_type in
+		rt_cmd) ;;
+		ip_cmd) opt_rt='/32' ;;
+		esac
+	fi
 
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the $test_command command adds $ROUTE_TOTAL IPv4 routes"
+	tst_resm TINFO "'$cmd_name' add IPv$ipver $ROUTE_TOTAL routes"
 
-    # Initialize the interface of the local host
-    initialize_if lhost ${LINK_NUM}
+	tst_restore_ipaddr || \
+		tst_resm TBROK "Failed to set default IP addresses"
 
-    # Assign IPv4 address to the interface of the local host
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	 tst_resm TBROK "Failed to add IPv4 address at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+	make_background_tcp_traffic
 
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
+	local x=1
+	local y=1
+	local cnt=1
 
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+	[ "$TST_IPV6" ] && local xymax=65535 || xymax=254
 
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
+	if [ $ROUTE_TOTAL -gt $((xymax * xymax)) ]; then
+		tst_resm TWARN "set ROUTE_TOTAL to $xymax * $xymax"
+		ROUTE_TOTAL=$((xymax * xymax))
 	fi
 
-	# Check the connectivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+	while [ $cnt -le $ROUTE_TOTAL ]; do
+
+		if [ "$TST_IPV6" ]; then
+			local hex_x=$(printf '%x' $x)
+			local hex_y=$(printf '%x' $y)
+			local new_rt=${IPV6_NET32_UNUSED}:$hex_x:$hex_y::
+		else
+			local new_rt=${IPV4_NET16_UNUSED}.$x.$y
+		fi
+
+		case $cmd_type in
+		rt_cmd) route -A $inet add ${new_rt}${opt_rt} dev $iface ;;
+		ip_cmd) ip route add ${new_rt}${opt_rt} dev $iface ;;
+		esac
 		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "The route is broken at ${cnt} time"
-		    return 1
+			tst_resm TFAIL "Can't add route $new_rt to $iface"
+			return
 		fi
-	    fi
-	fi
 
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
+		check_connectivity $cnt || return
 
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
+		# Check the background TCP traffic
+		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
 
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
+		cnt=$(($cnt + 1))
+		y=$(($y + 1))
+		if [ $y -gt $xymax ]; then
+			y=1
+			x=$(($x + 1))
+			if [ $x -gt $xymax ]; then
+				tst_brkm TBROK "Too large $ROUTE_TOTAL"
+			fi
+		fi
+	done
 
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	tst_resm TPASS "Test is finished correctly"
 }
 
+setup
 
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
+tst_check_cmds route
 
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`	# Case of route command
-test_body 2 || RC=`expr $RC + 1`	# Case of ip command
-do_cleanup
+test_body 'rt_cmd'
+test_body 'ip_cmd'
 
-exit $RC
+tst_exit
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
