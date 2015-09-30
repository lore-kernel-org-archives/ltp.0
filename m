From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 16:09:23 +0300
Subject: [LTP] [PATCH 05/10] network/nfs_stress/nfs02: use nfs_lib.sh
In-Reply-To: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1443618568-29200-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also, update runtest/nfs file with new test-cases.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/nfs                            |    6 +-
 testcases/network/nfs/nfs_stress/nfs02 |  259 ++++++--------------------------
 2 files changed, 48 insertions(+), 217 deletions(-)

diff --git a/runtest/nfs b/runtest/nfs
index 7bee16f..ad0e25f 100644
--- a/runtest/nfs
+++ b/runtest/nfs
@@ -7,7 +7,11 @@ nfs4_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01
 nfs3_ipv6_01 export VERSION=3 SOCKET_TYPE=udp; nfs01 -6
 nfs4_ipv6_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01 -6
 
-nfs02 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs02
+nfs3_02 export VERSION=3 SOCKET_TYPE=udp; nfs02
+nfs4_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02
+nfs3_ipv6_02 export VERSION=3 SOCKET_TYPE=udp; nfs02 -6
+nfs4_ipv6_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02 -6
+
 nfs03 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs03
 nfs04 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs04
 nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
diff --git a/testcases/network/nfs/nfs_stress/nfs02 b/testcases/network/nfs/nfs_stress/nfs02
index c192d96..a600034 100755
--- a/testcases/network/nfs/nfs_stress/nfs02
+++ b/testcases/network/nfs/nfs_stress/nfs02
@@ -1,245 +1,72 @@
 #! /bin/sh
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
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+# PURPOSE: Tests NFS copy of various filesizes, file consistency
+#          between copies and preservation of write/nowrite permissions.
 #
-#  FILE   : nfs02
-#
-#  PURPOSE: Tests NFS copy of various filesizes, file consistency between copies
-#           and preservation of write/nowrite permissions.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#
-#  HISTORY:
-#    05/15/01 Robbie Williamson (robbiew@us.ibm.com)
-#      -Ported
-#
-#**********************************************************************
-
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-
-$trace_logic
-
-#-----------------------------------------------------------------------
-# Initialize local variables
-#-----------------------------------------------------------------------
-
-TC=nfs02
-TCbin=${TCbin:=`pwd`}
-TCdat=${TCdat:=$TCbin/datafiles}
-TCsrc=${TCsrc:=$TCbin}
-TCtmp=${TCtmp:=$TCbin/$TC$$}
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
-
-PID=$$
-
-RHOST=${RHOST:=`hostname`}
-VERSION=${VERSION:=3}
-SOCKET_TYPE=${SOCKET_TYPE:=udp}
-TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-CLEANUP=${CLEANUP:="ON"}
-NFS_TYPE=${NFS_TYPE:=nfs}
-
-#---------------------------------------------------------------------#
-# FUNCTION: do_setup
-# PURPOSE:  To create the necessary files to carry out the test
-# INPUT:    None.
-# OUTPUT:   None.
-#---------------------------------------------------------------------#
-do_setup()
-{
-$trace_logic
-
-   echo "do_setup $TC"
-
-   echo ""
-   echo "Test Options:"
-   echo " VERSION: $VERSION"
-   echo " RHOST: $RHOST"
-   echo " SOCKET_TYPE: $SOCKET_TYPE"
-   echo " NFS_TYPE: $NFS_TYPE"
-   echo " TESTDIR: $TESTDIR"
-
-   if [ "x$NFS_TYPE" != "xnfs4" ]; then
-      OPTS="-o vers=$VERSION,proto=$SOCKET_TYPE"
-   fi
-
-   IAM=${IAM:=`whoami`}
-   [ $IAM = "root" ] || end_testcase "Must be root user"
+# Ported by: Robbie Williamson (robbiew@us.ibm.com)
 
-   #Setup and Export the data directory on RHOST
-   rsh -n $RHOST "mkdir -p $TESTDIR"
-   [ $? -eq 0 ] || end_testcase "Could not create $TESTDIR from $RHOST"
+TCID="nfs02"
+TST_TOTAL=3
+TST_CLEANUP="cleanup"
 
-   if [ "x$NFS_TYPE" = "xnfs4" ]; then
-      rsh -n $RHOST "mkdir -p /export$TESTDIR"
-      [ $? = 0 ] || end_testcase "Could not create /export$TESTDIR on server"
-      rsh -n $RHOST "mount --bind $TESTDIR /export$TESTDIR"
-      [ $? = 0 ] || end_testcase "Could notbind $TESTDIR to /export"
-      rsh -n $RHOST "/usr/sbin/exportfs -o no_root_squash,rw,nohide,insecure,no_subtree_check *:$TESTDIR"
-      [ $? = 0 ] || end_testcase "Could not export remote directory"
-   else
-      rsh -n $RHOST "/usr/sbin/exportfs -i *:$TESTDIR -o rw,no_root_squash "
-      [ $? -eq 0 ] || end_testcase "Could not export $TESTDIR from $RHOST"
-   fi
+. nfs_lib.sh
+. test_net.sh
 
-   #Verify export
-   showmount -e $RHOST | grep $TESTDIR
-   [ $? -eq 0 ] || end_testcase "$TESTDIR not exported"
-
-   #Create $TCtmp for mount point
-   mkdir -p $TCtmp
-   [ $? -eq 0 ] || end_testcase "Could not create $TCtmp"
-
-   #Mount $TCdat from RHOST.
-   mount -t $NFS_TYPE $OPTS $RHOST:$TESTDIR $TCtmp
-   [ $? -eq 0 ] || end_testcase "Could not mount from $RHOST"
-
-}
-
-
-#---------------------------------------------------------------------#
-# FUNCTION: do_test1
-# PURPOSE:  Perform the necessary steps to complete the test.
-# INPUT:    None.
-# OUTPUT:    Error messages are logged if any of the tests fail.
-#---------------------------------------------------------------------#
 do_test1()
 {
-$trace_logic
-  echo "do_test1 $TC "
-  cp $TCdat/ascii.jmb $TCtmp &
-  wait $!
-  echo "compare both ascii.jmbs"
-  diff $TCtmp/ascii.jmb $TCdat/ascii.jmb
-  [ $? -eq 0 ] || end_testcase "'diff' of ascii.jmb FAILED"
+	tst_resm TINFO "do_test1 $TC"
+	ROD cp $LTP_DATAFILES/ascii.jmb .
+	tst_resm TINFO "compare both ascii.jmbs"
+	ROD diff $LTP_DATAFILES/ascii.jmb ascii.jmb
 
+	tst_resm TPASS "test1 passed"
 }
 
