Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzY-0002d7-TT
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzS-0005ha-Qh
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:04 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4rUa030786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:53 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t1DC4q5i013116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:53 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4qH9023409
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:52 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:05 +0300
Message-Id: <1423829229-28963-7-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 7/11] network/stress/interface: cleanup 'addr' group
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

Use if-lib.sh, test_net.sh libraries

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if-addr-adddel  |  382 ++++----------
 .../network/stress/interface/if-addr-addlarge      |  556 ++++----------------
 2 files changed, 201 insertions(+), 737 deletions(-)

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 4e6e4d6..4fd72da 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -1,326 +1,124 @@
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
-#   if4-alias-adddel
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the IPv4 connectivity isn't broken with adding and deleting an
-#   IPv4 alias many times
-#    test01 - by `ifconfig add' style
-#    test02 - by `ifconfig ethn:n' style
-#    test03 - by ip command
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
+TST_TOTAL=2
+TCID=if-addr-adddel
 
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
+. if-lib.sh
 
-    # IPv4 address of the remote host
-    rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+# The interval of the check interface activity (check ten times)
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 100))}
 
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
+test_body()
 {
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
+	local cmd_type=$1
 
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
+	case $cmd_type in
+	if_cmd) local cmd_name='ifconfig' ;;
+	ip_cmd) local cmd_name='ip' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	esac
 
+	local num=$(($(od -A n -d -N 1 /dev/random) * 253 / 255 + 2 ))
+	local iface=$(tst_iface)
+	if [ "$TST_IPV6" ]; then
+		local new_ip=${IPV6_NET32_UNUSED}::$num
+		local netmask=64
+	else
+		local new_ip=${IPV4_NET16_UNUSED}.1.$num
+		local netmask=24
+	fi
 
+	tst_resm TINFO "'$cmd_name' add/del IPv$ipver '$new_ip' $NS_TIMES times"
 
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
+	tst_restore_ipaddr || \
+		tst_resm TBROK "Failed to set default IP addresses"
 
-    TCID=if4-alias-adddel0${test_type}
-    TST_COUNT=$test_type
+	make_background_tcp_traffic
 
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
+	local cnt=1
+	while [ $cnt -le $NS_TIMES ]; do
 
-    # Make sure that no alias exists.
-    initialize_if lhost ${LINK_NUM}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to initialize the interface at the local host"
-	return 1
-    fi
+		case $cmd_type in
+		if_cmd)
+			if [ "$TST_IPV6" ]; then
+				ifconfig $iface add $new_ip/$netmask
+			else
+				ifconfig $iface:1 $new_ip netmask 255.255.255.0
+			fi
+		;;
+		ip_cmd) ip addr add $new_ip/$netmask dev $iface ;;
+		esac
 
-    # Set the non-alias address
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to assign an IPv4 address to the interface at the local host"
-	return 1
-    fi
-    lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "command failed to add $new_ip to $iface"
+			return
+		fi
 
-    # Check the connctivity
-    ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_ipv4addr' ; echo $?'`
-    if [ $ret -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
+		ip addr show $iface | grep -q $new_ip
+		if [ $? -ne 0 ]; then
+			ip addr show $iface
+			tst_resm TFAIL "$new_ip not configured"
+			return
+		fi
 
-    # IPv4 alias address of the localhost
-    lhost_ipv4_alias_ip=${IPV4_NETWORK}.${test_type}${test_type}
+		check_connectivity $cnt || return
 
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
+		cnt=$(($cnt + 1))
 
-    # Make a background TCP traffic from the non-alias address
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+		# Check the background TCP traffic
+		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
 
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
+		case $cmd_type in
+		if_cmd)
+			if [ "$TST_IPV6" ]; then
+				ifconfig $iface del $new_ip/$netmask
+			else
+				ifconfig $iface:1 down
+			fi
+		;;
+		ip_cmd) ip addr del $new_ip/$netmask dev $iface ;;
+		esac
 
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
 		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "$lhost_ifname is broken."
-		    return 1
+			tst_resm TFAIL " delete command failed".
+			return
 		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
 
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
+		ip addr show $iface | grep -q $new_ip
+		if [ $? -eq 0 ]; then
+			ip addr show $iface
+			tst_resm TFAIL "Failed to remove '$new_ip' address"
+			return
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
+tst_check_cmds ifconfig
 
-RC=0
-do_setup
-test_body 1 || RC=`expr $RC + 1`	# Case of ifconfig add
-test_body 2 || RC=`expr $RC + 1`	# Case of ifconfig ethn:n
-test_body 3 || RC=`expr $RC + 1`	# Case of ip command
-do_cleanup
+test_body 'if_cmd'
+test_body 'ip_cmd'
 
-exit $RC
+tst_exit
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index 13efe84..fb41683 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -1,481 +1,147 @@
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
-#   if4-alias-addlarge
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the IPv4 connectivity isn't broken with creating a large number
-#   of IPv4-aliases
-#    test01 - by `ifconfig add' style
-#    test02 - by `ifconfig ethn:n' style
-#    test03 - by ip command
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
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
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
+TST_TOTAL=2
+TCID=if-addr-addlarge
 
