From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 17 Nov 2020 11:32:08 +0100
Subject: [LTP] [PATCH v2] net/host: update to new api
Message-ID: <20201117103208.1458-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix awk field separator parsing.
Clean test by removing loop and stderr redirection

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes since v1:
 - Remove tst_setup, loop test and stderr redirection
 - Remove RHOST and rename rhost

 testcases/network/tcp_cmds/host/host01.sh | 94 +++++------------------
 1 file changed, 18 insertions(+), 76 deletions(-)

diff --git a/testcases/network/tcp_cmds/host/host01.sh b/testcases/network/tcp_cmds/host/host01.sh
index 1308870f7..638c13cc3 100755
--- a/testcases/network/tcp_cmds/host/host01.sh
+++ b/testcases/network/tcp_cmds/host/host01.sh
@@ -1,87 +1,29 @@
 #!/bin/sh
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
-#
-#
-#
-#  FILE   : host
-#
-#  PURPOSE: To test the basic functionality of the `host` command.
-#
-#  SETUP: If "RHOST" is not exported, then the local hostname is used.
-#
-#  HISTORY:
-#    06/06/03 Manoj Iyer manjo@mail.utexas.edu
-#      - Modified to use LTP tests APIs
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#
-#-----------------------------------------------------------------------
-
-do_setup()
-{
-    NUMLOOPS=${NUMLOOPS:-1}
-    SLEEPTIME=${SLEEPTIME:-0}
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2020
+# Copyright (c) Manoj Iyer <manjo@mail.utexas.edu> 2003
+# Copyright (c) Robbie Williamson <robbiew@us.ibm.com> 2001
+# Copyright (c) International Business Machines  Corp., 2000
 
-    tst_setup
+TST_TESTFUNC="do_test"
+TST_NEEDS_CMDS="awk host hostname"
 
-    exists awk host hostname
-
-    RHOST=${RHOST:-`hostname`}
-
-}
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_test
-#
-#-----------------------------------------------------------------------
+. tst_net.sh
 
 do_test()
 {
+    local test_host=$(hostname)
+    local test_host_addr
 
-    tst_resm TINFO "test basic functionality of the \`$TC' command."
-
-    while [ $TST_COUNT -lt $NUMLOOPS ]; do
-
-        if rhost_addr=$(host $RHOST); then
-            rhost_addr=$(echo "$rhost_addr" | awk -F, '{print $NF}') >/dev/null 2>&1
-            if ! host $rhost_addr >/dev/null 2>&1; then
-                end_testcase "reverse lookup with host failed"
-            fi
-
-        else
-            end_testcase "host $RHOST on local machine failed"
-        fi
-
-        incr_tst_count
-        sleep $SLEEPTIME
-
-    done
+    tst_res TINFO "test basic functionality of the host command."
 
+    if test_host_addr=$(host $test_host); then
+        test_host_addr=$(echo "$test_host_addr" | awk '{print $NF}') >/dev/null
+        EXPECT_PASS host $test_host_addr \>/dev/null
+    else
+        tst_brk TFAIL "host $test_host on local machine failed"
+    fi
 }
 
-#-----------------------------------------------------------------------
-# FUNCTION: MAIN
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
-
-read_opts $*
-do_setup
-do_test
-end_testcase
+tst_run
-- 
2.17.1

