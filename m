From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 23 Aug 2016 14:16:02 +0300
Subject: [LTP] [PATCH v2 1/2] network/tcp_cmds/arp01: use test_net.sh and
	add test-cases with 'ip neigh'
Message-ID: <1471950963-7711-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

arp01 stress test removes/adds arp entries on the management interface.
This is unwelcome. Moreover, arp command is obsolete and there is
'ip neigh' command that replaces it.

The patch rewrites the test so that it can test both commands in the
same way + test IPv6 ndisc cache entries. Additionally, it checks that
arp/ndisc entry was removed by searching for rhost's hwaddr in the cache.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: * test IPv6 NDISC cache entries;
    * remove first test-case: on the second thought, the first test-case
      just repeats what will be done in the second one, so it seems
      useless. I've removed it and increased the number of iterations
      for the second one;
    * remove not used commands from checking with tst_check_cmds().

 testcases/network/tcp_cmds/arp/arp01 |  145 ++++++++++++++--------------------
 1 files changed, 58 insertions(+), 87 deletions(-)

diff --git a/testcases/network/tcp_cmds/arp/arp01 b/testcases/network/tcp_cmds/arp/arp01
index 601b7eb..5357db9 100755
--- a/testcases/network/tcp_cmds/arp/arp01
+++ b/testcases/network/tcp_cmds/arp/arp01
@@ -1,112 +1,83 @@
 #!/bin/sh
-#******************************************************************************
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
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
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
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
-#  FILE   : arp
-#
-#  PURPOSE: To test the basic functionality of `arp`.
-#
-#  SETUP: The "RHOST" setting should be exported to be the hostname of
-#         another machine on the same subnet.  Otherwise, the hostname
-#         of the tested machine will be used.
-#
-#  HISTORY:
-#    06/05/03 Manoj Iyer - manjo@mail.utexas.edu
-#      - Ported to use LTP test harness API
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#-----------------------------------------------------------------------
+# Test basic functionality of 'arp' and 'ip neigh'.
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_setup
-#
-#-----------------------------------------------------------------------
+TCID=arp01
+NUMLOOPS=${NUMLOOPS:-50}
+TST_TOTAL=2
+. test_net.sh
 
 do_setup()
 {
-
-    NUMLOOPS=${NUMLOOPS:-20}
-    TST_TOTAL=$(( $NUMLOOPS * 2 ))
-
-    tst_setup
-    exists arp grep hostname ping sleep whoami
-
-    RHOST=${RHOST:-$(hostname)}
-    SLEEPTIME=${SLEEPTIME:-1}
-    LUSER=$(whoami)
-
-    [ "$LUSER" = "root" ] || end_testcase "Must be root to run this test!"
-
+	tst_require_root
+	tst_check_cmds ip arp grep ping$TST_IPV6
 }
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_test
-#
-#-----------------------------------------------------------------------
-
 do_test()
 {
-    while [ $TST_COUNT -le $NUMLOOPS ]; do
-        arp -a 2>&1 1>/dev/null || end_testcase "arp -a failed"
-        incr_tst_count
-    done
+	local arp_show_cmd=$1
+	local arp_del_cmd=$2
 
-    sleep $SLEEPTIME
+	local entry_name
+	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"
 
-    # PURPOSE:  stress the automatic creation of arp entries by pinging a host
-    #           and deleting the arp entry again.
+	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
+	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
+	tst_resm TINFO "with '$arp_del_cmd'"
 
-    while [ $TST_COUNT -le $TST_TOTAL ]; do
+	for i in $(seq 1 $NUMLOOPS); do
 
-        ping -c1 $RHOST 2>&1 1>/dev/null || end_testcase "ping $RHOST failed"
+		ping$TST_IPV6 -q -c1 $rhost > /dev/null
 
-        if ! arp -a | grep "$RHOST\>" 2>&1 1>/dev/null; then
-            end_testcase "arp -a failed"
-        fi
+		local k
+		local ret=1
+		# wait for arp entry at least 3 seconds
+		for k in $(seq 1 30); do
+			$arp_show_cmd | grep -q $rhost
+			if [ $? -eq 0 ]; then
+				ret=0
+				break;
+			fi
+			usleep 100
+		done
 
-        if ! arp -d $RHOST 2>&1 1>/dev/null; then
-            end_testcase "arp -d $RHOST failed"
-        fi
+		[ "$ret" -ne 0 ] && \
+			tst_brkm TFAIL "$entry_name entry '$rhost' not listed"
 
-        incr_tst_count
+		$arp_del_cmd
 
-        sleep $SLEEPTIME
-
-    done
+		$arp_show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
+			tst_brkm TFAIL "'$arp_del_cmd' failed, entry has " \
+				       "$(tst_hwaddr rhost)' $i/$NUMLOOPS"
+	done
 
+	tst_resm TPASS "verified adding/removing of $entry_name cache entry"
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks outlined in the
-#           prologue.
-# INPUT:    None.
-# OUTPUT:   None.
-#-----------------------------------------------------------------------
+do_setup
 
-. net_cmdlib.sh
+rhost=$(tst_ipaddr rhost)
 
-read_opts $*
-do_setup
-do_test
-end_testcase
+if [ -z "$TST_IPV6" ]; then
+	do_test "arp -a" "arp -d $rhost"
+else
+	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
+fi
+
+do_test "ip neigh show" "ip neigh del $rhost dev $(tst_iface)"
+
+tst_exit
-- 
1.7.1

