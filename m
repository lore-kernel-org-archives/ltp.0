From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 16:09:28 +0300
Subject: [LTP] [PATCH 10/10] network/nfs04: cleanup and use nfs_lib.sh
In-Reply-To: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1443618568-29200-10-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The previous version created test files in tmp directory,
then copied it to NFS mount. This version creates the file
directly on NFS mount.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/nfs                            |    6 +-
 runtest/stress.part1                   |    8 +-
 testcases/network/nfs/nfs_stress/nfs04 |  213 ++++----------------------------
 3 files changed, 36 insertions(+), 191 deletions(-)

diff --git a/runtest/nfs b/runtest/nfs
index 3ab2eb8..5bee539 100644
--- a/runtest/nfs
+++ b/runtest/nfs
@@ -17,7 +17,11 @@ nfs4_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03
 nfs3_ipv6_03 export VERSION=3 SOCKET_TYPE=udp; nfs03 -6
 nfs4_ipv6_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03 -6
 
-nfs04 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs04
+nfs3_04 export VERSION=3 SOCKET_TYPE=udp; nfs04
+nfs4_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04
+nfs3_ipv6_04 export VERSION=3 SOCKET_TYPE=udp; nfs04 -6
+nfs4_ipv6_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04 -6
+
 nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
 
 # This will run 1 thread on 20 directories with 50 files in each.
diff --git a/runtest/stress.part1 b/runtest/stress.part1
index af5f69d..622fa01 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -191,10 +191,10 @@ nfs03 export VERSION=2 SOCKET_TYPE=tcp; nfs03
 nfs03 export VERSION=3 SOCKET_TYPE=udp; nfs03
 nfs03 export VERSION=3 SOCKET_TYPE=tcp; nfs03
 
-nfs04 export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs04
-nfs03 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs04
-nfs03 export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs04
-nfs03 export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs04
+nfs04 export VERSION=2 SOCKET_TYPE=udp; nfs04
+nfs04 export VERSION=2 SOCKET_TYPE=tcp; nfs04
+nfs04 export VERSION=3 SOCKET_TYPE=udp; nfs04
+nfs04 export VERSION=3 SOCKET_TYPE=tcp; nfs04
 
 nfsstress export VERSION=2 SOCKET_TYPE=udp; nfsstress 20 50 1
 nfsstress export VERSION=2 SOCKET_TYPE=tcp; nfsstress 20 50 1
diff --git a/testcases/network/nfs/nfs_stress/nfs04 b/testcases/network/nfs/nfs_stress/nfs04
index 7518d5b..b2375ab 100755
--- a/testcases/network/nfs/nfs_stress/nfs04
+++ b/testcases/network/nfs/nfs_stress/nfs04
@@ -1,197 +1,38 @@
-#! /bin/sh
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2003
 #
-#   Copyright (c) International Business Machines  Corp., 2003
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
-#  FILE   : nfs04.sh
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  PURPOSE: Creates a text file of specified size locally and copies
-#	    the file to an NFS mountpoint.  The two files are compared
-#	    and checked for differences.  If the files differ, then
-#	    the test fails.  By default, this test creates a 10Mb file
-#	    and runs for one loop.
-#
+#           the file to an NFS mountpoint.  The two files are compared
+#           and checked for differences.  If the files differ, then
+#           the test fails.  By default, this test creates a 10Mb file
+#           and runs for one loop.
 #
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#
-#  HISTORY:
-#    10/17/03 Robbie Williamson (robbiew@us.ibm.com)
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
-TC=${TC:=nfs04}
-TCbin=${TCbin:=`pwd`}
-TCtmp=${TCtmp:=/tmp/$TC$$}
-export TCID=$TC
-export TST_TOTAL=1
-
-# If CLEANUP is not set; set it to "ON"
-CLEANUP=${CLEANUP:="ON"}
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
+# Created by: Robbie Williamson (robbiew@us.ibm.com)
 
-    PID=$$
+TCID="nfs04"
+TST_TOTAL=1
+TST_CLEANUP="nfs_cleanup"
 
