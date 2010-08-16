Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1Ol3FE-0004ta-MW
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 17:13:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol3FD-00067n-Gc
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 17:13:08 +0000
Received: from int-mx08.intmail.prod.int.phx2.redhat.com
	(int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7GHD175029801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 13:13:01 -0400
Received: from dmarlin.csb (dhcp-224-3.tha.redhat.com [10.15.224.3])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o7GHCxjq004495
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 13:13:00 -0400
Message-ID: <4C69719A.3050507@redhat.com>
Date: Mon, 16 Aug 2010 12:12:58 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010801000908090301010303"
Subject: [LTP] redefinition of errno in some syscalls tests
Reply-To: dmarlin@redhat.com
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
To: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010801000908090301010303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I found that some of the testcases in kernel/syscalls redefine 'errno' 
as 'int':

   int errno;

'errno' is normally in errno.h as a #define to a function returning a 
pointer, i.e.,

   extern int *__errno_location (void)  . . .


Attached is a patch to remove the redefinition from the following files:

   testcases/kernel/syscalls/mallopt/mallopt01.c
   testcases/kernel/syscalls/memcmp/memcmp01.c
   testcases/kernel/syscalls/memcpy/memcpy01.c
   testcases/kernel/syscalls/memset/memset01.c
   testcases/kernel/syscalls/syscall/syscall01.c
   testcases/kernel/syscalls/string/string01.c


Signed-off-by: d.marlin <dmarlin@redhat.com>


--------------010801000908090301010303
Content-Type: text/x-patch;
 name="errno.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errno.patch"

--- testcases/kernel/syscalls/mallopt/mallopt01.c.orig	2010-07-03 13:29:23.000000000 -0500
+++ testcases/kernel/syscalls/mallopt/mallopt01.c	2010-08-13 10:28:12.318231274 -0500
@@ -51,7 +51,6 @@
 
 char *TCID = "mallopt01";
 int block_number;
-int errno;
 FILE *temp;
 int TST_TOTAL = 1;
 extern int Tst_COUNT;		/* Test Case counter for tst_routines */
--- testcases/kernel/syscalls/memcmp/memcmp01.c.orig	2010-07-20 17:40:58.107370000 -0500
+++ testcases/kernel/syscalls/memcmp/memcmp01.c	2010-07-20 16:51:07.468426000 -0500
@@ -57,7 +57,6 @@
 /*****	LTP Port	*****/
 int local_flag = PASSED;
 int block_number;
-int errno;
 FILE *temp;
 int TST_TOTAL = 2;
 int anyfail();
--- testcases/kernel/syscalls/memcpy/memcpy01.c.orig	2010-07-20 17:40:58.116371000 -0500
+++ testcases/kernel/syscalls/memcpy/memcpy01.c	2010-07-20 16:51:10.206237000 -0500
@@ -61,7 +61,6 @@
 /*****	LTP Port	*****/
 int local_flag = PASSED;
 int block_number;
-int errno;
 FILE *temp;
 int TST_TOTAL = 1;
 /*****	**	**	*****/
--- testcases/kernel/syscalls/memset/memset01.c.orig	2010-07-20 17:40:58.127370000 -0500
+++ testcases/kernel/syscalls/memset/memset01.c	2010-07-20 16:51:13.531048000 -0500
@@ -57,7 +57,6 @@
 /*****	LTP Port	*****/
 int local_flag = PASSED;
 int block_number;
-int errno;
 int TST_TOTAL = 1;
 
 extern int Tst_count;
--- testcases/kernel/syscalls/syscall/syscall01.c.orig	2010-07-20 17:40:58.136370000 -0500
+++ testcases/kernel/syscalls/syscall/syscall01.c	2010-07-20 16:51:18.080796000 -0500
@@ -52,7 +52,6 @@
 char *TCID = "syscall01";
 int local_flag = PASSED;
 int block_number;
-int errno;
 FILE *temp;
 int TST_TOTAL = 1;
 extern int Tst_count;
@@ -63,7 +62,6 @@
 #define ITER		500
 
 int t_flag;
-int errno;
 
 /*****	LTP Port	*****/
 void setup();
--- testcases/kernel/syscalls/string/string01.c.orig	2010-08-09 15:56:12.859181562 -0500
+++ testcases/kernel/syscalls/string/string01.c	2010-08-09 15:58:32.475110931 -0500
@@ -52,7 +52,6 @@
 
 int local_flag = PASSED;
 int block_number;
-int errno;
 FILE *temp;
 int TST_TOTAL = 1;
 extern int Tst_count;

--------------010801000908090301010303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--------------010801000908090301010303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010801000908090301010303--

