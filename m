Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@linux.vnet.ibm.com>) id 1QrdHj-0006K7-Qe
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 21:59:27 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QrdHh-0002g5-GI
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 21:59:27 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7BLpQIb023482
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:51:26 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7BLxHo7176486
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 15:59:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7BFwnsG025978
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 09:58:49 -0600
Received: from taco.beaverton.ibm.com ([9.47.29.114])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p7BFwnRe025956
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Aug 2011 09:58:49 -0600
Date: Thu, 11 Aug 2011 14:59:22 -0700
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Message-ID: <20110811215922.GA9518@us.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 5/7] Changes to pounder's teset scripts
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

Fixed several bugs that prevented test scripts from running
correctly. Affected test scripts: bonnie++, build_kernel,
cpufreq, get_hw_info, ide_cdrom_copy, ltp, memtest, nfs,
ping_nfs_server, random_syscall, time_consistency,
time_drift, xterm_stress.

Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
---
 tools/pounder21/test_scripts/bonnie++         |   11 -----------
 tools/pounder21/test_scripts/build_kernel     |    7 +++----
 tools/pounder21/test_scripts/cpufreq          |   10 +++++-----
 tools/pounder21/test_scripts/get_hw_info      |    2 +-
 tools/pounder21/test_scripts/ide_cdrom_copy   |    3 ++-
 tools/pounder21/test_scripts/ltp              |    6 +++++-
 tools/pounder21/test_scripts/memtest          |   14 +++-----------
 tools/pounder21/test_scripts/nfs              |    2 +-
 tools/pounder21/test_scripts/passloop.sh      |    1 -
 tools/pounder21/test_scripts/ping_nfs_server  |    2 +-
 tools/pounder21/test_scripts/random_syscall   |    1 +
 tools/pounder21/test_scripts/simpleD          |    4 ++++
 tools/pounder21/test_scripts/time_consistency |    1 -
 tools/pounder21/test_scripts/time_drift       |   14 ++++++++++----
 tools/pounder21/test_scripts/xterm_stress     |    2 +-
 15 files changed, 37 insertions(+), 43 deletions(-)
 create mode 100755 tools/pounder21/test_scripts/simpleD


--------------1.7.4.1
Content-Type: text/x-patch; name="0005-Changes-to-pounder-s-teset-scripts.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0005-Changes-to-pounder-s-teset-scripts.patch"

diff --git a/tools/pounder21/test_scripts/bonnie++ b/tools/pounder21/test_scripts/bonnie++
index 7b3cb95..109c4e3 100755
--- a/tools/pounder21/test_scripts/bonnie++
+++ b/tools/pounder21/test_scripts/bonnie++
@@ -36,10 +36,6 @@ fi
 LOGFILE=/proc/$$/fd/1
 OLD_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied)" $LOGFILE`
 
-# How much RAM do we have?
-RAM=`cat /proc/meminfo | grep MemTotal | awk -F " " '{print $2}'`
-SPACE_REQUIRED=`expr $RAM \* 4`
-
 # Now figure out where we have mounted filesystems
 MOUNTS=`egrep "(ext|reiser)" /proc/mounts | awk -F " " '{print $2}'`
 
@@ -51,13 +47,6 @@ echo $MOUNTS | sed -e 's/ /\n/g' | while read f; do
 	# Clean out space for bonnie
 	rm -rf "$f/bonnie/"
 
-	# Do we have enough space? (assume 4x RAM is enough)
-	FREE_SPACE=`df -k -P "$f" | tail -n 1 | awk -F " " '{print $4}'`
-	if [ "$FREE_SPACE" -lt "$SPACE_REQUIRED" ]; then
-		echo "Insufficient space on $f; not running bonnie."
-		continue
-	fi
-	
 	# Set up for bonnie
 	mkdir -p "$f/bonnie/"
 
diff --git a/tools/pounder21/test_scripts/build_kernel b/tools/pounder21/test_scripts/build_kernel
index ccd66ea..56f50c7 100755
--- a/tools/pounder21/test_scripts/build_kernel
+++ b/tools/pounder21/test_scripts/build_kernel
@@ -22,7 +22,7 @@
 
 CPUS=`grep processor /proc/cpuinfo | wc -l`
 ARCH=`uname -m`
