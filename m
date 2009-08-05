Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jyotiv@linux.vnet.ibm.com>) id 1MYcM3-0004fg-Bj
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 09:00:15 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYcLu-0006xw-9f
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 09:00:15 +0000
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n758vTJE016880
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 18:57:29 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n758xsge512140
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 18:59:54 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n758xr40006848
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Aug 2009 18:59:54 +1000
Date: Wed, 5 Aug 2009 14:30:05 +0530
From: Jyoti <jyotiv@linux.vnet.ibm.com>
Message-ID: <20090805090005.GA7428@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
Subject: [LTP] Submitting patch
Reply-To: Jyoti <jyotiv@linux.vnet.ibm.com>
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
Cc: ssant@in.ibm.com


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

The attached patch adds one more way of testing dataitegrity of files.
The data integrity test is performed on fragmented files.

Thanks,
Jyoti

--XsQoSWH+UP9D9v3l
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: attachment; filename="fs_di.patch"

Added one more approach for data integrity.
Data integrity is performed on two fragmented files.
1. Creating two fragmented files each of size DiskSize/2.
2. Then comapring against the original file.
3. If not equal test case fails.

My ultimate goal in creating fragmented files is that,
1. It creates many extents (fragments for each file)
2. FS code may behave wrong at corner cases which may come into picture after many extents gets added to the file.
3. Data corruption chances are there
     i. when file metadata updation is not proper(corner cases when fragments are more)
     ii.If write and read is not matching (write operation might have updated the block number some where and read
         may skip that block in some corner cases)
4. In reality fragments can occur only after much usage of the disk(create/delete file)
5. This is good test case for bigger size disk.(it can create more extents)
6. fsync() is called after every write, which makes it slow.

Signed-off-by: Jyoti Vantagodi <jyotiv@linux.vnet.ibm.com>
---

diff -Naurp ltp-full-20090630/testcases/kernel/fs/fs_di/frag.c ltp-full-20090630-final/testcases/kernel/fs/fs_di/frag.c
--- ltp-full-20090630/testcases/kernel/fs/fs_di/frag.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090630-final/testcases/kernel/fs/fs_di/frag.c	2009-07-30 14:20:33.962944167 +0530
@@ -0,0 +1,109 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) International Business Machines  Corp., 2009                 */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/******************************************************************************/
+
+/******************************************************************************/
+/*                                                                            */
+/* File:        frag.c                                                        */
+/*                                                                            */
+/* Description: This piece of code creates two files, and writes 1k data to   */
+/*              each file in a loop from datafile. Loop continues till it     */
+/*              reaches EOF of data file. In a loop fsync, fclose is called,  */
+/*              to create fragmented files.                                   */
+/*                                                                            */
+/* Author:      Jyoti Vantagodi jyotiv@linux.vnet.ibm.com                     */
+/*                                                                            */
+/* History:     Created-Jul 22 2009-Jyoti Vantagodi jyotiv@linux.vnet.ibm.com */
+/*                                                                            */
+/******************************************************************************/
+
+#include<stdio.h>
+#include<fcntl.h>
+#include<string.h>
+#include<sys/types.h>
+#include<unistd.h>
+
+FILE *fp_data;  /* File pointer for data file */
+FILE *fp_frag1; /* File pointer for fragmented file 1 */
+FILE *fp_frag2; /* File pointer for fragmented file 2 */
+
+int main(int argc, char *argv[])
+{
+	int bytes_read = 0, bytes_written = 0, fd1 = -1, fd2 = -1;
+	char buff[1024], frag_file1[100], frag_file2[100];
+
+	if (argc != 3) {
+		printf("Needs to pass two arguments..\n");
+		return -1;
+	}
+	fp_data = fopen(argv[1], "r");
+	if (!fp_data) {
+		perror("fopen:");
+		printf("Error opening datafile \n");
+		return 1;
+	}
+	strcpy(frag_file1, argv[2]);
+	strcat(frag_file1, "/frag1");
+
+	strcpy(frag_file2, argv[2]);
+	strcat(frag_file2, "/frag2");
+	do {
+		fp_frag1 = fopen(frag_file1, "a+");
+		if (!fp_frag1) {
+			printf("Error opening fragfile \n");
+			return -1;
+		}
+		fp_frag2 = fopen(frag_file2, "a+");
+		if (!fp_frag2) {
+			printf("Error opening fragfile \n");
+			perror("fwrite:");
+			return -1;
+		}
+		bytes_read = fread(buff, 1, 1024, fp_data);
+		if (bytes_read < 0) {
+			printf("Error reading data file\n");
+			perror("fread:");
+			return -1;
+		}
+		bytes_written = fwrite(buff, 1, bytes_read, fp_frag1);
+		if (bytes_read != bytes_written) {
+			printf("Error in writing data\n");
+			perror("fwrite:");
+			return -1;
+		}
+		bytes_written = fwrite(buff, 1, bytes_read, fp_frag2);
+		if (bytes_read != bytes_written) {
+			printf("Error in writing data\n");
+			perror("fwrite:");
+			return -1;
+		}
+		fd1 = fileno(fp_frag1);
+		fd2 = fileno(fp_frag2);
+
+		fsync(fd1);
+		fsync(fd2);
+		fclose(fp_frag1);
+		fclose(fp_frag2);
+
+		if (bytes_read < 1024)
+			break;
+	} while (1);
+	fclose(fp_data);
+	return 0;
+}
diff -Naurp ltp-full-20090630/testcases/kernel/fs/fs_di/fs_di ltp-full-20090630-final/testcases/kernel/fs/fs_di/fs_di
--- ltp-full-20090630/testcases/kernel/fs/fs_di/fs_di	2006-12-09 04:04:00.000000000 +0530
+++ ltp-full-20090630-final/testcases/kernel/fs/fs_di/fs_di	2009-07-30 14:24:52.886255358 +0530
@@ -18,20 +18,25 @@
 #
 #
 #
