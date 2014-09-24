Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XWoB9-0005Mn-M5
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 15:08:27 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWoB8-0005cG-MT
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 15:08:27 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s8OF8KYK002476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:21 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8OF8KbY015341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:20 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8OF8KRW026750
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:20 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 Sep 2014 19:09:54 +0400
Message-Id: <1411571394-14917-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1411571394-14917-1-git-send-email-alexey.kodanev@oracle.com>
References: <1411571394-14917-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/3] network/tcpdump01: cleanup test, use new library
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
 testcases/network/tcp_cmds/tcpdump/tcpdump01 |  113 +++++++++++---------------
 1 files changed, 48 insertions(+), 65 deletions(-)

diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
index 6296ad2..f8029f4 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
@@ -1,90 +1,73 @@
 #!/bin/sh
-
-#******************************************************************************
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
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
 #
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
-#
-#  FILE   : tcpdump
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 #  PURPOSE: To test the basic functionality of `tcpdump`.
 #
-#  SETUP: The "RHOST" setting should be exported to be the hostname of
-#         another machine on the same subnet.  Otherwise, the hostname
-#         of the tested machine will be used.
-#
 #  HISTORY:
 #    04/17/01 Robbie Williamson (robbiew@us.ibm.com)
 #      -Written
-#
-#-----------------------------------------------------------------------
 
-#******************************************************************************
-#
-# FUNCTION:  do_test
-# PURPOSE:   Invoke tcpdump
-# INPUT:     None
-#
-#******************************************************************************
+TST_TOTAL=1
+TCID="tcpdump01"
+TST_CLEANUP=do_cleanup
 
 do_setup()
 {
+	ping_cmd=ping$TST_EXEC_SUFFIX
+	tst_check_cmds tcpdump kill $ping_cmd
+	outfile="tcpdump_out"
+	numloops=20
+	tst_tmpdir
+}
+
+do_test()
+{
+	addr=$(tst_ipaddr rhost)
+	tst_resm TINFO "start $ping_cmd in background"
+
+	$ping_cmd -I $(tst_iface) -f $addr > /dev/null 2>&1 &
+	ping_pid=$!
+
+	tst_resm TINFO "running tcpdump..."
+	tcpdump -n -i $(tst_iface) -c $numloops > $outfile 2>/dev/null
 
-    tst_setup
+	[ $? -ne 0 ] && tst_brkm TBROK "problems trying to launch tcpdump"
 
-    exists awk grep host hostname ifconfig netstat ping tail tcpdump
-    RHOST=${RHOST:-`hostname`}
-    # Find the first interface that can ping RHOST
-    IF=""
-    for i in $(netstat -i | tail -n+3 | sed '/^lo/d' | cut -f1 -d' '); do
-        ping -I $i -c 3 -q $RHOST && { IF="$i"; break; }
-    done
-    test -z $IF && end_testcase "Could not find an interface that can ping remote host $RHOST"
-    IFNAME=${IF}
-    NUMLOOPS=${NUMLOOPS:-20}
-    OUTFILE=$TCtmp/tcpdump_out
+	grep "$addr\>" $outfile > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "'$ipaddr' was not listed in network traffic"
+		return
+	fi
 
+	tst_resm TPASS "Test finished successfully"
 }
 
-do_test()
+do_cleanup()
 {
-    ping -I $IFNAME -f $RHOST > /dev/null 2>&1 &
-    if ! tcpdump -i $IFNAME -c $NUMLOOPS > $OUTFILE; then
-        end_testcase "Problems trying to launch tcpdump"
-    fi
-    if ! grep "$RHOST\>" $OUTFILE; then
-        end_testcase "$RHOST was not listed in network traffic"
-    fi
-    kill -15 %1
-    rm -rf $OUTFILE
+	kill $ping_pid > /dev/null 2>&1
+	wait $ping_pid > /dev/null 2>&1
+	tst_rmdir
 }
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  MAIN
-# PURPOSE:   To invoke functions that perform the tasks as described in
-#	     the design in the prolog above.
-# INPUT:     See SETUP in the prolog above.
-# OUTPUT:    Logged run results written to testcase run log
-#
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
+. test_net.sh
 
-read_opts $*
+tst_read_opts $*
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