-#---------------------------------------------------------------------#
-# FUNCTION: do_test2
-# PURPOSE:  Perform the necessary steps to complete the test.
-# INPUT:    None.
-# OUTPUT:    Error messages are logged if any of the tests fail.
-#---------------------------------------------------------------------#
 do_test2()
 {
-$trace_logic
-   echo "do_test2 $TC "
-   cp $TCdat/ascii.sm $TCtmp &
-   wait $!
-   cp $TCdat/ascii.med $TCtmp &
-   wait $!
-   cp $TCdat/ascii.lg $TCtmp &
-   wait $!
-
-   #small file
-   cp $TCtmp/ascii.sm $TCtmp/ascii.smcp &
-   wait $!
-   diff $TCtmp/ascii.smcp $TCdat/ascii.sm
-   [ $? -eq 0 ] || end_testcase "'diff' of ascii.sm FAILED"
+	tst_resm TINFO "do_test2, copy data files"
+	local files="ascii.sm ascii.med ascii.lg"
 
-   #medium file
-   cp $TCtmp/ascii.med $TCtmp/ascii.medcp &
-   wait $!
-   diff $TCtmp/ascii.medcp $TCdat/ascii.med
-   [ $? -eq 0 ] || end_testcase "'diff' of ascii.med FAILED"
-
-   #large file
-   cp $TCtmp/ascii.lg $TCtmp/ascii.lgcp &
-   wait $!
-   diff $TCtmp/ascii.lgcp $TCdat/ascii.lg
-   [ $? -eq 0 ] || end_testcase "'diff' of ascii.lg FAILED"
+	for f in $files; do
+		tst_resm TINFO "copy '$f' file"
+		ROD cp $LTP_DATAFILES/$f .
+		ROD cp $f ${f}cp
+		ROD diff $LTP_DATAFILES/$f ${f}cp
+	done
 
+	tst_resm TPASS "test2 passed"
 }
 
-#---------------------------------------------------------------------#
-# FUNCTION: do_test3
-# PURPOSE:  Perform the necessary steps to complete the test.
-# INPUT:    None.
-# OUTPUT:    Error messages are logged if any of the tests fail.
-#---------------------------------------------------------------------#
 do_test3()
 {
-$trace_logic
-   echo "do_test3 $TC "
-   chmod a-wx $TCtmp/ascii.sm &
-   wait $!
-   ls -l $TCtmp/ascii.sm | grep "r--"
-   [ $? -eq 0 ] || end_testcase "Removal of write permissions not honored on ascii.sm"
-   chmod a+w $TCtmp/ascii.sm
+	tst_resm TINFO "do_test3, test permissions"
+	ROD chmod a-wx ascii.sm
+	ROD ls -l ascii.sm | grep -q "r--"
+	ROD chmod a+w ascii.sm
+	tst_resm TPASS "test3 passed"
 }
 
-#---------------------------------------------------------------------#
-# FUNCTION: do_cleanup
-# PURPOSE:  To delete all the files created to run this test.
-# INPUT:    None.
-# OUTPUT:   None.
-#---------------------------------------------------------------------#
-do_cleanup()
-{
-$trace_logic
-   echo "do_cleanup $TC "
-   rm -f $TCtmp/*.fil*
-   cd $TCbin
-   umount $TCtmp
-   sleep 3
-   rmdir $TCtmp
-   rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
-   rsh -n $RHOST "rm -rf $TESTDIR"
-}
-
-#=============================================================================
-# FUNCTION NAME:        end_testcase
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:           None.
-#
-# RETURNS:              None.
-#=============================================================================
-end_testcase()
-{
-$trace_logic
-    if [ "$CLEANUP" = "ON" ]; then
-       do_cleanup
-    fi
+LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"
 
-    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-    tst_resm TFAIL "Test Failed: $@"
-    exit 1
-}
+setup_testcase
 
-#=============================================================================
-#---------------------------------------------------------------------#
-# FUNCTION: MAIN
-# PURPOSE:  To invoke the functions to perform the tasks described in
-#           the prologue.
-# INPUT:    None.
-# OUTPUT:   A testcase run log with the results of the execution of this
-#           test.
-#---------------------------------------------------------------------#
-do_setup
 do_test1
 do_test2
 do_test3
-end_testcase
+
+tst_exit
-- 
1.7.1

