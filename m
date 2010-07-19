Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Oao0G-0008Tj-8s
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 10:55:20 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oao0E-0006Ll-P0
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 10:55:20 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx01.colomx.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
	o6JAtCDD010965
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jul 2010 06:55:12 -0400
Date: Mon, 19 Jul 2010 06:55:12 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1736556680.530871279536912040.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <183137942.530851279536896429.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23332_2060190123.1279536912039"
Subject: [LTP] [PATCH] Fix utimensat01 testcase
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
To: LTP List <ltp-list@lists.sourceforge.net>

------=_Part_23332_2060190123.1279536912039
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi all,
   I tested this case for many times in RHEL6 on all archs but
   always got a failure. The error message was:
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   open: Permission denied 
   FAILED (bad test setup)
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   when the testcase tried to execute ./utimensat01 <params,...>.

   After investigation, I found that the following two parts
   maybe have wrong RW parameter:

   a) Testing read-only file, owned by nobody(self).
   Since the perm is 400, the user `nobody' itself doesn't have
   write permission to the testfile, thus, if program executes
   ./utimensat01 with -w param, `Permission deined' error will
   occur. So we need to add -W in run_test param to avoid trying
   writing test.

   b) Testing read-only file, owned by root.
   Since root owns the test file and the perm is still 400,
   the user `nobody' has neither writing nor reading permission
   to this file, so -RW param should be both set to run_test
   function to avoid trying reading & writing test.

   Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 4246d1a..a861d61 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -288,22 +288,22 @@ echo "Testing read-only file, owned by self"
 echo
 
 echo "***** Testing times==NULL case *****"
-run_test "" 400 "" "" SUCCESS y y
+run_test -W "" 400 "" "" SUCCESS y y
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
-run_test "" 400 "" "0 n 0 n" SUCCESS y y
+run_test -W "" 400 "" "0 n 0 n" SUCCESS y y
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
-run_test "" 400 "" "0 o 0 o" SUCCESS n n
+run_test -W "" 400 "" "0 o 0 o" SUCCESS n n
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
-run_test "" 400 "" "0 n 0 o" SUCCESS y n
+run_test -W "" 400 "" "0 n 0 o" SUCCESS y n
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
-run_test "" 400 "" "0 o 0 n" SUCCESS n y
+run_test -W "" 400 "" "0 o 0 n" SUCCESS n y
 
 echo "***** Testing times=={ x, y } case *****"
-run_test "" 400 "" "1 1 1 1" SUCCESS y y
+run_test -W "" 400 "" "1 1 1 1" SUCCESS y y
 
 echo "============================================================"
 
@@ -312,22 +312,22 @@ echo "Testing read-only file, not owned by self"
 echo
 
 echo "***** Testing times==NULL case *****"
-run_test root 400 "" "" EACCES
+run_test -RW root 400 "" "" EACCES
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
-run_test root 400 "" "0 n 0 n" EACCES
+run_test -RW root 400 "" "0 n 0 n" EACCES
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
-run_test root 400 "" "0 o 0 o" SUCCESS n n
+run_test -RW root 400 "" "0 o 0 o" SUCCESS n n
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
-run_test root 400 "" "0 n 0 o" EPERM
+run_test -RW root 400 "" "0 n 0 o" EPERM
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
-run_test root 400 "" "0 o 0 n" EPERM
+run_test -RW root 400 "" "0 o 0 n" EPERM
 
 echo "***** Testing times=={ x, y } case *****"
-run_test root 400 "" "1 1 1 1" EPERM
+run_test -RW root 400 "" "1 1 1 1" EPERM
 
 echo "============================================================"

Thanks,
Caspar

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_23332_2060190123.1279536912039
Content-Type: text/x-patch; name=syscalls-utimensat01-fix-perm-denied.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-utimensat01-fix-perm-denied.patch

Hi all,
   I tested this case for many times in RHEL6 on all archs but
   always got a failure. The error message was:
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   open: Permission denied 
   FAILED (bad test setup)
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   when the testcase tried to execute ./utimensat01 <params,...>.

   After investigation, I found that the following two parts
   maybe have wrong RW parameters:

   a) Testing read-only file, owned by nobody(self).
   Since the perm is 400, the user `nobody' itself doesn't have
   write permission to the testfile, thus, if program executes
   ./utimensat01 with -w param, `Permission deined' error will
   occur. So we need to add -W in run_test param to avoid trying
   writing test.

   b) Testing read-only file, owned by root.
   Since root owns the test file and the perm is still 400,
   the user `nobody' has neither writing nor reading permission
   to this file, so -RW param should be both set to run_test
   function to avoid trying reading & writing test.

   Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 4246d1a..a861d61 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -288,22 +288,22 @@ echo "Testing read-only file, owned by self"
 echo
 
 echo "***** Testing times==NULL case *****"
-run_test "" 400 "" "" SUCCESS y y
+run_test -W "" 400 "" "" SUCCESS y y
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
-run_test "" 400 "" "0 n 0 n" SUCCESS y y
+run_test -W "" 400 "" "0 n 0 n" SUCCESS y y
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
-run_test "" 400 "" "0 o 0 o" SUCCESS n n
+run_test -W "" 400 "" "0 o 0 o" SUCCESS n n
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
-run_test "" 400 "" "0 n 0 o" SUCCESS y n
+run_test -W "" 400 "" "0 n 0 o" SUCCESS y n
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
-run_test "" 400 "" "0 o 0 n" SUCCESS n y
+run_test -W "" 400 "" "0 o 0 n" SUCCESS n y
 
 echo "***** Testing times=={ x, y } case *****"
-run_test "" 400 "" "1 1 1 1" SUCCESS y y
+run_test -W "" 400 "" "1 1 1 1" SUCCESS y y
 
 echo "============================================================"
 
@@ -312,22 +312,22 @@ echo "Testing read-only file, not owned by self"
 echo
 
 echo "***** Testing times==NULL case *****"
-run_test root 400 "" "" EACCES
+run_test -RW root 400 "" "" EACCES
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
-run_test root 400 "" "0 n 0 n" EACCES
+run_test -RW root 400 "" "0 n 0 n" EACCES
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
-run_test root 400 "" "0 o 0 o" SUCCESS n n
+run_test -RW root 400 "" "0 o 0 o" SUCCESS n n
 
 echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
-run_test root 400 "" "0 n 0 o" EPERM
+run_test -RW root 400 "" "0 n 0 o" EPERM
 
 echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
-run_test root 400 "" "0 o 0 n" EPERM
+run_test -RW root 400 "" "0 o 0 n" EPERM
 
 echo "***** Testing times=={ x, y } case *****"
-run_test root 400 "" "1 1 1 1" EPERM
+run_test -RW root 400 "" "1 1 1 1" EPERM
 
 echo "============================================================"
 

------=_Part_23332_2060190123.1279536912039
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_23332_2060190123.1279536912039
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_23332_2060190123.1279536912039--

