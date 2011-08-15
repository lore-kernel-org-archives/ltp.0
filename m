Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@taco.beaverton.ibm.com>) id 1Qt2pw-0001OT-Ow
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:28:36 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qt2pu-0005ca-VJ
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:28:36 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7FIg2KF019728
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 12:42:02 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7FIv9LK178844
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 12:57:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7FCug0H017199
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 06:56:42 -0600
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Date: Mon, 15 Aug 2011 11:56:30 -0700
Message-Id: <1313434593-7942-4-git-send-email-lgliang@linux.vnet.ibm.com>
In-Reply-To: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
References: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.4.1"
Subject: [LTP] [PATCH 4/7 ver2 w/attachment] Changes to pounder's build
	scripts
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Updated packages in some of pounder's build scripts to newer
versions (bonnie++, build_kernel, ipmitool). Merged a few related
build scripts (00check_cdrom_presence merged into ide_cdrom_copy,
nasm and schedutils merged into lame, time_test merged into
time_consistency and time_drift, 00xbonkers and coords merged into
xterm_stress). Removed 00checklatest altogether. Fixed a few bugs
that prevented certain subtests from building correctly.

Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
---
 .../pounder21/build_scripts/00check_cdrom_presence |   48 ------------
 tools/pounder21/build_scripts/00checklatest        |   68 -----------------
 tools/pounder21/build_scripts/00xbonkers           |   39 ----------
 tools/pounder21/build_scripts/bonnie++             |   26 ++++++-
 tools/pounder21/build_scripts/build_kernel         |    2 +-
 tools/pounder21/build_scripts/coords               |   26 -------
 tools/pounder21/build_scripts/cpufreq              |    7 ++
 tools/pounder21/build_scripts/ide_cdrom_copy       |   56 ++++++++++++++
 tools/pounder21/build_scripts/ipmitool             |    5 +-
 tools/pounder21/build_scripts/lame                 |   80 ++++++++++++++++++--
 tools/pounder21/build_scripts/ltp                  |   23 +++---
 tools/pounder21/build_scripts/memtest              |   32 ++++++--
 tools/pounder21/build_scripts/nasm                 |   55 -------------
 tools/pounder21/build_scripts/schedutils           |   64 ----------------
 tools/pounder21/build_scripts/time_consistency     |   24 ++++++
 tools/pounder21/build_scripts/time_drift           |   25 ++++++
 tools/pounder21/build_scripts/time_test            |   25 ------
 tools/pounder21/build_scripts/xterm_stress         |   39 ++++++++++
 18 files changed, 288 insertions(+), 356 deletions(-)
 delete mode 100755 tools/pounder21/build_scripts/00check_cdrom_presence
 delete mode 100755 tools/pounder21/build_scripts/00checklatest
 delete mode 100755 tools/pounder21/build_scripts/00xbonkers
 delete mode 100755 tools/pounder21/build_scripts/coords
 create mode 100755 tools/pounder21/build_scripts/ide_cdrom_copy
 delete mode 100755 tools/pounder21/build_scripts/nasm
 delete mode 100755 tools/pounder21/build_scripts/schedutils
 create mode 100755 tools/pounder21/build_scripts/time_consistency
 create mode 100755 tools/pounder21/build_scripts/time_drift
 delete mode 100755 tools/pounder21/build_scripts/time_test
 create mode 100755 tools/pounder21/build_scripts/xterm_stress


--------------1.7.4.1
Content-Type: text/x-patch;
	name="0004-Changes-to-pounder-s-build-scripts.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0004-Changes-to-pounder-s-build-scripts.patch"

