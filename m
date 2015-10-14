From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 14 Oct 2015 12:27:45 +0300
Subject: [LTP] [Committed 2/3] network/nfs_stress: cleanup nfs05 test and
	use nfs_lib.sh
In-Reply-To: <1444814866-20311-1-git-send-email-alexey.kodanev@oracle.com>
References: <1444814866-20311-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1444814866-20311-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/nfs                            |    8 +-
 runtest/stress.part1                   |    8 +-
 testcases/network/nfs/nfs_stress/nfs05 |  220 ++++----------------------------
 3 files changed, 36 insertions(+), 200 deletions(-)

diff --git a/runtest/nfs b/runtest/nfs
index 5bee539..43cf504 100644
--- a/runtest/nfs
+++ b/runtest/nfs
@@ -22,10 +22,12 @@ nfs4_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04
 nfs3_ipv6_04 export VERSION=3 SOCKET_TYPE=udp; nfs04 -6
 nfs4_ipv6_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04 -6
 
-nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
+nfs3_05 export VERSION=3 SOCKET_TYPE=udp; nfs05
+nfs4_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05
+nfs3_ipv6_05 export VERSION=3 SOCKET_TYPE=udp; nfs05 -6
+nfs4_ipv6_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05 -6
 
-# This will run 1 thread on 20 directories with 50 files in each.
-nfsstress export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfsstress 20 50 1
+nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
 
 nfsstat01 export VERSION; TCbin=$LTPROOT/testcases/bin nfsstat01
 nfsx-linux export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin fsx.sh
diff --git a/runtest/stress.part1 b/runtest/stress.part1
index 622fa01..423d25e 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -196,10 +196,10 @@ nfs04 export VERSION=2 SOCKET_TYPE=tcp; nfs04
 nfs04 export VERSION=3 SOCKET_TYPE=udp; nfs04
 nfs04 export VERSION=3 SOCKET_TYPE=tcp; nfs04
 
-nfsstress export VERSION=2 SOCKET_TYPE=udp; nfsstress 20 50 1
-nfsstress export VERSION=2 SOCKET_TYPE=tcp; nfsstress 20 50 1
-nfsstress export VERSION=3 SOCKET_TYPE=udp; nfsstress 20 50 1
-nfsstress export VERSION=3 SOCKET_TYPE=tcp; nfsstress 20 50 1
+nfs05 export VERSION=2 SOCKET_TYPE=udp; nfs05
+nfs05 export VERSION=2 SOCKET_TYPE=tcp; nfs05
+nfs05 export VERSION=3 SOCKET_TYPE=udp; nfs05
+nfs05 export VERSION=3 SOCKET_TYPE=tcp; nfs05
 
 nfsx-linux export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; fsx.sh
 nfsx-linux export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; fsx.sh
diff --git a/testcases/network/nfs/nfs_stress/nfs05 b/testcases/network/nfs/nfs_stress/nfs05
index 6e337d9..0e15c8c 100755
--- a/testcases/network/nfs/nfs_stress/nfs05
+++ b/testcases/network/nfs/nfs_stress/nfs05
@@ -1,207 +1,41 @@
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
-#  FILE   : nfsstress
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  DESCRIPTION: This script sets up the NFS directories in the remote machine
 #               and invokes the program make_tree with parameters.
 #
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#
-#  HISTORY:
-#    11/1/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Created
-#
-#***********************************************************************
-
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-
-$trace_logic
-
-#-----------------------------------------------------------------------
-# Initialize local variables
-#-----------------------------------------------------------------------
-TC=${TC:=nfsstress}
-TCbin=${TCbin:=$LTPROOT/testcases/bin}
-TCsrc=${TCsrc:=$TCbin}
-TCtmp=${TCtmp:=$TMPDIR/$TC$$}
-RHOST=${RHOST:=`hostname|awk {'print $1'}`}
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
-
-# Setting the NFS to version 3 with UDP by default
-PID=$$
-VERSION=${VERSION:=3}
-SOCKET_TYPE=${SOCKET_TYPE:=udp}
-TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-NFS_TYPE=${NFS_TYPE:=nfs}
-
-# If CLEANUP is not set; set it to "ON"
-CLEANUP=${CLEANUP:="ON"}
-
-# If EXECUTABLES is not set; set it to default executables
-EXECUTABLES=${EXECUTABLES:="make_tree"}
-
-DIR_NUM=$1
-FILE_NUM=$2
-THREAD_NUM=$3
-
-DIR_NUM=${DIR_NUM:=100}
-FILE_NUM=${FILE_NUM:=100}
-THREAD_NUM=${THREAD_NUM:=8}
-
-#=============================================================================
-# FUNCTION NAME:        setup_testcase
-#
-# FUNCTION DESCRIPTION: Perform the setup function for the testcase.
-#
-# PARAMETERS:   	None.
-#
-# RETURNS:      	None.
-#=============================================================================
+# Created by: Robbie Williamson (robbiew@us.ibm.com)
 
