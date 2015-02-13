Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzd-0002du-Vp
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:09 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzY-0004mM-9a
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:09 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4wFb030851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:58 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4vIP023524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:58 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4unQ009815
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:57 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:08 +0300
Message-Id: <1423829229-28963-10-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 10/11] network/stress/interface: cleanup 'updown' test
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

Note, this test could cause port flapping error on a switch

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if-updown |  285 +++++---------------------
 1 files changed, 54 insertions(+), 231 deletions(-)

diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index 90bffaa..81a5af5 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -1,258 +1,81 @@
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
-#   if4-updown
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-#   Verify the IPv4 connectivity isn't broken with upping and downing
-#   an interface many times
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
+TCID=if-updown
 
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
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 100))}
 
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
 test_body()
 {
-    test_type=$1
-
-    TCID=if4-updown0$test_type
-    TST_COUNT=$test_type
+	local cmd_type=$1
 
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
+	case $cmd_type in
+	if_cmd) local cmd_name='ifconfig' ;;
+	ip_cmd) local cmd_name='ip' ;;
+	*) tst_brkm TBROK "Unknown test parameter '$cmd_type'"
+	esac
 
-    # Check the connctivity
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "Test Link $LINK_NUM is something wrong."
-	return 1
-    fi
+	local iface=$(tst_iface)
 
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
+	tst_resm TINFO "'$cmd_name ups/downs $iface $IF_UPDOWN_TIMES times"
+	tst_resm TINFO "check connectivity interval is $CHECK_INTERVAL"
+	tst_restore_ipaddr || \
+		tst_resm TBROK "Failed to set default IP addresses"
 
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
+	local cnt=1
+	while [ $cnt -le $IF_UPDOWN_TIMES ]; do
+		case $cmd_type in
+		if_cmd) ifconfig $iface down ;;
+		ip_cmd) ip link set $iface down ;;
+		esac
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "Failed to down $iface"
+			return
+		fi
 
-	# Check the connectivity every CHECK_INTERVAL time
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
+		case $cmd_type in
+		if_cmd) ifconfig $iface up ;;
+		ip_cmd) ip link set $iface up ;;
+		esac
 		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "$lhost_ifname is broken at ${cnt} time"
-		    return 1
+			tst_resm TFAIL "Failed to up $iface"
+			return
 		fi
-	    fi
-	fi
-    done
 
-    # Check the connectivity again
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "$lhost_ifname is broken."
-	return 1
-    fi
-    tst_resm TPASS "Test is finished successfully."
+		check_connectivity $cnt || return
+
+		cnt=$(($cnt + 1))
+	done
 
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
-test_body 1 || RC=`expr $RC + 1`      # Case of ifconfig command
-test_body 2 || RC=`expr $RC + 1`      # Case of ip command
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
