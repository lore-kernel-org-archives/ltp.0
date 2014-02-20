Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WGSu8-0004ug-OZ
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 12:39:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGSu5-00071y-Et
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 12:39:04 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1KCcr6L017339
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Feb 2014 20:38:53 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 20 Feb 2014 20:37:32 +0800
Message-Id: <1392899852-18058-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] testscripts/test_robind.sh: cleanup and make some
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Remove useless comments and abandon the operation which creates
a 500MB image-file. If user wants to run these tests, a big block
device should be specified by running runltp with -z option.

And we split tests in testscripts/fs_ro_tests into separate testcases,
keep one entry per test in runtest/fs_readonly

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/fs_readonly        |  56 +++++++-
 testscripts/fs_ro_tests    |   1 -
 testscripts/test_robind.sh | 310 ++++++++++++++++++---------------------------
 3 files changed, 176 insertions(+), 191 deletions(-)

diff --git a/runtest/fs_readonly b/runtest/fs_readonly
index 96f12c3..0e1be5f 100644
--- a/runtest/fs_readonly
+++ b/runtest/fs_readonly
@@ -1 +1,55 @@
-ROBind $LTPROOT/testscripts/test_robind.sh
+test_robind01 test_robind.sh -c "growfiles -W gf01 -b -e 1 -u -i 0 -L 5 -w -C 1 -l -I r -T 10 glseek20 glseek20.2"
+test_robind02 test_robind.sh -c "growfiles -W gf02 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_"
+test_robind03 test_robind.sh -c "growfiles -W gf03 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_"
+test_robind04 test_robind.sh -c "growfiles -W gf04 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_"
+test_robind05 test_robind.sh -c "growfiles -W gf05 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_"
+test_robind06 test_robind.sh -c "growfiles -W gf06 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 3 -C 1 g_rand10 g_rand10.2"
+test_robind07 test_robind.sh -c "growfiles -W gf07 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 3 -C 1 -I p g_rand13 g_rand13.2"
+test_robind08 test_robind.sh -c "growfiles -W gf08 -b -e 1 -u -r 1-5000 -R 0--2 -i 0 -L 3 -C 1 g_rand11 g_rand11.2"
+test_robind09 test_robind.sh -c "growfiles -W gf09 -b -e 1 -u -r 1-5000 -R 0--1 -i 0 -L 3 -C 1 -I p g_rand12 g_rand12.2"
+test_robind10 test_robind.sh -c "growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 3 -C 1 -I l g_lio14 g_lio14.2"
+test_robind11 test_robind.sh -c "growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 3 -C 1 -I L g_lio15 g_lio15.2"
+test_robind12 test_robind.sh -c "mkfifo gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 3 gffifo17"
+test_robind13 test_robind.sh -c "mkfifo gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 3 -I r -r 1-4096 gffifo18"
+test_robind14 test_robind.sh -c "growfiles -W gf14 -b -e 1 -u -i 0 -L 2 -w -l -C 1 -T 10 glseek19 glseek19.2"
+test_robind15 test_robind.sh -c "growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 3 Lgfile1"
+test_robind16 test_robind.sh -c "growfiles -W gf16 -b -e 1 -i 0 -L 3 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_"
+test_robind17 test_robind.sh -c "growfiles -W gf17 -b -e 1 -i 0 -L 3 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_"
+test_robind18 test_robind.sh -c "growfiles -W gf18 -b -e 1 -i 0 -L 3 -w -u -r 10-5000 -I r -l -S 2 -f Lgf04_"
+test_robind19 test_robind.sh -c "growfiles -W gf19 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -o O_RDWR,O_CREAT,O_TRUNC -u -f gf08i_"
+test_robind20 test_robind.sh -c "growfiles -W gf20 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1-256000:512 -R 512-256000 -T 4 gfbigio-$$"
+test_robind21 test_robind.sh -c "growfiles -W gf21 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bld-$$"
+test_robind22 test_robind.sh -c "growfiles -W gf22 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 -T 10 -t 20480 gf-bldf-$$"
+test_robind23 test_robind.sh -c "growfiles -W gf23 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024 -R 1-384000 -T 4 gf-inf-$$"
+test_robind24 test_robind.sh -c "growfiles -W gf24 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -g 20480 gf-jbld-$$"
+test_robind25 test_robind.sh -c "growfiles -W gf25 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 1024000-2048000:2048 -R 4095-2048000 -T 1 gf-large-gs-$$"
+test_robind26 test_robind.sh -c "growfiles -W gf26 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R 512-64000 -T 4 gfsmallio-$$"
+test_robind27 test_robind.sh -c "growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$"
+test_robind28 test_robind.sh -c "growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$"
+test_robind29 test_robind.sh -c "growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$"
+test_robind30 test_robind.sh -c "growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$"
+test_robind31 test_robind.sh -c "rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$"
+test_robind32 test_robind.sh -c "rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$"
+test_robind33 test_robind.sh -c "rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$"
+test_robind34 test_robind.sh -c "rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$"
+test_robind35 test_robind.sh -c "rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:rwtest01%f"
+test_robind36 test_robind.sh -c "rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$"
+test_robind37 test_robind.sh -c "fs_inod . 10 10 1"
+test_robind38 test_robind.sh -c "openfile -f10 -t10"
+test_robind39 test_robind.sh -c "inode01"
+test_robind40 test_robind.sh -c "inode02"
+test_robind41 test_robind.sh -c "stream01"
+test_robind42 test_robind.sh -c "stream02"
+test_robind43 test_robind.sh -c "stream03"
+test_robind44 test_robind.sh -c "stream04"
+test_robind45 test_robind.sh -c "stream05"
+test_robind46 test_robind.sh -c "ftest01"
+test_robind47 test_robind.sh -c "ftest02"
+test_robind48 test_robind.sh -c "ftest03"
+test_robind49 test_robind.sh -c "ftest04"
+test_robind50 test_robind.sh -c "ftest05"
+test_robind51 test_robind.sh -c "ftest06"
+test_robind52 test_robind.sh -c "ftest07"
+test_robind53 test_robind.sh -c "ftest08"
+test_robind54 test_robind.sh -c "lftest 80"
+test_robind55 test_robind.sh -c "writetest"
diff --git a/testscripts/fs_ro_tests b/testscripts/fs_ro_tests
index ec4a86c..feb2fe7 100644
--- a/testscripts/fs_ro_tests
+++ b/testscripts/fs_ro_tests
@@ -35,7 +35,6 @@ rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10
 rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:rwtest01%f
 rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
 fs_inod . 10 10 1
