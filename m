From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 16:09:26 +0300
Subject: [LTP] [PATCH 08/10] network/nfs_stress/nfs03: use nfs_lib.sh,
	run over IPv6
In-Reply-To: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1443618568-29200-8-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also, remove setting LTPROOT directory in stress.part1 runtest file
for nfs02 and nfs03.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/nfs                            |    6 +-
 runtest/stress.part1                   |   18 +-
 testcases/network/nfs/nfs_stress/nfs03 |  479 ++++++--------------------------
 3 files changed, 100 insertions(+), 403 deletions(-)

diff --git a/runtest/nfs b/runtest/nfs
index ad0e25f..3ab2eb8 100644
--- a/runtest/nfs
+++ b/runtest/nfs
@@ -12,7 +12,11 @@ nfs4_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02
 nfs3_ipv6_02 export VERSION=3 SOCKET_TYPE=udp; nfs02 -6
 nfs4_ipv6_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02 -6
 
-nfs03 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs03
+nfs3_03 export VERSION=3 SOCKET_TYPE=udp; nfs03
+nfs4_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03
+nfs3_ipv6_03 export VERSION=3 SOCKET_TYPE=udp; nfs03 -6
+nfs4_ipv6_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03 -6
+
 nfs04 export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin nfs04
 nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
 
diff --git a/runtest/stress.part1 b/runtest/stress.part1
index 9ad21d9..af5f69d 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -181,15 +181,15 @@ nfs01 export VERSION=2 SOCKET_TYPE=tcp; nfs01
 nfs01 export VERSION=3 SOCKET_TYPE=udp; nfs01
 nfs01 export VERSION=3 SOCKET_TYPE=tcp; nfs01
 
-nfs02 export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs02
-nfs02 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs02
-nfs02 export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs02
-nfs02 export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs02
-
-nfs03 export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs03
-nfs03 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs03
-nfs03 export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs03
-nfs03 export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs03
+nfs02 export VERSION=2 SOCKET_TYPE=udp; nfs02
+nfs02 export VERSION=2 SOCKET_TYPE=tcp; nfs02
+nfs02 export VERSION=3 SOCKET_TYPE=udp; nfs02
+nfs02 export VERSION=3 SOCKET_TYPE=tcp; nfs02
+
+nfs03 export VERSION=2 SOCKET_TYPE=udp; nfs03
+nfs03 export VERSION=2 SOCKET_TYPE=tcp; nfs03
+nfs03 export VERSION=3 SOCKET_TYPE=udp; nfs03
+nfs03 export VERSION=3 SOCKET_TYPE=tcp; nfs03
 
 nfs04 export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs04
 nfs03 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs04
diff --git a/testcases/network/nfs/nfs_stress/nfs03 b/testcases/network/nfs/nfs_stress/nfs03
index a6c53ab..952162d 100755
--- a/testcases/network/nfs/nfs_stress/nfs03
+++ b/testcases/network/nfs/nfs_stress/nfs03
@@ -1,428 +1,121 @@
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
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : nfs03
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  DESCRIPTION: This script sets up the NFS directories in the remote machine
-#		and runs the LTP's filesystem test: fs_inod.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
+#               and runs the LTP's filesystem test: fs_inod.
 #
-#  HISTORY:
-#    11/2/01 Robbie Williamson (robbiew@us.ibm.com)
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
-TC=${TC:=nfs03}
-TCbin=${TCbin:=`pwd`}
-TCdat=${TCdat:=$TCbin}
-TCsrc=${TCsrc:=$TCbin}
-TCtmp=${TCtmp:=$TCbin/$TC$$}
-TCdump=${TCdump:=$TCbin}
-RHOST=${RHOST:=`hostname | awk {'print $1'}`}
-export TCID=$TC
-export TST_TOTAL=1
-export TST_COUNT=1
-
-PID=$$
-
-# Setting the NFS to version 3 by default
-VERSION=${VERSION:=3}
-SOCKET_TYPE=${SOCKET_TYPE:=udp}
-TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-NFS_TYPE=${NFS_TYPE:=nfs}
+# Created by: Robbie Williamson (robbiew@us.ibm.com)
 
