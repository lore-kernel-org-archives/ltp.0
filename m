Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VtfGS-0008WG-EJ
	for ltp-list@lists.sourceforge.net; Thu, 19 Dec 2013 15:11:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtfGP-00060K-OH
	for ltp-list@lists.sourceforge.net; Thu, 19 Dec 2013 15:11:52 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBJFBfme009909
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Dec 2013 23:11:42 +0800
Message-ID: <52B30CA9.2060509@cn.fujitsu.com>
Date: Thu, 19 Dec 2013 23:11:37 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testscripts/test_robind.sh: cleanup and make some
	fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


Remove useless comments and abandon the operation which creates
a 500MB image-file. If user wants to run these tests, a big block
device should be specified by runltp with -z option.

And we split tests in testscripts/fs_ro_tests into separate testcases,
keep one entry per test in runtest/fs_readonly

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/fs_readonly        |  57 +++++++-
 testscripts/test_robind.sh | 319 +++++++++++++++++++--------------------------
 2 files changed, 188 insertions(+), 188 deletions(-)

diff --git a/runtest/fs_readonly b/runtest/fs_readonly
index 96f12c3..437b94e 100644
--- a/runtest/fs_readonly
+++ b/runtest/fs_readonly
@@ -1 +1,56 @@
-ROBind $LTPROOT/testscripts/test_robind.sh
+test_robind01 test_robind.sh -i 1 -D $LTP_BIG_DEV
+test_robind02 test_robind.sh -i 2 -D $LTP_BIG_DEV
+test_robind03 test_robind.sh -i 3 -D $LTP_BIG_DEV
+test_robind04 test_robind.sh -i 4 -D $LTP_BIG_DEV
+test_robind05 test_robind.sh -i 5 -D $LTP_BIG_DEV
+test_robind06 test_robind.sh -i 6 -D $LTP_BIG_DEV
+test_robind07 test_robind.sh -i 7 -D $LTP_BIG_DEV
+test_robind08 test_robind.sh -i 8 -D $LTP_BIG_DEV
+test_robind09 test_robind.sh -i 9 -D $LTP_BIG_DEV
+test_robind10 test_robind.sh -i 10 -D $LTP_BIG_DEV
+test_robind11 test_robind.sh -i 11 -D $LTP_BIG_DEV
+test_robind12 test_robind.sh -i 12 -D $LTP_BIG_DEV
+test_robind13 test_robind.sh -i 13 -D $LTP_BIG_DEV
+test_robind14 test_robind.sh -i 14 -D $LTP_BIG_DEV
+test_robind15 test_robind.sh -i 15 -D $LTP_BIG_DEV
+test_robind16 test_robind.sh -i 16 -D $LTP_BIG_DEV
+test_robind17 test_robind.sh -i 17 -D $LTP_BIG_DEV
+test_robind18 test_robind.sh -i 18 -D $LTP_BIG_DEV
+test_robind19 test_robind.sh -i 19 -D $LTP_BIG_DEV
+test_robind20 test_robind.sh -i 20 -D $LTP_BIG_DEV
+test_robind21 test_robind.sh -i 21 -D $LTP_BIG_DEV
+test_robind22 test_robind.sh -i 22 -D $LTP_BIG_DEV
+test_robind23 test_robind.sh -i 23 -D $LTP_BIG_DEV
+test_robind24 test_robind.sh -i 24 -D $LTP_BIG_DEV
+test_robind25 test_robind.sh -i 25 -D $LTP_BIG_DEV
+test_robind26 test_robind.sh -i 26 -D $LTP_BIG_DEV
+test_robind27 test_robind.sh -i 27 -D $LTP_BIG_DEV
+test_robind28 test_robind.sh -i 28 -D $LTP_BIG_DEV
+test_robind29 test_robind.sh -i 29 -D $LTP_BIG_DEV
+test_robind30 test_robind.sh -i 30 -D $LTP_BIG_DEV
+test_robind31 test_robind.sh -i 31 -D $LTP_BIG_DEV
+test_robind32 test_robind.sh -i 32 -D $LTP_BIG_DEV
+test_robind33 test_robind.sh -i 33 -D $LTP_BIG_DEV
+test_robind34 test_robind.sh -i 34 -D $LTP_BIG_DEV
+test_robind35 test_robind.sh -i 35 -D $LTP_BIG_DEV
+test_robind36 test_robind.sh -i 36 -D $LTP_BIG_DEV
+test_robind37 test_robind.sh -i 37 -D $LTP_BIG_DEV
+test_robind38 test_robind.sh -i 38 -D $LTP_BIG_DEV
+test_robind39 test_robind.sh -i 39 -D $LTP_BIG_DEV
+test_robind40 test_robind.sh -i 40 -D $LTP_BIG_DEV
+test_robind41 test_robind.sh -i 41 -D $LTP_BIG_DEV
+test_robind42 test_robind.sh -i 42 -D $LTP_BIG_DEV
+test_robind43 test_robind.sh -i 43 -D $LTP_BIG_DEV
+test_robind44 test_robind.sh -i 44 -D $LTP_BIG_DEV
+test_robind45 test_robind.sh -i 45 -D $LTP_BIG_DEV
+test_robind46 test_robind.sh -i 46 -D $LTP_BIG_DEV
+test_robind47 test_robind.sh -i 47 -D $LTP_BIG_DEV
+test_robind48 test_robind.sh -i 48 -D $LTP_BIG_DEV
+test_robind49 test_robind.sh -i 49 -D $LTP_BIG_DEV
+test_robind50 test_robind.sh -i 50 -D $LTP_BIG_DEV
+test_robind51 test_robind.sh -i 51 -D $LTP_BIG_DEV
+test_robind52 test_robind.sh -i 52 -D $LTP_BIG_DEV
+test_robind53 test_robind.sh -i 53 -D $LTP_BIG_DEV
+test_robind54 test_robind.sh -i 54 -D $LTP_BIG_DEV
+test_robind55 test_robind.sh -i 55 -D $LTP_BIG_DEV
+test_robind56 test_robind.sh -i 56 -D $LTP_BIG_DEV
diff --git a/testscripts/test_robind.sh b/testscripts/test_robind.sh
index 4c01f4e..82ca943 100755
--- a/testscripts/test_robind.sh
+++ b/testscripts/test_robind.sh
@@ -23,15 +23,16 @@
 #   FUNCTIONALITY:  File system tests for normal mount, bind mount and RO mount
 #
 #   DESCRIPTION:    Performs filesystems tests for RO mount.