-    VERSION=${VERSION:=3}
-    RHOST=${RHOST:=`hostname`}
-    FILESIZE=${FILESIZE:=10}
-    SOCKET_TYPE=${SOCKET_TYPE:=udp}
-    TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-    NFS_TYPE=${NFS_TYPE:=nfs}
-    LOOPS=${LOOPS:=1}
-    export TST_COUNT=$LOOPS
-
-    echo ""
-    echo "Test Options:"
-    echo " VERSION: $VERSION"
-    echo " RHOST: $RHOST"
-    echo " FILESIZE: $FILESIZE"
-    echo " SOCKET_TYPE: $SOCKET_TYPE"
-    echo " TESTDIR: $TESTDIR"
-    echo " NFS_TYPE: $NFS_TYPE"
-    echo " LOOPS: $LOOPS"
-
-    if [ "x$NFS_TYPE" != "xnfs4" ]; then
-        OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
-    fi
-
-    REMOTE_DIR=${RHOST}:$TESTDIR
-    LUSER=${LUSER:=root}
-    mkdir -p $TCtmp || end_testcase "Could not create $TCtmp"
-    chmod 777 $TCtmp
-
-    tst_resm TINFO "Setting up remote machine: $RHOST"
-    rsh -n $RHOST "mkdir -p $TESTDIR"
-    [ $? = 0 ] || end_testcase "Could not create remote directory"
-    rsh -n $RHOST "touch $TESTDIR/testfile"
-    [ $? = 0 ] || end_testcase "Could not create testfile in remote directory"
-
-    if [ "x$NFS_TYPE" = "xnfs4" ]; then
-        rsh -n $RHOST "mkdir -p /export$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not create /export$TESTDIR on server"
-        rsh -n $RHOST "mount --bind $TESTDIR /export$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not bind $TESTDIR to /export"
-        rsh -n $RHOST "/usr/sbin/exportfs -o no_root_squash,rw,nohide,insecure,no_subtree_check *:$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not export remote directory"
-    else
-        rsh -n $RHOST "/usr/sbin/exportfs -i -o no_root_squash,rw *:$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not export remote directory"
-    fi
-
-    tst_resm TINFO "Mounting NFS filesystem"
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
-do_test()
-{
-$trace_logic
-  loopcount=0
-  nfs04_create_file $FILESIZE /tmp/nfs04$PID.testfile >/dev/null
-  if [ $? != 0 ]; then
-	end_testcase "Could not create testfile"
-  fi
-  tst_resm TINFO "Test Started"
-  while [ $loopcount -lt $LOOPS ]
-    do
-	cp /tmp/nfs04$PID.testfile $TCtmp/nfs04$PID.testfile$loopcount
-	cmp /tmp/nfs04$PID.testfile $TCtmp/nfs04$PID.testfile$loopcount
-	retval=$?
-	if [ "$retval" != 0 ]; then
-		end_testcase "Error in loop $loopcount: First cmp FAILED"
-	fi
-	cp $TCtmp/nfs04$PID.testfile$loopcount /tmp/nfs04$PID.testfile_compare
-	cmp /tmp/nfs04$PID.testfile /tmp/nfs04$PID.testfile_compare
-	retval=$?
-	if [ "$retval" != 0 ]; then
-		end_testcase "Error in loop $loopcount: Second cmp FAILED"
-	fi
-	rm -f /tmp/nfs04$PID.testfile_compare
-	loopcount=$(( $loopcount + 1 ))
-	tst_resm TINFO "Completed Loop $loopcount"
-    done
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
-	sleep 2
-        umount $TCtmp || tst_resm TBROK "Cannot umount $TCtmp"
-	rm -rf $TCtmp || tst_resm TBROK "Cannot remove $TCtmp"
-        rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
-		 rsh -n $RHOST "rm -rf $TESTDIR"
-	rm -f /tmp/nfs04$PID.testfile*
-    fi
+. nfs_lib.sh
+. test_net.sh
 
-    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-    tst_resm TFAIL "Test Failed: $@"
-    exit 1
-}
+nfs_setup
 
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
+tst_resm TINFO "create 10M file"
+ROD nfs04_create_file 10 nfs04.testfile
 
-setup_testcase
-do_test
-end_testcase
+tst_exit
-- 
1.7.1

