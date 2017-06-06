From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  6 Jun 2017 14:21:58 +0300
Subject: [LTP] [COMMITTED][PATCH 3/6] net/rusers01: convert to test_net.sh
	lib
In-Reply-To: <1496748121-10782-1-git-send-email-alexey.kodanev@oracle.com>
References: <1496748121-10782-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1496748121-10782-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* remove broadcast test-cases

* remove starting/stoping rusersd and TCONF if it's not started

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/rpc/basic_tests/rusers/rusers01 |  184 ++++-----------------
 1 files changed, 33 insertions(+), 151 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rusers/rusers01 b/testcases/network/rpc/basic_tests/rusers/rusers01
index 0b28c9e..a3f17c2 100755
--- a/testcases/network/rpc/basic_tests/rusers/rusers01
+++ b/testcases/network/rpc/basic_tests/rusers/rusers01
@@ -1,168 +1,50 @@
 #!/bin/sh
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
 #
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-#   Copyright (c) International Business Machines  Corp., 2000
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
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
-#
-#
-#
-#  FILE             : rusers
-#
-#  TEST DESCRIPTION : Basic test for the `rusers` command.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#  HISTORY:
-#    04/18/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Written
-#
-# CMD      FLAG      ARGS
-# rusers
-# rusers             RHOST
-# rusers    -a
-# rusers    -a       RHOST
-# rusers    -l
-# rusers    -l       RHOST
-# rusers             bogus_host
-# rusers   -bogus_flag
-#***********************************************************************
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 
-$trace_logic
-this_file=${0##*/}
+TCID="rusers01"
+TST_TOTAL=5
 
-TC=rusers
-TCtmp=${TCtmp:=`pwd`}
-TCbin=${TCbin:=`pwd`}
-TCsrc=${TCsrc:=$TCbin}
-LUSER=${LUSER:=root}
-RHOST=${RHOST:=`hostname`}
-CLEANUP=${CLEANUP:="ON"}
-PID=0
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
+. test_net.sh
 
-#=============================================================================
-# FUNCTION NAME:        do_test
-#
-# FUNCTION DESCRIPTION: Perform the test
-#
-# PARAMETERS:           None.
-#
-# RETURNS:              None.
-#=============================================================================
-do_test()
+do_setup()
 {
-$trace_logic
-
-echo "Checking for rusersd on $RHOST"
-
-rpcinfo -u $RHOST rusersd > /dev/null 2>&1
-if [ $? -ne 0 ]; then
-  echo "Attempting to start rusersd on $RHOST"
-  rsh -n -l root $RHOST "/usr/sbin/rpc.rusersd &"
-  [ $? -eq 0 ] || end_testcase "rusersd is inactive on $RHOST"
-  PID=`rsh -n $RHOST ps -ewf | grep rusersd | awk '{print $2 }'`
-  echo "ruserd started on $RHOST"
-fi
-
-#RHOST=`echo $RHOST | cut -d. -f1`   //The use is depriciated as it fails when RHOST is set to an IP address
-#                                    //Pointed out by "Ambar Seksena" <ambar.seksena@calsoftinc.com>
-
-echo "Test rusers with defaults...please be patient"
-# rusers with no options broadcasts over the net and reports
-# responses as it receives them. Time-out for responses is approx. 2 minutes.
-
-rusers > /dev/null
-[ $? -eq 0 ] || end_testcase "rusers with defaults - failed"
-
-echo "Test rusers with options set...please be patient"
-# Go through matrix of rusers options:
-
-rusers $RHOST > /dev/null
-[ $? -eq 0 ] || end_testcase "rusers $RHOST - failed"
-
-rusers -a $RHOST > /dev/null
-[ $? -eq 0 ] || end_testcase "rusers -a $RHOST - failed"
-
-rusers -l > /dev/null
-[ $? -eq 0 ] || end_testcase "rusers -l - failed"
-
-rusers -l $RHOST > /dev/null
-[ $? -eq 0 ] || end_testcase "rusers -l $RHOST - failed"
-
-echo "Test rusers with bad options"
-
-rusers bogushost > /dev/null 2>&1
-[ $? -eq 1 ] || end_testcase "rusers <invalid hostname> should fail"
-
-rusers -bogusflag > /dev/null 2>&1
-[ $? -eq 1 ] || end_testcase "rusers -<invalid flag> should fail"
+	tst_resm TINFO "Checking for rusersd on $(tst_ipaddr)"
+	tst_rhost_run -c "rpcinfo -u $(tst_ipaddr) rusersd" \
+		> /dev/null 2>&1 || \
+		tst_brkm TCONF "rusersd is inactive on $(tst_ipaddr)"
 }
 
-#=============================================================================
-# FUNCTION NAME:        do_cleanup
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:           None.
-#
-# RETURNS:              None.
-#=============================================================================
-do_cleanup()
+do_test()
 {
-    $trace_logic
+	tst_resm TINFO "Test rusers with options set"
 
-    if [ "$PID" != 0 ]; then
-        # Kill rusersd on remote machine
-        rsh -n $RHOST kill -9 $PID
-        echo "rusersd daemon stopped on $RHOST"
-    fi
-}
+	EXPECT_RHOST_PASS rusers $(tst_ipaddr)
 
-#=============================================================================
-# FUNCTION NAME:        end_testcase
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:           string, IF AND ONLY IF the testcase fails
-#
-# RETURNS:              None.
-#=============================================================================
+	local opts="-a -l"
+	for opt in $opts; do
+		EXPECT_RHOST_PASS rusers $opt $(tst_ipaddr)
+	done
 
-end_testcase()
-{
-   $trace_logic
-   echo "$this_file: doing $0."
-   if [ "$CLEANUP" = "ON" ]; then
-     do_cleanup
-   fi
-
-   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-   tst_resm TFAIL "Test Failed: $@"
-   exit 1
+	tst_resm TINFO "Test rusers with bad options"
+	EXPECT_RHOST_FAIL rusers bogushost
+	EXPECT_RHOST_FAIL rusers -bogusflag $(tst_ipaddr)
 }
 
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
-
+do_setup
 do_test
-end_testcase
+
+tst_exit
-- 
1.7.1

