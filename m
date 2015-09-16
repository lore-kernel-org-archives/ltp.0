From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Sep 2015 12:49:46 +0300
Subject: [LTP] [PATCH] network/nfs01: add IPv6 test-cases
Message-ID: <1442396986-30000-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* cleanup test, apply test_net.sh library
* don't use loop for test binaries because there is only one
  right now, 'open_files'
* use tst_tmpdir()
* update test-cases in runtest, add NFS over IPv6
* make four test-cases with NFS v3 and v4.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/nfs                       |    6 +-
 runtest/stress.part1              |    8 +-
 testcases/network/nfs/nfs01/nfs01 |  245 ++++++++++--------------------------
 3 files changed, 77 insertions(+), 182 deletions(-)

diff --git a/runtest/nfs b/runtest/nfs
index 19f2344..7bee16f 100644
--- a/runtest/nfs
+++ b/runtest/nfs
@@ -2,7 +2,11 @@
 #
 # PLEASE READ THE README FILE IN /nfs BEFORE RUNNING THESE.
 #
-nfs01 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs01
+nfs3_01 export VERSION=3 SOCKET_TYPE=udp; nfs01
+nfs4_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01
+nfs3_ipv6_01 export VERSION=3 SOCKET_TYPE=udp; nfs01 -6
+nfs4_ipv6_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01 -6
+
 nfs02 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs02
 nfs03 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs03
 nfs04 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs04
diff --git a/runtest/stress.part1 b/runtest/stress.part1
index fc8363d..9ad21d9 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -176,10 +176,10 @@ ftest06 ftest06
 ftest07 ftest07
 ftest08 ftest08
 
-nfs01 export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs01
-nfs01 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs01
-nfs01 export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs01
-nfs01 export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs01
+nfs01 export VERSION=2 SOCKET_TYPE=udp; nfs01
+nfs01 export VERSION=2 SOCKET_TYPE=tcp; nfs01
+nfs01 export VERSION=3 SOCKET_TYPE=udp; nfs01
+nfs01 export VERSION=3 SOCKET_TYPE=tcp; nfs01
 
 nfs02 export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs02
 nfs02 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs02
diff --git a/testcases/network/nfs/nfs01/nfs01 b/testcases/network/nfs/nfs01/nfs01
index 77d2775..eab2e74 100755
--- a/testcases/network/nfs/nfs01/nfs01
+++ b/testcases/network/nfs/nfs01/nfs01
@@ -1,24 +1,19 @@
-#! /bin/sh
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2001
 #
-#   Copyright (c) International Business Machines  Corp., 2001
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
-#   but WITHOUT ANY WARRANTY;  without even the implie; warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : nfs01
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  PURPOSE: Stresses NFS by opening a large number of files on a nfs
 #           mounted filesystem.
@@ -28,185 +23,81 @@
 #         where the test is executed.
 #
 #
-#  HISTORY:
-#    04/27/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#***********************************************************************
+# Ported by Robbie Williamson (robbiew@us.ibm.com)
 
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
 
-$trace_logic
+TCID="nfs01"
+TST_TOTAL=1
+TST_CLEANUP="cleanup"
 
-#-----------------------------------------------------------------------
-# Initialize local variables
-#-----------------------------------------------------------------------
-TC=${TC:=nfs01}
-TCbin=${TCbin:=`pwd`}
-TCdat=${TCdat:=$TCbin}
-TCsrc=${TCsrc:=$TCbin}
-TCtmp=${TCtmp:=$TCbin/$TC$$}
-TCdump=${TCdump:=$TCbin}
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
+. test_net.sh
 
