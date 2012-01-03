Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri2OW-000211-Qi
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:19:04 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri2OW-0005la-1v
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:19:04 +0000
Message-ID: <4F02E420.5040100@imgtec.com>
Date: Tue, 3 Jan 2012 11:18:56 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020202060705010807060407"
Subject: [LTP] [PATCH 12/21] syscalls/{getcontext,
 profil}: Move test.h header and TCID variable to the top
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

--------------020202060705010807060407
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------020202060705010807060407
Content-Type: text/plain;
	name="0012-syscalls-getcontext-profil-Move-test.h-header-and-TC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0012-syscalls-getcontext-profil-Move-test.h-header-and-TC.pa";
	filename*1="tch"

From 12fe59ab99a573210f38ca6c40b41aa68504ad37 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Fri, 18 Nov 2011 16:08:21 +0000
Subject: [PATCH 12/21] syscalls/{getcontext,profil}: Move test.h header and TCID variable to the top

The tst_brkm() function is used independently of UCLIBC macro so
they need to be defined outside of #ifdef statement

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 .../kernel/syscalls/getcontext/getcontext01.c      |    8 +++++---
 testcases/kernel/syscalls/profil/profil01.c        |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c b/testcases/kernel/syscalls/getcontext/getcontext01.c
index 7cadc67..aea0b1d 100644
--- a/testcases/kernel/syscalls/getcontext/getcontext01.c
+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
@@ -34,6 +34,10 @@
  **********************************************************/
 
 #include <features.h>
+#include "test.h"
+
+char *TCID = "getcontext01";	/* Test program identifier.    */
+
 #if !defined(__UCLIBC__)
 
 #include <stdio.h>
@@ -41,13 +45,11 @@
 #include <errno.h>
 #include <ucontext.h>
 
-#include "test.h"
 #include "usctest.h"
 
 void setup();
 void cleanup();
 
-char *TCID = "getcontext01";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 
 int exp_enos[] = { 0 };		/* must be a 0 terminated list */
@@ -102,4 +104,4 @@ int main()
 {
 	tst_brkm(TCONF, NULL, "system doesn't have getcontext support");
 }
-#endif
\ No newline at end of file
+#endif
diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index 63bed83..1af7e5d 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -41,6 +41,10 @@
 #endif
 
 #include <features.h>
+#include "test.h"
+
+char *TCID = "profil01";
+
 #ifndef __UCLIBC__
 
 #ifdef __arm__
@@ -58,7 +62,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "test.h"
 #include "usctest.h"
 #define FAILED 0
 #define PASSED 1
@@ -73,7 +76,6 @@ volatile int t_flag;
 //char progname[]= "profil1()";
 
 /*****	LTP Port	*****/
-char *TCID = "profil01";
 int local_flag = PASSED;
 int block_number;
 FILE *temp;
@@ -310,4 +312,4 @@ int main(void)
 	/* uClibc does not have profiling support */
 	tst_exit();
 }
-#endif
\ No newline at end of file
+#endif
-- 
1.7.1


--------------020202060705010807060407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------020202060705010807060407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020202060705010807060407--


