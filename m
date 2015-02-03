Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YIeYr-0003Ft-SQ
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:34:41 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIeYq-0007xq-2a
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:34:41 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13EYXNZ028759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:34 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13EYX2r007851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:33 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13EYW7b007835
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:34:32 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  3 Feb 2015 17:36:53 +0300
Message-Id: <1422974214-12517-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1422974214-12517-1-git-send-email-alexey.kodanev@oracle.com>
References: <1422974214-12517-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/3] network/multicast/mc_cmds: enable proc knob
	during the test
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

* enable net.ipv4.icmp_echo_ignore_broadcasts during the test
* use 'ip' command instead of 'netstat' and 'ifconfig'

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/multicast/mc_cmds/mc_cmds |  133 ++++++++------------------
 1 files changed, 41 insertions(+), 92 deletions(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index c4f7ab8..4848ab6 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -1,129 +1,77 @@
 #! /bin/sh
+
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
 #
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
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
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
-#  FILE             : mc_cmds
-#  TEST DESCRIPTION : To determine the stability of the IP Multicast product
-#                and to verify the accuracy and usability of IP Multicast
-#                related publications associated with changes and/or
-#                additions to command level interfaces for this implementations
-#                of IP Multicast.
-#  HISTORY:
-#    03/26/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
+# TEST DESCRIPTION :
+#     To determine the stability of the IP Multicast product
+#     and to verify the accuracy and usability of IP Multicast
+#     related publications associated with changes and/or
+#     additions to command level interfaces for this implementations
+#     of IP Multicast.
 #
-#*******************************************************************************
+# Robbie Williamson (robbiew@us.ibm.com)
 
-TC=mc_cmds
-PING_OUT=${TCtmp}/PING_OUT
+TCID=mc_cmds
+TST_TOTAL=1
 
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
+. test_net.sh
 
-. test.sh
+sysctl_path="/proc/sys/net/ipv4/icmp_echo_ignore_broadcasts"
+knob_changed=
 
 setup()
 {
-	tst_check_cmds netstat
-
-	val=$(cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts)
+	val=$(cat $sysctl_path)
 	if [ $val -ne 0 ]; then
-		tst_brkm TCONF "Multicast ping disabled on this system."
+		echo 0 > $sysctl_path || \
+			tst_brkm TBROK "failed to unset '$sysctl_path'"
+		knob_changed=1
 	fi
-
 	tst_tmpdir
 }
 
 do_test()
 {
-	tst_resm TINFO "Getting ALL enabled interfaces which are configured !"
-
-	IFNAME=${IFNAME:-$(netstat -i -n | \
-			   grep "^[b-z][[:alnum:]]\{1,3\}[0-9][^*]" | \
-			   awk '{print $1}')}
-	INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | \
-				 awk '{print $2}')}
-	if [ -z $INTERFACE ]; then
-		tst_brkm TCONF "$(hostname) is not found in /etc/hosts"
-	fi
-
-	tst_resm TINFO "Testing ifconfig and netstat"
+	ip addr show $(tst_iface) | grep -q 'MULTICAST' || \
+		tst_brkm TFAIL "Multicast not listed for $(tst_iface)"
 
-	# Finds the active ethernet interface
-	for eth in $IFNAME
-	do
-		ifconfig $eth | grep -q $INTERFACE
-		if [ $? -eq 0 ]; then
-			INTERFACE_DEVICE=$eth
-			break
-		fi
-	done
-
-	MulticastAdap=
-	for eth in $IFNAME
-	do
-		ifconfig $eth | grep -q MULTICAST
-		if [ $? -eq 0 ]; then
-			MulticastAdap=$eth
-			break
-		fi
-	done
-	if [ -z $MulticastAdap ]; then
-		tst_brkm TFAIL "Multicast not listed for $IFNAME"
-	fi
-	MulticastAdapJoined=
-	for eth in $IFNAME
-	do
-		netstat -gn | grep $eth | grep -q 224.0.0.1
-		if [ $? -eq 0 ]; then
-			MulticastAdapJoined=1
-			break
-		fi
-	done
-	if [ -z $MulticastAdapJoined ]; then
+	ip maddr show $(tst_iface) | grep -q '224.0.0.1' || \
 		tst_brkm TFAIL "all-host-group for $IFNAME not joined"
-	fi
 
 	# Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper
 	# number of responses are returned.
 	tst_resm TINFO "Ping all-host-groups address(over default route!)"
-	ping -c2 224.0.0.1 > $PING_OUT
-	if [ $? -ne 0 ]; then
+	ping -c2 224.0.0.1 > ping_out.log || \
 		tst_brkm TFAIL "No response from MC hosts to ping 224.0.0.1"
-	fi
 
 	tst_resm TINFO "Ping all-host-groups over specified interface"
-	ping -c2 -I $INTERFACE 224.0.0.1 > $PING_OUT
+	ping -c2 -I $(tst_ipaddr) 224.0.0.1 > ping_out.log
 	if [ $? -ne 0 ]; then
-		tst_resm TINFO "Trying to ping with $INTERFACE_DEVICE"\
+		tst_resm TINFO "Trying to ping with $(tst_iface)"\
 			       "with the -I option instead of IP address"
-		ping -c2 -I $INTERFACE_DEVICE 224.0.0.1 > $PING_OUT
-		if [ $? -ne 0 ]; then
+		ping -c2 -I $(tst_iface) 224.0.0.1 > ping_out.log || \
 			tst_brkm TFAIL "No response from MC hosts to ping -c2 "\
-				       "-I$INTERFACE 224.0.0.1"
-		fi
+				       "-I $(tst_ipaddr) 224.0.0.1"
 	fi
-	grep -q $INTERFACE $PING_OUT
+	grep -q $(tst_ipaddr) ping_out.log
 	if [ $? -ne 0 ]; then
 		tst_brkm TFAIL "Local host did not respond to ping -c2 "\
-			       "-I$INTERFACE 224.0.0.1"
+			       "-I $(tst_iface) 224.0.0.1"
 	fi
 
 	tst_resm TPASS "Test Successful"
@@ -132,6 +80,7 @@ do_test()
 
 do_cleanup()
 {
+	[ "$knob_changed" ] && echo 1 > $sysctl_path
 	tst_rmdir
 }
 
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
