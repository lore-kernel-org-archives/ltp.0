Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MJCdJ-000178-Fd
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:30:21 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJCdD-00046w-G8
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:30:16 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id A3EC2106AEECE
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Jun 2009 22:30:14 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #277) id 1MJCdB-0001TJ-00
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 22:30:14 +0200
Date: Fri, 19 Jun 2009 16:12:15 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvzveadhlwynca@debian>
Subject: [LTP] [PATCH] Use present autoconf test for asm/ldt.h in
 set_thread_area* tests to prevent build failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090619141215.EFnzuotVeUQVDdO6ddPMWPTFlmtXysau45N5FHv37aY@z>

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../syscalls/set_thread_area/set_thread_area01.c   |   27 +++++++++++++------
 .../syscalls/set_thread_area/set_thread_area02.c   |   27 +++++++++++++------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
index f924548..314045c 100644
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
@@ -49,25 +49,27 @@
 /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
 
-#include <stdio.h>
-#include <errno.h>
-#include <linux/unistd.h>
-#include <asm/ldt.h>
-
 /* Harness Specific Include Files. */
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-
-/* Extern Global Variables */
-extern int Tst_count;           /* counter for tst_xxx routines.         */
-extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+#include "config.h"
 
 /* Global Variables */
 char *TCID = "set_thread_area01";  /* Test program identifier.*/
 int  testno;
 int  TST_TOTAL = 2;                   /* total number of tests in this file.   */
 
+#if defined HAVE_ASM_LDT_H
+#include <stdio.h>
+#include <errno.h>
+#include <linux/unistd.h>
+#include <asm/ldt.h>
+
+/* Extern Global Variables */
+extern int Tst_count;           /* counter for tst_xxx routines.         */
+extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -175,3 +177,10 @@ int main(int ac, char **av) {
         tst_exit();
 }
 
+#else
+int main(int ac, char **av) {
+    
+    tst_resm(TCONF, "is not available for this architecture");
+    tst_exit();
+}
+#endif
diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
index 4fff9d6..52c7d06 100644
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
@@ -50,25 +50,27 @@
 /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
 
-#include <stdio.h>
-#include <errno.h>
-#include <linux/unistd.h>
-#include <asm/ldt.h>
-
 /* Harness Specific Include Files. */
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-
-/* Extern Global Variables */
-extern int Tst_count;           /* counter for tst_xxx routines.         */
-extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+#include "config.h"
 
 /* Global Variables */
 char *TCID = "set_thread_area_02";  /* Test program identifier.*/
 int  testno;
 int  TST_TOTAL = 3;                   /* total number of tests in this file.   */
 
+#if defined HAVE_ASM_LDT_H
+#include <stdio.h>
+#include <errno.h>
+#include <linux/unistd.h>
+#include <asm/ldt.h>
+
+/* Extern Global Variables */
+extern int Tst_count;           /* counter for tst_xxx routines.         */
+extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -195,4 +197,11 @@ int main(int ac, char **av) {
 	cleanup();
         tst_exit();
 }
+#else
+int main(int ac, char **av) {
+    
+    tst_resm(TCONF, "is not available for this architecture");
+    tst_exit();
+}
+#endif
 
-- 
1.6.3.1




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
