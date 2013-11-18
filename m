Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1ViNwR-00037d-Mq
	for ltp-list@lists.sourceforge.net; Mon, 18 Nov 2013 12:28:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ViNwN-0000Fa-Ta
	for ltp-list@lists.sourceforge.net; Mon, 18 Nov 2013 12:28:35 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAICSNAT015205
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Nov 2013 20:28:23 +0800
Message-ID: <528A07E4.7060608@cn.fujitsu.com>
Date: Mon, 18 Nov 2013 20:28:20 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testscripts/test_robind.sh: add fs_readonly to default
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

cleanup of testscripts/test_robind.sh

testscripts/fs_ro_tests: delete some unecessary tests

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 scenario_groups/default    |   1 +
 testscripts/fs_ro_tests    |  19 ----
 testscripts/test_robind.sh | 272 ++++++++++++++++++++++-----------------------
 3 files changed, 134 insertions(+), 158 deletions(-)

diff --git a/scenario_groups/default b/scenario_groups/default
index 9eca8ad..520db8b 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -25,3 +25,4 @@ hugetlb
 commands
 hyperthreading
 kernel_misc
+fs_readonly
diff --git a/testscripts/fs_ro_tests b/testscripts/fs_ro_tests
index ec4a86c..2ecd9c5 100644
--- a/testscripts/fs_ro_tests
+++ b/testscripts/fs_ro_tests
@@ -35,22 +35,3 @@ rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10
 rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:rwtest01%f
 rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
 fs_inod . 10 10 1
-linktest.pl
-openfile -f10 -t10
-inode01
-inode02
-stream01
-stream02
-stream03
-stream04
-stream05
-ftest01
-ftest02
-ftest03
-ftest04
-ftest05
-ftest06
-ftest07
-ftest08
-lftest 80
-writetest
diff --git a/testscripts/test_robind.sh b/testscripts/test_robind.sh
index 4c01f4e..231419a 100755
--- a/testscripts/test_robind.sh
+++ b/testscripts/test_robind.sh
@@ -45,23 +45,20 @@
 $trace_logic
 
 # The test case ID, the test case count and the total number of test case
-TCID=${TCID:-test_robind.sh}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
+export TCID=${TCID:-test_robind.sh}
+export TST_TOTAL=1
+export TST_COUNT=1
 
 usage()
 {
-  cat << EOF
-  usage: $0 [ext3,ext2,jfs,xfs,reiserfs,ramfs]
+	cat << EOF
+usage: $0 [ext3,ext2,jfs,xfs,reiserfs,ramfs]
 
-  This script verifies ReadOnly-filesystem, by mounting imagefile and
-  executing the filesystem tests.
+	This script verifies ReadOnly-filesystem, by mounting imagefile and
+executing the filesystem tests.
 
-  OPTIONS
-    -h    display this message and exit
+OPTIONS
+	-h    display this message and exit
 EOF
 }
 
@@ -81,18 +78,15 @@ trap cleanup INT
 #==============================================================================
 function cleanup
 {
-    umount ${TMPDIR}/dir3-ro 2> /dev/null > /dev/null
-    umount ${TMPDIR}/dir2-bound 2> /dev/null 1> /dev/null
-    umount ${TMPDIR}/dir1 2> /dev/null 1> /dev/null
-    if [ ! -z $1 ]; then {
-        rm -rf $1 || true
-    }
-    fi
+	umount ${TMPDIR}/dir3-ro 2> /dev/null > /dev/null
+	umount ${TMPDIR}/dir2-bound 2> /dev/null 1> /dev/null
+	umount ${TMPDIR}/dir1 2> /dev/null 1> /dev/null
+	if [ ! -z $1 ]; then
+		rm -rf $1 || true
+	fi
 }
 
-#===============================================================================
-# FUNCTION NAME:    setup
-#
+#=============================================================================== # FUNCTION NAME:    setup #
 # FUNCTION DESCRIPTION: Does the initailization
 #
 # PARAMETERS:   File_systems (if any )
