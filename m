Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1OlQzU-0001L9-OG
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 18:34:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlQzT-0006sw-Qs
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 18:34:28 +0000
Received: from int-mx03.intmail.prod.int.phx2.redhat.com
	(int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7HIYMGr029639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Aug 2010 14:34:22 -0400
Received: from dmarlin.csb (dhcp-224-3.tha.redhat.com [10.15.224.3])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o7HIYKlI006626
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Aug 2010 14:34:21 -0400
Message-ID: <4C6AD62B.2010905@redhat.com>
Date: Tue, 17 Aug 2010 13:34:19 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070503050105020802090103"
Subject: [LTP] problems building lchown02.c for uClinux
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
To: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070503050105020802090103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


'lchown02.c' does not build properly due to calls to mmap and
get_high_address (which references sbrk) when UCLINUX=1 is defined.

Attached is a patch to skip those sections of the test when building for
uClinux.


Signed-off-by: d.marlin <dmarlin@redhat.com>



--------------070503050105020802090103
Content-Type: text/x-patch;
 name="lchown02.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lchown02.c.patch"

--- testcases/kernel/syscalls/lchown/lchown02.c.orig	2010-04-01 01:23:10.000000000 -0500
+++ testcases/kernel/syscalls/lchown/lchown02.c	2010-07-07 17:42:51.751689213 -0500
@@ -109,8 +109,12 @@
 int setup3();			/* setup function to test lchown for ENOTDIR */
 int longpath_setup();		/* setup function to test chown for ENAMETOOLONG */
 
-char Longpathname[PATH_MAX + 2];
+#if !defined(UCLINUX)
+char *get_high_address();       /* function from ltp-lib        */
 char High_address_node[64];
+#endif
+
+char Longpathname[PATH_MAX + 2];
 char EXEC_DIR[PATH_MAX];
 char main_test_dir[PATH_MAX + 2];
 
@@ -123,9 +127,11 @@
 	{
 	SFILE1, "Process is not owner/root", EPERM, setup1}, {
 	SFILE2, "No Search permissions to process", EACCES, setup2}, {
+#if !defined(UCLINUX)
 	High_address_node, "Address beyond address space", EFAULT, no_setup},
 	{
 	(char *)-1, "Negative address", EFAULT, no_setup}, {
+#endif
 	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
 	"", "Pathname is empty", ENOENT, no_setup}, {
 	SFILE3, "Path contains regular file", ENOTDIR, setup3}, {
@@ -184,9 +190,11 @@
 			file_name = Test_cases[ind].pathname;
 			test_desc = Test_cases[ind].desc;
 
+#if !defined(UCLINUX)
 			if (file_name == High_address_node) {
 				file_name = (char *)get_high_address();
 			}
+#endif
 
 			/*
 			 * Call lchown(2) to test different test conditions.
@@ -279,12 +287,14 @@
 		tst_brkm(TBROK | TERRNO, cleanup, "chmod() failed");
 	}
 
+#if !defined(UCLINUX)
 	bad_addr = mmap(0, 1, PROT_NONE,
 			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr == MAP_FAILED) {
 		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
 	}
 	Test_cases[3].pathname = bad_addr;
+#endif
 
 	/* call individual setup functions */
 	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {



--------------070503050105020802090103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--------------070503050105020802090103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070503050105020802090103--

