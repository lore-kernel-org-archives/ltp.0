Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XW5Cl-0007gQ-LH
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 15:07:07 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XW5Cj-0001Ga-QY
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 15:07:07 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s8MF6x5l012650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Sep 2014 15:07:00 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8MF6wAn024953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Sep 2014 15:06:59 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8MF6wSA010394
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Sep 2014 15:06:58 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 22 Sep 2014 19:08:37 +0400
Message-Id: <1411398517-2207-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1411398517-2207-1-git-send-email-alexey.kodanev@oracle.com>
References: <1411398517-2207-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] network/ping: cleanup test, use new net library
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

Remove -R (record route) option from ping because:
* IPv6 doesn't support record route;
* many hosts ignore or discard the option;

Also, previous version didn't use EXEC_PREFIX to test ping6

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/ipv6                           |    2 +-
 testcases/network/tcp_cmds/ping/ping01 |   92 ++++++++++++-------------------
 2 files changed, 37 insertions(+), 57 deletions(-)

diff --git a/runtest/ipv6 b/runtest/ipv6
index 99f0f54..c8071d6 100644
--- a/runtest/ipv6
+++ b/runtest/ipv6
@@ -3,7 +3,7 @@ echo6 export TCbin=$LTPROOT/testcases/network/ipv6/echo6;echo601
 finger6 finger601
 ftp6 export TCbin=$LTPROOT/testcases/network/ipv6/ftp6; ftp01
 perf_lan6 export TCbin=$LTPROOT/testcases/network/ipv6/perf_lan6; perf_lan6
-ping6 ping601
+ping6 ping01 -6
 rcp6 export TCbin=$LTPROOT/testcases/network/ipv6/rcp6; rcp01
 rlogin6 rlogin01
 rsh6 rsh01
diff --git a/testcases/network/tcp_cmds/ping/ping01 b/testcases/network/tcp_cmds/ping/ping01
index ce0dcfb..5266b7c 100755
--- a/testcases/network/tcp_cmds/ping/ping01
+++ b/testcases/network/tcp_cmds/ping/ping01
@@ -1,25 +1,20 @@
 #! /bin/sh
-#***********************************************************************
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
 #
-#   Copyright (c) International Business Machines  Corp., 2000
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : ping
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 #  PURPOSE: To test the basic functionality of the `ping` command.
 #
@@ -30,57 +25,42 @@
 #    - Modified testcase to use test APIs and also fixed minor bugs
 #    03/01 Robbie Williamson (robbiew@us.ibm.com)
 #      -Ported
-#
-#
-#***********************************************************************
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION: do_setup
-#
-#-----------------------------------------------------------------------
+TST_TOTAL=1
+TCID="ping01"
+
+. test_net.sh
 
 do_setup()
 {
-    COUNT=${COUNT:-5}
-    SLEEPTIME=${SLEEPTIME:-1}
-    PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
+	COUNT=${COUNT:-5}
+	SLEEPTIME=${SLEEPTIME:-1}
+	PACKETSIZES=${PACKETSIZES:-"8 16 32 64 128 256 512 1024 2048 4064"}
 
-    tst_setup
+	PING_CMD=ping${TST_EXEC_SUFFIX}
 
-    exists ping
+	tst_check_cmds $PING_CMD
 
-    RHOST=${RHOST:-127.0.0.1}
+	RHOST=${RHOST:-127.0.0.1}
 }
 
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_test
-# PURPOSE:   Executes the testcases.
-#
-#-----------------------------------------------------------------------
-
 do_test()
 {
-    tst_resm TINFO "ping with $PACKETSIZES ICMP packets"
-    for packetsize in $PACKETSIZES; do
-        tst_resm TINFO "calling ping with packet size = $packetsize"
-        if ! ping -R -c $COUNT -s $packetsize $RHOST 2>&1 1>/dev/null; then
-            end_testcase "failed: ping -c $COUNT -s $packetsize $RHOST"
-        fi
-        sleep $SLEEPTIME
-    done
+	tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
+	for packetsize in $PACKETSIZES; do
+		tst_resm TINFO "call $PING_CMD with packet size = $packetsize"
+		$PING_CMD -c $COUNT -s $packetsize $RHOST > /dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "$PING_CMD -c $COUNT -s $packetsize $RHOST"
+			return
+		fi
+		sleep $SLEEPTIME
+	done
 }
 
-#*******************************************************************************
-#
-# FUNCTION:  MAIN
-#
-#*******************************************************************************
-. net_cmdlib.sh
+tst_read_opts $*
 
-read_opts $*
 do_setup
 do_test
-end_testcase
+
+tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
