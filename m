From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 18 Aug 2016 15:10:13 +0300
Subject: [LTP] [PATCH] network/tcp_cmds/arp01: use test_net.sh and add
	test-cases with 'ip neigh'
Message-ID: <1471522213-12836-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

arp01 stress test removes/adds arp entries on the management interface.
This is unwelcome. Moreover, arp command is obsolete and there is
'ip neigh' command that replaces it.

So the patch rewrites test-case into two more general ones that can test
both commands in the same way. Additionally, it checks that arp entry was
removed by searching for rhost's hwaddr in the arp table.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/arp/arp01 |  147 ++++++++++++++--------------------
 1 files changed, 61 insertions(+), 86 deletions(-)

diff --git a/testcases/network/tcp_cmds/arp/arp01 b/testcases/network/tcp_cmds/arp/arp01
index 601b7eb..9da0293 100755
--- a/testcases/network/tcp_cmds/arp/arp01
+++ b/testcases/network/tcp_cmds/arp/arp01
@@ -1,112 +1,87 @@
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
-#  FILE   : arp
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  PURPOSE: To test the basic functionality of `arp`.
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
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_setup
-#
-#-----------------------------------------------------------------------
+TCID=arp01
+NUMLOOPS=${NUMLOOPS:-20}
+TST_TOTAL=4
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
+	tst_check_cmds ip arp grep hostname ping sleep whoami
 }
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_test
-#
-#-----------------------------------------------------------------------
+do_test1()
+{
+	local arp_show_cmd=$1
+	local i
+	tst_resm TINFO "test command that shows arp table: '$arp_show_cmd'"
+	for i in $(seq 1 $NUMLOOPS); do
+		ROD $arp_show_cmd > /dev/null
+	done
+	tst_resm TPASS "verified '$arp_show_cmd' command $NUMLOOPS times"
+}
 
-do_test()
+do_test2()
 {
-    while [ $TST_COUNT -le $NUMLOOPS ]; do
-        arp -a 2>&1 1>/dev/null || end_testcase "arp -a failed"
-        incr_tst_count
-    done
+	local arp_show_cmd=$1
+	local arp_del_cmd=$2
 
-    sleep $SLEEPTIME
+	tst_resm TINFO "stress auto-creation of arp entries with '$arp_del_cmd'"
+	tst_resm TINFO "by pinging '$rhost' and deleting arp entry again"
 
-    # PURPOSE:  stress the automatic creation of arp entries by pinging a host
-    #           and deleting the arp entry again.
+	for i in $(seq 1 $NUMLOOPS); do
 
-    while [ $TST_COUNT -le $TST_TOTAL ]; do
+		ping -q -c1 $rhost > /dev/null
 
-        ping -c1 $RHOST 2>&1 1>/dev/null || end_testcase "ping $RHOST failed"
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
 
-        if ! arp -a | grep "$RHOST\>" 2>&1 1>/dev/null; then
-            end_testcase "arp -a failed"
-        fi
+		[ "$ret" -ne 0 ] && \
+			tst_brkm TFAIL "arp entry '$rhost' not listed"
 
-        if ! arp -d $RHOST 2>&1 1>/dev/null; then
-            end_testcase "arp -d $RHOST failed"
-        fi
+		$arp_del_cmd
 
-        incr_tst_count
+		$arp_show_cmd | grep -q $(tst_hwaddr rhost) && tst_brkm TFAIL \
+			"'$arp_del_cmd' failed, entry has '$(tst_hwaddr rhost)'"
+	done
 
-        sleep $SLEEPTIME
+	tst_resm TPASS "verified adding/removing of arp entry"
+}
 
-    done
+do_setup
 
-}
+rhost=$(tst_ipaddr rhost)
 
-#-----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks outlined in the
-#           prologue.
-# INPUT:    None.
-# OUTPUT:   None.
-#-----------------------------------------------------------------------
+do_test1 "arp -a"
+do_test2 "arp -a" "arp -d $rhost"
 
-. net_cmdlib.sh
+do_test1 "ip neigh show"
+do_test2 "ip neigh show" "ip neigh del $rhost dev $(tst_iface)"
 
-read_opts $*
-do_setup
-do_test
-end_testcase
+tst_exit
-- 
1.7.1