-# If CLEANUP is not set; set it to "ON"
-CLEANUP=${CLEANUP:="ON"}
+TCID="nfs03"
+TST_TOTAL=1
+TST_CLEANUP="nfs03_cleanup"
 
-DIR_NUM=$1
-FILE_NUM=$2
-NFSD_NUM=$3
-
-DIR_NUM=${DIR_NUM:=100}
-FILE_NUM=${FILE_NUM:= 100}
-THREAD_NUM=${THREAD_NUM:=1}
-
-#============================================================================
-# FUNCTION NAME:        fs_inod
-#
-# FUNCTION DESCRIPTION: Filesystems test from LTP.
-#
-# PARAMETERS:		Filesystem, number of directories, number of files,
-#			and loops
-#
-# RETURNS:		0 for PASS and Error Code for FAIL.
-#============================================================================
-fs_inod()
-{
-
-#=============================================================================
-# FUNCTION NAME:        err_log
-#
-# FUNCTION DESCRIPTION: Log error
-#
-# PARAMETERS:           None.
-#
-# RETURNS:              None.
-#=============================================================================
-err_log()
-{
-    error "$1"
-    : $(($step_errors+=1))
-}
+. nfs_lib.sh
+. test_net.sh
 
+DIR_NUM=${DIR_NUM:-"100"}
+FILE_NUM=${FILE_NUM:-"100"}
+THREAD_NUM=${THREAD_NUM:-"1"}
+ORIG_NFSD=
 
-#=============================================================================
-# FUNCTION NAME:        make_subdirs
-#
-# FUNCTION DESCRIPTION: Creates $numsubdirs subdirectories
-#
-# PARAMETERS:           None.
-#
-# RETURNS:              None.
-#=============================================================================
 make_subdirs()
 {
-    i=0;
-    while [ "$i" -lt "$numsubdirs" ]; do
-        [ -d dir$i ] || { \
-            echo "$0: mkdir dir$i"
-            mkdir -p dir$i || echo "mkdir dir$i FAILED"
-        }
-        : $(( i += 1 ))
-    done;
+	tst_resm TINFO "make '$DIR_NUM' directories"
+	for i in $(seq 0 $DIR_NUM); do
+		ROD mkdir -p dir$i
+	done
 }
 
-
-#=============================================================================
-# FUNCTION NAME:        touch_files
-#
-# FUNCTION DESCRIPTION: Creates $numfiles in each of $numsubdirs directories
-#
-# PARAMETERS:           None.
-#
-# RETURNS:              None.
-#=============================================================================
 touch_files()
 {
-    echo "$0: touch files [0-$numsubdirs]/file$numsubdirs[0-$numfiles]"
-    j=0;
-
-    while [ "$j" -lt "$numsubdirs" ]; do
-        cd dir$j
-        k=0;
-
-        while [ "$k" -lt "$numfiles" ]; do
-            >file$j$k || err_log ">file$j$k FAILED"
-            : $(( k += 1 ))
-        done
-
-        : $(( j += 1 ))
-        cd ..
-    done
+	tst_resm TINFO "create files [0 - $DIR_NUM]/file$DIR_NUM[0 - $FILE_NUM]"
+	for j in $(seq 0 $DIR_NUM); do
+		cd dir$j
+		for k in $(seq 0 $FILE_NUM); do
+			ROD >file$j$k
+		done
+		cd ..
+	done
 }
 
-
-#=============================================================================
-# FUNCTION NAME:        rm_files
-#
-# FUNCTION DESCRIPTION: Removes $numfiles in each $numsubdir directory
-#
-# PARAMETERS:   None.
-#
-# RETURNS:      None.
-#=============================================================================
 rm_files()
 {
-    echo "$0: rm files [0-$numsubdirs]/file$numsubdirs[0-$numfiles]"
-    j=0;
-
-    while [ "$j" -lt "$numsubdirs" ]; do
-        cd dir$j
-        k=0;
-
-        while [ "$k" -lt "$numfiles" ]; do
-            rm -f file$j$k || err_log "rm -f file$j$k FAILED"
-            : $(( k += 1 ))
-        done
-
-        : $(( j += 1 ))
-        cd ..
-    done
-}
-
-
-#=============================================================================
-# FUNCTION NAME:        step1
-#
-# FUNCTION DESCRIPTION: multiple processes creating and deleting files
-#
-# PARAMETERS:           None.
-#
-# RETURNS:              None.
-#=============================================================================
-step1()
-{
-    echo "=============================================="
-    echo "MULTIPLE PROCESSES CREATING AND DELETING FILES"
-    echo "=============================================="
-
-    echo "$0: creating dir2 subdirectories"
-    [ -d dir2 ] || { \
-        mkdir -p dir2 || end_testcase "mkdir dir2 failed"
-    }
-    cd dir2 || err_log "cd dir2 FAILED"
-    make_subdirs || err_log "make_subdirs on dir2 FAILED"
-    cd ..
-
-    echo "$0: creating dir1 subdirectories & files"
-    [ -d dir1 ] || { \
-        mkdir dir1 || abort "mkdir dir1 FAILED"
-    }
-    cd dir1 || err_log "cd dir1 FAILED"
-    make_subdirs || err_log "make_subdirs on dir1 FAILED"
-    touch_files
-    pid1=$!
-
-    i=1;
-    while [ "$i" -le "$numloops" ]; do
-        echo "Executing loop $i of $numloops..."
-
-#       Added date stamps to track execution time and duration
-
-        echo "$0: cd ../dir1 & creating files"
-        cd ../dir1
-        wait $pid1
-        touch_files &
-        pid1=$!
-
-        echo "$0: cd ../dir1 & removing files"
-        cd ../dir1
-        wait $pid1
-        rm_files &
-        pid1=$!
-
-        echo "$0: cd ../dir2 & creating files"
-        cd ../dir2
-        wait $pid2
-        touch_files &
-        pid2=$!
-
-        echo "$0: cd ../dir2 & removing files"
-        cd ../dir2
-        wait $pid2
-        rm_files &
-        pid2=$!
-
-        : $(( i += 1 ))
-    done
-
-    # wait for all background processes to complete execution
-    wait
-    return $step_errors
-}
-
-
-#=============================================================================
-# MAIN
-#     See the description, purpose, and design of this test under TEST
-#     in this test's prolog.
-#=============================================================================
-    USAGE="Usage: ./fs_inod [volumename] [numsubdirectories] [numfiles] [numloops]"
-
-    if [ $# -ne 4 ]
-    then
-       echo $USAGE
-       exit 2
-    fi
-
-    testvol=$1
-    numsubdirs=$2
-    numfiles=$3
-    numloops=$4
-
-    cd $testvol || exit 2
-
-    echo "FS_INODE: File system stress - inode allocation/deallocation"
-    echo "Volume under test: $testvol"
-    echo "Number of subdirectories: $numsubdirs"
-    echo "Number of files: $numfiles"
-    echo "Number of loops: $numloops"
-    echo "Execution begins "
-    date
-
-    STEPS="1"
-    for I in $STEPS
-    do
-         step_errors=0
-         step$I
-         if [ $? != 0 ]; then
-            error "step$I failed - see above errors"
-         fi
-    done
-
-# Clean up and timestamp
-    rm -rf $testvol/dir*
-    echo "Execution completed"
-    date
-
-    return $ERRORS
+	tst_resm TINFO "rm files [0 - $DIR_NUM]/file$DIR_NUM[0 - $FILE_NUM]"
+	for j in $(seq 0 $DIR_NUM); do
+		cd dir$j
+		for k in $(seq 0 $FILE_NUM); do
+			ROD rm -f file$j$k
+		done
+		cd ..
+	done
 }
 
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
+do_test()
 {
-$trace_logic
-
-
-    echo ""
-    echo "Test Options:"
-    echo " VERSION: $VERSION"
-    echo " SOCKET_TYPE: $SOCKET_TYPE"
-    echo " TESTDIR: $TESTDIR"
-    echo " RHOST: $RHOST"
-    echo " NFS_TYPE: $NFS_TYPE"
-    echo ""
-    echo "Test Parameters:"
-    echo " Number of Directories: $DIR_NUM"
-    echo " Number of Files per Directory: $FILE_NUM"
-    echo " Number of nfsds tested: $THREAD_NUM"
-    echo ""
-
-    if [ "x$NFS_TYPE" != "xnfs4" ]; then
-        OPTS=${OPTS:="-o vers=$VERSION,proto=$SOCKET_TYPE "}
-    fi
-
-    REMOTE_DIR=${RHOST}:$TESTDIR
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
-        echo "rsh -n $RHOST 'mount --bind $TESTDIR /export$TESTDIR'"
-        rsh -n $RHOST "mount --bind $TESTDIR /export$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not bind $TESTDIR to /export"
-        rsh -n $RHOST "/usr/sbin/exportfs -i -o no_root_squash,rw *:$TESTDIR"
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
-    echo "Setting server side nfsd count to $THREAD_NUM"
-    ORIG_NFSD=`rsh -n $RHOST "ps -ef" | grep nfsd | grep -v grep | wc -l`
-    rsh -n $RHOST "/usr/sbin/rpc.nfsd $THREAD_NUM"
-    [ $? = 0 ] || end_testcase "Could not set the number of nfsds on $RHOST"
-
+	tst_resm TINFO "Multiple processes creating and deleting files"
+
+	tst_resm TINFO "creating dir1 subdirectories & files"
+	ROD mkdir -p dir1
+	ROD cd dir1
+	make_subdirs
+	touch_files &
+	pid1=$!
+	cd ..
+
+	tst_resm TINFO "creating dir2 subdirectories & files"
+	ROD mkdir -p dir2
+	ROD cd dir2
+	make_subdirs
+	touch_files &
+	pid2=$!
+
+	tst_resm TINFO "cd dir1 & removing files"
+	ROD cd ../dir1
+	wait $pid1
+	rm_files &
+
+	tst_resm TINFO "cd dir2 & removing files"
+	ROD cd ../dir2
+	wait $pid2
+	rm_files &
+
+	# wait for all background processes to complete execution
+	wait
+
+	tst_resm TPASS "test done"
 }
 
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
+nfs03_setup()
 {
-$trace_logic
-    echo "fs_inod starting on $TCtmp."
-    fs_inod $TCtmp $DIR_NUM $FILE_NUM 1
-    retval=$?
-    echo "fs_inod on $TCtmp finished."
+	nfs_setup
 
-    if [ "$retval" != 0 ]; then
-      end_testcase "Errors have resulted from this test: fs_inod returned $retval."
-    fi
-
-    cd /
+	tst_resm TINFO "Setting server side nfsd count to $THREAD_NUM"
+	ORIG_NFSD=$(tst_rhost_run -s -c 'ps -ef | grep nfsd | grep -v grep | wc -l')
+	tst_rhost_run -s -c "rpc.nfsd $THREAD_NUM"
 }
 
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
+nfs03_cleanup()
 {
-$trace_logic
-    if [ "$CLEANUP" = "ON" ]; then
-	cd \
-
-	echo "Cleaning up testcase"
-        /bin/umount $TCtmp || echo "Cannot umount $TCtmp"
-	sleep 2
-	rmdir $TCtmp || echo "Cannot remove $TCtmp"
-        rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
-		 rsh -n $RHOST "rm -rf $TESTDIR"
-	rsh -n $RHOST "/usr/sbin/rpc.nfsd $ORIG_NFSD"
-
-    fi
-
-    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-    tst_resm TFAIL "Test Failed: $@"
-    exit 1
+	tst_rhost_run -c "rpc.nfsd $ORIG_NFSD"
+	nfs_cleanup
 }
 
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
+nfs03_setup
 
-setup_testcase
 do_test
-end_testcase
+
+tst_exit
-- 
1.7.1

