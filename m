From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 27 Jun 2016 16:17:40 +0300
Subject: [LTP] [PATCH 1/2] network/tcp_cmds/rwho: fix/cleanup test
Message-ID: <1467033461-18797-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Basically, we need to check if rhost and lhost are listed with
rwho and ruptime. Output parsing with sed is not really needed.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/rwho/rwho01 |  199 +++++++++++---------------------
 1 files changed, 69 insertions(+), 130 deletions(-)

diff --git a/testcases/network/tcp_cmds/rwho/rwho01 b/testcases/network/tcp_cmds/rwho/rwho01
index dc194e9..9842aba 100755
--- a/testcases/network/tcp_cmds/rwho/rwho01
+++ b/testcases/network/tcp_cmds/rwho/rwho01
@@ -1,152 +1,91 @@
 #!/bin/sh
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+# PURPOSE: To test the basic functionality of the rwhod daemon using the
+#          `rwho` and `ruptime` commands.
 #
-#
-#
-#  FILE   : rwho
-#
-#  PURPOSE: To test the basic functionality of the rwhod daemon using the
-#           `rwho` and `ruptime` commands.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed. Also, both machines MUST have
-#         the rwhod daemon installed. However, it does not need to be
-#         active, the test will handle this.
-#
-#  HISTORY:
-#    06/09 Manoj Iyer manjo@mail.utexas.edu
-#    - Modified to use test harness API and also fix defects
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#
-#==============================================================================
-# error codes:  0 rwho/ruptime successful
-#             1 rwho failed no local and remote host in file
-#             2 ruptime failed no local and remote host in file
-#==============================================================================
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_setup
-#
-#-----------------------------------------------------------------------
+TCID=rwho01
+TST_TOTAL=25
+TST_CLEANUP="do_cleanup"
 
-LHOST_PID=""
-RHOST_PID=""
+. test_net.sh
+
+LHOST_PID=
+RHOST_PID=
 
 do_setup()
 {
-    TCtmp=${TCtmp:-$LTPROOT/testcases/bin/$TC${EXEC_SUFFIX}$$}
-
-    SLEEPTIME=${SLEEPTIME:-5}
-    NUMLOOPS=${NUMLOOPS:-25}
-    OUTFILE=${OUTFILE:-$TCtmp/${TC}.out}
-
-    tst_setup
-
-    exists awk cut hostname killall ps rsh rwho
-
-    LHOST=`hostname | cut -f1 -d.`
-    RHOST=${RHOST:-$LHOST}
-
-    trap do_cleanup EXIT
-
-    if ! pgrep -x rwhod > /dev/null; then
-        tst_resm TINFO "Starting rwhod on $LHOST"
-        rwhod || end_testcase "Unable to start rwhod on $LHOST"
-        LHOST_PID=$(pgrep -x rwhod)
-        sleep $SLEEPTIME
-    fi
-
-    if [ "$(rsh -n -l root $RHOST pgrep -x rwhod)" == "" ]; then
-        tst_resm TINFO "Starting rwhod on $RHOST"
-        rsh -n -l root $RHOST /usr/sbin/rwhod
-        RHOST_PID=$(rsh -n -l root $RHOST pgrep -x rwhod)
-        if [ -z "$RHOST_PID" ]; then
-            end_testcase "Unable to start rwhod on $RHOST"
-        fi
-        sleep $SLEEPTIME
-    fi
-
-    RHOSTNAME=`rsh -n -l root $RHOST hostname | cut -f1 -d.`
-    if [ -z "$RHOSTNAME" ]; then
-        end_testcase "Unable to determine RHOSTNAME"
-    fi
+	tst_check_cmds cut hostname killall rwho ruptime
+
+	LHOST=$(hostname | cut -f1 -d.)
+
+	pgrep -x rwhod > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "Starting rwhod on $LHOST"
+		ROD rwhod
+		LHOST_PID=$(pgrep -x rwhod)
+		[ -z "$LHOST_PID" ] && \
+			tst_brkm TBROK "Unable to start rwhod on $LHOST"
+	fi
+
+	tst_rhost_run -c "pgrep -x rwhod" > /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "Starting rwhod on $RHOST"
+		tst_rhost_run -s -c "rwhod"
+		RHOST_PID=$(tst_rhost_run -c "pgrep -x rwhod")
+		[ -z "$RHOST_PID" ] && \
+			tst_brkm TBROK "Unable to start rwhod on $RHOST"
+	fi
+
+	RHOSTNAME=$(tst_rhost_run -c "hostname | cut -f1 -d.")
+	[ "$RHOSTNAME" ] || tst_brkm TBROK "Unable to determine RHOSTNAME"
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
-        rwho -a > $OUTFILE
-        HOST=`grep $LHOST $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
-        [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in rwho outfile"
-        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
-        [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in rwho outfile"
-
-        ruptime -a > $OUTFILE
-        HOST=`grep $LHOST $OUTFILE | sed 's/ .*//' | uniq`
-        [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in ruptime outfile"
-        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/ .*//' | uniq`
-        [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in ruptime outfile"
-
-        tst_resm TINFO "Test $TST_COUNT of $NUMLOOPS complete"
-        incr_tst_count
-    done
+	rwho -a | grep -q $LHOST || \
+		tst_brkm TFAIL "$LHOST isn't in rwho output"
+	rwho -a | grep -q $RHOSTNAME || \
+		tst_brkm TFAIL "$RHOSTNAME isn't in rwho output"
+	ruptime -a | grep -q $LHOST || \
+		tst_brkm TFAIL "$LHOST is not in ruptime outfile"
+	ruptime -a | grep -q $RHOSTNAME || \
+		tst_brkm TFAIL "$RHOSTNAME is not in ruptime outfile"
 }
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_cleanup
-#
-#-----------------------------------------------------------------------
-
 do_cleanup()
 {
-    if [ -n "$LHOST_PID" ]; then
-        tst_resm TINFO "Stopping rwhod on $LHOST"
-        killall rwhod
-    fi
-
-    if [ -n "$RHOST_PID" ]; then
-        tst_resm TINFO "Stopping rwhod on $RHOST"
-        rsh -n -l root $RHOST "killall rwhod"
-    fi
-
-    tst_cleanup
+	if [ "$LHOST_PID" ]; then
+		tst_resm TINFO "Stopping rwhod on $LHOST"
+		killall rwhod
+	fi
+
+	if [ "$RHOST_PID" ]; then
+		tst_resm TINFO "Stopping rwhod on $RHOST"
+		tst_rhost_run -c "killall rwhod"
+	fi
 }
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  MAIN
-#
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
-
-read_opts $*
 do_setup
-do_test
-do_cleanup
-end_testcase
+
+for i in $(seq 1 $TST_TOTAL); do
+	do_test
+	tst_resm TPASS "Test $i/$TST_COUNT complete"
+done
+
+tst_exit
-- 
1.7.1