diff --git a/tools/pounder21/build_scripts/00check_cdrom_presence b/tools/pounder21/build_scripts/00check_cdrom_presence
deleted file mode 100755
index 966e381..0000000
--- a/tools/pounder21/build_scripts/00check_cdrom_presence
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/bin/bash
-
-# Determine if there is at least ONE disc in the system's CDROM drives.
-
-# Copyright (C) 2003-2006 IBM
-# 
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-# 
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-. "$POUNDER_SRCDIR/libidecd.sh"
-
-DEFAULT_MOUNT="$POUNDER_TMPDIR/cdmount"
-
-# Ensure that our default mountpoint and destination dirs exist.
-mkdir -p "$DEFAULT_MOUNT"
-
-# How many discs can we find?
-DISCS_FOUND=`find_discs_with_media | wc -l`
-if [ $DISCS_FOUND -lt 1 ]; then
-	echo -en "Examined "
-	find_disc_devices | while read f; do
-		echo -en "$f "
-		eject "$f"
-	done
-	echo " and found no discs to test."
-	echo "Please put a disc into the CD/DVD drive(s) and press ENTER."
-	read garbage
-
-	DISCS_FOUND=`find_discs_with_media | wc -l`
-	if [ $DISCS_FOUND -lt 1 ]; then
-		echo "Still can't find any discs.  CD test will (probably) not run."
-		exit 0
-	fi
-fi
-
-exit 0
diff --git a/tools/pounder21/build_scripts/00checklatest b/tools/pounder21/build_scripts/00checklatest
deleted file mode 100755
index 3d10bf8..0000000
--- a/tools/pounder21/build_scripts/00checklatest
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/bin/bash
-
-# Check for program updates.
-
-# Copyright (C) 2003-2006 IBM
-# 
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-# 
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-source "$POUNDER_HOME/libpounder.sh"
-
-if [ ! -f "$POUNDER_HOME/README" ]; then
-	echo "README file (with version number) is missing.  Not checking version."
-	exit 0
-fi
-
-if [ -z "$POUNDER_HEAD" ]; then
-	echo "No POUNDER_HEAD defined; can't check version."
-	exit 0
-fi
-
-X=$(( `echo $POUNDER_VERSION | cut -c 1-4 | sed -e 's/^0*//g'` * 10000 + `echo $POUNDER_VERSION | cut -c 6-7 | sed -e 's/^0*//g'` * 100 + `echo $POUNDER_VERSION | cut -c 9-10 | sed -e 's/^0*//g'`))
-
-LATEST_POUNDER=`wget -O - "$POUNDER_HEAD/.version" 2> /dev/null`
-if [ -z "$LATEST_POUNDER" ]; then
-	# If we couldn't get the version, then the variable is zero-length.
-	echo "Unable to determine if there's a new pounder2 release."
-	echo "This is not a fatal error, merely a warning."
-	exit 0
-fi
-
-Y=$(( `echo $LATEST_POUNDER | cut -c 1-4 | sed -e 's/^0*//g'` * 10000 + `echo $LATEST_POUNDER | cut -c 6-7 | sed -e 's/^0*//g'` * 100 + `echo $LATEST_POUNDER | cut -c 9-10 | sed -e 's/^0*//g'`))
-
-if [ $Y -gt $X ]; then
-	echo "Version mismatch detected."
-	echo "You are running: $POUNDER_VERSION."
-	echo "The server has $LATEST_POUNDER."
-	echo
-	while true; do
-		echo -en "Would you like to download it [Y/n]? "
-		read f
-		if [ "$f" == "Y" -o "$f" == "y" -o -z "$f" ]; then
-			cd "$POUNDER_HOME/../"
-			wget "$POUNDER_HEAD/pounder21-$LATEST_POUNDER.src.tar.gz"
-			cd -
-			echo "Please unpack your new pounder and rerun Install."
-			exit 1
-		elif [ "$f" == "N" -o "$f" == "n" ]; then
-			echo "Ok; ignoring mismatch and proceeding."
-			exit 0
-		fi
-	done
-fi
-
-exit 0
diff --git a/tools/pounder21/build_scripts/00xbonkers b/tools/pounder21/build_scripts/00xbonkers
deleted file mode 100755
index 349752e..0000000
--- a/tools/pounder21/build_scripts/00xbonkers
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/bash
-
-# Build the program that wiggles X windows.
-
-# Copyright (C) 2003-2006 IBM
-# 
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-# 
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-cd "$POUNDER_SRCDIR/xbonkers/"
-
-make $*
-RESULT=$?
-
-if [ $RESULT -ne 0 ]; then
-	echo
-	echo "xbonkers build failed; you probably need X11 devel packages."
-	echo -en "Ignore for now [y/N]? "
-	while read f; do
-		if [ "$f" == "y" -o "$f" == "Y" ]; then
-			exit 0
-		elif [ "$f" == "n" -o "$f" == "n" -o -z "$f" ]; then
-			exit $RESULT
-		fi
-	done
-fi
diff --git a/tools/pounder21/build_scripts/bonnie++ b/tools/pounder21/build_scripts/bonnie++
index c3afdf2..d408fb7 100755
--- a/tools/pounder21/build_scripts/bonnie++
+++ b/tools/pounder21/build_scripts/bonnie++
@@ -20,10 +20,34 @@
 # 02111-1307, USA.
 
 
