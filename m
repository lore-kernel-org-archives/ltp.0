Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzU-0005OA-UJ
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:00 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzT-0005hg-MY
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:05:00 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4reg030796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t1DC4rFL013141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:53 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t1DC4rfB013968
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:53 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:02 +0300
Message-Id: <1423829229-28963-4-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 4/11] network/stress/interface/ip4-addr-change: apply
	test_net.sh library
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

* skip rhost address
* cleanup

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if4-addr-change |  262 +++++---------------
 1 files changed, 56 insertions(+), 206 deletions(-)

diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index e066d62..813e760 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -1,237 +1,87 @@
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
-#   if4-addr-change
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:
-# Verify the IPv4 connectivity isn't broken with changing IPv4 address
-# many times
-#    test01 - by ifconfig command
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
 # Author:
 #   Mitsuru Chinen <mitch@jp.ibm.com>
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
 
-# Total number of the test case
 TST_TOTAL=1
-export TST_TOTAL
-
-# Default of the test case ID and the test case count
 TCID=if4-addr-change
-TST_COUNT=0
-export TCID
-export TST_COUNT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
+TST_CLEANUP="cleanup"
 
-# The total number of changing of IPv4 address
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
+. test_net.sh
 
 # Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
-
-# Host portion of the IPv4 address on the remote host
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-
-# Minumum host portion of the IPv4 address on the local host
-LHOST_IPV4_HOST_MIN=${LHOST_IPV4_HOST:-"2"}
-
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 100))}
 # Maximum host portion of the IPv4 address on the local host
 LHOST_IPV4_HOST_MAX="254"
 
+trap "tst_brkm TBROK 'test interrupted'" INT
 
-
-#-----------------------------------------------------------------------
-#
-# NAME:
-#   do_setup
-#
-# DESCRIPTION:
-#   Make a IPv4 connectivity on the Test Link
-#
-# SET VALUES:
-#   rhost_ipv4addr	- IPv4 Address of the remote host
-#   lhost_ifname	- Interface name of the localhost
-#
-#-----------------------------------------------------------------------
-do_setup()
+cleanup()
 {
-    TCID=if4-addr-change
-    TST_COUNT=0
-
-    # Initialize the interfaces
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-
-    # Set IPv4 address to the interfaces
-    set_ipv4addr lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST_MIN}
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
+	tst_restore_ipaddr
 }
 
+test01()
+{
+	tst_resm TINFO "ifconfig changes IPv4 address $NS_TIMES times"
+
+	tst_restore_ipaddr
 
+	check_icmpv4_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
+		tst_brkm TBROK "Failed to ping to $(tst_ipaddr rhost)"
 
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
+	local cnt=0
+	num=1
+	while [ $cnt -lt $NS_TIMES ]; do
+		# Define the network portion
+		num=$(($num + 1))
+		[ $num -gt $LHOST_IPV4_HOST_MAX ] && num=1
 
+		[ $num -eq $RHOST_IPV4_HOST ] && continue
 
+		# Change the IPv4 address
+		lhost_ipv4addr="${IPV4_NETWORK}.${num}"
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:
-#   test01
-#
-# DESCRIPTION:
-#   ifconfig case
-#
-#-----------------------------------------------------------------------
-test01()
-{
-    TCID=if4-addr-change01
-    TST_COUNT=1
-    tst_resm TINFO "Verify the IPv4 connectivity is not broken when the ifconfig command changes the IPv4 address $NS_TIMES times"
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
-    current_lhost_ipv4_host=$LHOST_IPV4_HOST_MIN
-    while [ $cnt -lt $NS_TIMES ]; do
-	# Define the network portion
-	current_lhost_ipv4_host=`expr $current_lhost_ipv4_host + 1`
-	if [ $current_lhost_ipv4_host -gt $LHOST_IPV4_HOST_MAX ]; then
-	    current_lhost_ipv4_host=$LHOST_IPV4_HOST_MIN
-	fi
-
-	# Change the IPv4 address
-	lhost_ipv4addr="${IPV4_NETWORK}.${current_lhost_ipv4_host}"
-	ifconfig $lhost_ifname $lhost_ipv4addr netmask $IPV4_NETMASK broadcast $IPV4_BROADCAST
-	if [ $? -ne 0 ]; then
-	    test_resm TFAIL "Failed to change IPv4 address into ${lhost_ipv4addr}"
-	    return 1
-	fi
-
-	# Check the connecitivity
-	cnt=`expr $cnt + 1`
-	if [ $CHECK_INTERVAL -ne 0 ]; then
-	    if [ `expr $cnt % ${CHECK_INTERVAL}` -eq 0 ]; then
-		check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-		if [ $? -ne 0 ]; then
-		    tst_resm TFAIL "$lhost_ifname is broken at around ${cnt} times"
-		    return 1
-		fi
-	    fi
-	fi
-    done
-
-    # Check the connectivity again.
-    check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "$errmsg $lhost_ifname is broken."
-	return 1
-    fi
-
-    tst_resm TPASS "Test is finished successfully."
-    return 0
-}
+		ifconfig $(tst_iface) $lhost_ipv4addr netmask 255.255.255.0 \
+			broadcast 255.255.255.255 || \
+			tst_brkm TFAIL "Failed to change into ${lhost_ipv4addr}"
 
+		cnt=$(($cnt + 1))
 
+		[ $CHECK_INTERVAL -eq 0 ] && continue
+		[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && continue
 
-#-----------------------------------------------------------------------
-#
-# Main
-#
-# Exit Value:
-#   The number of the failure
-#
-#-----------------------------------------------------------------------
+		tst_resm TINFO "ping from $lhost_ipv4addr to $(tst_ipaddr rhost)"
+		check_icmpv4_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
+			tst_brkm TFAIL "$(tst_iface) is broken at around ${cnt} times"
+	done
+
+	tst_resm TINFO "ping from $lhost_ipv4addr to $(tst_ipaddr rhost)"
+	check_icmpv4_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
+		tst_brkm TFAIL "$(tst_iface) is broken"
+
+	tst_resm TPASS "Test is finished successfully"
+}
+
+tst_check_cmds ifconfig
 
-RC=0
-do_setup
-test01 || RC=`expr $RC + 1`
-do_cleanup
+test01
 
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
