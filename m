From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 Jan 2017 18:23:18 +0300
Subject: [LTP] [PATCH 2/2] net: traceroute01: use latest net API and add
	IPv6 version
In-Reply-To: <1484666598-26339-1-git-send-email-alexey.kodanev@oracle.com>
References: <1484666598-26339-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1484666598-26339-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.ipv6                             |    1 +
 testcases/network/traceroute/traceroute01.sh |  213 ++++++--------------------
 2 files changed, 45 insertions(+), 169 deletions(-)

diff --git a/runtest/net.ipv6 b/runtest/net.ipv6
index 0e63467..d8f85cc 100644
--- a/runtest/net.ipv6
+++ b/runtest/net.ipv6
@@ -4,6 +4,7 @@ ping602 ping02.sh -6
 sendfile601 sendfile01 -6
 tcpdump601 tcpdump01 -6
 tracepath601 tracepath01.sh -6
+traceroute601 traceroute01.sh -6
 dhcpd6 dhcpd_tests.sh -6
 dnsmasq6 dnsmasq_tests.sh -6
 ipneigh601 ipneigh01.sh -6
diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index ad65d37..fb612a7 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -1,187 +1,62 @@
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
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
-################################################################################
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2001
 #
-# File :         traceroute_tests.sh
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-# Description:   Test Basic functionality of traceroute command.
-#                Test #1: execute traceroute on hostname, expected number of
-#                hops is 1.
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-# Author:        Manoj Iyer, manjo@mail.utexas.edu
-#
-# History:       Mar 03 2003 - Created - Manoj Iyer.
-#
-# Function:     chk_ifexists
-#
-# Description:  - Check if command required for this test exits.
-#
-# Input:        - $1 - calling test case.
-#               - $2 - command that needs to be checked.
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-chk_ifexists()
-{
-    RC=0
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 
-    which $2 > $LTPTMP/tst_traceroute.err 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
-    then
-        tst_brkm TBROK NULL "$1: command $2 not found."
-    fi
-    return $RC
-}
+TST_TOTAL=2
+TCID="traceroute01"
+TST_CLEANUP="cleanup"
 
+. test_net.sh
 
-# Function: init
-#
-# Description:  - Check if command required for this test exits.
-#               - Create temporary directories required for this test.
-#               - Initialize global variables.
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-init()
+cleanup()
 {
-    # Initialize global variables.
-    export RC=0
-    export TST_TOTAL=2
-    export TCID="traceroute"
-    export TST_COUNT=0
-
-    # Inititalize cleanup function.
-    trap "cleanup" 0
-
-    # create the temporary directory used by this testcase
-    if [ -z $TMP ]
-    then
-        LTPTMP=/tmp/tst_traceroute.$$
-    else
-        LTPTMP=$TMP/tst_traceroute.$$
-    fi
-
-    mkdir -p $LTPTMP > /dev/null 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
-    then
-         tst_brkm TBROK "INIT: Unable to create temporary directory"
-         return $RC
-    fi
-
-    # check if commands tst_*, traceroute, awk exists.
-    chk_ifexists INIT tst_resm   || return $RC
-    chk_ifexists INIT traceroute || return $RC
-    chk_ifexists INIT awk        || return $RC
-    chk_ifexists INIT head       || return $RC
-    chk_ifexists INIT cat        || return $RC
-    chk_ifexists INIT diff       || return $RC
-
-    # Create expected file.
-    cat > $LTPTMP/tst_traceroute.exp <<-EOF || RC=$?
-    traceroute to $(hostname) ($(hostname -i)), 30 hops max, 38 byte packets
-	EOF
-
-    if [ $RC -ne 0 ]
-    then
-        tst_brkm TBROK  NULL \
-            "INIT: unable to create expected file $LTPTMP/tst_traceroute.exp"
-        return $RC
-    fi
-    return $RC
+	tst_rmdir
 }
 
-
-# Function:     cleanup
-#
-# Description:  - remove temporaty files and directories.
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
-cleanup()
+setup()
 {
-    # remove all the temporary files created by this test.
-    tst_resm TINFO "CLEAN: removing $LTPTMP"
-    rm -fr $LTPTMP
+	tst_check_cmds traceroute
+	tst_tmpdir
 }
 
-
-# Function:     test01
-#
-# Description:  - Test that traceroute hostname will trace route of an IP
-#                 packet to that host.
-#
-# Return:       - zero on success.
-#               - non-zero on failure.
 test01()
 {
-    TCID=traceroute01
-    TST_COUNT=1
-    nhops=0             # Number of hops required to get to host.
-    RC=0                # Return value from commands.
-
-    tst_resm TINFO "Test #1: Execute traceroute on hostname."
-    tst_resm TINFO "Test #1: traceroute returns the path taken by IP packet"
-    tst_resm TINFO "Test #1: to that host."
-
-    traceroute `hostname` 38 > $LTPTMP/tst_traceroute.out 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
-    then
-        tst_res TFAIL $LTPTMP/tst_traceroute.out \
-            "Test #1: traceroute command failed: return = $RC. Details:"
-        return $RC
-    fi
-
-    cat $LTPTMP/tst_traceroute.out | head -n 1 > $LTPTMP/tst_traceroute.out.1 2>&1
-    diff -iwB $LTPTMP/tst_traceroute.out.1 $LTPTMP/tst_traceroute.exp \
-        > $LTPTMP/tst_traceroute.err 2>&1 || RC=$?
-    if [ $RC -ne 0 ]
-    then
-        tst_res TFAIL $LTPTMP/tst_traceroute.err \
-            "Test #1: unexpected output. Details:"
-        return $RC
-    else
-        # Only one hop is required to get to hostname.
-        nhops=$(cat $LTPTMP/tst_traceroute.out | tail -n 1 | awk '{print $1}')
-        if [ $nhops -ne 1 ]
-        then
-            tst_resm TFAIL "Test #1: $hops number of hops unexpected"
-        else
-            tst_resm TPASS \
-                "Test #1: traceroute $hostname traced route correctly"
-        fi
-    fi
-
-    return $RC
+	local bytes=100
+	local ip=$(tst_ipaddr rhost)
+
+	EXPECT_PASS traceroute $ip $bytes \>out.log 2>&1
+
+	tst_resm TINFO "check traceroute output"
+	grep -q "$bytes byte" out.log
+	if [ $? -ne 0 ]; then
+		cat out.log
+		tst_brkm TFAIL "pattern '$bytes byte' not found in log"
+	fi
+
+	grep -qE "^.+1.+$ip.+($ip).+[0-9] ms.+[0-9] ms.+[0-9] ms" out.log
+	if [ $? -ne 0 ]; then
+		cat out.log
+		tst_brkm TFAIL "pattern '^.+1.+$ip.+($ip).+"
+			"[0-9] ms.+[0-9] ms.+[0-9] ms' not found in log"
+	fi
+
+	tst_resm TPASS "traceroute test completed with 1 hop"
 }
 
+setup
+test01
 
-# Function:    main
-#
-# Description:    - Execute all tests and report results.
-#
-# Exit:            - zero on success
-#               - non-zero on failure.
-
-RC=0
-init || exit $?
-
-test01 || RC=$?
-
-exit $RC
+tst_exit
-- 
1.7.1