-PKGNAME=bonnie++-1.03a
+PKGNAME=bonnie++-1.03e
 TARNAME="$PKGNAME.tgz"
 PROGNAME=bonnie++
 
+# How much RAM do we have?
+RAM=`cat /proc/meminfo | grep MemTotal | awk -F " " '{print $2}'`
+SPACE_REQUIRED=`expr $RAM \* 4`
+
+# Now figure out where we have mounted filesystems
+MOUNTS=`egrep "(ext|reiser)" /proc/mounts | awk -F " " '{print $2}'`
+
+RET=$(
+	echo $MOUNTS | sed -e 's/ /\n/g' | while read f; do
+
+        	# Do we have enough space? (assume 4x RAM is enough)
+        	FREE_SPACE=`df -k -P "$f" | tail -n 1 | awk -F " " '{print $4}'`
+
+        	if [ "$FREE_SPACE" -lt "$SPACE_REQUIRED" ]; then
+			break
+        	fi
+	done
+)
+
+if [ ! -z $RET ]; then
+        echo "[bonnie++] Insufficient space. Free space: $FREE_SPACE kB. Space required: $SPACE_REQUIRED kB. Not building bonnie."
+	exit 1
+fi
+
 # Is it already installed?
 PROG=`which $PROGNAME`
 if [ ! -z "$PROG" ]; then
diff --git a/tools/pounder21/build_scripts/build_kernel b/tools/pounder21/build_scripts/build_kernel
index 87cd62e..1511578 100755
--- a/tools/pounder21/build_scripts/build_kernel
+++ b/tools/pounder21/build_scripts/build_kernel
@@ -20,7 +20,7 @@
 # 02111-1307, USA.
 
 
-TARNAME=linux-2.6.18.tar.gz
+TARNAME=linux-2.6.39.tar.bz2
 # WARNING: If you update the kernel version that we use, be sure to
 # update $POUNDER_SRCDIR/memtest.patch, $POUNDER_HOME/test_scripts/memtest,
 # $POUNDER_HOME/test_scripts/build_kernel, and
diff --git a/tools/pounder21/build_scripts/coords b/tools/pounder21/build_scripts/coords
deleted file mode 100755
index 9b8c79d..0000000
--- a/tools/pounder21/build_scripts/coords
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/bash
-
-# Builds a program to generate random coordinates for X11
-# programs' -geometry flag.
-
-# Copyright (C) 2003-2006 IBM
-# 
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-# 
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-cd "$POUNDER_SRCDIR/randacoords/"
-
-make $*
diff --git a/tools/pounder21/build_scripts/cpufreq b/tools/pounder21/build_scripts/cpufreq
index 7ddebe8..96514f3 100755
--- a/tools/pounder21/build_scripts/cpufreq
+++ b/tools/pounder21/build_scripts/cpufreq
@@ -20,6 +20,13 @@
 # 02111-1307, USA.
 
 
+# Do any CPU support cpufreq?
+CPUFREQ_ENABLED_CPUS=`/bin/ls -lad /sys/devices/system/cpu/cpu*/cpufreq 2> /dev/null | wc -l`
+if [ "$CPUFREQ_ENABLED_CPUS" -lt 1 ]; then
+        echo "[cpufreq] None of your CPUs support cpufreq. Not building cpufreq."
+        exit 255
+fi
+
 cd "$POUNDER_SRCDIR/cpufreq/"
 
 make $*
