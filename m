Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WjpSN-0003mt-L5
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 12:35:47 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WjpSM-0001YM-9v
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 12:35:47 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4CCZdVA010246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:40 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4CCZdFB005288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:39 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4CCZcYB018358
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:38 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 12 May 2014 16:35:27 +0400
Message-Id: <1399898127-15934-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1399898127-15934-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1399898127-15934-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V4 4/4] Declare an iso9660 fs testcase based on
	isofs.sh
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
Cc: vasily.isaenko@oracle.com

Script isofs.sh looks like a not bad candidate for
testing an iso9660 file system.

Therefore moved it into a separate directory and declared
a new test case entry in runtest/fs.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/fs                           |    2 +
 testcases/kernel/fs/iso9660/Makefile |   26 ++++++
 testcases/kernel/fs/iso9660/isofs.sh |  145 ++++++++++++++++++++++++++++++++++
 testscripts/isofs.sh                 |  145 ----------------------------------
 4 files changed, 173 insertions(+), 145 deletions(-)
 create mode 100644 testcases/kernel/fs/iso9660/Makefile
 create mode 100755 testcases/kernel/fs/iso9660/isofs.sh
 delete mode 100755 testscripts/isofs.sh

diff --git a/runtest/fs b/runtest/fs
index 438c79c..33a8412 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -74,3 +74,5 @@ fs_racer fs_racer.sh -t 5
 
 #Run the Quota Remount Test introduced in linux-2.6.26
 quota_remount_test01 quota_remount_test01.sh
