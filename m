From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 16:09:27 +0300
Subject: [LTP] [PATCH 09/10] network/nfs04: move to nfs_stress directory
In-Reply-To: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1443618568-29200-9-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/.gitignore                       |    2 +-
 testcases/network/nfs/nfs04/Makefile               |   31 ---
 testcases/network/nfs/nfs04/nfs04                  |  197 --------------------
 testcases/network/nfs/nfs04/nfs04_create_file.c    |   74 --------
 testcases/network/nfs/nfs_stress/Makefile          |    5 +-
 testcases/network/nfs/nfs_stress/nfs04             |  197 ++++++++++++++++++++
 .../network/nfs/nfs_stress/nfs04_create_file.c     |   74 ++++++++
 7 files changed, 276 insertions(+), 304 deletions(-)
 delete mode 100644 testcases/network/nfs/nfs04/Makefile
 delete mode 100755 testcases/network/nfs/nfs04/nfs04
 delete mode 100644 testcases/network/nfs/nfs04/nfs04_create_file.c
 create mode 100755 testcases/network/nfs/nfs_stress/nfs04
 create mode 100644 testcases/network/nfs/nfs_stress/nfs04_create_file.c

diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index eae306a..7fd6c16 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -18,7 +18,7 @@
 /multicast/mc_opts/mc_verify_opts
 /multicast/mc_opts/mc_verify_opts_error
 /nfs/nfs_stress/open_files
-/nfs/nfs04/nfs04_create_file
+/nfs/nfs_stress/nfs04_create_file
 /nfs/nfs_fsstress/fsstress
 /nfs/nfslock01/nfs_flock
 /nfs/nfslock01/nfs_flock_dgen