diff --git a/tools/pounder21/build_scripts/ide_cdrom_copy b/tools/pounder21/build_scripts/ide_cdrom_copy
new file mode 100755
index 0000000..07e6c71
--- /dev/null
+++ b/tools/pounder21/build_scripts/ide_cdrom_copy
@@ -0,0 +1,56 @@
+#!/bin/bash
+
+# Looks for CD/DVD drives and then determine
+# if there is at least ONE disc in the system's CDROM drives.
+
+# Copyright (C) 2003-2006 IBM
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of the
+# License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+# 02111-1307, USA.
+
+. "$POUNDER_SRCDIR/libidecd.sh"
+
+DRIVES_FOUND=`find_discs_with_media`
+if [ "$DRIVES_FOUND" == "NONE 0" ]; then
+        echo "[ide_cdrom_copy] No CD/DVD drives found. CD test will not build."
+        exit 1;
+fi
+
+DEFAULT_MOUNT="$POUNDER_TMPDIR/cdmount"
+
+# Ensure that our default mountpoint and destination dirs exist.
+mkdir -p "$DEFAULT_MOUNT"
+
+# How many discs can we find?
+DISCS_FOUND=`find_discs_with_media | wc -l`
+if [ $DISCS_FOUND -lt 1 ]; then
+        echo -en "Examined "
+        find_disc_devices | while read f; do
+                echo -en "$f "
+                eject "$f"
+        done
+        echo " and found no discs to test."
+        echo "Please put a disc into the CD/DVD drive(s) and press ENTER."
+        read garbage
+
+        DISCS_FOUND=`find_discs_with_media | wc -l`
+        if [ $DISCS_FOUND -lt 1 ]; then
+                echo "Still can't find any discs.  CD test will probably not run."
+                exit 0
+        fi
+fi
+
+exit 0
+
diff --git a/tools/pounder21/build_scripts/ipmitool b/tools/pounder21/build_scripts/ipmitool
index 4874a81..ed2e114 100755
--- a/tools/pounder21/build_scripts/ipmitool
+++ b/tools/pounder21/build_scripts/ipmitool
@@ -26,9 +26,9 @@ Req_Maj=1
 Req_Min=8
 Req_Pat=7
 
-TESTCURRENTIPMI=0
+TESTCURRENTIPMI=1 #TODO: 0
 
-PKGNAME=ipmitool-1.8.8
+PKGNAME=ipmitool-1.8.9
 #end of stuff to move
 TARNAME="$PKGNAME.tar.gz"
 PROGNAME=ipmitool
@@ -58,6 +58,7 @@ if [ $TESTCURRENTIPMI -ne 0 ]; then
 		if [ ! -f "$TARNAME" ]; then
 			get_from_sourceforge $PROGNAME $TARNAME
 		fi
+		#TODO: what if no target found?
 	fi
 	
 	# Unpack if req'd
diff --git a/tools/pounder21/build_scripts/lame b/tools/pounder21/build_scripts/lame
index 7e7ecea..d7d968d 100755
--- a/tools/pounder21/build_scripts/lame
+++ b/tools/pounder21/build_scripts/lame
@@ -21,12 +21,8 @@
 
 source "$POUNDER_HOME/libpounder.sh"
 
-PKGNAME=lame-3.96.1
-TARNAME="$PKGNAME.tar.gz"
-PROGNAME=lame
-
 # Is it already installed?
-PROG=`which $PROGNAME`
+PROG=`which lame`
 if [ ! -z "$PROG" ]; then
 	exit 0
 fi
@@ -35,11 +31,39 @@ fi
 NASM=`which nasm`
 if [ -z "$NASM" ]; then
 	# Build it so we can test MMX/SSE.
-	./`dirname $0`/nasm
+	NASM_PKG=nasm-0.98.38
+	NASM_TAR="$NASM_PKG.tar.gz"
+
+	# Retrieve tarball
+	cd "$POUNDER_OPTDIR"
+	if [ ! -f "$NASM_TAR" ]; then
+        	if [ $USE_CACHE -eq 1 ]; then
+                	wget "${POUNDER_CACHE}${NASM_TAR}"
+        	fi
+        	if [ ! -f "$NASM_TAR" ]; then
+                	get_from_sourceforge nasm $NASM_TAR
+        	fi
+	fi
+
+	# Unpack if necessary
+	if [ ! -d "NASM_PKG" ]; then
+        	tar -xzf "$NASM_TAR"
+	fi
+
+	# Build
+	cd "$NASM_PKG"
+	./configure
+	make $*
+
 	export PATH=`/bin/ls -d $POUNDER_OPTDIR/nasm*/`:$PATH