-# If CLEANUP is not set; set it to "ON"
-CLEANUP=${CLEANUP:="ON"}
+setup_testcase()
+{
+	VERSION=${VERSION:=3}
+	NFILES=${NFILES:=1000}
+	SOCKET_TYPE="${SOCKET_TYPE:=udp}${TST_IPV6}"
+	NFS_TYPE=${NFS_TYPE:=nfs}
 
-# If EXECUTABLES is not set; set it to default executables
-EXECUTABLES=${EXECUTABLES:="open_files"}
+	tst_check_cmds mount exportfs
 
+	tst_tmpdir
 
-#=============================================================================
-# FUNCTION NAME:        setup_testcase
-#
-# FUNCTION DESCRIPTION: Perform the setup function for the testcase.
-#
-# PARAMETERS:   	None.
-#
-# RETURNS:      	None.
-#=============================================================================
+	tst_resm TINFO "NFS_TYPE: $NFS_TYPE, NFS VERSION: $VERSION"
+	tst_resm TINFO "NFILES: $NFILES, SOCKET_TYPE: $SOCKET_TYPE"
 
-setup_testcase()
-{
-$trace_logic
-
-    PID=$$
-
-    VERSION=${VERSION:=3}
-    RHOST=${RHOST:=`hostname`}
-    NFILES=${NFILES:=1000}
-    SOCKET_TYPE=${SOCKET_TYPE:=udp}
-    TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-    NFS_TYPE=${NFS_TYPE:=nfs}
-
-    echo ""
-    echo "Test Options:"
-    echo " VERSION: $VERSION"
-    echo " RHOST: $RHOST"
-    echo " NFILES: $NFILES"
-    echo " SOCKET_TYPE: $SOCKET_TYPE"
-    echo " NFS_TYPE: $NFS_TYPE"
-    echo " TESTDIR: $TESTDIR"
-
-    if [ "x$NFS_TYPE" != "xnfs4" ]; then
-        OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
-    fi
-
-    REMOTE_DIR=${RHOST}:${TESTDIR}
-    LOCAL_DIR=$TCtmp/${RHOST}.${LUSER}
-    LUSER=${LUSER:=root}
-    mkdir -p $TCtmp || end_testcase "Could not create $TCtmp"
-    chmod 777 $TCtmp
-
-    echo "Setting up remote machine: $RHOST"
-    rsh -n $RHOST "mkdir -p $TESTDIR"
-    [ $? = 0 ] || end_testcase "Could not create remote directory"
-
-    if [ "x$NFS_TYPE" = "xnfs4" ]; then
-        rsh -n $RHOST "mkdir -p /export$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not create /export$TESTDIR on server"
-        rsh -n $RHOST "mount --bind $TESTDIR /export$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not bind $TESTDIR to export on server"
-        rsh -n $RHOST "/usr/sbin/exportfs -o no_root_squash,rw,nohide,insecure,no_subtree_check *:$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not export remote directory"
-    else
-        rsh -n $RHOST "/usr/sbin/exportfs -i -o no_root_squash,rw *:$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not export remote directory"
-    fi
-
-    echo "Mounting NFS filesystem $REMOTE_DIR on $TCtmp with options '$OPTS'"
-    mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TCtmp || end_testcase "Cannot mount $TCtmp"
-    [ $? = 0 ] || end_testcase "Could not mount $REMOTE_DIR"
-
-    cd $TCtmp
-    echo "Removing old and create new directories"
-    [ -d $LOCAL_DIR ] && rm -rf $LOCAL_DIR
-    [ -d $LOCAL_DIR ] || { \
-	mkdir -p $LOCAL_DIR || end_testcase "Could not create $LOCAL_DIR"
-	chmod 777 $LOCAL_DIR
-        cp $TCsrc/$EXECUTABLES $LOCAL_DIR || end_testcase "Could not write to mount point"
-    }
-}
+	if [ "$NFS_TYPE" != "nfs4" ]; then
+		OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
+	fi
 
+	tst_rhost_run -s -c "mkdir -p $TST_TMPDIR"
 
-#=============================================================================
-# FUNCTION NAME:        do_test
-#
-# FUNCTION DESCRIPTION: Perform the test
-#
-# PARAMETERS:   	None.
-#
-# RETURNS:      	None.
-#=============================================================================
-do_test()
-{
-$trace_logic
-    for executable in $EXECUTABLES
-    do
-
-        cd $LOCAL_DIR
-    	echo "${LOCAL_DIR}/${executable} $NFILES Starting"
-	./${executable} $NFILES 2>&1
-	retval=$?
-    	echo "${LOCAL_DIR}/${executable} $NFILES Finished"
-
-	if [ "$retval" != 0 ]; then
-		end_testcase "Errors have resulted from this test"
+	if [ $TST_IPV6 ]; then
+		REMOTE_DIR="[$(tst_ipaddr rhost)]:$TST_TMPDIR"
+	else
+		REMOTE_DIR="$(tst_ipaddr rhost):$TST_TMPDIR"
 	fi
 
-        cd $HOME
-    	echo "Unmounting $TCtmp"
-	sleep 2
-        umount $TCtmp || error "Cannot umount $TCtmp"
-    done
-}
+	if [ "$NFS_TYPE" = "nfs4" ]; then
+		tst_rhost_run -s -c "mkdir -p /export$TST_TMPDIR"
+		tst_rhost_run -s -c "mount --bind $TST_TMPDIR /export$TST_TMPDIR"
+		tst_rhost_run -s -c "exportfs -o no_root_squash,rw,nohide,\
+			insecure,no_subtree_check *:$TST_TMPDIR"
+	else
+		tst_rhost_run -s -c "exportfs -i -o no_root_squash,rw \
+			*:$TST_TMPDIR"
+	fi
 
+	tst_resm TINFO "Mounting NFS '$REMOTE_DIR' with options '$OPTS'"
+	ROD mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TST_TMPDIR
+}
 
-#=============================================================================
-# FUNCTION NAME:        end_testcase
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:   	None.
-#
-# RETURNS:      	None.
-#=============================================================================
-end_testcase()
+do_test()
 {
-$trace_logic
-    if [ "$CLEANUP" = "ON" ]; then
-	cd \
-
-	echo "Cleaning up testcase"
-
-        mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TCtmp || echo "Cannot mount $TCtmp"
-	rm -rf $LOCAL_DIR || echo "Cannot remove $LOCAL_DIR"
-        /bin/umount $TCtmp || echo "Cannot umount $TCtmp"
-	rm -rf $TCtmp || echo "Cannot remove $TCtmp"
-        rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
-		 rsh -n $RHOST "rm -rf $TESTDIR"
-    fi
-
-    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-    tst_resm TFAIL "Test Failed: $@"
-    exit 1
+	tst_resm TINFO "starting 'open_files $NFILES'"
+	ROD open_files $NFILES
+
+	cd $LTPROOT
+	ROD umount $TST_TMPDIR
+	tst_resm TPASS "test finished successfully"
 }
 
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
+cleanup()
+{
+	tst_resm TINFO "Cleaning up testcase"
+	cd $LTPROOT
+	grep -q "$TST_TMPDIR" /proc/mounts && umount $TST_TMPDIR
+
+	tst_rhost_run -c "exportfs -u *:$TST_TMPDIR"
+	tst_rhost_run -c "rm -rf $TST_TMPDIR"
+}
 
 # Check if current filesystem is NFS
-
-STR=`stat -f . | grep "Type: nfs"`
-if [ -n "$STR" ]; then
-        test_resm TCONF "Cannot run nfs stress test on an NFS mounted filesystem"
-        exit 0
+if [ "$(stat -f . | grep "Type: nfs")" ]; then
+	tst_resm TCONF "Cannot run nfs-stress test on mounted NFS"
 fi
 
 setup_testcase
 do_test
-end_testcase
+
+tst_exit
-- 
1.7.1