-VERSION=2.6.18
+VERSION=2.6.39
 # WARNING: If you update the kernel version that we use, be sure to
 # update $POUNDER_SRCDIR/memtest.patch, $POUNDER_HOME/test_scripts/memtest,
 # $POUNDER_HOME/test_scripts/build_kernel, and
@@ -32,12 +32,11 @@ VERSION=2.6.18
 
 # Decompress tarball if necessary
 cd "$POUNDER_TMPDIR"
-if [ ! -d linux-$VERSION ]; then
-	tar -xzf "$POUNDER_OPTDIR/linux-$VERSION.tar.gz"
-fi
+tar -xvf "$POUNDER_OPTDIR/linux-$VERSION.tar.bz2"
 
 # Clean up the tree.
 cd linux-$VERSION
+
 make mrproper
 
 # Create a config file
diff --git a/tools/pounder21/test_scripts/cpufreq b/tools/pounder21/test_scripts/cpufreq
index 09b2925..8fd44db 100755
--- a/tools/pounder21/test_scripts/cpufreq
+++ b/tools/pounder21/test_scripts/cpufreq
@@ -21,12 +21,12 @@
 
 
 # Do any CPU support cpufreq?
-CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
+#CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
 
-if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
-	echo "None of your CPUs support cpufreq.  Bye."
-	exit 255
-fi
+#if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
+#	echo "None of your CPUs support cpufreq.  Bye."
+#	exit 255
+#fi
 
 # Turn on acpi_pstate_strict to ensure that state transitions actually happen...
 if [ -f /sys/module/acpi_cpufreq/parameters/acpi_pstate_strict ]; then
diff --git a/tools/pounder21/test_scripts/get_hw_info b/tools/pounder21/test_scripts/get_hw_info
index f4d469a..c0ee107 100755
--- a/tools/pounder21/test_scripts/get_hw_info
+++ b/tools/pounder21/test_scripts/get_hw_info
@@ -82,6 +82,6 @@ fdisk -l /dev/sd[a-z] /dev/hd[a-z]
 echo
 echo "sysfs Device Info:"
 echo "=================="
-find /sys -type f | while read f; do echo $f: `cat $f`; done
+find /sys -mount -type f | while read f; do echo $f: `cat $f`; done
 
 exit 0
diff --git a/tools/pounder21/test_scripts/ide_cdrom_copy b/tools/pounder21/test_scripts/ide_cdrom_copy
index 45e24cc..ed67f2f 100755
--- a/tools/pounder21/test_scripts/ide_cdrom_copy
+++ b/tools/pounder21/test_scripts/ide_cdrom_copy
@@ -40,6 +40,7 @@ trap 'exit 255' SIGABRT
 
 # Now, mount each disc and do the test.
 find_discs_with_media | while read DEV USE_FSTAB; do
+
 	# Are there no CDs at all?
 	if [ "$DEV" == "NONE" ]; then
 		echo "No CD/DVD drives found.  Aborting."
@@ -76,6 +77,7 @@ find_discs_with_media | while read DEV USE_FSTAB; do
 	rm -rf "$DESTINATION"
 done
 
+
 # Look for new errors.
 NEW_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied)" $LOGFILE`
 NEW_DIFFS=`egrep -ic "^---" $LOGFILE`
@@ -86,5 +88,4 @@ WRONG=$(( ERRORS + DIFFS ))
 if [ $WRONG -eq 255 ]; then
 	WRONG=254
 fi
-
 exit $WRONG
diff --git a/tools/pounder21/test_scripts/ltp b/tools/pounder21/test_scripts/ltp
index fb70c63..fce09eb 100755
--- a/tools/pounder21/test_scripts/ltp
+++ b/tools/pounder21/test_scripts/ltp
@@ -19,7 +19,7 @@
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 # 02111-1307, USA.
 
-LTPRUNALL=`ls $POUNDER_HOME/../../runltp`
+LTPRUNALL=`ls $POUNDER_TMPDIR/opt/ltp/runltp`
 
 # Catch errors
 LOGFILE=/proc/$$/fd/1
@@ -27,6 +27,10 @@ OLD_ERRORS=`egrep -c "FAIL  :" $LOGFILE`
 
 "$LTPRUNALL"
 
