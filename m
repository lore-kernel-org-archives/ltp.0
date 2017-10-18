From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 15:49:58 +0200
Subject: [LTP] [RFC PATCH 4/7] net/tcp_cmds: Remove rsh test
In-Reply-To: <20171018135001.30382-1-pvorel@suse.cz>
References: <20171018135001.30382-1-pvorel@suse.cz>
Message-ID: <20171018135001.30382-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rsh is way too old to bother to test it and it has been
deprecated for many years in favour of ssh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                    |   1 -
 testcases/network/tcp_cmds/rsh/Makefile |  31 ---------
 testcases/network/tcp_cmds/rsh/rsh01    | 115 --------------------------------
 3 files changed, 147 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/rsh/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rsh/rsh01

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 0bbf95edd..d2535ed46 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -13,7 +13,6 @@ netstat netstat01
 ping01 ping01.sh
 ping02 ping02.sh
 rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
-rsh rsh01
 sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
 tcpdump tcpdump01
 telnet telnet01
diff --git a/testcases/network/tcp_cmds/rsh/Makefile b/testcases/network/tcp_cmds/rsh/Makefile
deleted file mode 100644
index f8870a3ec..000000000
--- a/testcases/network/tcp_cmds/rsh/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/tcp_cmds/rsh testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= rsh01
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/rsh/rsh01 b/testcases/network/tcp_cmds/rsh/rsh01
deleted file mode 100755
index 3968f9056..000000000
--- a/testcases/network/tcp_cmds/rsh/rsh01
+++ /dev/null
@@ -1,115 +0,0 @@
-#!/bin/sh
-#
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
-#  FILE   : rsh
-#
-#  PURPOSE: To test the basic functionality of the `rsh` command.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#  HISTORY:
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#
-#
-#----------------------------------------------------------------------
-
-do_setup()
-{
-
-    FAIL_IMMEDIATELY=${FAIL_IMMEDIATELY:-1}
-    SLEEPTIME=${SLEEPTIME:-0}
-    NUMLOOPS=${NUMLOOPS:-1}
-
-    export TST_TOTAL=$NUMLOOPS
-
-    tst_setup
-
-    exists awk hostname rsh
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
-
-do_test()
-{
-
-    while [ $TST_COUNT -le $NUMLOOPS ]; do
-
-        PASSED=0
-
-        if OUT=$(rsh -n -l root $RHOST 'ls -l /etc/hosts'); then
-
-            #
-            # Successful output would be something of the form:
-            #
-            # gcooper@orangebox ~ $ ls -l /etc/hosts
-            # -rw-r--r-- 1 root root 463 Jul  5 09:26 /etc/hosts
-            #
-            echo "$OUT" |
-                awk 'BEGIN { RET=1 } NF == 9 && $NF == "/etc/hosts" { RET=0 } END { exit RET }' \
-                > /dev/null 2>&1
-
-            if [ $? -eq 0 ] ; then
-                tst_resm TPASS "rsh to $RHOST test succeeded"
-                PASSED=1
-            fi
-
-        fi
-
-        if [ $PASSED -ne 1 ] ; then
-            tst_resm TFAIL "rsh to $RHOST failed"
-            # If the first rsh failed, the likelihood that the rest will
-            # succeed is low.
-            if [ "$FAIL_IMMEDIATELY" = "1" ] && [ $TST_COUNT -eq 1 ]; then
-                exit 2
-            fi
-        fi
-
-        sleep $SLEEPTIME
-        incr_tst_count
-
-    done
-
-}
-
-#----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks described in
-#           the prologue.
-# INPUT:    None.
-# OUTPUT:   A testcase run log with the results of the execution of this
-#           test.
-#----------------------------------------------------------------------
-. net_cmdlib.sh
-
-read_opts $*
-do_setup
-do_test
-end_testcase
-- 
2.14.2