+. if-lib.sh
 
+# The interval of the check interface activity (check ten times)
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 100))}
 
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
+test_body()
 {
-    # Make sure the TCP traffic server/client doesn't run
-    bg_tcp_traffic killall
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
+	local cmd_type=$1
 
+	case $cmd_type in
+	if_cmd) local cmd_name='ifconfig' ;;
+	ip_cmd) local cmd_name='ip' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	esac
 
+	local iface=$(tst_iface)
+	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
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
+	tst_resm TINFO "'$cmd_name' add $IP_TOTAL IPv$ipver addresses"
+	tst_resm TINFO "check interval that $iface is working: $CHECK_INTERVAL"
 
-    # Make sure that no alias exists.
-    initialize_if lhost ${LINK_NUM}
+	tst_restore_ipaddr || \
+		tst_resm TBROK "Failed to set default IP addresses"
 
-    # Set the non-alias address
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Failed to add IPv4 address to the interface at the local host"
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
 
-    # Set up for the loop
-    # Note: 2 colon aliases are added by `ifconfig ethn:x:y'
-    #       `ifconfig ethn:x:y:... add ' runs 4 times per a pair of x,y
-    cnt=0
-    x=1 ; y=1 ; xymax=99
-    a=1 ; amax=3
-    ifalias="${lhost_ifname}:${x}:${y}"
-    ifconfig $ifalias ${IPV4_NETWORK}.${x}.${y}.${a} \
-	    netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
+	[ "$TST_IPV6" ] && local xymax=65535 || xymax=254
 
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
+	if [ $IP_TOTAL -gt $((xymax * xymax)) ]; then
+		tst_resm TWARN "set IP_TOTAL to $xymax * $xymax"
+		IP_TOTAL=$((xymax * xymax))
 	fi
 
-	# Create
-	a=`expr $a + 1`
-	ifconfig $ifalias add ${IPV4_NETWORK}.${x}.${y}.${a} \
-		    netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
-	if [ $? -ne 0 ]; then
-	    tst_resm TINFO "It seems $cnt is limit."
-	    break
-	fi
-	ifalias="${ifalias}:0"
+	while [ $cnt -le $IP_TOTAL ]; do
 
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
+		if [ "$TST_IPV6" ]; then
+			local hex_x=$(printf '%x' $x)
+			local hex_y=$(printf '%x' $y)
+			local new_ip=${IPV6_NET32_UNUSED}:1:1:1:$hex_x:$hex_y:1
+		else
+			local new_ip=${IPV4_NET16_UNUSED}.$x.$y
 		fi
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
+		tst_resm TINFO "set new ip $new_ip"
+
+		case $cmd_type in
+		if_cmd)
+			if [ "$TST_IPV6" ]; then
+				ifconfig $iface add $new_ip/$netmask
+			else
+				ifconfig $iface:$x:$y $new_ip netmask 255.255.0.0
+			fi
+		;;
+		ip_cmd) ip addr add $new_ip/$netmask dev $iface ;;
+		esac
+
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "command failed to add $new_ip to $iface"
+			return
 		fi
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
+		ip addr show $iface | grep -q $new_ip
+		if [ $? -ne 0 ]; then
+			ip addr show $iface
+			tst_resm TFAIL "$new_ip not configured"
+			return
 		fi
-	    fi
-	fi
-
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
-	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
-	fi
 
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
+		# Check the connectivity
+		check_connectivity $cnt || return
+
+		# Check the background TCP traffic
+		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
+
+		case $cmd_type in
+		if_cmd)
+			if [ "$TST_IPV6" ]; then
+				ifconfig $iface del $new_ip/$netmask
+			else
+				ifconfig $iface:$x:$y down
+			fi
+		;;
+		ip_cmd) ip addr del $new_ip/$netmask dev $iface ;;
+		esac
+
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL " delete command failed".
+			return
+		fi
 
-    # Check the connecitivy from the interface (non-alias)
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "The interface ${lhost_ifname} is broken."
-	return 1
-    fi
+		ip addr show $iface | grep -q $new_ip
+		if [ $? -eq 0 ]; then
+			ip addr show $iface
+			tst_resm TFAIL "Failed to remove '$new_ip' address"
+			return
+		fi
 
-    # Stop the background TCP traffic
-    bg_tcp_traffic killall
+		cnt=$(($cnt + 1))
+		y=$(($y + 1))
+		if [ $y -gt $xymax ]; then
+			y=1
+			x=$(($x + 1))
+			if [ $x -gt $xymax ]; then
+				tst_brkm TBROK "Too large $IP_TOTAL"
+			fi
+		fi
+	done
 
-    tst_resm TPASS "Test is finished correctly."
-    return 0
+	tst_resm TPASS "Test is finished correctly"
 }
 
+setup
 
+tst_check_cmds ifconfig
 
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
+test_body 'if_cmd'
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
