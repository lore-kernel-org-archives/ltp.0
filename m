Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WO4uY-0004oR-LT
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 12:38:58 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WO4uX-0008NY-4z
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 12:38:58 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2DCcp6J003870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:51 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2DCco2X010495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:50 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s2DCcn14010461
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:49 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Mar 2014 16:38:26 +0400
Message-Id: <1394714306-9678-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [RFC PATCH 3/3] Declare iso9660 fs testcase based on isofs.sh
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
testing iso9660 file system.

Therefore moved it into a separate directory and declared
a new test case entry in runtest/fs.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/fs                           |    2 +
 testcases/kernel/fs/iso9660/Makefile |   25 +++++
 testcases/kernel/fs/iso9660/isofs.sh |  187 ++++++++++++++++++++++++++++++++++
 testscripts/isofs.sh                 |  187 ----------------------------------
 4 files changed, 214 insertions(+), 187 deletions(-)
 create mode 100644 testcases/kernel/fs/iso9660/Makefile
 create mode 100755 testcases/kernel/fs/iso9660/isofs.sh
 delete mode 100755 testscripts/isofs.sh

diff --git a/runtest/fs b/runtest/fs
index 438c79c..9687ffa 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -74,3 +74,5 @@ fs_racer fs_racer.sh -t 5
 
 #Run the Quota Remount Test introduced in linux-2.6.26
 quota_remount_test01 quota_remount_test01.sh