-#     For filesystem's like ext2, ext3, reiserfs, jfs & xfs.
-#     This test creates an image-file and
+#     For filesystem, like ext2, ext3, reiserfs, jfs & xfs,
+#     This test needs a big block device(>=500MB is ok), and you can specify
+#     it by -z option when running runltp.
 #        a)  mounts on dir1,
 #        b)  mount --bind dir2
 #        c)  mount -o remount,ro
 #       It verifies the tests on a) and b) works correctly.
-#     For the c) option it checks that the tests are not able to write into dir.
+#       For the c) option it checks that the tests are not able to write
+#       into dir.
 #     Then it executes the tests from flat-file  {LTPROOT}/testscripts/fs_ro_tests
-#     Check the logs /tmp/fs$$/errs.log and /tmp/fs$$/pass.log for pass/failures.
 #===============================================================================
 #
 # CHANGE HISTORY:
@@ -41,161 +42,97 @@
 # This script is based on the Dave Hansen script for testing the robind.
 #*******************************************************************************
 
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-test_robind.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
+export TCID="test_robind"
+export TST_TOTAL=3
+export TST_COUNT=1
 
 usage()
 {
-  cat << EOF
-  usage: $0 [ext3,ext2,jfs,xfs,reiserfs,ramfs]
+	cat << EOF
+	usage: $0 -i command_id -D device [ext3,ext2,jfs,xfs,reiserfs,ramfs]
+
+	This script verifies ReadOnly-filesystem, by mounting block device and
+	executing the filesystem tests.
 
-  This script verifies ReadOnly-filesystem, by mounting imagefile and
-  executing the filesystem tests.
+	OPTIONS
+		-h    display this message and exit
+		-i    command index in fs_ro_tests
+		-D    theese tests require an unmounted block device
 
-  OPTIONS
-    -h    display this message and exit
 EOF
+	exit 1
 }
 
 DIRS="dir1 dir2-bound dir3-ro"