-linktest.pl
 openfile -f10 -t10
 inode01
 inode02
diff --git a/testscripts/test_robind.sh b/testscripts/test_robind.sh
index 4c01f4e..76d0e9d 100755
--- a/testscripts/test_robind.sh
+++ b/testscripts/test_robind.sh
@@ -23,15 +23,15 @@
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
-#     Then it executes the tests from flat-file  {LTPROOT}/testscripts/fs_ro_tests
-#     Check the logs /tmp/fs$$/errs.log and /tmp/fs$$/pass.log for pass/failures.
+#       For the c) option it checks that the tests are not able to write
+#       into dir.
 #===============================================================================
 #
 # CHANGE HISTORY:
@@ -41,161 +41,101 @@
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
+	usage: $0 -c command [ext3,ext2,jfs,xfs,reiserfs,ramfs]
+
+	This script verifies ReadOnly-filesystem, by mounting block device and
+	executing the filesystem tests.
 
-  This script verifies ReadOnly-filesystem, by mounting imagefile and
-  executing the filesystem tests.
+	OPTIONS
+		-h    display this message and exit
+		-c    command to be executed
 
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
+	umount ${TESTDIR}/dir3-ro
+	umount ${TESTDIR}/dir2-bound
+	umount ${TESTDIR}/dir1
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
+	if [ -z "$LTP_BIG_DEV" ];then
+		tst_brkm TCONF ignored "tests need a big block device(>=500MB)"
+		exit 0
+	else
+		device=$LTP_BIG_DEV
+	fi
+
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
+	tst_resm TINFO "command: $command"
+
+	# we need to export TMPDIR, in case test calls tst_rmdir()
+	export TMPDIR=$TESTDIR/$dir
+	eval $command > $TESTDIR/test.log 2>&1
+	tst_result=$?
+
+	# if tst_result isn't 0 and read-only flag is false, the test failed
+	# or if tst_result is 0 and read-only flag is true, the test failed.
+	if [ "$RO" = "false" -a $tst_result -ne 0 -o "$RO" = "true" -a \
+	     $tst_result -eq 0 ];then
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
+	rm -rf $TESTDIR/$dir/*
+	cd ..
 }
 
 #=============================================================================
@@ -204,62 +144,54 @@ function testdir
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
+if [ -z "$TMPDIR" ]; then
+	TMPDIR="/tmp"
+fi
+
+TESTDIR=$(mktemp -d "$TMPDIR/$TCID.XXXXXXXXXX")
+cd ${TESTDIR}
+
+while getopts c:h: OPTION; do
+	case $OPTION in
+	c)
+		command=$OPTARG;;
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
 setup $*
 
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
-
-    mount -t $fstype -o loop $image dir1
-    mount --bind dir1 dir2-bound || exit -1
-    mount --bind dir1 dir3-ro    || exit -1
-    mount -o remount,ro dir3-ro  || exit -1
-
-    testdir dir1 $fstype false
-    testdir dir2-bound $fstype false
-    testdir dir3-ro $fstype true
-    cleanup $image
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
+		mkfs.$fstype $opts $device > /dev/null
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
 done
 
-    for i in $DIRS; do
-        rm -rf ./$i || true
-    done;
-    cd $oldpwd || true
-    exit $retcode
+rm -rf $TESTDIR
 
+exit $retcode
-- 
1.8.2.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
