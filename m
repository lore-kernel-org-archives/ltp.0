Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jyotiv@linux.vnet.ibm.com>) id 1MUIVa-0000mj-JR
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 11:00:14 +0000
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUIVX-0005hP-T2
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 11:00:14 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id n6OB01A3010578
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 16:30:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6OB01ON1769620
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 16:30:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6OB01oN023941
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 16:30:01 +0530
From: jyotiv@linux.vnet.ibm.com
Date: Fri, 24 Jul 2009 16:30:08 +0530
Message-ID: <20090724110008.GA11878@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"
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


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

PATCH IS CREATED FOR ltp-full-20090630.

I am submitting a patch to kernel/fs/fs_di

In this file data integity is performed by creating the file at
different directory depth and then by comparing with original file.

To this I have added one more approach to perform integrity test.
1. Creating two fragmented files each of size DiskSize/2.
2. Then comapring against the original file.
3. If not equal test case fails.

My ultimate goal in creating fragmented files is that,
1. It creates many extents (fragments for each file)
2. FS code may behave wrong at corner cases which may come into picture
   after many extents gets added to the file.
3. Data corruption chances are there 
     i. when file metadata updation is not proper (corner cases when fragments are more)
     ii.If write and read is not matching (write operation might have updated the block 
        number some where and read may skip that block in some corner cases)
4. In reality fragments can occur only after much usage of the disk(create/delete file)
5. This is good test case for bigger size disk.(it can create more extents)


To: ltp-list@lists.sourceforge.net
Cc: subrata@linux.vnet.ibm.com
Bcc: Jyoti <jyotiv@linux.vnet.ibm.com>
Subject: Submitting patch 
Reply-To: Jyoti <jyotiv@linux.vnet.ibm.com>


--Fba/0zbH8Xs+Fj9o
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

Signed_off_by: Jyoti Vantagodi (jyotiv@linux.vnet.ibm.com)

diff -Naurp ltp-full-20090630/testcases/kernel/fs/fs_di/frag.c ltp-full-20090630-new/testcases/kernel/fs/fs_di/frag.c
--- ltp-full-20090630/testcases/kernel/fs/fs_di/frag.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090630-new/testcases/kernel/fs/fs_di/frag.c	2009-07-24 11:41:54.000000000 +0530
@@ -0,0 +1,121 @@
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
+/*              reaches EOF of data file. In a loop fclose is called, to      */
+/*              create fragmented files.                                      */
+/*                                                                            */
+/* Author:      Jyoti Vantagodi jvantago@in.ibm.com                           */
+/*                                                                            */
+/* History:     Created - Jul 22 2009 -  Jyoti Vantagodi jvantago@in.ibm.com  */
+/*                                                                            */
+/******************************************************************************/
+
+#include<stdio.h>
+#include<fcntl.h>
+#include<string.h>
+#include<sys/types.h>
+#include<unistd.h>
+
+FILE *fp_data = NULL;  //File pointer for data file
+FILE *fp_frag1 = NULL; //File pointer for fragmented file 1
+FILE *fp_frag2 = NULL; //File pointer for fragmented file 2
+
+int main(int argc, char *argv[])
+{
+	int bytes_read=0, bytes_written=0, fd1,fd2;
+	char buff[1024],frag_file1[100],frag_file2[100];
+
+	if (argc != 3 )
+   	{
+		printf("Needs to pass two arguments..\n");	
+      		return -1 ;
+   	}
+	fp_data = fopen(argv[1], "r");
+	if(!fp_data)
+	{
+		perror("fopen:");
+		printf("Error opening datafile \n");
+		return 1;
+	}
+	strcpy(frag_file1, argv[2]);
+	strcat(frag_file1, "/frag1");
+
+	strcpy(frag_file2, argv[2]);
+	strcat(frag_file2, "/frag2");
+	do
+	{
+	
+		fp_frag1 = fopen(frag_file1, "a+");
+    		if(!fp_frag1)
+    		{   
+        		printf("Error opening fragfile \n");
+        		return -1;
+    		}			 
+		fp_frag2 = fopen(frag_file2, "a+");
+    		if(!fp_frag2 )
+    		{   
+        		printf("Error opening fragfile \n");
+        		return -1;
+    		}		 
+
+		bytes_read = fread(buff, 1, 1024, fp_data);
+		if( bytes_read < 0)
+		{
+			printf("Error reading data file\n");
+			return -1;
+		}
+                
+		bytes_written = fwrite(buff, 1, bytes_read, fp_frag1);
+		if( bytes_read!= bytes_written)
+		{
+			printf("Error in writing data\n");
+			return -1;
+		}
+
+		bytes_written = fwrite(buff, 1, bytes_read, fp_frag2);
+		if( bytes_read!= bytes_written)
+        	{
+            		printf("Error in writing data\n");
+            		return -1;
+        	}	
+		fd1 = fileno(fp_frag1);
+		fd2 = fileno(fp_frag2);
+
+		fsync(fd1);
+		fsync(fd2);
+		fclose(fp_frag1);
+		fclose(fp_frag2);
+
+                if(bytes_read < 1024)
+		{
+			break;
+		}
+	}while(1);
+	fclose(fp_data);
+	return 0;
+}
+				
+		
diff -Naurp ltp-full-20090630/testcases/kernel/fs/fs_di/fs_di ltp-full-20090630-new/testcases/kernel/fs/fs_di/fs_di
--- ltp-full-20090630/testcases/kernel/fs/fs_di/fs_di	2006-12-09 04:04:00.000000000 +0530
+++ ltp-full-20090630-new/testcases/kernel/fs/fs_di/fs_di	2009-07-24 11:42:21.000000000 +0530
@@ -21,17 +21,24 @@
 #  FILE   : fs_di 
 #
 #  PURPOSE: FileSystem Data Integrity