-TMPDIR=/tmp/fs$$
 trap cleanup ERR
 trap cleanup INT
 
-#==============================================================================
-# FUNCTION NAME:    cleanup
-#
-# FUNCTION DESCRIPTION: Unmounts dir, Removes dir's, files created by the tests.
-#
-# PARAMETERS:       The $fs_image .
-#
-# RETURNS:      None.
-#==============================================================================
+# umount dirs
 function cleanup
 {
-    umount ${TMPDIR}/dir3-ro 2> /dev/null > /dev/null
-    umount ${TMPDIR}/dir2-bound 2> /dev/null 1> /dev/null
-    umount ${TMPDIR}/dir1 2> /dev/null 1> /dev/null
-    if [ ! -z $1 ]; then {
-        rm -rf $1 || true
-    }
-    fi
+	umount ${TESTDIR}/dir3-ro 2> /dev/null > /dev/null
+	umount ${TESTDIR}/dir2-bound 2> /dev/null 1> /dev/null
+	umount ${TESTDIR}/dir1 2> /dev/null 1> /dev/null
 }
 
-#===============================================================================
-# FUNCTION NAME:    setup
-#
-# FUNCTION DESCRIPTION: Does the initailization
-#
-# PARAMETERS:   File_systems (if any )
-#
-# RETURNS:      None.
-#===============================================================================
+# do the initailization
+# parameters:   file_systems (if any )
 function setup
 {
-    mkdir ${TMPDIR}
-    FAILLOG="$TMPDIR/errs.log"
-    PASSLOG="$TMPDIR/pass.log"
-
-    for i in $DIRS; do
-        rm -rf ${TMPDIR}/$i || true
-        mkdir -p ${TMPDIR}/$i
-    done;
-
-    # Populating the default FS as ext3, if FS is not given
-    if [ -z "$*" ]; then
-        FSTYPES="ext3"
-    else
-        FSTYPES="$*"
-    fi
-
-    # set the LTPROOT directory
-    cd `dirname $0`
-    echo "${PWD}" | grep testscripts > /dev/null 2>&1
-    if [ $? -eq 0 ]; then
-        cd ..
-        export LTPROOT="${PWD}"
-        export PATH="${PATH}:${LTPROOT}/testcases/bin"
-    fi
-
-    FS_Tests="${LTPROOT}/testscripts/fs_ro_tests"
-    cd ${TMPDIR}
+	for i in $DIRS
+	do
+		rm -rf ${TESTDIR}/$i || true
+		mkdir -p ${TESTDIR}/$i
+	done
+
+	# populating the default FS as ext3, if FS is not given
+	if [ -z "$*" ]; then
+		FSTYPES="ext3"
+	else
+		FSTYPES="$*"
+	fi
+
+	fs_ro_tests="${LTPROOT}/testscripts/fs_ro_tests"
 }
 
