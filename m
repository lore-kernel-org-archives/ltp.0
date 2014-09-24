Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XWoB6-0004Ue-W5
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 15:08:25 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWoB5-0002la-Jc
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 15:08:24 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s8OF8HCX002408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:18 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8OF8H1V026651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:17 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8OF8Gdp015150
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:16 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 Sep 2014 19:09:53 +0400
Message-Id: <1411571394-14917-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1411571394-14917-1-git-send-email-alexey.kodanev@oracle.com>
References: <1411571394-14917-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/3] network/sendfile01: cleanup test,
	apply new net library
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

This test require remote host IP address. Don't get it from RHOST,
get the one from network.sh. It is done because RHOST may be set as
management link and we don't want test traffic on it.

Also, test used 'rsh' without input redirection to /dev/null. It could block
the test, see bug section in rsh man page.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/ipv6                                       |    2 +-
 testcases/network/tcp_cmds/sendfile/Makefile       |    2 +-
 testcases/network/tcp_cmds/sendfile/sendfile01     |  162 ++++++++-----------
 .../network/tcp_cmds/sendfile/sendfile01_server    |    6 -
 4 files changed, 70 insertions(+), 102 deletions(-)
 delete mode 100755 testcases/network/tcp_cmds/sendfile/sendfile01_server

diff --git a/runtest/ipv6 b/runtest/ipv6
index c8071d6..d9d8b48 100644
--- a/runtest/ipv6
+++ b/runtest/ipv6
@@ -8,6 +8,6 @@ rcp6 export TCbin=$LTPROOT/testcases/network/ipv6/rcp6; rcp01
 rlogin6 rlogin01
 rsh6 rsh01
 rwho6 rwho01
-sendfile6 export TCbin=$LTPROOT/testcases/network/ipv6/sendfile6; sendfile601
+sendfile6 sendfile01 -6
 tcpdump6 tcpdump601
 telnet6 telnet01
diff --git a/testcases/network/tcp_cmds/sendfile/Makefile b/testcases/network/tcp_cmds/sendfile/Makefile
index a8b0736..124ce5d 100644
--- a/testcases/network/tcp_cmds/sendfile/Makefile
+++ b/testcases/network/tcp_cmds/sendfile/Makefile
@@ -27,7 +27,7 @@ include $(abs_srcdir)/../Makefile.inc
 
 CPPFLAGS		+= -I$(abs_srcdir)/../include
 
-INSTALL_TARGETS		:= sendfile01 sendfile01_server
+INSTALL_TARGETS		:= sendfile01
 
 MAKE_TARGETS		+= testsf_c testsf_s testsf_c6 testsf_s6
 
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/sendfile01
index ad16290..8fc5aa4 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01
@@ -1,24 +1,20 @@
 #!/bin/sh
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
-#  FILE   : sendfile
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 #  PURPOSE: Copy files from server to client using the sendfile()
 #           function.
@@ -38,100 +34,78 @@
 #
 #***********************************************************************
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  exists
-#
-# DESCRIPTION: Check if required commands exits.
-#
-#-----------------------------------------------------------------------
+TST_TOTAL=1
+TCID="sendfile01"
+TST_CLEANUP=do_cleanup
 
 do_setup()
 {
-    TC=sendfile01
-    RHOST=${RHOST:-`hostname`}
-    TCdat=${TCdat:-$LTPROOT/testcases/bin/datafiles}
-    TCtmp=${TCtmp:-$LTPROOT/testcases/bin/$TC${EXEC_SUFFIX}$$}
-    CLIENT="testsf_c${EXEC_SUFFIX}"
-    SERVER="testsf_s${EXEC_SUFFIX}"
-    LTPROOT=${LTPROOT:-../../../..}
-    FILES=${FILES:-"ascii.sm ascii.med ascii.lg ascii.jmb"}
+	TCdat=${TCdat:-$LTPROOT/testcases/bin/datafiles}
 
-    tst_setup
+	CLIENT="testsf_c${TST_EXEC_SUFFIX}"
+	SERVER="testsf_s${TST_EXEC_SUFFIX}"
 
-    exists awk diff mc_gethost grep rsh stat
+	FILES=${FILES:-"ascii.sm ascii.med ascii.lg ascii.jmb"}
 
-    if ! IPADDR=$(mc_gethost ${EXEC_SUFFIX:+-6} $RHOST | awk 'BEGIN { ec=1 } /addresses:/ {print $2; ec=0 } END { exit ec }'); then
-        # XXX (garrcoop): || exit 1 is there to prevent the test from hanging in the event of an install error.
-        end_testcase "Failed to determine the appropriate IP address for the machine." || exit 1
-    fi
+	tst_check_cmds diff stat
 
+	tst_tmpdir
 }
 