@@ -101,33 +95,33 @@ function cleanup
 #===============================================================================
 function setup
 {
-    mkdir ${TMPDIR}
-    FAILLOG="$TMPDIR/errs.log"
-    PASSLOG="$TMPDIR/pass.log"
+	mkdir ${TMPDIR}
+	FAILLOG="$TMPDIR/errs.log"
+	PASSLOG="$TMPDIR/pass.log"
 
-    for i in $DIRS; do
-        rm -rf ${TMPDIR}/$i || true
-        mkdir -p ${TMPDIR}/$i
-    done;
+	for i in $DIRS; do
+		rm -rf ${TMPDIR}/$i || true
+		mkdir -p ${TMPDIR}/$i
+	done;
 
-    # Populating the default FS as ext3, if FS is not given
-    if [ -z "$*" ]; then
-        FSTYPES="ext3"
-    else
-        FSTYPES="$*"
-    fi
+	# Populating the default FS as ext3, if FS is not given
+	if [ -z "$*" ]; then
+		FSTYPES="ext3"
+	else
+		FSTYPES="$*"
+	fi
 
-    # set the LTPROOT directory
-    cd `dirname $0`
-    echo "${PWD}" | grep testscripts > /dev/null 2>&1
-    if [ $? -eq 0 ]; then
-        cd ..
-        export LTPROOT="${PWD}"
-        export PATH="${PATH}:${LTPROOT}/testcases/bin"
-    fi
+	# set the LTPROOT directory
+	cd `dirname $0`
+	echo "${PWD}" | grep testscripts > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		cd ..
+		export LTPROOT="${PWD}"
+		export PATH="${PATH}:${LTPROOT}/testcases/bin"
+	fi
 
-    FS_Tests="${LTPROOT}/testscripts/fs_ro_tests"
-    cd ${TMPDIR}
+	FS_Tests="${LTPROOT}/testscripts/fs_ro_tests"
+	cd ${TMPDIR}
 }
 
 #=============================================================================