+
+iso9660 isofs.sh
diff --git a/testcases/kernel/fs/iso9660/Makefile b/testcases/kernel/fs/iso9660/Makefile
new file mode 100644
index 0000000..bba35e6
--- /dev/null
+++ b/testcases/kernel/fs/iso9660/Makefile
@@ -0,0 +1,25 @@
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
+INSTALL_TARGETS		:= isofs.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
new file mode 100755
index 0000000..fd42a3c
--- /dev/null
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -0,0 +1,187 @@
+#!/bin/bash
+
+
+##############################################################
+#
+#  Copyright (c) International Business Machines  Corp., 2003
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
+#  FILE        : isofs.sh
+#  USAGE       : isofs.sh <optional> -n (no clean up)
+#
+#  DESCRIPTION : A script that will test isofs on Linux system.
+#                It makes ISO9660 file system with different options and also
+#                mounts the ISO9660 file system with different mount options.
+#
+#  REQUIREMENTS:
+#
+#  HISTORY     :
+#      06/27/2003 Prakash Narayana (prakashn@us.ibm.com)
+#      07/28/2005 Michael Reed (mreed10@us.ibm.com)
+#      - Changed the directory where the filesytems were being created
+#        from /etc to copying /etc to /tmp/for_isofs_test/etc and
+#        creating the file systems there
+#      - Added the -n option to not remove the directories created for
+#        debugging purposes
+#      - Added -d option to specify a different directory to copy to /tmp
+#        to make the file system
+#
+#  CODE COVERAGE: 40.5% - fs/isofs (Total Coverage)
+#
+#                 23.7% - fs/isofs/dir.c
+#                 46.0% - fs/isofs/inode.c
+#                 22.9% - fs/isofs/joliet.c
+#                 50.0% - fs/isofs/namei.c
+#                 38.5% - fs/isofs/rock.c
+#                 10.7% - fs/isofs/util.c
+#
+##############################################################
+
+USAGE="$0"
+NO_CLEANUP=""
+
+  usage()
+  {
+    echo "USAGE: $USAGE <optional> -n -h -d [directory name]"
+    exit
+  }
+
+#Initialize directory variables
+    TMPDIR=${TMPDIR:-/tmp}
+    MNT_POINT="$TMPDIR/isofs_$$"
+    COPY_DIR="/etc/"
+    TEMP_DIR="$TMPDIR/for_isofs_test"
+    MAKE_FILE_SYS_DIR=$TEMP_DIR$COPY_DIR
+
+   while getopts :hnd: arg
+      do  case $arg in
+	  d)
+             COPY_DIR=$OPTARG
+    	     MAKE_FILE_SYS_DIR=${TEMP_DIR}${COPY_DIR}
+	    ;;
+	  h)
+	    echo ""
+            echo "n - The directories created will not be removed"
+            echo "d - Specify a directory to copy into $TEMP_DIR"
+	    echo "h - Help options"
+	    echo ""
+	    usage
+	    echo ""
+	    ;;
+	  n)
+	    NO_CLEANUP="no"
+	    ;;
+        esac
+    done
+
+
+##############################################################
+#
+# Make sure that uid=root is running this script.
+# Validate the command line arguments.
+#
+##############################################################
+
+if [ $UID != 0 ]
+then
+	echo "FAILED: Must have root access to execute this script"
+	exit 1
+fi
+
+
+      mkdir -p -m 777 $MNT_POINT
+      mkdir -p $MAKE_FILE_SYS_DIR
+
+
+	if [ -e "$COPY_DIR" ]; then
+   		cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
+	else
+    		echo "$COPY_DIR not found"
+    		echo "use the -d option to copy a different directory into"
+    		echo "/tmp to makethe ISO9660 file system with different"
+                echo "options"
+    		usage
+	fi
+
+
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
+        echo "Running mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR  Command"
+	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
+	if [ $? != 0 ]
+	then
+		rm -rf isofs.iso $MNT_POINT $TEMP_DIR
+		echo "FAILED: mkisofs -o isofs.iso $mkisofs_opt $MAKE_FILE_SYS_DIR failed"
+		exit 1
+	fi
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
+		echo "Running mount -o $mount_opt isofs.iso $MNT_POINT Command"
+		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
+		if [ $? != 0 ]
+		then
+			rm -rf isofs.iso $MNT_POINT $TEMP_DIR
+			echo "FAILED: mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT failed"
+			exit 1
+		fi
+		echo "Running ls -lR $MNT_POINT Command"
+		ls -lR $MNT_POINT > /dev/null
+		exportfs -i -o no_root_squash,rw *:$MNT_POINT
+		exportfs -u :$MNT_POINT
+		umount $MNT_POINT
+	done
+	rm -rf isofs.iso
+done
+
+#######################################################
+#
+# Just before exit, perform the cleanup.
+#
+#######################################################
+
+  if [ "$NO_CLEANUP" == "no" ]; then
+     echo "$MAKE_FILE_SYS_DIR and $MNT_POINT were not removed"
+     echo "These directories will have to be removed manually"
+  else
+    rm -rf $TEMP_DIR
+    rm -rf $MNT_POINT
+  fi
+
+
+echo "PASSED: $0 passed!"
+exit 0
diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
deleted file mode 100755
index fd42a3c..0000000
--- a/testscripts/isofs.sh
+++ /dev/null
@@ -1,187 +0,0 @@
-#!/bin/bash
-
-
-##############################################################
-#
-#  Copyright (c) International Business Machines  Corp., 2003
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#  FILE        : isofs.sh
-#  USAGE       : isofs.sh <optional> -n (no clean up)
-#
-#  DESCRIPTION : A script that will test isofs on Linux system.
-#                It makes ISO9660 file system with different options and also
-#                mounts the ISO9660 file system with different mount options.
-#
-#  REQUIREMENTS:
-#
-#  HISTORY     :
-#      06/27/2003 Prakash Narayana (prakashn@us.ibm.com)
-#      07/28/2005 Michael Reed (mreed10@us.ibm.com)
-#      - Changed the directory where the filesytems were being created
-#        from /etc to copying /etc to /tmp/for_isofs_test/etc and
-#        creating the file systems there
-#      - Added the -n option to not remove the directories created for
-#        debugging purposes
-#      - Added -d option to specify a different directory to copy to /tmp
-#        to make the file system
-#
-#  CODE COVERAGE: 40.5% - fs/isofs (Total Coverage)
-#
-#                 23.7% - fs/isofs/dir.c
-#                 46.0% - fs/isofs/inode.c
-#                 22.9% - fs/isofs/joliet.c
-#                 50.0% - fs/isofs/namei.c
-#                 38.5% - fs/isofs/rock.c
-#                 10.7% - fs/isofs/util.c
-#
-##############################################################
-
-USAGE="$0"
-NO_CLEANUP=""
-
-  usage()
-  {
-    echo "USAGE: $USAGE <optional> -n -h -d [directory name]"
-    exit
-  }
-
-#Initialize directory variables
-    TMPDIR=${TMPDIR:-/tmp}
-    MNT_POINT="$TMPDIR/isofs_$$"
-    COPY_DIR="/etc/"
-    TEMP_DIR="$TMPDIR/for_isofs_test"
-    MAKE_FILE_SYS_DIR=$TEMP_DIR$COPY_DIR
-
-   while getopts :hnd: arg
-      do  case $arg in
-	  d)
-             COPY_DIR=$OPTARG
-    	     MAKE_FILE_SYS_DIR=${TEMP_DIR}${COPY_DIR}
-	    ;;
-	  h)
-	    echo ""
-            echo "n - The directories created will not be removed"
-            echo "d - Specify a directory to copy into $TEMP_DIR"
-	    echo "h - Help options"
-	    echo ""
-	    usage
-	    echo ""
-	    ;;
-	  n)
-	    NO_CLEANUP="no"
-	    ;;
-        esac
-    done
-
-
-##############################################################
-#
-# Make sure that uid=root is running this script.
-# Validate the command line arguments.
-#
-##############################################################
-
-if [ $UID != 0 ]
-then
-	echo "FAILED: Must have root access to execute this script"
-	exit 1
-fi
-
-
-      mkdir -p -m 777 $MNT_POINT
-      mkdir -p $MAKE_FILE_SYS_DIR
-
-
-	if [ -e "$COPY_DIR" ]; then
-   		cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
-	else
-    		echo "$COPY_DIR not found"
-    		echo "use the -d option to copy a different directory into"
-    		echo "/tmp to makethe ISO9660 file system with different"
-                echo "options"
-    		usage
-	fi
-
-
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
-        echo "Running mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR  Command"
-	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
-	if [ $? != 0 ]
-	then
-		rm -rf isofs.iso $MNT_POINT $TEMP_DIR
-		echo "FAILED: mkisofs -o isofs.iso $mkisofs_opt $MAKE_FILE_SYS_DIR failed"
-		exit 1
-	fi
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
-		echo "Running mount -o $mount_opt isofs.iso $MNT_POINT Command"
-		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
-		if [ $? != 0 ]
-		then
-			rm -rf isofs.iso $MNT_POINT $TEMP_DIR
-			echo "FAILED: mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT failed"
-			exit 1
-		fi
-		echo "Running ls -lR $MNT_POINT Command"
-		ls -lR $MNT_POINT > /dev/null
-		exportfs -i -o no_root_squash,rw *:$MNT_POINT
-		exportfs -u :$MNT_POINT
-		umount $MNT_POINT
-	done
-	rm -rf isofs.iso
-done
-
-#######################################################
-#
-# Just before exit, perform the cleanup.
-#
-#######################################################
-
-  if [ "$NO_CLEANUP" == "no" ]; then
-     echo "$MAKE_FILE_SYS_DIR and $MNT_POINT were not removed"
-     echo "These directories will have to be removed manually"
-  else
-    rm -rf $TEMP_DIR
-    rm -rf $MNT_POINT
-  fi
-
-
-echo "PASSED: $0 passed!"
-exit 0
-- 
1.7.9.5


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
