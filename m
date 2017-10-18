From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 15:49:59 +0200
Subject: [LTP] [RFC PATCH 5/7] net/tcp_cmds: Remove rcp test
In-Reply-To: <20171018135001.30382-1-pvorel@suse.cz>
References: <20171018135001.30382-1-pvorel@suse.cz>
Message-ID: <20171018135001.30382-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rcp is way too old to bother to test it as it has been
deprecated for many years in favour of scp.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                    |   1 -
 testcases/network/tcp_cmds/rcp/Makefile |  30 -------
 testcases/network/tcp_cmds/rcp/rcp01    | 144 --------------------------------
 3 files changed, 175 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/rcp/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rcp/rcp01

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index d2535ed46..6d062ce76 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -12,7 +12,6 @@ host host01
 netstat netstat01
 ping01 ping01.sh
 ping02 ping02.sh
-rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
 sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
 tcpdump tcpdump01
 telnet telnet01
diff --git a/testcases/network/tcp_cmds/rcp/Makefile b/testcases/network/tcp_cmds/rcp/Makefile
deleted file mode 100644
index 7cb00b096..000000000
--- a/testcases/network/tcp_cmds/rcp/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-#    network/tcp_cmds/rcp testcases Makefile.
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
-# Ngie Cooper, September 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
-
-INSTALL_TARGETS		:= rcp01
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/rcp/rcp01 b/testcases/network/tcp_cmds/rcp/rcp01
deleted file mode 100755
index 1f54471cd..000000000
--- a/testcases/network/tcp_cmds/rcp/rcp01
+++ /dev/null
@@ -1,144 +0,0 @@
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
-#  FILE   : rcp
-#
-#  PURPOSE: To test the basic functionality of the `rcp` command.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#  HISTORY:
-#    06/06/03 Manoj Iyer manjo@mail.utexas.edu
-#    - Modified testcases to use test APIS and fixed bugs
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#
-#-----------------------------------------------------------------------
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_setup
-#
-#-----------------------------------------------------------------------
-
-do_setup()
-{
-
-    TCtmp=${TCtmp:-$LTPROOT/testcases/bin/$TC${EXEC_SUFFIX}$$}
-    TCdat=${TCdat:-$LTPROOT/testcases/bin/datafiles}
-    LHOST=`hostname`
-    RHOST=${RHOST:-$LHOST}
-    SLEEPTIME=${SLEEPTIME:-0}
-    FILES=${FILES:-"bin.sm bin.med bin.lg bin.jmb"}
-
-    tst_setup
-
-    exists awk rcp rsh sum
-
-    if ! rsh -n -l root $RHOST mkdir -p $TCtmp 2>&1 1>/dev/null; then
-        end_testcase "Remote mkdir failed"
-    fi
-
-    trap do_cleanup EXIT
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
-    for j in $FILES; do
-
-        if ! rcp $TCdat/$j $RHOST:$TCtmp/$j; then
-            end_testcase "Failed to rcp file."
-        fi
-
-        SUM1=`sum $TCdat/$j | awk '{print $1}'`
-        SUM2=`rsh -n -l root $RHOST sum $TCtmp/$j | awk '{print $1}'`
-        rsh -n -l root $RHOST "rm -f $TCtmp/$j"
-        sleep $SLEEPTIME
-
-        if [ "$SUM1 = $SUM2" ]; then
-            tst_resm TINFO "rcp $TCdat/$j $RHOST:$TCtmp/$j successful"
-        else
-            end_testcase "FAILED: wrong sum in transfer to $RHOST"
-        fi
-
-        sleep $SLEEPTIME
-
-    done
-
-    for j in $FILES; do
-
-        tst_resm TINFO "remote copying $RHOST:$TCdat/$j to $TCtmp/$j"
-        if ! rcp $RHOST:$TCdat/$j $TCtmp/$j 2>&1 1>/dev/null; then
-            tst_resm TFAIL "Failed to rcp file."; continue
-        fi
-
-        SUM1=`sum $TCtmp/$j | awk '{print $1}'`
-        SUM2=`rsh -n -l root $RHOST sum $TCdat/$j | awk '{print $1}'`
-        rm -f $TCtmp/$j
-        sleep $SLEEPTIME
-
-        if [ "$SUM1" = "$SUM2" ]; then
-            tst_resm TINFO "rcp $RHOST:$TCdat/$j $TCtmp/$j successful"
-        else
-            end_testcase "FAILED: wrong sum in transfer to $LHOST from $RHOST"
-        fi
-        sleep $SLEEPTIME
-
-    done
-
-}
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_cleanup
-#
-#-----------------------------------------------------------------------
-
-do_cleanup()
-{
-    rsh -n -l root $RHOST rmdir $TCtmp
-    tst_cleanup
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

