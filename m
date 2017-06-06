From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  6 Jun 2017 14:22:00 +0300
Subject: [LTP] [COMMITTED][PATCH 5/6] net/rpc01: convert to test_net.sh lib
In-Reply-To: <1496748121-10782-1-git-send-email-alexey.kodanev@oracle.com>
References: <1496748121-10782-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1496748121-10782-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also wait for server to be registered with rpcinfo -T udp...

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/rpc01 |  158 +++++++------------------
 1 files changed, 44 insertions(+), 114 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index 8ed69b0..fd8915a 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -1,132 +1,62 @@
 #!/bin/sh
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#  FILE             : rpc01
-#
-#  TEST DESCRIPTION : Test rpc using file transfers between a client & server
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#  HISTORY:
-#    04/18/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#***********************************************************************
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-this_file=${0##*/}
-TC=${TC:=rpc01}
-TCbin=${TCbin:=$LTPROOT/testcases/bin}
-TCdat=${TCdat:=$LTPROOT/testcases/data/rpc01}
-NUMLOOPS=${NUMLOOPS:=3}
-RHOST=${RHOST:=`hostname`}
-CLEANUP=${CLEANUP:="ON"}
-DATAFILES=${DATAFILES:="file.1 file.2"}
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 
-#=============================================================================
-# FUNCTION NAME:        do_test
-#
-# FUNCTION DESCRIPTION: Perform the test
-#
-# PARAMETERS:   	None.
-#
-# RETURNS:      	None.
-#=============================================================================
-do_test()
-{
-    $trace_logic
+TCID="rpc01"
+TST_TOTAL=6
+TST_CLEANUP=do_cleanup
 
-    # Start server process
-    rsh -n $RHOST $TCbin/rpc_server
-    PID1=`rsh -n $RHOST ps -ewf | grep rpc_server | grep -v grep | awk '{print $2 }'`
-    echo "The rpc_server PID is $PID1"
-    # Start client process
-    echo "Starting $TC"
-    COUNT=1
-    while [ $COUNT -le $NUMLOOPS ]
-    do
-      for FILE in $DATAFILES
-      do
-	rpc1 -s $RHOST -f $TCdat/$FILE
-	[ $? -eq 0 ] || end_testcase "Fail on using $FILE"
-      done
-      COUNT=`expr $COUNT + 1`
-    done
-}
+. test_net.sh
 
+NUMLOOPS=${NUMLOOPS:=3}
+DATAFILES=${DATAFILES:="file.1 file.2"}
 
-#=============================================================================
-# FUNCTION NAME:        do_cleanup
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:   	None.
-#
-# RETURNS:      	None.
-#=============================================================================
 do_cleanup()
 {
-    $trace_logic
-
-    if [ "$CLEANUP" = "ON" ]; then
-	if [ -f $TMPDIR/core ]; then
-	   echo "Core file is saved in /tmp"
-	   mv $TMPDIR/core /tmp
-	fi
-
-	# Kill server
-        rsh -n $RHOST kill -9 $PID1
-    fi
+	pkill -9 rpc_server > /dev/null 2>&1
 }
 
-#=============================================================================
-# FUNCTION NAME:        end_testcase
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:           string, IF AND ONLY IF the testcase fails
-#
-# RETURNS:              None.
-#=============================================================================
-
-end_testcase()
+do_setup()
 {
-   $trace_logic
-   echo "$this_file: doing $0."
-
-   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-   tst_resm TFAIL "Test Failed: $@"
-   exit 1
+	tst_resm TINFO "start rpc_server"
+	rpc_server
+
+	tst_resm TINFO "wait for server to be registered"
+	for i in $(seq 1 30); do
+		rpcinfo -T udp $(tst_ipaddr) 2000333 10 >/dev/null 2>&1 && break
+		[ "$i" -eq 30 ] && tst_brkm TBROK "server not registered"
+		tst_sleep 100ms
+	done
 }
 
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
+do_test()
+{
+	local thost="$(tst_ipaddr)"
+
+	tst_resm TINFO "starting client process"
+	local cnt=1
+	while [ $cnt -le $NUMLOOPS ]; do
+		for f in $DATAFILES; do
+			EXPECT_RHOST_PASS rpc1 -s $thost -f $LTP_DATAROOT/$f
+		done
+		cnt=$(($cnt + 1))
+	done
+}
 
+do_setup
 do_test
-do_cleanup
-end_testcase
 
+tst_exit
-- 
1.7.1

