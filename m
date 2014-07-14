Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X6eYi-00052v-Db
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 11:36:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X6eYg-0002oc-OW
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 11:36:40 +0000
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 14 Jul 2014 13:36:22 +0200
Message-Id: <34c197c03d5d2d3296bd1e770e70922f72c770f5.1405337663.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] fs-bench: rename test*.sh scripts to fs-bench-test*.sh
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
Cc: Awais_Belal@mentor.com

Install name of these scripts is in conflict with testcases/lib/test.sh.
In problem Awais reported, he ended up with test.sh from fs-bench in
install directory, instead of shell script library he was expecting:
  install -m 00775 "/root/ltp/testcases/lib/test.sh" "/opt/ltp/testcases/bin/test.sh"
  ...
  install -m 00775 "/root/ltp/testcases/kernel/fs/fs-bench/test.sh" "/opt/ltp/testcases/bin/test.sh"

Reported-by: Awais Belal <Awais_Belal@mentor.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/fs-bench/Makefile          |    2 +-
 testcases/kernel/fs/fs-bench/fs-bench-test.sh  |   50 +++++++++++++++++++
 testcases/kernel/fs/fs-bench/fs-bench-test2.sh |   63 ++++++++++++++++++++++++
 testcases/kernel/fs/fs-bench/test.sh           |   50 -------------------
 testcases/kernel/fs/fs-bench/test2.sh          |   63 ------------------------
 5 files changed, 114 insertions(+), 114 deletions(-)
 create mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test.sh
 create mode 100755 testcases/kernel/fs/fs-bench/fs-bench-test2.sh
 delete mode 100755 testcases/kernel/fs/fs-bench/test.sh
 delete mode 100755 testcases/kernel/fs/fs-bench/test2.sh

diff --git a/testcases/kernel/fs/fs-bench/Makefile b/testcases/kernel/fs/fs-bench/Makefile
index c986184..8807ffc 100644
--- a/testcases/kernel/fs/fs-bench/Makefile
+++ b/testcases/kernel/fs/fs-bench/Makefile
@@ -24,7 +24,7 @@ top_srcdir			?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS			:= modaltr.sh test.sh test2.sh
+INSTALL_TARGETS			:= modaltr.sh fs-bench-test.sh fs-bench-test2.sh
 
 LDLIBS				+= -lm
 
diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test.sh b/testcases/kernel/fs/fs-bench/fs-bench-test.sh
new file mode 100755
index 0000000..c2ca767
--- /dev/null
+++ b/testcases/kernel/fs/fs-bench/fs-bench-test.sh
@@ -0,0 +1,50 @@
+#! /bin/bash
+
+echo "## Start Test"
+date
+if [ -d ./00 ] ; then
+    echo -n "Clear old files..."
+    /bin/rm -fr ./00 >& /dev/null
+    echo "done"
+fi
+STARTT=`date +%s`
+echo $STARTT
+echo ""
+echo "## Create files "
+time ~/fs-bench/cr
+
+echo ""
+echo "## tar all "
+MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
+
+echo ""
+echo "## Change owner"
+time chown -R $USER  ./00
+
+echo ""
+echo "## random access"
+time ~/fs-bench/ra  $MAXFILE
+
+echo ""
+echo "## Change mode "
+time chmod -R go+rw  ./00
+
+echo ""
+echo "## Random delete and create"
+time ~/fs-bench/radc  $MAXFILE
+
+echo ""
+echo "## Change mode again"
+time chmod -R go-rw  ./00
+
+echo ""
+echo "## Remove all files and directories"
+time /bin/rm -fr ./00
+echo ""
+echo "## Finish test"
+ENDT=`date +%s`
+echo $ENDT
+date
+
+echo -n 'TOTAL(seconds): '
+expr $ENDT - $STARTT
diff --git a/testcases/kernel/fs/fs-bench/fs-bench-test2.sh b/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
new file mode 100755
index 0000000..25c67af
--- /dev/null
+++ b/testcases/kernel/fs/fs-bench/fs-bench-test2.sh
@@ -0,0 +1,63 @@
+#! /bin/bash
+
+echo "## Start Test"
+date
+date +%s
+if [ -d ./00 ] ; then
+/bin/rm -fr ./00 >& /dev/null
+fi
+STARTT=`date +%s`
+echo $STARTT
+
+echo ""
+echo "## Create files "
+time ~/fs-bench/cr
+
+echo ""
+echo "## tar all "
+MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
+HALFFILE=`echo "obase=F;ibase=F;$MAXFILE/2" | bc`
+
+echo ""
+echo "## Remove all files and directories"
+/bin/rm -fr ./00 >& /dev/null
+
+echo ""
+echo "## Create half files"
+echo create half files
+time ~/fs-bench/cr  $HALFFILE
+
+echo ""
+echo "## Change owner"
+time chown -R $USER  ./00
+
+echo ""
+echo "## random access"
+time ~/fs-bench/ra  $HALFFILE
+
+
+echo ""
+echo "## Change mode "
+time chmod -R go+rw  ./00
+
+echo ""
+echo "## Random delete and create"
+time ~/fs-bench/radc  $HALFFILE
+
+echo ""
+echo "## Change mode again"
+time chmod -R go-rw  ./00
+
+echo ""
+echo "## Remove all files and directories"
+time /bin/rm -fr ./00
+
+echo ""
+echo "## Finish test"
+date
+ENDT=`date +%s`
+echo $ENDT
+echo -n 'TOTAL(seconds): '
+expr $ENDT - $STARTT
+
+
diff --git a/testcases/kernel/fs/fs-bench/test.sh b/testcases/kernel/fs/fs-bench/test.sh
deleted file mode 100755
index c2ca767..0000000
--- a/testcases/kernel/fs/fs-bench/test.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#! /bin/bash
-
-echo "## Start Test"
-date
-if [ -d ./00 ] ; then
-    echo -n "Clear old files..."
-    /bin/rm -fr ./00 >& /dev/null
-    echo "done"
-fi
-STARTT=`date +%s`
-echo $STARTT
-echo ""
-echo "## Create files "
-time ~/fs-bench/cr
-
-echo ""
-echo "## tar all "
-MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
-
-echo ""
-echo "## Change owner"
-time chown -R $USER  ./00
-
-echo ""
-echo "## random access"
-time ~/fs-bench/ra  $MAXFILE
-
-echo ""
-echo "## Change mode "
-time chmod -R go+rw  ./00
-
-echo ""
-echo "## Random delete and create"
-time ~/fs-bench/radc  $MAXFILE
-
-echo ""
-echo "## Change mode again"
-time chmod -R go-rw  ./00
-
-echo ""
-echo "## Remove all files and directories"
-time /bin/rm -fr ./00
-echo ""
-echo "## Finish test"
-ENDT=`date +%s`
-echo $ENDT
-date
-
-echo -n 'TOTAL(seconds): '
-expr $ENDT - $STARTT
diff --git a/testcases/kernel/fs/fs-bench/test2.sh b/testcases/kernel/fs/fs-bench/test2.sh
deleted file mode 100755
index 25c67af..0000000
--- a/testcases/kernel/fs/fs-bench/test2.sh
+++ /dev/null
@@ -1,63 +0,0 @@
-#! /bin/bash
-
-echo "## Start Test"
-date
-date +%s
-if [ -d ./00 ] ; then
-/bin/rm -fr ./00 >& /dev/null
-fi
-STARTT=`date +%s`
-echo $STARTT
-
-echo ""
-echo "## Create files "
-time ~/fs-bench/cr
-
-echo ""
-echo "## tar all "
-MAXFILE=`tar cBf - 00 | tar tvBf - 2>&1 | tail -n 1 | awk '{print $6;}'| awk -F'/' '{print $4;}'`
-HALFFILE=`echo "obase=F;ibase=F;$MAXFILE/2" | bc`
-
-echo ""
-echo "## Remove all files and directories"
-/bin/rm -fr ./00 >& /dev/null
-
-echo ""
-echo "## Create half files"
-echo create half files
-time ~/fs-bench/cr  $HALFFILE
-
-echo ""
-echo "## Change owner"
-time chown -R $USER  ./00
-
-echo ""
-echo "## random access"
-time ~/fs-bench/ra  $HALFFILE
-
-
-echo ""
-echo "## Change mode "
-time chmod -R go+rw  ./00
-
-echo ""
-echo "## Random delete and create"
-time ~/fs-bench/radc  $HALFFILE
-
-echo ""
-echo "## Change mode again"
-time chmod -R go-rw  ./00
-
-echo ""
-echo "## Remove all files and directories"
-time /bin/rm -fr ./00
-
-echo ""
-echo "## Finish test"
-date
-ENDT=`date +%s`
-echo $ENDT
-echo -n 'TOTAL(seconds): '
-expr $ENDT - $STARTT
-
-
-- 
1.7.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
