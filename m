Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1Me9WA-0000Pb-2Z
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:34 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Me9W4-0005FU-9o
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:34 +0000
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 20 Aug 2009 17:25:16 +0200
Message-Id: <1250781918-23897-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Subject: [LTP] [PATCH] Spelling fixes: commad => command
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
To: Ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 ChangeLog                                          |    2 +-
 testcases/commands/ade/file/file_test.sh           |    8 ++++----
 testcases/commands/eject/eject-tests.sh            |    2 +-
 .../plugins/ilo2_ribcl/ilo2_ribcl_reset.c          |    2 +-
 tools/mkrootfs/mkrootfs                            |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 1e087c1..b96acf3 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -959,7 +959,7 @@ ltp/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
 ltp/testcases/kernel/syscalls/utils/common_j_h.c
 
 49) Log Message:
-Some makefiles ignore errors from commads ran in shell loops. This patch fixes that. Signed-off-by: Jiri Palecek <jpalecek@web.de>.
+Some makefiles ignore errors from commands ran in shell loops. This patch fixes that. Signed-off-by: Jiri Palecek <jpalecek@web.de>.
 
 Modified Files:
 ltp/doc/man1/Makefile
diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
index 4fc9dec..6f09f21 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -149,7 +149,7 @@ RC=0
 export TCID=file01
 export TST_COUNT=1
 
-$LTPBIN/tst_resm TINFO "TEST #1: file commad recogizes ASCII text files"
+$LTPBIN/tst_resm TINFO "TEST #1: file command recogizes ASCII text files"
 
 cat > $LTPTMP/test_file.txt <<EOF
 This is a text file 
@@ -191,7 +191,7 @@ cat > $LTPTMP/bash_script.sh <<EOF
 #! /bin/bash
 
 echo "this is a shell script"
-echo "used to test file commad"
+echo "used to test file command"
 
 EOF
 
@@ -226,7 +226,7 @@ cat > $LTPTMP/ksh_script.sh <<EOF
 #! /bin/ksh
 
 echo "this is a shell script"
-echo "used to test file commad"
+echo "used to test file command"
 
 EOF
 
@@ -262,7 +262,7 @@ cat > $LTPTMP/C_script.sh <<EOF
 #! /bin/csh
 
 echo "this is a shell script"
-echo "used to test file commad"
+echo "used to test file command"
 
 EOF
 
diff --git a/testcases/commands/eject/eject-tests.sh b/testcases/commands/eject/eject-tests.sh
index 1b2b3e8..f7fce60 100755
--- a/testcases/commands/eject/eject-tests.sh
+++ b/testcases/commands/eject/eject-tests.sh
@@ -101,7 +101,7 @@ export TCID=eject02
 export TST_COUNT=2
 RC=0
 
-$LTPBIN/tst_resm TINFO "Test #2: eject commad with no options"
+$LTPBIN/tst_resm TINFO "Test #2: eject command with no options"
 $LTPBIN/tst_resm TINFO "Test #2: will eject the default cdrom device."
 
 eject -v > $LTPTMP/tst_eject.res 2>&1 || RC=$?
diff --git a/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/ilo2_ribcl_reset.c b/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/ilo2_ribcl_reset.c
index b20c644..466a767 100644
--- a/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/ilo2_ribcl_reset.c
+++ b/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/ilo2_ribcl_reset.c
@@ -116,7 +116,7 @@ SaErrorT ilo2_ribcl_get_reset_state(void *hnd,
  * Sets a resource's reset action state.
  * Retrieves a resource's reset action state. If the resource has
  * SAHPI_CAPABILITY_RESET then sends RESET_SERVER RIBCL command to iLO2
- * to do a warm reset the system and a COLD_BOOT_SERVER commad to do a
+ * to do a warm reset the system and a COLD_BOOT_SERVER command to do a
  * cold reset. Please note that this command doesn't bring the system and
  * (OS running on it down gracefully.
  *
diff --git a/tools/mkrootfs/mkrootfs b/tools/mkrootfs/mkrootfs
index 9adf8b4..0c77153 100755
--- a/tools/mkrootfs/mkrootfs
+++ b/tools/mkrootfs/mkrootfs
@@ -84,7 +84,7 @@ usage()
 
 help()
 {
-    echo "This program will create a root file system with busybox commads."
+    echo "This program will create a root file system with busybox commands."
     echo "Follow these steps to boot your machine with this file system"
     echo "1. create a boot floppy."
     echo "   - use command: dd if=<path>/bzImage of=/dev/fd0h1440 bs=1k"
-- 
1.6.2.4


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