-#	    Creates a data file of specified or random size and copies 
-#           the file to a random directory depth on a specified filesystem
-#	    The two files are compared and checked for differences. 
-#	    If the files differ, then the test fails. By default, this 
-#	    test creates a 30Mb file and runs for ten loops.
+#	   1. Creates a data file of specified or random size and copies 
+#             the file to a random directory depth on a specified filesystem
+#	      The two files are compared and checked for differences. 
+#	      If the files differ, then the test fails. By default, this 
+#	      test creates a 30Mb file and runs for ten loops.
+#          2. Creates a datafile of size half of the partition size. Creates 
+#             two fragmented files on the specified partition and copies datafile 
+#             to them. Then compares both the fragmented files with datafile. If 
+#             files differ, then test fails.  
+#
 #	               
 #
 #  SETUP: None
 #
 #
 #  HISTORY:
+#    22/07/09 Jyoti Vantagodi (jvantago@in.ibm.com)
+#             Added point two of above PURPOSE 
 #    04/11/05 Robbie Williamson (robbiew@us.ibm.com)
 #      -Written
 #
@@ -59,15 +66,15 @@ usage()
 {
     cat <<-EOF >&2
 
-    usage: ./${0##*/} -d TMPDIR [-h] [-l # of LOOPS ] [-s SIZE in Mb]
+    usage: ./${0##*/} -d TMPDIR [-h] [-l # of LOOPS ] [-s SIZE in Mb][-S partition SIZE in Mb]
 
     -d TMPDIR       Directory where temporary files will be created.
     -h              Help. Prints all available options.
     -l # of LOOPS   The number of times to run the test. Default=10.
     -s SIZE in Mb   The size of the data file to create. Default=30Mb. A "0" means random sizes from 10-500Mb.
+    -S              Size of usable partition (in MBs) on which the testing is carried out
     -v 		    Verbose output.
-
-    example: ./${0##*/} -d /mnt/cifsmount -l 20 -s 100
+    example: ./${0##*/} -d /mnt/cifsmount -l 20 -s 100 -S 200
 
 
 	EOF
@@ -89,6 +96,8 @@ $trace_logic
     if [ "$CLEANUP" = "ON" ]; then
 	rm -rf $TCtmp
 	rm -rf ${TESTFS}
+   	rm -rf $TMPBASE/*
+        rm -f $TCtmp/testfile*
     fi
 
     [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
@@ -110,16 +119,17 @@ $trace_logic
     LOOPS=10
     SIZE=30
     RANDOM_SIZE=0
-    while getopts d:hl:s:v arg
+    DISK_SIZE=0
+    while getopts d:hl:s:S:v arg
     do  
 	case $arg in
 
         d)  # append $$ to TMP, as it is recursively
             # removed at end of script.
-            TMPBASE=$OPTARG
+            export TMPBASE=$OPTARG
             TMP="${TMPBASE}/fs_di-$$"
             export TESTFS="$TMP";;
-
+  
         h)  usage
 	    exit 0;;
    
@@ -134,6 +144,9 @@ $trace_logic
 
 	v)  # Verbose
 	    trace_logic=${trace_logic:-"set -x"};;
+
+        S)  # Size of usable partition, which is used for creating creating the files
+            DISK_SIZE=$OPTARG;;
 	
        \?) usage
 	   exit 0;;
@@ -143,6 +156,12 @@ $trace_logic
       tst_resm TBROK "You must specify the target directory [-d]"
       exit 1
     fi 
+  
+    if [ $DISK_SIZE -eq 0 ]; then
+      tst_resm TBROK "You must specify the disk size [-S]"
+      exit 1
+    fi 
+
     export TST_COUNT=$LOOPS
 
     echo ""
@@ -230,6 +249,46 @@ $trace_logic
 	loopcount=$(( $loopcount + 1 ))
 	tst_resm TINFO "Completed Loop $loopcount"
     done
+	#Create a datafile of size half of the disk size
+	DISK_SIZE=$(( $DISK_SIZE / 2 ))
+	create_datafile $DISK_SIZE $TCtmp/testfile >/dev/null 
+	retval=$?
+        if [ "$retval" != 0 ]; then
+                end_testcase "Error in creating data file"
+        fi
+
+	#Invoke frag to create 2 fragmented files and copy data file to both the files
+	frag $TCtmp/testfile $TMPBASE >/dev/null
+	retval=$?
+        if [ "$retval" != 0 ]; then
+                end_testcase "Error in creating frag files"
+        fi
+
+	tst_resm TINFO "Created fragmented files"
+
+	#Compare both frag files with data file
+	cmp $TCtmp/testfile $TMPBASE/frag1
+	retval=$?
+	if [ "$retval" != 0 ]; then
+		end_testcase "frag1 and datafile are not matching"
+	fi
+	
+	cmp $TCtmp/testfile $TMPBASE/frag2
+	if [ "$retval" != 0 ]; then
+		end_testcase "frag2 and datafile are not matching"
+	fi
+
+	tst_resm TINFO "DataIntegrity test with fragmented files is successful"
+
+	rm -rf $TMPBASE/*
+	rm -f $TCtmp/testfile*
+    
   end_testcase
 

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--Fba/0zbH8Xs+Fj9o--