@@ -141,61 +135,61 @@ function setup
 #=============================================================================
 function testdir
 {
-    dir=$1
-    fs=$2
-    RO=$3
-    pushd $dir
-    testnums=`wc -l $FS_Tests | cut -f1 -d" "`
-    status=0
+	dir=$1
+	fs=$2
+	RO=$3
+	pushd $dir
+	testnums=`wc -l $FS_Tests | cut -f1 -d" "`
+	status=0
+
+	echo "---------------------------------------------------" >> $FAILLOG ;
+	echo "Running RO-FileSystem Tests for $dir $fs filesystem" >> $FAILLOG ;
+	echo "---------------------------------------------------" >> $FAILLOG ;
 
-    echo "---------------------------------------------------" >> $FAILLOG ;
-    echo "Running RO-FileSystem Tests for $dir $fs filesystem" >> $FAILLOG ;
-    echo "---------------------------------------------------" >> $FAILLOG ;
+	echo "---------------------------------------------------" >> $PASSLOG ;
+	echo "Running RO-FileSystem Tests for $dir $fs filesystem" >> $PASSLOG ;
+	echo "---------------------------------------------------" >> $PASSLOG ;
 
-    echo "---------------------------------------------------" >> $PASSLOG ;
-    echo "Running RO-FileSystem Tests for $dir $fs filesystem" >> $PASSLOG ;
-    echo "---------------------------------------------------" >> $PASSLOG ;
+	export TDIRECTORY=$PWD ;
+	echo TDIR is $TDIRECTORY;
+	if [ $RO == false ] ; then	# Testing Read-Write dir
+		for tests in `seq $testnums` ; do
+			cmd=`cat $FS_Tests | head -$tests | tail -n 1`
+			eval $cmd 2> /dev/null 1> /dev/null
+			if [ $? -eq 0 ]; then
+				echo "$tests. '$cmd' PASS" >> $PASSLOG
+			else
+				echo "$tests. '$cmd' FAIL " >> $FAILLOG
+				status=1
+			fi
+		done
 
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
+	else	# Testing Read-Only dir
+		for tests in `seq $testnums` ; do
+			cmd=`cat $FS_Tests | head -$tests | tail -n 1`
+			eval $cmd 2> /dev/null 1> /dev/null
+			if [ $? -ne 0 ]; then
+				echo "$tests. '$cmd' PASS " >> $PASSLOG
+			else
+				echo "$tests. '$cmd' FAIL" >> $FAILLOG
+				status=1
+			fi
+		done
+	fi
 
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
+	if [ $status == 1 ] ; then
+		echo "RO-FileSystem Tests FAILED for $dir $fs filesystem" >> $FAILLOG
+		echo >> $FAILLOG
+		retcode=$status
+	else
+		echo "RO-FileSystem Tests PASSed for $dir $fs filesystem" >> $PASSLOG
+		echo >> $PASSLOG
+	fi
+
+	# Remove all the temp-files created.
+	rm -rf ${TMPDIR}/${dir}/* > /dev/null 2>&1 || true
+	unset TDIRECTORY
+	popd
 }
 
 #=============================================================================
@@ -205,17 +199,18 @@ function testdir
 #=============================================================================
 retcode=0
 while getopts h: OPTION; do
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
+	case $OPTION in
+	h)
+		usage
+		exit 1
+		;;
+	?)
+		usage
+		exit 1
+		;;
+	esac
 done
+
 # Does the initial setups
 oldpwd=${PWD}
 setup $*
@@ -223,43 +218,42 @@ setup $*
 # Executes the tests for differnt FS's
 # Creates an image file of 500 MB and mounts it.
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
+	image=$fstype.img
+	dd if=/dev/zero of=$image bs=$((1<<20)) count=500 2> /dev/null 1> /dev/null
+	if [ $? -ne 0 ] ; then
+		tst_resm  TFAIL "Unable to create image "
+		tst_resm  TFAIL "Free Disk space of 512MB is required in /tmp fs"
+		tst_resm  TFAIL "Please free it and rerun thank you.."
+		rm -f $image
+		exit -1
+	fi
 
-    OPTS="-F"
-    if [ "$fstype" == "reiserfs" ]; then
-    OPTS="-f --journal-size 513 -q"
-    elif [ "$fstype" == "jfs" ]; then
-    OPTS="-f"
-    elif [ "$fstype" == "xfs" ]; then
-    OPTS=""
-    fi
+	OPTS="-F"
+	if [ "$fstype" == "reiserfs" ]; then
+		OPTS="-f --journal-size 513 -q"
+	elif [ "$fstype" == "jfs" ]; then
+		OPTS="-f"
+	elif [ "$fstype" == "xfs" ]; then
+		OPTS=""
+	fi
 
-    if [ "$fstype" != "ramfs" ] ; then
-        mkfs.$fstype $OPTS $image 2> /dev/null 1> /dev/null
-    fi
+	if [ "$fstype" != "ramfs" ] ; then
+		mkfs.$fstype $OPTS $image 2> /dev/null 1> /dev/null
+	fi
 
-    mount -t $fstype -o loop $image dir1
-    mount --bind dir1 dir2-bound || exit -1
-    mount --bind dir1 dir3-ro    || exit -1
-    mount -o remount,ro dir3-ro  || exit -1
+	mount -t $fstype -o loop $image dir1
+	mount --bind dir1 dir2-bound || exit -1
+	mount --bind dir1 dir3-ro    || exit -1
+	mount -o remount,ro,bind dir1 dir3-ro  || exit -1
 
-    testdir dir1 $fstype false
-    testdir dir2-bound $fstype false
-    testdir dir3-ro $fstype true
-    cleanup $image
+	testdir dir1 $fstype false
+	testdir dir2-bound $fstype false
+	testdir dir3-ro $fstype true
+	cleanup $image
 done
 
-    for i in $DIRS; do
-        rm -rf ./$i || true
-    done;
-    cd $oldpwd || true
-    exit $retcode
+for i in $DIRS; do
+	rm -rf ./$i || true
+done;
 
+exit $retcode
-- 
1.8.2.1


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