+if [ $? -ne 0 ]; then
+	exit 255
+fi
+
 # Catch errors
 NEW_ERRORS=`egrep -c "FAIL  :" $LOGFILE`
 ERRORS=$(( NEW_ERRORS - OLD_ERRORS ))
diff --git a/tools/pounder21/test_scripts/memtest b/tools/pounder21/test_scripts/memtest
index 3a6bd1f..841fee7 100755
--- a/tools/pounder21/test_scripts/memtest
+++ b/tools/pounder21/test_scripts/memtest
@@ -26,19 +26,9 @@ if [ ! -f "$POUNDER_OPTDIR/memtest.sh" ]; then
 	exit -1
 fi
 
-# How much RAM do we have?
-RAM=`cat /proc/meminfo | grep MemTotal | awk -F " " '{print $2}'`
-SPACE_REQUIRED=`expr $RAM \* 2`
-
-# Do we have enough space?
 MEMTESTDIR="$POUNDER_TMPDIR/memtest/"
 rm -rf "$MEMTESTDIR"
 mkdir -p "$MEMTESTDIR"
-FREE_SPACE=`df -k -P "$MEMTESTDIR" | tail -n 1 | awk -F " " '{print $4}'`
-if [ "$FREE_SPACE" -lt "$SPACE_REQUIRED" ]; then
-	echo "Insufficient space; not running memtest."
-	exit -1
-fi
 
 # Did we see any failures?
 LOGFILE=/proc/$$/fd/1
@@ -46,7 +36,9 @@ OLD_ERRORS=`egrep -ic "(err|fail|invalid|cannot|denied|diff)" $LOGFILE`
 
 # Run the test
 cd "$POUNDER_OPTDIR"
-NR_PASSES=2 TEST_DIR="$MEMTESTDIR" SOURCE_FILE="$POUNDER_OPTDIR/linux-2.6.18.tar.gz" ./memtest.sh
+cp "$POUNDER_OPTDIR/linux-2.6.39.tar.bz2" "$MEMTESTDIR/linux-2.6.39.tar.bz2"
+#NR_PASSES=2 TEST_DIR="$MEMTESTDIR" SOURCE_FILE="$POUNDER_OPTDIR/linux-2.6.39.tar.gz" 
+./memtest.sh
 
 # Now clean up
 rm -rf "$POUNDER_TMPDIR/memtest/"
diff --git a/tools/pounder21/test_scripts/nfs b/tools/pounder21/test_scripts/nfs
index ca335dd..94d45c9 100755
--- a/tools/pounder21/test_scripts/nfs
+++ b/tools/pounder21/test_scripts/nfs
@@ -19,7 +19,7 @@
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 # 02111-1307, USA.
 
-if [ -z "$NFS_SERVER" ]; then
+if [ -z "$NFS_SERVER" -o "$NFS_SERVER" == "0" ]; then
 	echo "NFS server not configured."
 	exit 255
 fi
diff --git a/tools/pounder21/test_scripts/passloop.sh b/tools/pounder21/test_scripts/passloop.sh
index 8af9b18..72b6a30 100755
--- a/tools/pounder21/test_scripts/passloop.sh
+++ b/tools/pounder21/test_scripts/passloop.sh
@@ -19,6 +19,5 @@
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 # 02111-1307, USA.
 
-
 $POUNDER_HOME/timed_loop 1 $POUNDER_HOME/test_scripts/pass.sh
 exit $?
diff --git a/tools/pounder21/test_scripts/ping_nfs_server b/tools/pounder21/test_scripts/ping_nfs_server
index 6b510e0..ebcf233 100755
--- a/tools/pounder21/test_scripts/ping_nfs_server
+++ b/tools/pounder21/test_scripts/ping_nfs_server
@@ -19,7 +19,7 @@
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 # 02111-1307, USA.
 
-if [ -z "$NFS_SERVER" ]; then
+if [ -z "$NFS_SERVER" -o "$NFS_SERVER" == "0" ]; then
 	echo "NFS server not configured."
 	exit -1
 fi
diff --git a/tools/pounder21/test_scripts/random_syscall b/tools/pounder21/test_scripts/random_syscall
index ee290f1..823a4bb 100755
--- a/tools/pounder21/test_scripts/random_syscall
+++ b/tools/pounder21/test_scripts/random_syscall
@@ -58,6 +58,7 @@ wait
 
 # Save another copy of dmesg
 dmesg > "$POUNDER_TMPDIR/randasys-after"
