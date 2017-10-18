From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 15:50:00 +0200
Subject: [LTP] [RFC PATCH 6/7] net/tcp_cmds: Remove finger test
In-Reply-To: <20171018135001.30382-1-pvorel@suse.cz>
References: <20171018135001.30382-1-pvorel@suse.cz>
Message-ID: <20171018135001.30382-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

finger is way too old to bother to test it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                       |   1 -
 testcases/network/tcp_cmds/finger/Makefile |  31 -----
 testcases/network/tcp_cmds/finger/finger01 | 203 -----------------------------
 3 files changed, 235 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/finger/Makefile
 delete mode 100755 testcases/network/tcp_cmds/finger/finger01

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 6d062ce76..0c565b055 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -6,7 +6,6 @@ ipneigh01 ipneigh01.sh
 arping01 arping01.sh
 clockdiff01 clockdiff01.sh
 echo export TCbin=$LTPROOT/testcases/network/tcp_cmds/echo; echo01
-finger finger01
 ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
 host host01
 netstat netstat01
diff --git a/testcases/network/tcp_cmds/finger/Makefile b/testcases/network/tcp_cmds/finger/Makefile
deleted file mode 100644
index 891a44f00..000000000
--- a/testcases/network/tcp_cmds/finger/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/tcp_cmds/finger testcases Makefile.
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
-INSTALL_TARGETS		:= finger01
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
deleted file mode 100755
index 59c239722..000000000
--- a/testcases/network/tcp_cmds/finger/finger01
+++ /dev/null
@@ -1,203 +0,0 @@
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
-#  FILE   : finger
-#
-#  PURPOSE: To test the basic functionality of the `finger` command.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed. Also, both machines MUST have
-#         the fingerd daemon active (see inetd or xinetd config file).
-#
-#  HISTORY:
-#    06/06/03 Manoj Iyer - manjo@mail.utexas.edu
-#      - Ported tests to use test macro
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
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
-    # Start fingerd locally and remotely.
-    export TST_TOTAL=3
-
-    tst_setup
-
-    exists awk finger hostname netstat rsh whoami
-
-    LHOST=$(hostname)
-    LUSER=$(whoami)
-    RUSER=root
-    RHOST=${RHOST:-$(hostname)}
-    SLEEPTIME=${SLEEPTIME:-1}
-
-    exists awk finger netstat rsh whoami
-
-    [ "$LUSER" = "root" ] || end_testcase "MUST BE root to run the test!"
-
-    FINGER=$(netstat -a | grep ":finger" |awk '{print $6}')
-    if [ "$FINGER" != "LISTEN" ]; then
-        end_testcase "Please start fingerd locally."
-    fi
-
-    FINGER=$(rsh -n $RHOST netstat -a |grep ":finger"|awk '{print $6}')
-    if [ "$FINGER" != "LISTEN" ]; then
-        end_testcase "Please start fingerd on remote host."
-    fi
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: do_test1
-# PURPOSE: Run finger with no flags
-# INPUT:    None.
-# OUTPUT:   Error messages are logged for all discrepancies found.
-#-----------------------------------------------------------------------
-
-do_test1()
-{
-    tst_resm TINFO "finger: do_test1 started"
-
-    finger @$LHOST  2>&1 1>/dev/null
-    [ $? = 0 ] || end_testcase "finger @$LHOST"
-    finger @$RHOST  2>&1 1>/dev/null
-    [ $? = 0 ] || end_testcase "finger @$RHOST"
-
-    # Testing finger command with user argument
-
-    finger $LUSER 2>&1 1>/dev/null || end_testcase "finger $LUSER"
-    if ! finger $LUSER@$LHOST  2>&1 1>/dev/null; then
-        end_testcase "finger $LUSER@$LHOST"
-    fi
-    finger $RUSER@$RHOST 2>&1 1>/dev/null || end_testcase "finger @$RUSER"
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: do_test2
-# PURPOSE:  To run the "finger User@host" commands and verify that the
-#           "finger" command is functioning properly.
-# INPUT:    None.
-# OUTPUT:   Error messages are logged for all discrepancies found.
-#-----------------------------------------------------------------------
-
-do_test2()
-{
-    tst_resm TINFO "finger: do_test2 (-bad flag) started"
-    BADUSER="uuuu"
-    BADHOST="xxxx"
-
-    tst_resm TINFO "finger -badflag default "
-    finger -x 2> /dev/null && end_testcase "finger -x should fail"
-
-    tst_resm TINFO "finger -bad user "
-    [ "$(finger $BADUSER 2>&1 1>/dev/null)" ] || end_testcase "finger $BADUSER"
-    [ "$(finger @$BADHOST 2>&1 1>/dev/null)" ] || \
-        end_testcase "finger @$BADHOST"
-    [ "$(finger $BADUSER@$BADHOST 2>&1 1>/dev/null)" ] || \
-        end_testcase "finger $BADUSER@$BADHOST"
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: do_test3
-# PURPOSE:  To run the "finger -flag User@Host" commands and verify that the
-#           "finger" command is functioning properly.
-# INPUT:    None.
-# OUTPUT:   Error messages are logged for all discrepancies found.
-#-----------------------------------------------------------------------
-
-do_test3()
-{
-    tst_resm TINFO "finger: do_test3 (-f flag) started"
-
-    tst_resm TINFO "finger -l : gives a long listing"
-    finger -l  2>&1 1>/dev/null || end_testcase "finger -l"
-    finger -l $LUSER 2>&1 1>/dev/null || end_testcase "finger -l $LUSER"
-    finger -l @$LHOST 2>&1 1>/dev/null || end_testcase "finger -l @$LHOST"
-    if ! finger -l $LUSER@$LHOST 2>&1 1>/dev/null; then
-        end_testcase "finger -l $LUSER@$LHOST"
-    fi
-    finger -l @$RHOST  2>&1 1>/dev/null || end_testcase "finger -l @$RHOST"
-    if ! finger -l $RUSER@$RHOST  2>&1 1>/dev/null; then
-        end_testcase "finger -l $RUSER@$RHOST"
-    fi
-
-    tst_resm TINFO "finger -m : assures that user is a user ID discretionary"
-    finger -m 2>&1 1>/dev/null || end_testcase "finger -m"
-    finger -m $LUSER 2>&1 1>/dev/null || end_testcase "finger -m $LUSER"
-    finger -m @$LHOST 2>&1 1>/dev/null || end_testcase "finger -m @$LHOST"
-    if ! finger -m $LUSER@$LHOST 2>&1 1>/dev/null; then
-        end_testcase "finger -m $LUSER@$LHOST"
-    fi
-    finger -m @$RHOST 2>&1 1>/dev/null || end_testcase "finger -m @$RHOST"
-    if ! finger -m $RUSER@$RHOST  2>&1 1>/dev/null; then
-        end_testcase "finger -m $RUSER@$RHOST"
-    fi
-
-    tst_resm TINFO "finger -p : suppresses printing of .plan files on long and \
-        brief long formats"
-    finger -p  2>&1 1>/dev/null || end_testcase "finger -p"
-    finger -p $LUSER  2>&1 1>/dev/null || end_testcase "finger -p $LUSER"
-    finger -p @$LHOST  2>&1 1>/dev/null || end_testcase "finger -p @$LHOST"
-    if ! finger -p $LUSER@$LHOST  2>&1 1>/dev/null; then
-        end_testcase "finger -p $LUSER@$LHOST"
-    fi
-    finger -p @$RHOST  2>&1 1>/dev/null || end_testcase "finger -p @$RHOST"
-    if ! finger -p $RUSER@$RHOST 2>&1 1>/dev/null; then
-        end_testcase "finger -p $RUSER@$RHOST"
-    fi
-
-    tst_resm TINFO "finger -s : gives a short format list"
-    finger -s  2>&1 1>/dev/null || end_testcase "finger -s"
-    finger -s $LUSER 2>&1 1>/dev/null || end_testcase "finger -s $LUSER "
-    finger -s @$LHOST 2>&1 1>/dev/null || end_testcase "finger -s @$LHOST"
-    if ! finger -s $LUSER@$LHOST 2>&1 1>/dev/null; then
-        end_testcase "finger -s $LUSER@$LHOST"
-    fi
-    finger -s @$RHOST 2>&1 1>/dev/null || end_testcase "finger -s @$RHOST"
-    if ! finger -s $RUSER@$RHOST 2>&1 1>/dev/null; then
-        end_testcase "finger -s $RUSER@$RHOST"
-    fi
-
-}
-
-#-----------------------------------------------------------------------
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks outlined in the
-#           prologue.
-# INPUT:    None.
-# OUTPUT:   None.
-#-----------------------------------------------------------------------
-. net_cmdlib.sh
-
-read_opts $*
-do_setup
-for TST_COUNT in 1 2 3; do
-    eval "do_test$TST_COUNT"
-    sleep $SLEEPTIME
-done
-end_testcase
-- 
2.14.2

