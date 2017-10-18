From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 15:49:56 +0200
Subject: [LTP] [RFC PATCH 2/7] net/tcp_cmds: Remove rdist test
In-Reply-To: <20171018135001.30382-1-pvorel@suse.cz>
References: <20171018135001.30382-1-pvorel@suse.cz>
Message-ID: <20171018135001.30382-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rdist is way too old to bother to test it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                      |   1 -
 testcases/network/tcp_cmds/rdist/Makefile |  30 -----
 testcases/network/tcp_cmds/rdist/rdist01  | 187 ------------------------------
 3 files changed, 218 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/rdist/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rdist/rdist01

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index dab7128e8..151b7d22f 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -13,7 +13,6 @@ netstat netstat01
 ping01 ping01.sh
 ping02 ping02.sh
 rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
-rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
 rlogin rlogin01
 rsh rsh01
 sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
diff --git a/testcases/network/tcp_cmds/rdist/Makefile b/testcases/network/tcp_cmds/rdist/Makefile
deleted file mode 100644
index 0d2ad6a29..000000000
--- a/testcases/network/tcp_cmds/rdist/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-#    network/tcp_cmds/rdist testcases Makefile.
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
-INSTALL_TARGETS		:= rdist01
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/rdist/rdist01 b/testcases/network/tcp_cmds/rdist/rdist01
deleted file mode 100755
index 9fdaf1bed..000000000
--- a/testcases/network/tcp_cmds/rdist/rdist01
+++ /dev/null
@@ -1,187 +0,0 @@
-#!/bin/sh
-#
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
-#  FILE   : rdist
-#
-#  PURPOSE: To test the basic functionality of the `rdist` command.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#  HISTORY:
-#    06/06/03 Manoj Iyer manjo@mail.utexas.edu
-#    - Modified testcases to use test harness APIs and fixed defects
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#
-#***********************************************************************
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
-    USER_LIST=${USER_LIST:-'root'}
-    TCdat=${TCdat:-$LTPROOT/testcases/bin/datafiles}
-    TCtmp=${TCtmp:-$LTPROOT/testcases/bin/$TC${EXEC_SUFFIX}$$}
-    FILES=${FILES:-'bin.sm bin.med bin.lg bin.jmb file.dir/bin.sm file.dir/bin.med file.dir/bin.jmb'}
-    SLEEPTIME=${SLEEPTIME:-10}
-
-    tst_setup
-
-    exists awk hostname rdist
-
-    RHOST=${RHOST:-`hostname`}
-
-    # start with a clean LHOST
-    for i in $FILES; do
-        rm -rf $i
-    done
-
-    for i in $FILES; do
-        BASE=$(basename "$i")
-        DIR=$(dirname "$i")
-        test -d "$DIR" || mkdir -p "$DIR"
-        if [ $? -ne 0 ] ; then
-            end_testcase "failed to create $DIR"
-        fi
-        if ! cp $TCdat/$BASE $DIR; then
-            end_testcase "failed to copy $TCdat/$BASE to $DIR"
-        fi
-        chmod 764 $i
-    done
-
-    # get the sum of all the files to rdist on the local machine
-    LSUM=0
-    SUM=`sum -s $FILES | awk '{ print $1 }'`
-    for i in $SUM; do
-        LSUM=$(( $LSUM + $i ))
-    done
-}
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  create_distfile
-# create file $TCtmp/distfile
-#
-#-----------------------------------------------------------------------
-
-create_distfile()
-{
-    T_FILES="FILES = ( "
-    for i in $FILES; do
-        if [ $(dirname "$i") == "." ]; then
-            T_FILES="$T_FILES $i"
-        else
-            T_FILES="$T_FILES $DIR"
-        fi
-    done
-    T_FILES="$T_FILES )"
-
-    T_HOST="HOSTS = ("
-    for c_ruser in $RUSERS; do
-        for c_rhost in $HOSTS; do
-         T_HOST=$T_HOST" $c_ruser@$c_rhost"
-        done
-    done
-
-    T_HOST="$T_HOST)"
-    cat <<EOF > "$TCtmp/distfile"
-$T_HOST
-$T_FILES
-\${FILES} -> \${HOSTS}
-EOF
-}
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  check_result
-#
-# check the sum of all files rdisted from local machine to remote machine
-#
-#-----------------------------------------------------------------------
-
-check_result()
-{
-    cd $TCtmp
-    for c_rhost in $HOSTS; do
-        for c_ruser in $RUSERS; do
-            TOTAL_SUM=0
-            for i in $(rsh -n -l $c_ruser $c_rhost sum -s $FILES | awk '{ print $1 }'); do
-                TOTAL_SUM=$(( $TOTAL_SUM + $i ))
-            done
-            if [ $TOTAL_SUM -eq $LSUM ]; then
-                tst_resm TINFO "Success rdist in $c_ruser@$c_rhost"
-                rsh -n -l $c_ruser $c_rhost "rm -rf $FILES"
-            else
-                end_testcase "Wrong sum doing rdist in $c_ruser@$c_rhost"
-            fi
-       done
-   done
-}
-
-#----------------------------------------------------------------------
-# FUNCTION: do_test
-# PURPOSE:  Perform the necessary steps to complete the test.
-# INPUT:    None.
-# OUPUT:    Error messages are logged if any of the tests fail.
-# EXIT VAR: 0 Success
-#----------------------------------------------------------------------
-
-do_test()
-{
-    HOSTS=""
-    RUSERS=""
-
-    for cur_host in $RHOST; do
-        HOSTS=$HOSTS" $cur_host"
-        for cur_user in $USER_LIST; do
-            RUSERS=$RUSERS" $cur_user"
-            create_distfile
-            if ! rdist -f $TCtmp/distfile; then
-                end_testcase "error doing rdist -f $TCtmp/distfile"
-            fi
-            check_result
-            sleep $SLEEPTIME
-        done
-    done
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