-setup_testcase()
-{
-$trace_logic
+TCID="nfs05"
+TST_TOTAL=1
+TST_CLEANUP="nfs_cleanup"
 
+DIR_NUM=${DIR_NUM:-"20"}
+FILE_NUM=${FILE_NUM:-"50"}
+THREAD_NUM=${THREAD_NUM:-"8"}
 
-    echo ""
-    echo "Test Options:"
-    echo " VERSION: $VERSION"
-    echo " RHOST: $RHOST"
-    echo " SOCKET_TYPE: $SOCKET_TYPE"
-    echo " NFS_TYPE: $NFS_TYPE"
-    echo ""
-    echo "Test Parameters:"
-    echo " Number of Directories: $DIR_NUM"
-    echo " Number of Files per Directory: $FILE_NUM"
-    echo " Number of Threads: $THREAD_NUM"
-    echo ""
-
-    if [ "x$NFS_TYPE" != "xnfs4" ]; then
-        OPTS=${OPTS:="-o vers=$VERSION,proto=$SOCKET_TYPE "}
-    fi
-    REMOTE_DIR=${RHOST}:$TESTDIR
-    LOCAL_DIR=$TCtmp/${RHOST}
-    mkdir -p $TCtmp || end_testcase "Could not create $TCtmp"
-    chmod 777 $TCtmp
-
-    echo "Setting up remote machine: $RHOST"
-    rsh -n $RHOST "mkdir $TESTDIR"
-    [ $? = 0 ] || end_testcase "Could not create remote directory"
-
-   if [ "x$NFS_TYPE" = "xnfs4" ]; then
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
-
-}
-
-
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
-    EXEC=${EXEC:=$EXECUTABLES -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM}
-    cd $LOCAL_DIR
-    echo "${LOCAL_DIR}/${EXEC} Starting"
-    ./$EXEC &
-    wait $!
-    retval=$?
-    echo "${LOCAL_DIR}/${EXEC} Finished"
-
-    if [ "$retval" != 0 ]; then
-      end_testcase "Errors have resulted from this test: $EXECUTABLES returned $retval."
-    fi
-
-    cd /
-}
-
-
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
-{
-$trace_logic
-    if [ "$CLEANUP" = "ON" ]; then
-	cd \
+. nfs_lib.sh
+. test_net.sh
 
-	echo "Cleaning up testcase"
-	rm -rf $LOCAL_DIR || echo "Cannot remove $LOCAL_DIR"
-	sleep 2
-        /bin/umount $TCtmp || echo "Cannot umount $TCtmp"
-	sleep 2
-	rm -rf $TCtmp || echo "Cannot remove $TCtmp"
-        rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
-		 rsh -n $RHOST "rm -rf $TESTDIR"
-    fi
+nfs_setup
 
-    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-    tst_resm TFAIL "Test Failed: $@"
-    exit 1
-}
+tst_resm TINFO "start nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM"
+ROD nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM
 
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
+tst_resm TPASS "test finished"
 
-setup_testcase
-do_test
-end_testcase
+tst_exit
-- 
1.7.1