+
 fi
 
-# Retrieve binary, if necessary
+# Retrieve binary for lame, if necessary
+PKGNAME=lame-3.96.1
+TARNAME="$PKGNAME.tar.gz"
+PROGNAME=lame
+
 cd "$POUNDER_OPTDIR"
 if [ ! -f "$TARNAME" ]; then
 	if [ $USE_CACHE -eq 1 ]; then
@@ -59,3 +83,45 @@ fi
 cd "$PKGNAME"
 ./configure --enable-nasm
 make $*
+
+# Now build schedutils for CPU affinity assignments
+_PKGNAME=schedutils-1.4.0
+S_TARNAME="$S_PKGNAME.tar.gz"
+S_PROGNAME=taskset
+
+# Is it already installed?
+S_PROG=`which $S_PROGNAME`
+if [ ! -z "$S_PROG" ]; then
+        exit 0
+fi
+
+# Does this OS support taskset?
+grep sched_setaffinity /usr/include/sched.h > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+        # Can't find the sched_setaffinity syscall; abort.
+        # Probably we want to remove the schedutils dir in case
+        # this install was leftover from another distro.
+        cd "$POUNDER_OPTDIR"
+        rm -rf "$S_PKGNAME"
+        exit 0
+fi
+
+# Retrieve tarball, if necessary
+cd "$POUNDER_OPTDIR"
+if [ ! -f "$S_TARNAME" ]; then
+        if [ $USE_CACHE -eq 1 ]; then
+                wget "${POUNDER_CACHE}${S_TARNAME}"
+        fi
+        if [ ! -f "$S_TARNAME" ]; then
+                wget "http://tech9.net/rml/schedutils/packages/$VERSION/$S_TARNAME"
+        fi
+fi
+
+# Unpack if necessary
+if [ ! -d "S_PKGNAME" ]; then
+        tar -xzf "$S_TARNAME"
+fi
+
+# Build
+cd "$S_PKGNAME"
+make $*
diff --git a/tools/pounder21/build_scripts/ltp b/tools/pounder21/build_scripts/ltp
index 68dcdbe..70defe4 100755
--- a/tools/pounder21/build_scripts/ltp
+++ b/tools/pounder21/build_scripts/ltp
@@ -55,23 +55,24 @@ fi
 
 # NAK the setregid EPERM -> EINVAL patch, because it's
 # broken on 2.6!  May be fixed some time after 20050804 release.
-if [ ! -e "testcases/kernel/syscalls/setregid/setregid02.c.pounder" ]; then
-	echo "Patching some holes in ltp..."
-	cp -pRdu testcases/kernel/syscalls/setregid/setregid02.c testcases/kernel/syscalls/setregid/setregid02.c.pounder
-	patch -p1 < $POUNDER_SRCDIR/ltp-setregid-fix.patch
-	RESULT=$?
-	if [ $RESULT -ne 0 ]; then
-		echo Patching failed.
-		exit 1
-	fi
-fi
+#if [ ! -e "testcases/kernel/syscalls/setregid/setregid02.c.pounder" ]; then
+#	echo "Patching some holes in ltp..."
+#	cp -pRdu testcases/kernel/syscalls/setregid/setregid02.c testcases/kernel/syscalls/setregid/setregid02.c.pounder
+#	patch -p1 < $POUNDER_SRCDIR/ltp-setregid-fix.patch
+#	RESULT=$?
+#	if [ $RESULT -ne 0 ]; then
+#		echo Patching failed.
+#		exit 1
+#	fi
+#fi
 
 # Build
+./configure
 make -j$NR_CPUS
 MK_RET=$?
 
 if [ $MK_RET -eq 0 ]; then
-	make install
+	make DESTDIR=$POUNDER_TMPDIR install
 	MK_RET=$?
 fi
 