+
+isofs isofs.sh
diff --git a/testcases/kernel/fs/iso9660/Makefile b/testcases/kernel/fs/iso9660/Makefile
new file mode 100644
index 0000000..459b3a4
--- /dev/null
+++ b/testcases/kernel/fs/iso9660/Makefile
@@ -0,0 +1,26 @@
+#
+#  Copyright (c) 2005-2014 Linux Test Project
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+MAKE_TARGETS		:=
+INSTALL_TARGETS		:= isofs.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
new file mode 100755
index 0000000..e4f3093
--- /dev/null
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+#
+# Copyright (c) International Business Machines  Corp., 2003
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Written by Prakash Narayana (prakashn@us.ibm.com)
+# and Michael Reed (mreed10@us.ibm.com)
+#
+# A script that will test isofs on Linux system.
+# It makes ISO9660 file system with different options and also
+# mounts the ISO9660 file system with different mount options.
+#
+
+TCID=isofs
+TST_TOTAL=77
+. test.sh
+
+NO_CLEANUP=""
+
+usage()
+{
+	echo "USAGE: $0 <optional> -n -h -d [directory name]"
+	exit
+}
+
+cleanup()
+{
+	if [ "$NO_CLEANUP" = "no" ]; then
+		tst_resm TINFO "Temporary directory $PWD was not removed"
+	else
+		tst_rmdir
+	fi
+}
+
+
+COPY_DIR="/etc/"
+
+while getopts :hnd: arg; do
+	case $arg in
+	d)
+		COPY_DIR=$OPTARG
+		;;
+	h)
+		echo ""
+		echo "n - The directories created will not be removed"
+		echo "d - Specify a directory to copy into /tmp"
+		echo "h - Help options"
+		echo ""
+		usage
+		echo ""
+		;;
+	n)
+		NO_CLEANUP="no"
+		;;
+	esac
+done
+
+if [ ! -e "$COPY_DIR" ]; then
+	tst_brkm TCONF "$COPY_DIR not found"
+fi
+
+tst_require_root
+
+tst_tmpdir
+TST_CLEANUP=cleanup
+
+MNT_POINT="$PWD/mnt"
+MAKE_FILE_SYS_DIR="$PWD/tmp/$COPY_DIR"
+
+mkdir -p -m 777 $MNT_POINT
+mkdir -p $MAKE_FILE_SYS_DIR
+
+cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
+
+# Make ISO9660 file system with different options.
+# Mount the ISO9660 file system with different mount options.
+
+for mkisofs_opt in \
+	" " \
+	"-J" \
+	"-hfs -D" \
+	" -R " \
+	"-R -J" \
+	"-f -l -D -J -L -R" \
+	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
+do
+	rm -f isofs.iso
+	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS \
+			"mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
+	else
+		tst_resm TFAIL \
+			tst_resm TFAIL "mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
+		continue
+	fi
+
+	for mount_opt in \
+		"loop" \
+		"loop,norock" \
+		"loop,nojoliet" \
+		"loop,block=512,unhide" \
+		"loop,block=1024,cruft" \
+		"loop,block=2048,nocompress" \
+		"loop,check=strict,map=off,gid=bin,uid=bin" \
+		"loop,check=strict,map=acorn,gid=bin,uid=bin" \
+		"loop,check=relaxed,map=normal" \
+		"loop,block=512,unhide,session=2"
+		# "loop,sbsector=32"
+	do
+		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				"mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT"
+			continue
+		fi
+
+		ls -lR $MNT_POINT > /dev/null
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "ls -lR $MNT_POINT"
+		fi
+
+		umount $MNT_POINT
+		if [ $? -ne 0 ]; then
+			tst_brkm TFAIL "umount $MNT_POINT"
+		fi
+
+		tst_resm TPASS "mount/umount with \"$mount_opt\" options"
+	done
+done
+
+tst_exit
diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
deleted file mode 100755
index e4f3093..0000000
--- a/testscripts/isofs.sh
+++ /dev/null
@@ -1,145 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2003
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Written by Prakash Narayana (prakashn@us.ibm.com)
-# and Michael Reed (mreed10@us.ibm.com)
-#
-# A script that will test isofs on Linux system.
-# It makes ISO9660 file system with different options and also
-# mounts the ISO9660 file system with different mount options.
-#
-
-TCID=isofs
-TST_TOTAL=77
-. test.sh
-
-NO_CLEANUP=""
-
-usage()
-{
-	echo "USAGE: $0 <optional> -n -h -d [directory name]"
-	exit
-}
-
-cleanup()
-{
-	if [ "$NO_CLEANUP" = "no" ]; then
-		tst_resm TINFO "Temporary directory $PWD was not removed"
-	else
-		tst_rmdir
-	fi
-}
-
-
-COPY_DIR="/etc/"
-
-while getopts :hnd: arg; do
-	case $arg in
-	d)
-		COPY_DIR=$OPTARG
-		;;
-	h)
-		echo ""
-		echo "n - The directories created will not be removed"
-		echo "d - Specify a directory to copy into /tmp"
-		echo "h - Help options"
-		echo ""
-		usage
-		echo ""
-		;;
-	n)
-		NO_CLEANUP="no"
-		;;
-	esac
-done
-
-if [ ! -e "$COPY_DIR" ]; then
-	tst_brkm TCONF "$COPY_DIR not found"
-fi
-
-tst_require_root
-
-tst_tmpdir
-TST_CLEANUP=cleanup
-
-MNT_POINT="$PWD/mnt"
-MAKE_FILE_SYS_DIR="$PWD/tmp/$COPY_DIR"
-
-mkdir -p -m 777 $MNT_POINT
-mkdir -p $MAKE_FILE_SYS_DIR
-
-cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
-
-# Make ISO9660 file system with different options.
-# Mount the ISO9660 file system with different mount options.
-
-for mkisofs_opt in \
-	" " \
-	"-J" \
-	"-hfs -D" \
-	" -R " \
-	"-R -J" \
-	"-f -l -D -J -L -R" \
-	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
-do
-	rm -f isofs.iso
-	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS \
-			"mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
-	else
-		tst_resm TFAIL \
-			tst_resm TFAIL "mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
-		continue
-	fi
-
-	for mount_opt in \
-		"loop" \
-		"loop,norock" \
-		"loop,nojoliet" \
-		"loop,block=512,unhide" \
-		"loop,block=1024,cruft" \
-		"loop,block=2048,nocompress" \
-		"loop,check=strict,map=off,gid=bin,uid=bin" \
-		"loop,check=strict,map=acorn,gid=bin,uid=bin" \
-		"loop,check=relaxed,map=normal" \
-		"loop,block=512,unhide,session=2"
-		# "loop,sbsector=32"
-	do
-		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
-		if [ $? -ne 0 ]; then
-			tst_resm TFAIL \
-				"mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT"
-			continue
-		fi
-
-		ls -lR $MNT_POINT > /dev/null
-		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "ls -lR $MNT_POINT"
-		fi
-
-		umount $MNT_POINT
-		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL "umount $MNT_POINT"
-		fi
-
-		tst_resm TPASS "mount/umount with \"$mount_opt\" options"
-	done
-done
-
-tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