-#  FILE   : fs_di 
+#  FILE   : fs_di
 #
 #  PURPOSE: FileSystem Data Integrity
-#	    Creates a data file of specified or random size and copies 
-#           the file to a random directory depth on a specified filesystem
-#	    The two files are compared and checked for differences. 
-#	    If the files differ, then the test fails. By default, this 
-#	    test creates a 30Mb file and runs for ten loops.
-#	               
+#	   1. Creates a data file of specified or random size and copies
+#         the file to a random directory depth on a specified filesystem
+#	      The two files are compared and checked for differences.
+#	      If the files differ, then the test fails. By default, this
+#	      test creates a 30Mb file and runs for ten loops.
+#      2. Creates a datafile of size half of the partition size. Creates
+#         two fragmented files on the specified partition and copies datafile
+#         to them. Then compares both the fragmented files with datafile. If
+#         files differ, then test fails.
 #
 #  SETUP: None
 #
 #
 #  HISTORY:
+#    28/07/09 Jyoti Vantagodi (jyotiv@linux.vnet.ibm.com)
+#             Added point two of above PURPOSE
 #    04/11/05 Robbie Williamson (robbiew@us.ibm.com)
 #      -Written
 #
@@ -59,17 +64,18 @@ usage()
 {
     cat <<-EOF >&2
 
-    usage: ./${0##*/} -d TMPDIR [-h] [-l # of LOOPS ] [-s SIZE in Mb]
+    usage: ./${0##*/} -d TMPDIR [-h] [-l # of LOOPS ] [-s SIZE in Mb][-S partition SIZE in Mb]
 
     -d TMPDIR       Directory where temporary files will be created.
     -h              Help. Prints all available options.
     -l # of LOOPS   The number of times to run the test. Default=10.
     -s SIZE in Mb   The size of the data file to create. Default=30Mb. A "0" means random sizes from 10-500Mb.
-    -v 		    Verbose output.
-
+    -S SIZE in Mb   Size of usable partition (in MBs) on which the testing is carried out (needs to be passed
+                    for fragmented file test)
+    -v              Verbose output.
+    example: ./${0##*/} -d /mnt/cifsmount -l 20 -s 100 -S 200
     example: ./${0##*/} -d /mnt/cifsmount -l 20 -s 100
 
-
 	EOF
 exit 0
 }
@@ -89,6 +95,8 @@ $trace_logic
     if [ "$CLEANUP" = "ON" ]; then
 	rm -rf $TCtmp
 	rm -rf ${TESTFS}
+   	rm -rf $TMPBASE/*
+        rm -f $TCtmp/testfile*
     fi
 
     [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
@@ -110,16 +118,16 @@ $trace_logic
     LOOPS=10
     SIZE=30
     RANDOM_SIZE=0
-    while getopts d:hl:s:v arg
-    do  
+    DISK_SIZE=0
+    while getopts d:hl:s:S:v arg
+    do
 	case $arg in
 
         d)  # append $$ to TMP, as it is recursively
             # removed at end of script.
-            TMPBASE=$OPTARG
+            export TMPBASE=$OPTARG
             TMP="${TMPBASE}/fs_di-$$"
             export TESTFS="$TMP";;
-
         h)  usage
 	    exit 0;;
    
@@ -130,10 +138,13 @@ $trace_logic
             SIZE=$OPTARG
 	    if [ $SIZE -eq 0 ]; then
               RANDOM_SIZE=1
-	    fi;;	
+	    fi;;
 
 	v)  # Verbose
 	    trace_logic=${trace_logic:-"set -x"};;
+
+        S)  # Size of usable partition, which is used for creating creating the files
+            DISK_SIZE=$OPTARG;;
 	
        \?) usage
 	   exit 0;;
@@ -142,7 +153,8 @@ $trace_logic
     if [ $TMPBASE = "0" ]; then
       tst_resm TBROK "You must specify the target directory [-d]"
       exit 1
-    fi 
+    fi
+
     export TST_COUNT=$LOOPS
 
     echo ""
@@ -184,12 +196,12 @@ $trace_logic
               SIZE=$RANDOM
               let "SIZE %= 500"
  	    done
-        fi
+      	fi
   	create_datafile $SIZE $TCtmp/testfile >/dev/null
 	  if [ $? != 0 ]; then
 		end_testcase "Could not create testfile of size ${SIZE}Mb"
 	  fi
-	RANDOM_DEPTH=$RANDOM 
+	RANDOM_DEPTH=$RANDOM
 	let "RANDOM_DEPTH %= 500"
 
 	RANDOM_LENGTH=$RANDOM
@@ -230,6 +242,39 @@ $trace_logic
 	loopcount=$(( $loopcount + 1 ))
 	tst_resm TINFO "Completed Loop $loopcount"
     done
-  end_testcase
+    if [ "$DISK_SIZE" != 0 ]; then
+    #Create a datafile of size half of the disk size
+    tst_resm TINFO "Creating fragmented files. Please wait..."
+    DISK_SIZE=$(( $DISK_SIZE / 2 ))
+	if [ "$DISK_SIZE" == 0 ]; then
+		DISK_SIZE=1
+	fi
+    create_datafile $DISK_SIZE $TCtmp/testfile >/dev/null
+    retval=$?
+    if [ "$retval" != 0 ]; then
+        end_testcase "Error in creating data file"
+    fi
 
+    #Invoke frag to create 2 fragmented files and copy data file to both the files
+    frag $TCtmp/testfile $TMPBASE
+    retval=$?
+    if [ "$retval" != 0 ]; then
+        end_testcase "Error in creating frag files"
+    fi
+    tst_resm TINFO "Created fragmented files"
 
+    #Compare both frag files with data file
+    cmp $TCtmp/testfile $TMPBASE/frag1
+    retval=$?
+    if [ "$retval" != 0 ]; then
+        end_testcase "frag1 and datafile are not matching"
+    fi
+    if [ "$retval" != 0 ]; then
+       end_testcase "frag2 and datafile are not matching"
+    fi
+
+    tst_resm TINFO "Completed test with fragmented files"
+	rm -rf $TMPBASE/*
+	rm -f $TCtmp/testfile*
+    fi
+end_testcase

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--XsQoSWH+UP9D9v3l--