-
-#=============================================================================
-# FUNCTION NAME:        do_test
-#
-# FUNCTION DESCRIPTION: Perform the test
-#
-# PARAMETERS:       None.
-#
-# RETURNS:          None.
-#=============================================================================
 do_test()
 {
-    tst_resm TINFO "Doing $0."
-
-    mkdir -p $TCtmp
-    PORT=$$
-    if ! rsh -l root $IPADDR "$LTPROOT/testcases/bin/sendfile01_server $IPADDR $PORT $LTPROOT/testcases/bin $SERVER"; then
-        end_testcase "rsh failed to $IPADDR as root failed"
-    fi
-    sleep 10
-    PID=$(rsh -l root $IPADDR "ps -ef" | awk "\$0 !~ /awk/ && /$SERVER/ && /$PORT/ {print \$2}")
-    [ -n "$PID" ] || end_testcase "Could not start server"
-
-    for clnt_fname in $FILES; do
-        serv_fname=$TCdat/$clnt_fname
-        SIZE=`stat -c '%s' $serv_fname`
-        tst_resm TINFO "Starting $SERVER $IPADDR Client_filename Server_filename Size "
-
-        $CLIENT $IPADDR $PORT "$TCtmp/$clnt_fname" $serv_fname $SIZE
-        RetVal=$?
-
-        [ $RetVal -eq 0 ] || end_testcase "$CLIENT returned error $RetVal"
-
-        diff $serv_fname $TCtmp/$clnt_fname
-        DiffVal=$?
-        [ $DiffVal -gt 1 ] && end_testcase "ERROR: Cannot compare files"
-        [ $DiffVal -eq 1 ] && end_testcase "The file copied differs from the original"
-    done
-
+	tst_resm TINFO "Doing $0."
+
+	local ipv="ipv${TST_EXEC_SUFFIX:-"4"}"
+	local ipaddr=$(tst_ipaddr rhost)
+	local port=$(tst_rhost_run -s -c "tst_get_unused_port $ipv stream")
+	[ -z "$port" ] && tst_brkm TBROK "failed to get unused port"
+
+	tst_rhost_run -s -b -c "$SERVER $ipaddr $port"
+	server_started=1
+	sleep 10
+
+	for clnt_fname in $FILES; do
+		serv_fname=${TCdat}/$clnt_fname
+		local size=$(stat -c '%s' $serv_fname)
+
+		tst_resm TINFO \
+			"$CLIENT ip '$ipaddr' port '$port' file '$clnt_fname'"
+
+		$CLIENT $ipaddr $port $clnt_fname $serv_fname $size >\
+			/dev/null 2>&1
+
+		local ret=$?
+		if [ $ret -ne 0 ]; then
+			tst_resm TFAIL "$CLIENT returned error '$ret'"
+			return;
+		fi
+
+		diff $serv_fname $clnt_fname > /dev/null 2>&1
+		local diff_res=$?
+		if [ $diff_res -gt 1 ]; then
+			tst_resm TFAIL "ERROR: Cannot compare files"
+			return
+		fi
+
+		if [ $diff_res -eq 1 ]; then
+			tst_resm TFAIL "The file copied differs from the original"
+			return
+		fi
+	done
+	tst_resm TPASS "test finished successfully"
 }
 
-#=============================================================================
-# FUNCTION NAME:        do_cleanup
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:       None.
-#
-# RETURNS:          None.
-#=============================================================================
-
 do_cleanup()
 {
-      PID=$(rsh -n -l root $RHOST "ps -eopid,cmd" | awk "\$0 !~ /awk/ && /$SERVER/ && /$PORT/ {print \$1}")
-      [ -n "$PID" ] && rsh -n -l root $RHOST kill -9 $PID
-      tst_cleanup
+	[ -n "$server_started" ] && tst_rhost_run -s -c "pkill $SERVER"
+	tst_rmdir
 }
 
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
-. net_cmdlib.sh
+. test_net.sh
 
-read_opts $*
+tst_read_opts $*
 do_setup
 do_test
-end_testcase
+
+tst_exit
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01_server b/testcases/network/tcp_cmds/sendfile/sendfile01_server
deleted file mode 100755
index 9933db4..0000000
--- a/testcases/network/tcp_cmds/sendfile/sendfile01_server
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-#set -x
-cd $3
-exec 1< /dev/null       # open descriptor 1
-exec 2< /dev/null       # open descriptor 1
-nohup ./$4 $1 $2 &
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