diff --git a/tools/pounder21/build_scripts/memtest b/tools/pounder21/build_scripts/memtest
index 4308c43..e22def9 100755
--- a/tools/pounder21/build_scripts/memtest
+++ b/tools/pounder21/build_scripts/memtest
@@ -20,24 +20,38 @@
 # 02111-1307, USA.
 
 
+# How much RAM do we have?
+RAM=`cat /proc/meminfo | grep MemTotal | awk -F " " '{print $2}'`
+SPACE_REQUIRED=`expr $RAM \* 2`
+
+# Do we have enough space?
+MEMTESTDIR="$POUNDER_TMPDIR/memtest/"
+rm -rf "$MEMTESTDIR"
+mkdir -p "$MEMTESTDIR"
+FREE_SPACE=`df -k -P "$MEMTESTDIR" | tail -n 1 | awk -F " " '{print $4}'`
+if [ "$FREE_SPACE" -lt "$SPACE_REQUIRED" ]; then
+        echo "[memtest] Insufficient space. Free space: $FREE_SPACE kB. Space required: $SPACE_REQUIRED kB. Not building memtest."
+        exit -1
+fi
+
 cd "$POUNDER_OPTDIR"
 
 # Download a script and parse out the junk we don't want.
 if [ ! -f "memtest.sh" ]; then
 	if [ $USE_CACHE -eq 1 ]; then
-		wget "${POUNDER_CACHE}memtest.html"
+		wget "${POUNDER_CACHE}memtest.shtml"
 	fi
-	if [ ! -f "memtest.html" ]; then
-		wget "http://people.redhat.com/dledford/memtest.html"
+	if [ ! -f "memtest.shtml" ]; then
+		wget "http://people.redhat.com/dledford/memtest.shtml"
 	fi
 	IN_BLOCK=0
-
-	if [ ! -f "memtest.html" ]; then
-		echo "Could not download memtest.html.  Aborting!"
+	
+	if [ ! -f "memtest.shtml" ]; then
+		echo "[memtest] Could not download memtest.shtml.  Aborting!"
 		exit -1
 	fi