diff --git a/testcases/network/nfs/nfs04/Makefile b/testcases/network/nfs/nfs04/Makefile
deleted file mode 100644
index 9676a57..0000000
--- a/testcases/network/nfs/nfs04/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/nfs/nfs04 testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Garrett Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-CPPFLAGS		+= -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-
-INSTALL_TARGETS		:= nfs04
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfs/nfs04/nfs04 b/testcases/network/nfs/nfs04/nfs04
deleted file mode 100755
index 7518d5b..0000000
--- a/testcases/network/nfs/nfs04/nfs04
+++ /dev/null
@@ -1,197 +0,0 @@
-#! /bin/sh
-#
-#   Copyright (c) International Business Machines  Corp., 2003
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
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
-#  FILE   : nfs04.sh
-#
-#  PURPOSE: Creates a text file of specified size locally and copies
-#	    the file to an NFS mountpoint.  The two files are compared
-#	    and checked for differences.  If the files differ, then
-#	    the test fails.  By default, this test creates a 10Mb file
-#	    and runs for one loop.
-#
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#
-#  HISTORY:
-#    10/17/03 Robbie Williamson (robbiew@us.ibm.com)
-#      -Written
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
-TC=${TC:=nfs04}
-TCbin=${TCbin:=`pwd`}
-TCtmp=${TCtmp:=/tmp/$TC$$}
-export TCID=$TC
-export TST_TOTAL=1
-
-# If CLEANUP is not set; set it to "ON"
-CLEANUP=${CLEANUP:="ON"}
-
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
-{
-$trace_logic
-
-    PID=$$
-
-    VERSION=${VERSION:=3}
-    RHOST=${RHOST:=`hostname`}
-    FILESIZE=${FILESIZE:=10}
-    SOCKET_TYPE=${SOCKET_TYPE:=udp}
-    TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-    NFS_TYPE=${NFS_TYPE:=nfs}
-    LOOPS=${LOOPS:=1}
-    export TST_COUNT=$LOOPS
-
-    echo ""
-    echo "Test Options:"
-    echo " VERSION: $VERSION"
-    echo " RHOST: $RHOST"
-    echo " FILESIZE: $FILESIZE"
-    echo " SOCKET_TYPE: $SOCKET_TYPE"
-    echo " TESTDIR: $TESTDIR"
-    echo " NFS_TYPE: $NFS_TYPE"
-    echo " LOOPS: $LOOPS"
-
-    if [ "x$NFS_TYPE" != "xnfs4" ]; then
-        OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
-    fi
-
-    REMOTE_DIR=${RHOST}:$TESTDIR
-    LUSER=${LUSER:=root}
-    mkdir -p $TCtmp || end_testcase "Could not create $TCtmp"
-    chmod 777 $TCtmp
-
-    tst_resm TINFO "Setting up remote machine: $RHOST"
-    rsh -n $RHOST "mkdir -p $TESTDIR"
-    [ $? = 0 ] || end_testcase "Could not create remote directory"
-    rsh -n $RHOST "touch $TESTDIR/testfile"
-    [ $? = 0 ] || end_testcase "Could not create testfile in remote directory"
-
-    if [ "x$NFS_TYPE" = "xnfs4" ]; then
-        rsh -n $RHOST "mkdir -p /export$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not create /export$TESTDIR on server"
-        rsh -n $RHOST "mount --bind $TESTDIR /export$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not bind $TESTDIR to /export"
-        rsh -n $RHOST "/usr/sbin/exportfs -o no_root_squash,rw,nohide,insecure,no_subtree_check *:$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not export remote directory"
-    else
-        rsh -n $RHOST "/usr/sbin/exportfs -i -o no_root_squash,rw *:$TESTDIR"
-        [ $? = 0 ] || end_testcase "Could not export remote directory"
-    fi
-
-    tst_resm TINFO "Mounting NFS filesystem"
-    mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TCtmp || end_testcase "Cannot mount $TCtmp"
-    [ $? = 0 ] || end_testcase "Could not mount $REMOTE_DIR"
-}
-
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
-{
-$trace_logic
-  loopcount=0
-  nfs04_create_file $FILESIZE /tmp/nfs04$PID.testfile >/dev/null
-  if [ $? != 0 ]; then
-	end_testcase "Could not create testfile"
-  fi
-  tst_resm TINFO "Test Started"
-  while [ $loopcount -lt $LOOPS ]
-    do
-	cp /tmp/nfs04$PID.testfile $TCtmp/nfs04$PID.testfile$loopcount
-	cmp /tmp/nfs04$PID.testfile $TCtmp/nfs04$PID.testfile$loopcount
-	retval=$?
-	if [ "$retval" != 0 ]; then
-		end_testcase "Error in loop $loopcount: First cmp FAILED"
-	fi
-	cp $TCtmp/nfs04$PID.testfile$loopcount /tmp/nfs04$PID.testfile_compare
-	cmp /tmp/nfs04$PID.testfile /tmp/nfs04$PID.testfile_compare
-	retval=$?
-	if [ "$retval" != 0 ]; then
-		end_testcase "Error in loop $loopcount: Second cmp FAILED"
-	fi
-	rm -f /tmp/nfs04$PID.testfile_compare
-	loopcount=$(( $loopcount + 1 ))
-	tst_resm TINFO "Completed Loop $loopcount"
-    done
-}
-
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
-{
-$trace_logic
-    if [ "$CLEANUP" = "ON" ]; then
-	sleep 2
-        umount $TCtmp || tst_resm TBROK "Cannot umount $TCtmp"
-	rm -rf $TCtmp || tst_resm TBROK "Cannot remove $TCtmp"
-        rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
-		 rsh -n $RHOST "rm -rf $TESTDIR"
-	rm -f /tmp/nfs04$PID.testfile*
-    fi
-
-    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-    tst_resm TFAIL "Test Failed: $@"
-    exit 1
-}
-
-#=============================================================================
-# MAIN PROCEDURE
-#=============================================================================
-
-setup_testcase
-do_test
-end_testcase
diff --git a/testcases/network/nfs/nfs04/nfs04_create_file.c b/testcases/network/nfs/nfs04/nfs04_create_file.c
deleted file mode 100644
index 653c500..0000000
--- a/testcases/network/nfs/nfs04/nfs04_create_file.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2003
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- *  FILE        : create_file.c
- *  PURPOSE	: Creates a text file of specified size.
- *  HISTORY	:
- *  	10/17/2003 Robbie Williamson
- *	  -Written
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-
-/* set write buffer size to whatever floats your boat.  I usually use 1M */
-#define BSIZE 1048576L
-
-int main(int argc, char *argv[])
-{
-	off_t i;
-	long bufnum;
-	char buf[BSIZE];
-	off_t fd;
-
-	if (argc != 3 || atoi(argv[1]) < 1) {
-		printf
-		    ("usage:\n\tcreate_file <# of %ld buffers to write> <name of file to create>\n\t ex. # create_file 10 /tmp/testfile\n",
-		     BSIZE);
-		exit(3);
-	}
-	bufnum = strtol(argv[1], NULL, 0);
-	printf("Started building a %lu megabyte file\n", bufnum);
-	buf[0] = 'A';
-	for (i = 1; i < BSIZE; i++)
-		buf[i] = buf[i - 1] + 1;
-	buf[BSIZE - 1] = 'Z';
-
-	if ((fd = creat(argv[2], 0755)) == -1)
-		perror("lftest: ");
-
-	for (i = 0; i < bufnum; i++) {
-		if (write(fd, buf, BSIZE) == -1)
-			return -1;
-		else {
-			printf(".");
-			fflush(stdout);
-		}
-		fsync(fd);
-	}
-	close(fd);
-	printf("\nFinished building a %lu megabyte file\n", bufnum);
-	return (0);
-}
diff --git a/testcases/network/nfs/nfs_stress/Makefile b/testcases/network/nfs/nfs_stress/Makefile
index 69d2c81..2b5242c 100644
--- a/testcases/network/nfs/nfs_stress/Makefile
+++ b/testcases/network/nfs/nfs_stress/Makefile
@@ -18,9 +18,12 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
+nfs04_create_file: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
+
 INSTALL_TARGETS		:= nfs_lib.sh \
 			   nfs01 \
 			   nfs02 \
