From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Jun 2016 17:28:52 +0300
Subject: [LTP] [PATCH 4/8] network/nfs/fsx: cleanup test,
	use test_net library
In-Reply-To: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
References: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1466432936-3099-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With nfs_lib.sh we can test several versions of NFS,
so changing test-cases in runtest/net.nfs as well.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.nfs                        |   10 ++-
 testcases/network/nfs/fsx-linux/fsx.sh |  204 +++++---------------------------
 2 files changed, 38 insertions(+), 176 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 7208a3b..5853573 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -50,4 +50,12 @@ nfs42_ipv6_05 nfs05 -6 -v 4.2 -t tcp
 nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
 
 nfsstat01 export VERSION; TCbin=$LTPROOT/testcases/bin nfsstat01
-nfsx-linux export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin fsx.sh
+
+nfsx3 fsx.sh -v 3 -t udp
+nfsx4 fsx.sh -v 4 -t tcp
+nfsx41 fsx.sh -v 4.1 -t tcp
+nfsx42 fsx.sh -v 4.2 -t tcp
+nfsx3_ipv6 fsx.sh -6 -v 3 -t udp
+nfsx4_ipv6 fsx.sh -6 -v 4 -t tcp
+nfsx41_ipv6 fsx.sh -6 -v 4.1 -t tcp
+nfsx42_ipv6 fsx.sh -6 -v 4.2 -t tcp
diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index facc708..9f2e437 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -1,194 +1,48 @@
-#! /bin/sh
+#!/bin/sh
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : fsx.sh
 #
 #  PURPOSE: Runs the fsx-linux tool with a 50000 iterations setting to
 #	    attempt to uncover the "doread:read input/output" error
 #	    received if the latest NFS patches for 2.4.17 from Trond
 #	    are not applied. http://nfs.sf.net
-#
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#
-#  HISTORY:
-#    12/18/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Written
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
-TC=${TC:=fsx}
-TCbin=${TCbin:=`pwd`}
-TCdat=${TCdat:=$TCbin}
-TCsrc=${TCsrc:=$TCbin}
-TCtmp=${TCtmp:=$TCbin/$TC$$}
-TCdump=${TCdump:=$TCbin}
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
-
-# If CLEANUP is not set; set it to "ON"
-CLEANUP=${CLEANUP:="ON"}
-
-# If EXECUTABLES is not set; set it to default executables
-EXECUTABLES=${EXECUTABLES:="fsx-linux"}
-
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
-
-setup_testcase()
-{
-$trace_logic
-
-    PID=$$
-
-    VERSION=${VERSION:=3}
-    RHOST=${RHOST:=`hostname`}
-    ITERATIONS=${ITERATIONS:=50000}
-    SOCKET_TYPE=${SOCKET_TYPE:=udp}
-    TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-    NFS_TYPE=${NFS_TYPE:=nfs}
 
-    echo ""
-    echo "Test Options:"
-    echo " VERSION: $VERSION"
-    echo " RHOST: $RHOST"
-    echo " ITERATIONS: $ITERATIONS"
-    echo " SOCKET_TYPE: $SOCKET_TYPE"
-    echo " NFS_TYPE: $NFS_TYPE"
+TCID=nfsx
+TST_TOTAL=1
+TST_CLEANUP="nfs_cleanup"
 
-    if [ "x$NFS_TYPE" != "xnfs4" ]; then
-        OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
-    fi
+. nfs_lib.sh
+. test_net.sh
 
-    REMOTE_DIR=${RHOST}:${TESTDIR}
-    LUSER=${LUSER:=root}
-    mkdir -p $TCtmp || end_testcase "Could not create $TCtmp"
-    chmod 777 $TCtmp
-
-    echo "Setting up remote machine: $RHOST"
-    rsh -n $RHOST "mkdir $TESTDIR"
-    [ $? = 0 ] || end_testcase "Could not create remote directory"
-    rsh -n $RHOST "touch $TESTDIR/testfile"
-    [ $? = 0 ] || end_testcase "Could not create testfile in remote directory"
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
 do_test()
 {
-$trace_logic
-    for executable in $EXECUTABLES
-    do
-
-        cd $TCbin
-    	echo "${executable} -N $ITERATIONS $TCtmp/testfile Starting"
-	./${executable} -N $ITERATIONS $TCtmp/testfile 2>&1
-	retval=$?
-    	echo "${executable} -N $ITERATIONS $TCtmp/testfile Finished"
-
-	if [ "$retval" != 0 ]; then
-		end_testcase "Errors have resulted from this test"
+	ITERATIONS=${ITERATIONS:=50000}
+	tst_resm TINFO "starting fsx-linux -N $ITERATIONS..."
+	fsx-linux -N $ITERATIONS testfile 2>&1 > fsx-out.log
+	if [ "$?" -ne 0 ]; then
+		tst_resm TFAIL "Errors have resulted from this test"
+		cat fsx-out.log
+	else
+		tst_resm TPASS "fsx-linux test passed"
 	fi
-
-    done
 }
 
+nfs_setup
 
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
-
-	echo "Cleaning up testcase"
-        cd $HOME
-    	echo "Unmounting $TCtmp"
-	sleep 2
-        umount $TCtmp || { echo "Cannot umount $TCtmp"; exit 1; }
-	rm -rf $TCtmp || echo "Cannot remove $TCtmp"
-        rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
- rsh -n $RHOST "rm -rf $TESTDIR"
-    fi
-
-    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-    tst_resm TFAIL "Test Failed: $@"
-    exit 1
-}
-
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
-
-setup_testcase
 do_test
-end_testcase
+
+tst_exit
-- 
1.7.1