-#=============================================================================
-# FUNCTION NAME:    testdir
-#
-# FUNCTION DESCRIPTION: The core function where it runs the tests
-#
-# PARAMETERS:   dir_name, file_systems, Read_only flag = [true|false]
-#
-# RETURNS:      None.
-#=============================================================================
+# the core function where it runs the tests
+# $1 - directory where to run tests
+# $2 - file system type
+# $3 - read-only flag [true|false]
 function testdir
 {
-    dir=$1
-    fs=$2
-    RO=$3
-    pushd $dir
-    testnums=`wc -l $FS_Tests | cut -f1 -d" "`
-    status=0
-
-    echo "---------------------------------------------------" >> $FAILLOG ;
-    echo "Running RO-FileSystem Tests for $dir $fs filesystem" >> $FAILLOG ;
-    echo "---------------------------------------------------" >> $FAILLOG ;
-
-    echo "---------------------------------------------------" >> $PASSLOG ;
-    echo "Running RO-FileSystem Tests for $dir $fs filesystem" >> $PASSLOG ;
-    echo "---------------------------------------------------" >> $PASSLOG ;
-
-    export TDIRECTORY=$PWD ;
-    echo TDIR is $TDIRECTORY;
-    if [ $RO == false ] ; then                          # Testing Read-Write dir
-        for tests in `seq $testnums` ; do
-            cmd=`cat $FS_Tests | head -$tests | tail -n 1`
-#            eval $cmd 2>&1 /dev/null
-            eval $cmd 2> /dev/null 1> /dev/null
-            if [ $? -eq 0 ]; then
-                echo "$tests. '$cmd' PASS" >> $PASSLOG
-            else
-                echo "$tests. '$cmd' FAIL " >> $FAILLOG
-                echo "TDIR is $TDIRECTORY" >> $FAILLOG;
-                status=1
-            fi
-        done
-
-    else                                                # Testing Read-Only dir
-        for tests in `seq $testnums` ; do
-            cmd=`cat $FS_Tests | head -$tests | tail -n 1`
-            eval $cmd 2> /dev/null 1> /dev/null
-            if [ $? -ne 0 ]; then
-                echo "$tests. '$cmd' PASS " >> $PASSLOG
-            else
-                 echo "$tests. '$cmd' FAIL" >> $FAILLOG
-                 status=1
-            fi
-        done
-    fi
-    if [ $status == 1 ] ; then
-        echo "RO-FileSystem Tests FAILED for $dir $fs filesystem" >> $FAILLOG
-        echo >> $FAILLOG
-        retcode=$status
-    else
-        echo "RO-FileSystem Tests PASSed for $dir $fs filesystem" >> $PASSLOG
-        echo >> $PASSLOG
-    fi
-    # Remove all the temp-files created.
-    eval rm -rf ${TMPDIR}/${dir}/* > /dev/null 2>&1 || true
-    unset TDIRECTORY
-    popd
+	local dir=$1
+	local fs_type=$2
+	local RO=$3
+	local tst_result=0
+
+	cd $dir
+
+	cmd=`cat $fs_ro_tests | head -$command_id | tail -n 1`
+	tst_resm TINFO "command: $cmd"
+
+	# we need to export TMPDIR, in case test calls tst_rmdir()
+	export TMPDIR=$TESTDIR/$dir
+	eval $cmd > $TESTDIR/test.log 2>&1
+	tst_result=$?
+
+	# if tst_result isn't 0 and read-only flag is false, the test failed
+	# or if tst_result is 0 and read-only flag is true, the test failed.
+	if [ "$RO" = "false" -a $tst_result -ne 0 -o "$RO" = "true" -a $tst_result -eq 0 ];then
+		tst_resm TINFO "error info:"
+		cat $TESTDIR/test.log
+		tst_resm TFAIL "RO-FileSystem Tests FAILED for \
+				$dir $fs_type read-only flag: $RO"
+		retcode=1
+	else
+		tst_resm TPASS "RO-FileSystem Tests PASSED for \
+				$dir $fs_type read-only flag: $RO"
+	fi
+
+	# remove all the temp files created.
+	rm -f $TESTDIR/test.log
+	rm -rf $TESTDIR/$dir/* > /dev/null 2>&1 || true
+	cd ..
 }
 
 #=============================================================================
@@ -204,62 +141,70 @@ function testdir
 #     in this test's prolog.
 #=============================================================================
 retcode=0
-while getopts h: OPTION; do
-  case $OPTION in
-    h)
-      usage
-      exit 1
-      ;;
-    ?)
-      usage
-      exit 1
-      ;;
-  esac
+
+TESTDIR=$LTPROOT/testcases/bin/test_robind$$
+mkdir -p $TESTDIR || \
+{
+	tst_brkm TCONF ignored "failed to create $TESTDIR"
+	exit 1
+}
+cd ${TESTDIR}
+
+while getopts i:D:h: OPTION; do
+	case $OPTION in
+	i)
+		command_id=$OPTARG;;
+	D)
+		device=$OPTARG;;
+	h)
+		usage;;
+	?)
+		usage;;
+	esac
 done
-# Does the initial setups
-oldpwd=${PWD}
+shift $((OPTIND-1))
+
+# does the initial setups
 setup $*
 
+testnums=`wc -l $fs_ro_tests | cut -f1 -d " "`
+if [ $command_id -lt 1 -o $command_id -gt $testnums ]; then
+	tst_brkm TCONF ignored " $command_id is invalid"
+	exit 0
+fi
+
 # Executes the tests for differnt FS's
-# Creates an image file of 500 MB and mounts it.
 for fstype in $FSTYPES; do
-    image=$fstype.img
-    dd if=/dev/zero of=$image bs=$((1<<20)) count=500 2> /dev/null 1> /dev/null
-    if [ $? -ne 0 ] ; then
-        tst_resm, TFAIL "Unable to create image "
-        tst_resm, TFAIL "Free Disk space of 512MB is required in /tmp fs"
-        tst_resm, TFAIL "Please free it and rerun thank you.."
-        rm -f $image
-        exit -1
-    fi
-
-    OPTS="-F"
-    if [ "$fstype" == "reiserfs" ]; then
-    OPTS="-f --journal-size 513 -q"
-    elif [ "$fstype" == "jfs" ]; then
-    OPTS="-f"
-    elif [ "$fstype" == "xfs" ]; then
-    OPTS=""
-    fi
-
-    if [ "$fstype" != "ramfs" ] ; then
-        mkfs.$fstype $OPTS $image 2> /dev/null 1> /dev/null
-    fi
+	opts="-F"
+	if [ "$fstype" == "reiserfs" ]; then
+		opts="-f --journal-size 513 -q"
+	elif [ "$fstype" == "jfs" ]; then
+		opts="-f"
+	elif [ "$fstype" == "xfs" ]; then
+		opts=""
+	fi
+
+	if [ "$fstype" != "ramfs" ]; then
+		mkfs.$fstype $opts $device 2> /dev/null 1> /dev/null
+	fi
+
+	mount -t $fstype $device  dir1
+	mount --bind dir1 dir2-bound || exit -1
+	mount --bind dir1 dir3-ro    || exit -1
+	mount -o remount,ro,bind dir1 dir3-ro  || exit -1
+
+	testdir dir1 $fstype false
+	testdir dir2-bound $fstype false
+	testdir dir3-ro $fstype true
+	cleanup
+done
 
-    mount -t $fstype -o loop $image dir1
-    mount --bind dir1 dir2-bound || exit -1
-    mount --bind dir1 dir3-ro    || exit -1
-    mount -o remount,ro dir3-ro  || exit -1
 
-    testdir dir1 $fstype false
-    testdir dir2-bound $fstype false
-    testdir dir3-ro $fstype true
-    cleanup $image
+for i in $DIRS
+do
+	rm -rf ./$i
 done
+cd $LTPROOT
+rm -rf $TESTDIR
 
-    for i in $DIRS; do
-        rm -rf ./$i || true
-    done;
-    cd $oldpwd || true
-    exit $retcode
-
+exit $retcode
-- 
1.8.2.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