-			   nfs03
+			   nfs03 \
+			   nfs04
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfs/nfs_stress/nfs04 b/testcases/network/nfs/nfs_stress/nfs04
new file mode 100755
index 0000000..7518d5b
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs04
@@ -0,0 +1,197 @@
+#! /bin/sh
+#
+#   Copyright (c) International Business Machines  Corp., 2003
+#
+#   This program is free software;  you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2 of the License, or
+#   (at your option) any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY;  without even the implie; warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#   the GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program;  if not, write to the Free Software
+#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+#
+#
+#
+#  FILE   : nfs04.sh
+#
+#  PURPOSE: Creates a text file of specified size locally and copies
+#	    the file to an NFS mountpoint.  The two files are compared
+#	    and checked for differences.  If the files differ, then
+#	    the test fails.  By default, this test creates a 10Mb file
+#	    and runs for one loop.
+#
+#
+#  SETUP: The home directory of root on the machine exported as "RHOST"
+#         MUST have a ".rhosts" file with the hostname of the machine
+#         where the test is executed.
+#
+#
+#  HISTORY:
+#    10/17/03 Robbie Williamson (robbiew@us.ibm.com)
+#      -Written
+#
+#***********************************************************************
+
+#Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+
+$trace_logic
+
+#-----------------------------------------------------------------------
+# Initialize local variables
+#-----------------------------------------------------------------------
+TC=${TC:=nfs04}
+TCbin=${TCbin:=`pwd`}
+TCtmp=${TCtmp:=/tmp/$TC$$}
+export TCID=$TC
+export TST_TOTAL=1
+
+# If CLEANUP is not set; set it to "ON"
+CLEANUP=${CLEANUP:="ON"}
+
+#=============================================================================
+# FUNCTION NAME:        setup_testcase
+#
+# FUNCTION DESCRIPTION: Perform the setup function for the testcase.
+#
+# PARAMETERS:   	None.
+#
+# RETURNS:      	None.
+#=============================================================================
+
+setup_testcase()
+{
+$trace_logic
+
+    PID=$$
+
+    VERSION=${VERSION:=3}
+    RHOST=${RHOST:=`hostname`}
+    FILESIZE=${FILESIZE:=10}
+    SOCKET_TYPE=${SOCKET_TYPE:=udp}
+    TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
+    NFS_TYPE=${NFS_TYPE:=nfs}
+    LOOPS=${LOOPS:=1}
+    export TST_COUNT=$LOOPS
+
+    echo ""
+    echo "Test Options:"
+    echo " VERSION: $VERSION"
+    echo " RHOST: $RHOST"
+    echo " FILESIZE: $FILESIZE"
+    echo " SOCKET_TYPE: $SOCKET_TYPE"
+    echo " TESTDIR: $TESTDIR"
+    echo " NFS_TYPE: $NFS_TYPE"
+    echo " LOOPS: $LOOPS"
+
+    if [ "x$NFS_TYPE" != "xnfs4" ]; then
+        OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
+    fi
+
+    REMOTE_DIR=${RHOST}:$TESTDIR
+    LUSER=${LUSER:=root}
+    mkdir -p $TCtmp || end_testcase "Could not create $TCtmp"
+    chmod 777 $TCtmp
+
+    tst_resm TINFO "Setting up remote machine: $RHOST"
+    rsh -n $RHOST "mkdir -p $TESTDIR"
+    [ $? = 0 ] || end_testcase "Could not create remote directory"
+    rsh -n $RHOST "touch $TESTDIR/testfile"
+    [ $? = 0 ] || end_testcase "Could not create testfile in remote directory"
+
+    if [ "x$NFS_TYPE" = "xnfs4" ]; then
+        rsh -n $RHOST "mkdir -p /export$TESTDIR"
+        [ $? = 0 ] || end_testcase "Could not create /export$TESTDIR on server"
+        rsh -n $RHOST "mount --bind $TESTDIR /export$TESTDIR"
+        [ $? = 0 ] || end_testcase "Could not bind $TESTDIR to /export"
+        rsh -n $RHOST "/usr/sbin/exportfs -o no_root_squash,rw,nohide,insecure,no_subtree_check *:$TESTDIR"
+        [ $? = 0 ] || end_testcase "Could not export remote directory"
+    else
+        rsh -n $RHOST "/usr/sbin/exportfs -i -o no_root_squash,rw *:$TESTDIR"
+        [ $? = 0 ] || end_testcase "Could not export remote directory"
+    fi
+
+    tst_resm TINFO "Mounting NFS filesystem"
+    mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TCtmp || end_testcase "Cannot mount $TCtmp"
+    [ $? = 0 ] || end_testcase "Could not mount $REMOTE_DIR"
+}
+
+
+#=============================================================================
+# FUNCTION NAME:        do_test
+#
+# FUNCTION DESCRIPTION: Perform the test
+#
+# PARAMETERS:   	None.
+#
+# RETURNS:      	None.
+#=============================================================================
+do_test()
+{
+$trace_logic
+  loopcount=0
+  nfs04_create_file $FILESIZE /tmp/nfs04$PID.testfile >/dev/null
+  if [ $? != 0 ]; then
+	end_testcase "Could not create testfile"
+  fi
+  tst_resm TINFO "Test Started"
+  while [ $loopcount -lt $LOOPS ]
+    do
+	cp /tmp/nfs04$PID.testfile $TCtmp/nfs04$PID.testfile$loopcount
+	cmp /tmp/nfs04$PID.testfile $TCtmp/nfs04$PID.testfile$loopcount
+	retval=$?
+	if [ "$retval" != 0 ]; then
+		end_testcase "Error in loop $loopcount: First cmp FAILED"
+	fi
+	cp $TCtmp/nfs04$PID.testfile$loopcount /tmp/nfs04$PID.testfile_compare
+	cmp /tmp/nfs04$PID.testfile /tmp/nfs04$PID.testfile_compare
+	retval=$?
+	if [ "$retval" != 0 ]; then
+		end_testcase "Error in loop $loopcount: Second cmp FAILED"
+	fi
+	rm -f /tmp/nfs04$PID.testfile_compare
+	loopcount=$(( $loopcount + 1 ))
+	tst_resm TINFO "Completed Loop $loopcount"
+    done
+}
+
+
+#=============================================================================
+# FUNCTION NAME:        end_testcase
+#
+# FUNCTION DESCRIPTION: Clean up
+#
+# PARAMETERS:   	None.
+#
+# RETURNS:      	None.
+#=============================================================================
+end_testcase()
+{
+$trace_logic
+    if [ "$CLEANUP" = "ON" ]; then
+	sleep 2
+        umount $TCtmp || tst_resm TBROK "Cannot umount $TCtmp"
+	rm -rf $TCtmp || tst_resm TBROK "Cannot remove $TCtmp"
+        rsh -n $RHOST "/usr/sbin/exportfs -u *:$TESTDIR"
+		 rsh -n $RHOST "rm -rf $TESTDIR"
+	rm -f /tmp/nfs04$PID.testfile*
+    fi
+
+    [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
+    exit 1
+}
+
+#=============================================================================
+# MAIN PROCEDURE
+#=============================================================================
+
+setup_testcase
+do_test
+end_testcase
diff --git a/testcases/network/nfs/nfs_stress/nfs04_create_file.c b/testcases/network/nfs/nfs_stress/nfs04_create_file.c
new file mode 100644
index 0000000..653c500
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs04_create_file.c
@@ -0,0 +1,74 @@
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2003
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/*
+ *  FILE        : create_file.c
+ *  PURPOSE	: Creates a text file of specified size.
+ *  HISTORY	:
+ *  	10/17/2003 Robbie Williamson
+ *	  -Written
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+
+/* set write buffer size to whatever floats your boat.  I usually use 1M */
+#define BSIZE 1048576L
+
+int main(int argc, char *argv[])
+{
+	off_t i;
+	long bufnum;
+	char buf[BSIZE];
+	off_t fd;
+
+	if (argc != 3 || atoi(argv[1]) < 1) {
+		printf
+		    ("usage:\n\tcreate_file <# of %ld buffers to write> <name of file to create>\n\t ex. # create_file 10 /tmp/testfile\n",
+		     BSIZE);
+		exit(3);
+	}
+	bufnum = strtol(argv[1], NULL, 0);
+	printf("Started building a %lu megabyte file\n", bufnum);
+	buf[0] = 'A';
+	for (i = 1; i < BSIZE; i++)
+		buf[i] = buf[i - 1] + 1;
+	buf[BSIZE - 1] = 'Z';
+
+	if ((fd = creat(argv[2], 0755)) == -1)
+		perror("lftest: ");
+
+	for (i = 0; i < bufnum; i++) {
+		if (write(fd, buf, BSIZE) == -1)
+			return -1;
+		else {
+			printf(".");
+			fflush(stdout);
+		}
+		fsync(fd);
+	}
+	close(fd);
+	printf("\nFinished building a %lu megabyte file\n", bufnum);
+	return (0);
+}
-- 
1.7.1

