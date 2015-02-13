Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzY-0004c3-1G
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzV-0004mG-Nl
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:04 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4tNn030809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:56 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4sJN009751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:55 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4sFI009738
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:54 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:06 +0300
Message-Id: <1423829229-28963-8-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 8/11] network/stress/interface: cleanup and fix 'mtu'
	test
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

In the end of test-case set default 1500 mtu back

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if-mtu-change |  294 +++++-----------------
 1 files changed, 65 insertions(+), 229 deletions(-)

diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index f272ebd..d360b7e 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -1,264 +1,100 @@
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
-#   if4-mtu-change
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the IPv4 connectivity isn't broken with changing MTU many times
-#    test01 - by ifconfig command
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
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
-export LTPROOT
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
-# Total number of the test case
 TST_TOTAL=2
-export TST_TOTAL
+TCID=if-mtu-change
 
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
+. if-lib.sh
 
 # The interval of the change [second]
 CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
-
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($MTU_CHANGE_TIMES / 100))}
 # The array of the value which MTU is changed into sequentially
 CHANGE_VALUES="784 1142 426 1500 68 1500 68 748 68 1142 1500"
+CHANGE6_VALUES="1280 1445 1335 1390 1500 1280 1500 1280 1335 1500"
+[ "$TST_IPV6" ] && CHANGE_VALUES=$CHANGE6_VALUES
 
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
+	local iface=$(tst_iface)
+	[ "$TST_IPV6" ] && local netmask=64 || local netmask=16
 
-    TCID=if4-mtu-change0${test_type}
-    TST_COUNT=${test_type}
+	tst_resm TINFO "'$cmd_name changes MTU $MTU_CHANGE_TIMES times " \
+	               "every $CHANGE_INTERVAL seconds"
 
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
+	tst_restore_ipaddr || \
+		tst_resm TBROK "Failed to set default IP addresses"
 
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when $test_command command changes MTU $MTU_CHANGE_TIMES times every $CHANGE_INTERVAL seconds"
+	make_background_tcp_traffic
 
-    # Check the connctivity
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is somthing wrong."
-	return 1
-    fi
+	mtu_array_len=$(echo $CHANGE_VALUES | wc -w)
+	local cnt=0
+	while [ $cnt -lt $MTU_CHANGE_TIMES ]; do
+		sleep $CHANGE_INTERVAL
+		local nth=$(($cnt % $mtu_array_len))
+		field=$(($nth + 1))
+		cnt=$(($cnt + 1))
+		mtu=$(echo $CHANGE_VALUES | cut -d ' ' -f $field)
+		[ $cnt -eq $MTU_CHANGE_TIMES ] && mtu=1500
 
-    # Make a background TCP traffic
-    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+		tst_resm TINFO "set MTU to $mtu $cnt/$MTU_CHANGE_TIMES"
+		case $cmd_type in
+		if_cmd) ifconfig $iface mtu $mtu ;;
+		ip_cmd) ip link set $iface mtu $mtu ;;
+		esac
 
-    # Start the loop
-    mtu_array_len=`echo $CHANGE_VALUES | wc -w`
-    cnt=0
-    while [ $cnt -lt $MTU_CHANGE_TIMES ]; do
-	# Wait CHANGE_INTERVAL seconds
-	sleep $CHANGE_INTERVAL
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "Failed to change the mtu at $cnt time"
+			return
+		fi
 
-	# Change
-	nth=`expr $cnt % $mtu_array_len`
-	field=`expr $nth + 1`
-	mtu=`echo $CHANGE_VALUES | cut -d ' ' -f $field`
+		check_connectivity $cnt || return
 
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
+		# Check the background TCP traffic
+		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
+	done
 
-	# Check the background TCP traffic
-	bg_tcp_traffic check $server_pid
+	tst_resm TINFO "check connectivity through $iface"
+	check_icmpv${ipver}_connectivity $iface $(tst_ipaddr rhost)
 	if [ $? -ne 0 ]; then
-	    server_pid=`bg_tcp_traffic make $lhost_ipv4addr`
+		tst_resm TFAIL "$iface is broken"
+		return
 	fi
 
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
-test_body 1 || RC=`expr $RC + 1`	# Case of ifconfig command
-test_body 2 || RC=`expr $RC + 1`	# Case of ip command
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
