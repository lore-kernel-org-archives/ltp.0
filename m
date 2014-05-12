Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WjpSL-0002Hm-CM
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 12:35:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WjpSK-0000ks-4v
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 12:35:45 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4CCZc4E014007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:38 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4CCZbl5001979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:37 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s4CCZZiC000989
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 12:35:36 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 12 May 2014 16:35:24 +0400
Message-Id: <1399898127-15934-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1399898127-15934-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1399898127-15934-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V4 1/4] testscripts/isofs.sh: cleanup
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testscripts/isofs.sh |  165 ++++++++++++++++++++-----------------------------
 1 files changed, 67 insertions(+), 98 deletions(-)

diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
index e6a3b09..ec1f2fc 100755
--- a/testscripts/isofs.sh
+++ b/testscripts/isofs.sh
@@ -1,91 +1,64 @@
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
+#!/bin/sh
 #
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
+# Copyright (c) International Business Machines  Corp., 2003
 #
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
 #
-#  FILE        : isofs.sh
-#  USAGE       : isofs.sh <optional> -n (no clean up)
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#  DESCRIPTION : A script that will test isofs on Linux system.
-#                It makes ISO9660 file system with different options and also
-#                mounts the ISO9660 file system with different mount options.
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
-#  REQUIREMENTS:
+# Written by Prakash Narayana (prakashn@us.ibm.com)
+# and Michael Reed (mreed10@us.ibm.com)
 #
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
+# A script that will test isofs on Linux system.
+# It makes ISO9660 file system with different options and also
+# mounts the ISO9660 file system with different mount options.
 #
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
 
 USAGE="$0"
 NO_CLEANUP=""
 
-  usage()
-  {
-    echo "USAGE: $USAGE <optional> -n -h -d [directory name]"
-    exit
-  }
+usage()
+{
+	echo "USAGE: $USAGE <optional> -n -h -d [directory name]"
+	exit
+}
 
 #Initialize directory variables
-    MNT_POINT="/tmp/isofs_$$"
-    COPY_DIR="/etc/"
-    TEMP_DIR="/tmp/for_isofs_test"
-    MAKE_FILE_SYS_DIR=$TEMP_DIR$COPY_DIR
-
-   while getopts :hnd: arg
-      do  case $arg in
-	  d)
-             COPY_DIR=$OPTARG
-    	     MAKE_FILE_SYS_DIR="/tmp/for_isofs_test"$COPY_DIR
-	    ;;
-	  h)
-	    echo ""
-            echo "n - The directories created will not be removed"
-            echo "d - Specify a directory to copy into /tmp"
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
+MNT_POINT="/tmp/isofs_$$"
+COPY_DIR="/etc/"
+TEMP_DIR="/tmp/for_isofs_test"
+MAKE_FILE_SYS_DIR=$TEMP_DIR$COPY_DIR
+
+while getopts :hnd: arg; do
+	case $arg in
+	d)
+		COPY_DIR=$OPTARG
+		MAKE_FILE_SYS_DIR="/tmp/for_isofs_test"$COPY_DIR
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
 
 ##############################################################
 #
@@ -100,22 +73,19 @@ then
 	exit 1
 fi
 
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
+mkdir -p -m 777 $MNT_POINT
+mkdir -p $MAKE_FILE_SYS_DIR
 
 
+if [ -e "$COPY_DIR" ]; then
+	cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
+else
+	echo "$COPY_DIR not found"
+	echo "use the -d option to copy a different directory into"
+	echo "/tmp to makethe ISO9660 file system with different"
+	echo "options"
+	usage
+fi
 
 # Make ISO9660 file system with different options.
 # Mount the ISO9660 file system with different mount options.
@@ -129,7 +99,7 @@ for mkisofs_opt in \
 	"-f -l -D -J -L -R" \
 	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
 do
-        echo "Running mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR  Command"
+	echo "Running mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR  Command"
 	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR
 	if [ $? != 0 ]
 	then
@@ -173,14 +143,13 @@ done
 #
 #######################################################
 
-  if [ "$NO_CLEANUP" == "no" ]; then
-     echo "$MAKE_FILE_SYS_DIR and $MNT_POINT were not removed"
-     echo "These directories will have to be removed manually"
-  else
-    rm -rf $TEMP_DIR
-    rm -rf $MNT_POINT
-  fi
-
+if [ "$NO_CLEANUP" == "no" ]; then
+	echo "$MAKE_FILE_SYS_DIR and $MNT_POINT were not removed"
+	echo "These directories will have to be removed manually"
+else
+	rm -rf $TEMP_DIR
+	rm -rf $MNT_POINT
+fi
 
 echo "PASSED: $0 passed!"
 exit 0
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