-	
-	(cat memtest.html | while read f; do
+
+	(cat memtest.shtml | while read f; do
 		echo "$f" | grep -q BLOCKQUOTE
 		if [ "$?" -eq 0 ]; then
 			if [ "$IN_BLOCK" -eq 0 ]; then
@@ -53,5 +67,5 @@ if [ ! -f "memtest.sh" ]; then
 	done) | sed -e 's/\/bin\/bash2/\/bin\/bash/g' > memtest.sh
 	chmod a+x memtest.sh
 	patch -p0 < "$POUNDER_SRCDIR/memtest.patch"
-	rm -rf memtest.html
+	rm -rf memtest.shtml
 fi
diff --git a/tools/pounder21/build_scripts/nasm b/tools/pounder21/build_scripts/nasm
deleted file mode 100755
index 2722861..0000000
--- a/tools/pounder21/build_scripts/nasm
+++ /dev/null
@@ -1,55 +0,0 @@
-#!/bin/bash
-
-# Builds nasm
-
-# Copyright (C) 2003-2006 IBM
-# 
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-# 
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-source "$POUNDER_HOME/libpounder.sh"
-
-VERSION=0.98.38
-NAME=nasm
-PKGNAME=$NAME-$VERSION
-TARNAME="$PKGNAME.tar.gz"
-PROGNAME=nasm
-
-# Is it already installed?
-PROG=`which $PROGNAME`
-if [ ! -z "$PROG" ]; then
-	exit 0
-fi
-
-# Retrieve tarball, if necessary
-cd "$POUNDER_OPTDIR"
-if [ ! -f "$TARNAME" ]; then
-	if [ $USE_CACHE -eq 1 ]; then
-		wget "${POUNDER_CACHE}${TARNAME}"
-	fi
-	if [ ! -f "$TARNAME" ]; then
-		get_from_sourceforge $PROGNAME $TARNAME
-	fi
-fi
-
-# Unpack if necessary
-if [ ! -d "PKGNAME" ]; then
-	tar -xzf "$TARNAME"
-fi
-
-# Build
-cd "$PKGNAME"
-./configure
-make $*
diff --git a/tools/pounder21/build_scripts/schedutils b/tools/pounder21/build_scripts/schedutils
deleted file mode 100755
index 99b0ab5..0000000
--- a/tools/pounder21/build_scripts/schedutils
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/bash
-
-# Builds schedutils for CPU affinity assignments
-
-# Copyright (C) 2003-2006 IBM
-# 
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-# 
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-VERSION=1.4.0
-NAME=schedutils
-PKGNAME=$NAME-$VERSION
-TARNAME="$PKGNAME.tar.gz"
-PROGNAME=taskset
-
-# Is it already installed?
-PROG=`which $PROGNAME`
-if [ ! -z "$PROG" ]; then
-	exit 0
-fi
-
-# Does this OS support taskset?
-grep sched_setaffinity /usr/include/sched.h > /dev/null 2>&1
-if [ $? -ne 0 ]; then
-	# Can't find the sched_setaffinity syscall; abort.
-	# Probably we want to remove the schedutils dir in case
-	# this install was leftover from another distro.
-	cd "$POUNDER_OPTDIR"
-	rm -rf "$PKGNAME"
-	exit 0
-fi
-
-# Retrieve tarball, if necessary
-cd "$POUNDER_OPTDIR"
-if [ ! -f "$TARNAME" ]; then
-	if [ $USE_CACHE -eq 1 ]; then
-		wget "${POUNDER_CACHE}${TARNAME}"
-	fi
-	if [ ! -f "$TARNAME" ]; then
-		wget "http://tech9.net/rml/schedutils/packages/$VERSION/$TARNAME"
-	fi
-fi
-
-# Unpack if necessary
-if [ ! -d "PKGNAME" ]; then
-	tar -xzf "$TARNAME"
-fi
-
-# Build
-cd "$PKGNAME"
-make $*
diff --git a/tools/pounder21/build_scripts/time_consistency b/tools/pounder21/build_scripts/time_consistency
new file mode 100755
index 0000000..dede6e7
--- /dev/null
+++ b/tools/pounder21/build_scripts/time_consistency
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+# Build time tests
+
+# Copyright (C) 2003-2006 IBM
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of the
+# License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+# 02111-1307, USA.
+
+cd "$POUNDER_SRCDIR/time_tests/"
+
+make $*
diff --git a/tools/pounder21/build_scripts/time_drift b/tools/pounder21/build_scripts/time_drift
new file mode 100755
index 0000000..ec856b7
--- /dev/null
+++ b/tools/pounder21/build_scripts/time_drift
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# Build time tests
+
+# Copyright (C) 2003-2006 IBM
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of the
+# License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+# 02111-1307, USA.
+
+cd "$POUNDER_SRCDIR/time_tests/"
+
+make $*
+
diff --git a/tools/pounder21/build_scripts/time_test b/tools/pounder21/build_scripts/time_test
deleted file mode 100755
index 25d93cb..0000000
--- a/tools/pounder21/build_scripts/time_test
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-
-# Build time tests
-
-# Copyright (C) 2003-2006 IBM
-# 
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-# 
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-# 02111-1307, USA.
-
-
-cd "$POUNDER_SRCDIR/time_tests/"
-
-make $*
diff --git a/tools/pounder21/build_scripts/xterm_stress b/tools/pounder21/build_scripts/xterm_stress
new file mode 100755
index 0000000..77e0917
--- /dev/null
+++ b/tools/pounder21/build_scripts/xterm_stress
@@ -0,0 +1,39 @@
+#!/bin/bash
+
+# Build the program that wiggles X windows.
+
+# Copyright (C) 2003-2006 IBM
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of the
+# License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+# 02111-1307, USA.
+
+cd "$POUNDER_SRCDIR/xbonkers/"
+
+make $*
+RESULT=$?
+
+if [ $RESULT -ne 0 ]; then
+        echo
+        echo "[xterm_stress] build failed; you probably need X11 devel packages."
+        exit 1
+fi
+
+# Build a program to generate random coordinates for X11
+# programs' -geometry flag.
+
+cd "$POUNDER_SRCDIR/randacoords/"
+
+make $*
+

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.4.1--