+echo "CECHK 5"
 
 # Diff
 DMESG_DIFF_LINES=`diff "$POUNDER_TMPDIR/randasys-before" "$POUNDER_TMPDIR/randasys-after" | wc -l`
diff --git a/tools/pounder21/test_scripts/simpleD b/tools/pounder21/test_scripts/simpleD
new file mode 100755
index 0000000..0fddc95
--- /dev/null
+++ b/tools/pounder21/test_scripts/simpleD
@@ -0,0 +1,4 @@
+#!/bin/sh
+echo simpleD running....
+sleep 100
+exit  $?
diff --git a/tools/pounder21/test_scripts/time_consistency b/tools/pounder21/test_scripts/time_consistency
index 4a8a2bc..3d4dae7 100755
--- a/tools/pounder21/test_scripts/time_consistency
+++ b/tools/pounder21/test_scripts/time_consistency
@@ -25,7 +25,6 @@ LOGFILE=/proc/$$/fd/1
 OLD_ERRORS=`grep ^--- $LOGFILE | wc -l`
 
 $POUNDER_HOME/timed_loop 600 "$POUNDER_SRCDIR/time_tests/inconsistency-check"
-
 # Can we find any new errors?
 NEW_ERRORS=`grep ^--- $LOGFILE | wc -l`
 
diff --git a/tools/pounder21/test_scripts/time_drift b/tools/pounder21/test_scripts/time_drift
index a92efd3..5bdbfdd 100755
--- a/tools/pounder21/test_scripts/time_drift
+++ b/tools/pounder21/test_scripts/time_drift
@@ -19,7 +19,7 @@
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 # 02111-1307, USA.
 
-if [ -z "$NTP_SERVER" ]; then
+if [ -z "$NTP_SERVER" -o "$NTP_SERVER" == "0" ]; then
 	echo "NTP server is not configured."
 	exit 255
 fi
@@ -35,19 +35,25 @@ DFT=500
 LOGFILE=/proc/$$/fd/1
 
 # Why do we need this?  Output is already being logged!
-#cp -f $LOGFILE $POUNDER_TMPDIR/ntpdrift-$$
+cp -f $LOGFILE $POUNDER_TMPDIR/ntpdrift-$$
 
 # Do we have a python interpreter?
 PYTHON=`which python`
 if [ -n "$PYTHON" -a -x "$PYTHON" ]; then
-	$POUNDER_HOME/timed_loop 900 "$POUNDER_SRCDIR/time_tests/drift-test.py" $NTP_SERVER $FREQ
+		$POUNDER_HOME/timed_loop 900 "$POUNDER_SRCDIR/time_tests/drift-test.py" $NTP_SERVER $FREQ
 else
 	echo "There is no python interpreter installed.  Aborting."
 	exit -1
 fi
 
-# Did we see any failures?
+# Did drift-test.py fail to run properly?
+if [ $? -ne 0 ]; then
+	exit 1
+fi
+
+# Did we see any failures in actual drift test?
 ERRORS=0
+cp -f $LOGFILE $POUNDER_TMPDIR/ntpdrift2-$$
 diff -u $POUNDER_TMPDIR/ntpdrift-$$ $LOGFILE | while read a b c d e field drift garbage; do
 	if [ "$field" != "drift:" ]; then
 		continue;
diff --git a/tools/pounder21/test_scripts/xterm_stress b/tools/pounder21/test_scripts/xterm_stress
index 8abeaf6..370d2a6 100755
--- a/tools/pounder21/test_scripts/xterm_stress
+++ b/tools/pounder21/test_scripts/xterm_stress
@@ -32,7 +32,7 @@ NEED_TO_START_X=1
 #fi
 
 # Kill test if we don't want it.
-if [ $DO_X_TESTS -eq 0 ]; then
+if [ -z "$DO_X_TESTS" -o "$DO_X_TESTS" == "0" ]; then
 	echo "X11 testing is off."
 	exit -1
 fi

--------------1.7.4.1--



------------------------------------------------------------------------------
FREE DOWNLOAD - uberSVN with Social Coding for Subversion.
Subversion made easy with a complete admin console. Easy 
to use, easy to manage, easy to install, easy to extend. 
Get a Free download of the new open ALM Subversion platform now.
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
